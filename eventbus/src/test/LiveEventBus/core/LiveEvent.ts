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

import Observable from './Observable'
import Observer from '../lifecycle/Observer'
import LifecycleOwner from '../lifecycle/LifecycleOwner'
import State from '../lifecycle/State'
import LiveEventBusCore from './LiveEventBusCore'
import Level from '../logger/Level'
import LiveData from '../lifecycle/LiveData'
import Base from '@ohos.base';
import CommonEventManager from '@ohos.commonEventManager';

function loggerLog(level: Level, msg: string, th?: Error): void {
  let coreLog = LiveEventBusCore.get().logger
  if (coreLog) {
    coreLog.log(level, msg, th);
  }
}

export class LifecycleLiveData<T> extends LiveData<T> {
  private readonly key: string
  private mVersion: number = -1
  private ownerMap: Map<Observer<T>, LifecycleOwner>

  constructor(key: string) {
    super()
    this.key = key
    this.ownerMap = new Map()
  }

  public getVersion(): number {
    return this.mVersion
  }

  public observe(observer: Observer<T>, owner?: LifecycleOwner): void {
    if (owner) {
      if (owner.getLifecycle().getCurrentState() == State.DESTROYED) {
        // ignore
        return;
      }
      this.ownerMap.set(observer, owner)
    }
    super.observe(observer)

  }

  public observeForever(observer: Observer<T>) {
    super.observe(observer)
  }

  /**
   * Sets current LiveData value, and notifies observers.
   *
   * @param value The value to set.
   */
  public postValue(value: T) {
    this.data = value;
    this.mVersion++;
    let removeObservers: Array<Observer<T>> = [];
    this.observers.forEach(observer => {
      if (this.ownerMap.has(observer)) {
        let owner = this.ownerMap.get(observer);
        loggerLog(Level.INFO, 'postValue:' + value + ' observer:' + observer + ' owner:' + owner.getLifecycle().getCurrentState());
        if (owner.getLifecycle().getCurrentState() != State.DESTROYED) {
          observer.onChanged(value);
        } else {
          removeObservers.push(observer);
        }
      } else {
        loggerLog(Level.INFO, 'postValue:' + value + ' observer:' + observer);
        observer.onChanged(value);
      }
    })
    removeObservers.forEach((observer) => {
      this.ownerMap.delete(observer);
      super.removeObserver(observer);
    })
  }
}

export class ObserverWrapper<T> implements Observer<T> {
  private observer: Observer<T>
  public preventNextEvent: boolean = false

  constructor(observer: Observer<T>) {
    this.observer = observer
  }

  getObserver(): Observer<T> {
    return this.observer;
  }

  onChanged(t: T): void {
    if (this.preventNextEvent) {
      this.preventNextEvent = false;
      return;
    }
    loggerLog(Level.INFO, "message received: " + t);
    try {
      this.observer.onChanged(t);
    } catch (e) {
      loggerLog(Level.WARNING, "error on message received: " + t, e);
    }
  }
}

export default class LiveEvent<T> implements Observable<T> {
  private readonly key: string
  private liveData: LifecycleLiveData<T>
  private observerMap: Map<Observer<T>, ObserverWrapper<T>>
  private subscriberMap: Map<string, CommonEventManager.CommonEventSubscriber> = new Map<string, CommonEventManager.CommonEventSubscriber>();
  private busCore: LiveEventBusCore
  private event_id: number
  private sendInnerEvent = null;
  private callInnerEvent = null

  constructor(key: string, busCore: LiveEventBusCore) {
    this.key = key
    this.busCore = busCore
    this.liveData = new LifecycleLiveData<T>(key)
    this.observerMap = new Map()

    this.initBroadcast()
  }

  private initBroadcast() {
    var CommonEventSubscribeInfo = {
      events: [this.key]
    };
    CommonEventManager.createSubscriber(CommonEventSubscribeInfo, (err, subscriber) => {
      if (err) {
        loggerLog(Level.WARNING, 'initBroadcast(' + this.key + ') ---> Operation failed. Cause: ' + JSON.stringify(err));
        return;
      } else {
        if (!!subscriber) {
          this.subscriberMap.set(this.key, subscriber);
          CommonEventManager.subscribe(subscriber, (error, commonEventData) => {
            if (error && error.code != 0) {
              loggerLog(Level.WARNING, 'initBroadcast(' + this.key + ') ---> Operation failed. Cause: ' + JSON.stringify(error));
            } else {
              loggerLog(Level.INFO, 'initBroadcast(' + this.key + ') ---> subscribe callback: ' + JSON.stringify(commonEventData));
              this.postInternal(JSON.parse(commonEventData.data))
            }
          });
        } else {
          loggerLog(Level.WARNING, 'createSubscriber subscriber is null');
        }
      }
    })
  }

  private broadcastInternal(value: T) {
    loggerLog(Level.INFO, "broadcast: " + value + " with key: " + this.key);
    // 自定义事件，只支持string类型数据
    var data = {
      code: 1, data: JSON.stringify(value), isOrdered: true
    }
    CommonEventManager.publish(this.key, data, (error) => {
      if (error && error.code != 0) {
        loggerLog(Level.WARNING, 'broadcast ---> publish failed. Cause: ' + JSON.stringify(error));
      } else {
        loggerLog(Level.INFO, 'broadcast ---> publish common event success. ');
      }
    });
  }

  private postInternal(value: T): void {
    loggerLog(Level.INFO, "post: " + value + " with key: " + this.key);
    this.liveData.postValue(value);
  }

  private observeInternal(owner: LifecycleOwner, observer: Observer<T>) {
    let observerWrapper: ObserverWrapper<T> = new ObserverWrapper<T>(observer);
    observerWrapper.preventNextEvent = this.liveData.getVersion() > -1;
    this.liveData.observe(observerWrapper, owner);
    loggerLog(Level.INFO, "observe observer: " + observerWrapper + "(" + observer + ")" + " on owner: " + owner + " with key: " + this.key);
  }

  private observeStickyInternal(owner: LifecycleOwner, observer: Observer<T>) {
    let observerWrapper: ObserverWrapper<T> = new ObserverWrapper<T>(observer);
    this.liveData.observe(observerWrapper, owner);
    if (this.liveData.getVersion() > -1) {
      observerWrapper.onChanged(this.liveData.getValue())
    }
    loggerLog(Level.INFO, "observe sticky observer: " + observerWrapper + "(" + observer + ")" + " on owner: " + owner + " with key: " + this.key);
  }

  private observeStickyForeverInternal(observer: Observer<T>) {
    let observerWrapper: ObserverWrapper<T> = new ObserverWrapper<T>(observer);
    this.liveData.observe(observerWrapper);
    if (this.liveData.getVersion() > -1) {
      observerWrapper.onChanged(this.liveData.getValue())
    }
    loggerLog(Level.INFO, "observe forever observer: " + observerWrapper + "(" + observer + ")" + " with key: " + this.key);
  }

  private observeForeverInternal(observer: Observer<T>) {
    let observerWrapper: ObserverWrapper<T> = new ObserverWrapper<T>(observer);
    observerWrapper.preventNextEvent = this.liveData.getVersion() > -1;
    this.liveData.observe(observerWrapper);
    loggerLog(Level.INFO, "observe forever observer: " + observerWrapper + "(" + observer + ")" + " with key: " + this.key);
  }

  /**
   * 进程内发送消息
   *
   * @param value 发送的消息
   */
  post(value: T): void {
    this.postInternal(value);
  }

  /**
   * App内发送消息，跨进程使用
   *
   * @param value 发送的消息
   */
  postAcrossProcess(value: T): void {
    this.postInternal(value);
  }

  /**
   * App之间发送消息
   *
   * @param value 发送的消息
   */
  postAcrossApp(value: T): void {
    this.broadcast(value);
  }


  /**
   * 进程内发送消息，延迟发送，带生命周期
   * 如果延时发送消息的时候sender处于非激活状态，消息取消发送
   *
   * @param sender 消息发送者
   * @param value  发送的消息
   * @param delay  延迟毫秒数
   */
  postDelay(value: T, delay: number, sender?: LifecycleOwner): void {
    setTimeout(() => {
      if (sender != null) {
        if (sender.getLifecycle().isAtLeast(State.STARTED)) {
          this.postInternal(value);
        }
      } else {
        this.postInternal(value);
      }

    }, delay)
  }

  /**
   * 进程内发送消息
   * 强制接收到消息的顺序和发送顺序一致
   *
   * @param value 发送的消息
   */
  postOrderly(value: T): void {
    this.postInternal(value);
  }

  /**
   * 以广播的形式发送一个消息
   * 需要跨进程、跨APP发送消息的时候调用该方法
   * 可使用postAcrossProcess or postAcrossApp代替
   *
   * @param value 发送的消息
   */
  broadcast(value: T): void {
    this.broadcastInternal(value)
  }

  /**
   * 注册一个Observer，生命周期感知，自动取消订阅
   *
   * @param owner    LifecycleOwner
   * @param observer 观察者
   */
  observe(owner: LifecycleOwner, observer: Observer<T>): void {
    this.observeInternal(owner, observer);
  }

  /**
   * 注册一个Observer，生命周期感知，自动取消订阅
   * 如果之前有消息发送，可以在注册时收到消息（消息同步）
   *
   * @param owner    LifecycleOwner
   * @param observer 观察者
   */
  observeSticky(owner: LifecycleOwner, observer: Observer<T>): void {
    this.observeStickyInternal(owner, observer)
  }

  /**
   * 注册一个Observer，需手动解除绑定
   *
   * @param observer 观察者
   */
  observeForever(observer: Observer<T>): void {
    this.observeForeverInternal(observer);
  }

  /**
   * 注册一个Observer，需手动解除绑定
   * 如果之前有消息发送，可以在注册时收到消息（消息同步）
   *
   * @param observer 观察者
   */
  observeStickyForever(observer: Observer<T>): void {
    this.observeStickyForeverInternal(observer)
  }

  /**
   * 通过observeForever或observeStickyForever注册的，需要调用该方法取消订阅
   *
   * @param observer 观察者
   */
  removeObserver(observer: Observer<T>): void {
    if (this.observerMap != undefined && this.observerMap.has(observer)) {
      this.observerMap.delete(observer)
    }
    this.liveData.removeObserver(observer)
  }

  /**
   * 通过broadcast注册的，需要调用该方法取消订阅
   *
   * @param observer 观察者
   *
   */
  unsubscribe(observer: Observer<T>): void {
    try {
      if (this.subscriberMap.has(this.key)) {
        let commonEventSubscriber: CommonEventManager.CommonEventSubscriber = this.subscriberMap.get(this.key);
        CommonEventManager.unsubscribe(commonEventSubscriber, (err: Base.BusinessError) => {
          if (err) {
            loggerLog(Level.WARNING, 'unsubscribe(' + this.key + ') ---> Operation failed. Cause: ' + JSON.stringify(err));
          } else {
            this.subscriberMap.delete(this.key);
            this.removeObserver(observer);
          }
        })
      }
    } catch (err) {
      loggerLog(Level.WARNING, 'unsubscribe(' + this.key + ') ---> Operation failed. Cause: ' + JSON.stringify(err));
    }
  }
}
