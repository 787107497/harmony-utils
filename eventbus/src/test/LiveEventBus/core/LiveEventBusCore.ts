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

import Observable from './Observable';
import Config from './Config';
import LoggerManager from '../logger/LoggerManager';
import Logger from '../logger/Logger';
import ConsoleLogger from '../logger/ConsoleLogger';
import ObservableConfig from '../lifecycle/ObservableConfig';
import LiveEvent from './LiveEvent';
import { LogUtil } from '../logger/LogUtil';

export class LiveEventBusCore {
  private static DEFAULT_BUS: LiveEventBusCore;

  public static get(): LiveEventBusCore {
    LogUtil.log(`-----> LiveEventBusCore get <------`);
    if (!LiveEventBusCore.DEFAULT_BUS) {
      LiveEventBusCore.DEFAULT_BUS = new LiveEventBusCore();
    }
    return LiveEventBusCore.DEFAULT_BUS;
  }

  //  private bus: { [key: string]: Observable<any> } = {}
  public bus: Map<string, Observable<any>>

  /**
   * 可配置的项
   */
  protected config: Config = new Config();
  public lifecycleObserverAlwaysActive: boolean
  public autoClear: boolean
  public logger: LoggerManager
  //  private observableConfigs:{ [key: string]: ObservableConfig } = {}
  public observableConfigs: Map<string, ObservableConfig> // 这个配置没啥用
  public isRegisterReceiver: boolean

  private constructor() {
    LogUtil.log(`-----> LiveEventBusCore create <------`)
    this.bus = new Map<string, Observable<any>>()
    this.observableConfigs = new Map<string, ObservableConfig>()
    this.autoClear = false;
    this.logger = new LoggerManager(new ConsoleLogger());
  }

  /**
   * use the class
   * @param key
   * @param classType
   */
  public with<T>(key: string): Observable<T> {
    if (!this.bus.has(key)) {
      this.bus.set(key, new LiveEvent<T>(key, this))
    }
    return this.bus.get(key)
  }

  public getConfig(): Config {
    return this.config
  }

  public getObservableConfig(key: string) {
    if (!this.observableConfigs.has(key)) {
      this.observableConfigs.set(key, new ObservableConfig());
    }
    return this.observableConfigs.get(key)
  }

  public setLifecycleObserverAlwaysActive(active: boolean): void {
    this.lifecycleObserverAlwaysActive = active
  }

  public setAutoClear(auto: boolean) {
    this.autoClear = auto
  }

  public setLogger(logger: Logger) {
    this.logger.setLogger(logger)
  }

  public enableLogger(enable: boolean) {
    this.logger.setEnable(enable)
  }

  public destroy() {
    if (this.observableConfigs) {
      this.observableConfigs.clear()
      this.observableConfigs = null
    }
    if (this.bus) {
      this.bus.clear()
      this.bus = null
    }
  }
}

export default LiveEventBusCore