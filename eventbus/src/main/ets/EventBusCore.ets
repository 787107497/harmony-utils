import { EventAllType } from './constraint';
import { commonEventManager } from '@kit.BasicServicesKit';

export class EventBusCore {
  private static instance: EventBusCore;
  private static events: Map<string, Set<Function>> = new Map();
  private static stickyData: Map<string, EventAllType> = new Map();

  public static getInstance(): EventBusCore {
    if (!EventBusCore.instance) {
      EventBusCore.instance = new EventBusCore();
      EventBusCore.instance.initBroadcast();
    }
    return EventBusCore.instance;
  }


  /**
   * 注册事件监听
   * @param eventName 事件名
   * @param handler 监听回调
   * @param isSticky 是否粘性
   * @returns
   */
  on(eventName: string, handler: Function, isSticky = false) {
    if (typeof handler === 'function') {
      let items: Set<Function> | undefined = EventBusCore.events.get(eventName);
      if (!items) {
        items = new Set();
        EventBusCore.events.set(eventName, items);
      }
      items.add(handler); //添加事件
      if (isSticky && EventBusCore.stickyData.has(eventName)) {
        let value = EventBusCore.stickyData.get(eventName);
        if (value == undefined) {
          handler();
        } else {
          handler(value);
        }
      }
    } else {
      throw new TypeError('the listener not a function');
    }
  }


  /**
   * 注册单次事件监听
   * @param eventName 事件名
   * @param handler 监听回调
   * @param isSticky 是否粘性
   */
  once(eventName: string, handler: Function, isSticky = false): void {
    const onceHandler = (args: EventAllType) => {
      handler(args);
      this.off(eventName, onceHandler);
    };
    this.on(eventName, onceHandler, isSticky);
  }


  /**
   * 注销事件监听
   * @param eventName 事件名
   * @param handler 监听回调
   */
  off(eventName: string, handler?: Function): void {
    if (EventBusCore.events.has(eventName)) {
      if (handler) {
        EventBusCore.events.get(eventName)?.delete(handler);
      } else {
        EventBusCore.events.delete(eventName);
      }
    }
  }


  /**
   * 注销所有事件监听
   */
  offAll(): void {
    EventBusCore.events = new Map();
  }


  /**
   * 发布普通消息
   * @param eventName 事件名
   * @param data 发送的数据
   */
  post(eventName: string, data: EventAllType) {
    let items: Set<Function> | undefined = EventBusCore.events.get(eventName);
    items?.forEach(handler => {
      if (typeof handler === 'function') {
        handler(data);
      }
    });
  }


  /**
   * 发布粘性消息
   * @param eventName 事件名
   * @param data 发送的数据
   */
  postSticky(eventName: string, data: EventAllType): void {
    EventBusCore.stickyData.set(eventName, data);
    this.post(eventName, data);
  }


  /**
   * 发布跨App消息
   * @param eventName 事件名
   * @param data 发送的数据
   */
  postApp(eventName: string, data: EventAllType) {
    let options: commonEventManager.CommonEventPublishData = {
      data: eventName,
      parameters: { data: data }
    };
    commonEventManager.publish('event', options, (err) => {
      if (err) {
        console.error(`Failed to publish common event. Code is ${err.code}, message is ${err.message}`);
      }
    });
  }


  /**
   * 获取粘性事件数据
   * @param eventName
   * @returns
   */
  getSticky(eventName: string): EventAllType | undefined {
    return EventBusCore.stickyData.get(eventName);
  }


  /**
   * 移除粘性事件
   * @param eventName
   */
  removeSticky(eventName: string): void {
    if (EventBusCore.stickyData.get(eventName)) {
      EventBusCore.stickyData.delete(eventName);
    }
  }


  private initBroadcast() {
    let subscribeInfo: commonEventManager.CommonEventSubscribeInfo = {
      events: ['event'], //订阅事件
    };
    commonEventManager.createSubscriber(subscribeInfo).then((subscriber) => {
      commonEventManager.subscribe(subscriber, (err, data) => {
        if (err) {
          console.error(`Failed to subscribe common event. Code is ${err.code}, message is ${err.message}`);
          return;
        }
        if (data.data && data.parameters) {
          const pData = data.parameters['data'] as EventAllType;
          this.post(data.data, pData);
        }
      });
    });
  }
}