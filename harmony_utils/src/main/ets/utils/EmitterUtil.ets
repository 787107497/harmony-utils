import { emitter } from '@kit.BasicServicesKit';


/**
 * TODO Emitter工具类（进行线程间通信）
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class EmitterUtil {

  private constructor() {}


  /**
   * 发送事件
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param data 发送的数据
   * @param EventPriority 事件被发送的优先级
   */
  static post<T>(eventId: string, data: T, priority: emitter.EventPriority = emitter.EventPriority.HIGH) {
    let eventData: emitter.EventData = { data: { "eventData": data } };
    let options: emitter.Options = { priority: priority };
    emitter.emit(eventId, options, eventData);
  }


  /**
   * 订阅事件
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param callback 事件的回调处理函数。
   */
  static onSubscribe<T>(eventId: string, callback: (data: T) => void) {
    emitter.on(eventId, (eventData: emitter.EventData) => {
      callback(eventData.data?.eventData);
    });
  }


  /**
   * 单次订阅指定事件
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param callback 事件的回调处理函数。
   */
  static onceSubscribe<T>(eventId: string, callback: (data: T) => void) {
    emitter.once(eventId, (eventData: emitter.EventData) => {
      callback(eventData.data?.eventData);
    });
  }


  /**
   * 取消事件订阅
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   */
  static unSubscribe(eventId: string) {
    emitter.off(eventId);
  }


}