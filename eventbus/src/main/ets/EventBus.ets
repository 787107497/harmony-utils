import { EventAllType } from './constraint';
import { EventBusCore } from './EventBusCore';

export class EventBus {

  /**
   * 注册事件监听
   * @param eventName 事件名
   * @param handler 监听回调
   * @param isSticky 是否粘性
   * @returns
   */
  static on(eventName: string, handler: Function, isSticky = false) {
    EventBusCore.getInstance().on(eventName, handler, isSticky);
  }


  /**
   * 注册单次事件监听
   * @param eventName 事件名
   * @param handler 监听回调
   * @param isSticky 是否粘性
   */
  static once(eventName: string, handler: Function, isSticky = false): void {
    EventBusCore.getInstance().once(eventName, handler, isSticky);
  }


  /**
   * 注销事件监听
   * @param eventName 事件名
   * @param handler 监听回调
   */
  static off(eventName: string, handler?: Function): void {
    EventBusCore.getInstance().off(eventName, handler);
  }


  /**
   * 注销所有事件监听
   */
  static offAll(): void {
    EventBusCore.getInstance().offAll();
  }


  /**
   * 发布普通消息
   * @param eventName 事件名
   * @param data 发送的数据
   */
  static post(eventName: string, data: EventAllType) {
    EventBusCore.getInstance().post(eventName, data);
  }


  /**
   * 发布粘性消息
   * @param eventName 事件名
   * @param data 发送的数据
   */
  static postSticky(eventName: string, data: EventAllType): void {
    EventBusCore.getInstance().postSticky(eventName, data);
  }


  /**
   * 发布跨App消息
   * @param eventName 事件名
   * @param data 发送的数据
   */
  static postApp(eventName: string, data: EventAllType) {
    EventBusCore.getInstance().postApp(eventName, data);
  }


  /**
   * 获取粘性事件数据
   * @param eventName
   * @returns
   */
  static getSticky(eventName: string): EventAllType | undefined {
    return EventBusCore.getInstance().getSticky(eventName);
  }


  /**
   * 移除粘性事件
   * @param eventName
   */
  static removeSticky(eventName: string): void {
    EventBusCore.getInstance().removeSticky(eventName);
  }


}