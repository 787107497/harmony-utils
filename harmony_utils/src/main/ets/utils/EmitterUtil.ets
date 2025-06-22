/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-utils
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { emitter } from '@kit.BasicServicesKit';


/**
 * TODO Emitter工具类（进行线程间通信）
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class EmitterUtil {


  /**
   * 发送事件
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param data 发送的数据
   * @param EventPriority 事件被发送的优先级
   */
  static post<T>(eventId: string | number, eventData: T, priority: emitter.EventPriority = emitter.EventPriority.HIGH) {
    const genericEventData: emitter.GenericEventData<T> = { data: eventData };
    const options: emitter.Options = { priority: priority };
    emitter.emit(eventId.toString(), options, genericEventData);
  }


  /**
   * 订阅事件
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param callback 事件的回调处理函数。
   */
  static onSubscribe<T>(eventId: string | number, callback: Callback<T>) {
    emitter.on(eventId.toString(), (eventData: emitter.GenericEventData<T>) => {
      callback(eventData.data);
    });
  }


  /**
   * 单次订阅指定事件
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param callback 事件的回调处理函数。
   */
  static onceSubscribe<T>(eventId: string | number, callback: Callback<T>) {
    emitter.once(eventId.toString(), (eventData: emitter.GenericEventData<T>) => {
      callback(eventData.data);
    });
  }


  /**
   * 取消事件订阅
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   */
  static unSubscribe(eventId: string | number) {
    emitter.off(eventId.toString());
  }


  /**
   * 获取指定事件的订阅数
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @returns
   */
  static getListenerCount(eventId: number | string): number {
    return emitter.getListenerCount(eventId);
  }


  /**
   * 订阅事件，支持取消指定事件回调
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param callback 接收到该事件时需要执行的回调处理函数。
   */
  static on<T>(eventId: string | number, callback: Callback<emitter.GenericEventData<T>>) {
    emitter.on(eventId.toString(), callback);
  }


  /**
   * 单次订阅指定事件，支持取消指定事件回调
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param callback 接收到该事件时需要执行的回调处理函数。
   */
  static once<T>(eventId: string | number, callback: Callback<emitter.GenericEventData<T>>) {
    emitter.once(eventId.toString(), callback);
  }

  /**
   * 取消事件订阅，支持取消指定事件回调
   * @param eventId 事件ID，string类型的eventId不支持空字符串。
   * @param callback 取消该事件的回调处理函数。不传callback，取消事件ID为eventId的所有订阅
   */
  static off<T>(eventId: string | number, callback?: Callback<emitter.GenericEventData<T>>) {
    if (callback) {
      emitter.off(eventId.toString(), callback);
    } else {
      emitter.off(eventId.toString()); //取消事件ID为eventId的所有订阅
    }
  }


}