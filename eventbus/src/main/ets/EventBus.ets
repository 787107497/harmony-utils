import { EventAllType } from './constraint';
import { EventItem } from './EventItem';

export class EventBus {

  private static instance: EventBus;
  private static events: Map<string, Set<Function>> = new Map()
  private static stickyData: Map<string, EventAllType[]> = new Map

  public static getInstance(): EventBus {
    if (!EventBus.instance) {
      EventBus.instance = new EventBus();
    }

    return EventBus.instance;
  }



  /**
   * 添加监听
   * @param key
   * @param listener
   * @returns
   */
  public on(key: string, listener: Function) {
    if (typeof listener === 'function') {
      let items: Set<Function> | undefined = EventBus.events.get(key);
      if (!items) {
        items = new Set();
      }
      items.add(listener); //添加事件
      // EventBus.events.set(key, items)
      if (EventBus.stickyData.has(key)) {
        let value = EventBus.stickyData.get(key)
        if (value == undefined) {
          listener();
        } else {
          listener(...value);
        }
      }
    } else {
      throw new TypeError('the listener not a function');
    }
  }

  /**
   * 取消监听
   * @param listener
   */
  public off(listener: EventItem | undefined): void {
    if (!listener) {
      return;
    }
    let items = EventBus.events.get(listener.key)
    if (!items) {
      return;
    }
    items = items.filter((it)=> {
      return it !== listener;
    })
    EventBus.events.set(listener.key, items);
  }

  /**
   * 发布普通消息
   * @param key
   * @param args
   */
  public emmit<T>(key: string, ...args: T[]) {
    let items = EventBus.events.get(key)
    if (!items || items.length == 0) {
      return;
    }

    items.forEach((item: EventItem, index: number) => {
      if (typeof item.listener === 'function') {
        item.listener(...args)
      }
    });
  }

  /**
   * 发布粘性消息
   * @param key
   * @param args
   */
  public emmitViscosity<T>(key: string, ...args: T[]) {
    this.emmit(key, ...args);
    EventBus.viscosityData.set(key, args as EventAllType[]);
  }

  /**
   * 移除粘性消息
   * @param key
   */
  public deleteViscosity(key: string) {
    if (EventBus.viscosityData.has(key)) {
      EventBus.viscosityData.delete(key)
    }
  }

  /**
   * 删除所有监听
   */
  public removeAllListener() {
    EventBus.events = new Map;
  }


}