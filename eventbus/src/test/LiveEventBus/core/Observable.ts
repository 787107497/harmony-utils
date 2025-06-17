/*
 * Copyright (C) 2022 Huawei Device Co., Ltd.
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

import Observer from '../lifecycle/Observer'
import LifecycleOwner from '../lifecycle/LifecycleOwner'

export default interface Observable<T> {
  /**
   * 进程内发送消息
   *
   * @param value 发送的消息
   */
  post(value: T): void;

  /**
   * App内发送消息，跨进程使用
   *
   * @param value 发送的消息
   */
  postAcrossProcess(value: T): void;

  /**
   * App之间发送消息
   *
   * @param value 发送的消息
   */
  postAcrossApp(value: T): void;

  /**
   * 进程内发送消息，延迟发送，带生命周期
   * 如果延时发送消息的时候sender处于非激活状态，消息取消发送
   *
   * @param sender 消息发送者
   * @param value  发送的消息
   * @param delay  延迟毫秒数
   */
  postDelay(value: T, delay: number, sender?: LifecycleOwner): void;

  /**
   * 进程内发送消息
   * 强制接收到消息的顺序和发送顺序一致
   *
   * @param value 发送的消息
   */
  postOrderly(value: T): void;

  /**
   * 以广播的形式发送一个消息
   * 需要跨进程、跨APP发送消息的时候调用该方法
   * 可使用postAcrossProcess or postAcrossApp代替
   *
   * @param value 发送的消息
   */
  //    @Deprecated
  broadcast(value: T): void;

  /**
   * 注册一个Observer，生命周期感知，自动取消订阅
   *
   * @param owner    LifecycleOwner
   * @param observer 观察者
   */
  observe(owner: LifecycleOwner, observer: Observer<T>): void;

  /**
   * 注册一个Observer，生命周期感知，自动取消订阅
   * 如果之前有消息发送，可以在注册时收到消息（消息同步）
   *
   * @param owner    LifecycleOwner
   * @param observer 观察者
   */
  observeSticky(owner: LifecycleOwner, observer: Observer<T>): void;

  /**
   * 注册一个Observer，需手动解除绑定
   *
   * @param observer 观察者
   */
  observeForever(observer: Observer<T>): void;

  /**
   * 注册一个Observer，需手动解除绑定
   * 如果之前有消息发送，可以在注册时收到消息（消息同步）
   *
   * @param observer 观察者
   */
  observeStickyForever(observer: Observer<T>): void;

  /**
   * 通过observeForever或observeStickyForever注册的，需要调用该方法取消订阅
   *
   * @param observer 观察者
   */
  removeObserver(observer: Observer<T>): void;

  /**
   * 通过broadcast注册的，需要调用该方法取消订阅
   *
   * @param observer 观察者
   *
   */
  unsubscribe(observer: Observer<T>): void;
}