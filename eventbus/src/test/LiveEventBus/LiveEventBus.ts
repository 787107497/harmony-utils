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


import Observable from './core/Observable'
import Config from './core/Config'
import ObservableConfig from './lifecycle/ObservableConfig'
import LiveEventBusCore from './core/LiveEventBusCore'
import GlobalContext from './GlobalContext'

function getIns(): LiveEventBusCore {
  let liveEventBusCore: LiveEventBusCore = GlobalContext.getContext().getObject("liveEventBus") as LiveEventBusCore;
  if (!liveEventBusCore) {
    liveEventBusCore = LiveEventBusCore.get();
    GlobalContext.getContext().setObject("liveEventBus", liveEventBusCore);
  }
  return liveEventBusCore;
}


/**
 * _     _           _____                _  ______
 * | |   (_)         |  ___|              | | | ___ \
 * | |    ___   _____| |____   _____ _ __ | |_| |_/ /_   _ ___
 * | |   | \ \ / / _ \  __\ \ / / _ \ '_ \| __| ___ \ | | / __|
 * | |___| |\ V /  __/ |___\ V /  __/ | | | |_| |_/ / |_| \__ \
 * \_____/_| \_/ \___\____/ \_/ \___|_| |_|\__\____/ \__,_|___/
 * <p>
 * <p>
 * <p>
 */
export default class LiveEventBus {
  public static getCore(): LiveEventBusCore {
    return getIns()
  }

  public static get<T>(key: string): Observable<T> {
    return getIns().with<T>(key);
  }

  public static config(): Config {
    return getIns().getConfig()
  }

  public static getObservableConfig(key: string): ObservableConfig {
    return getIns().getObservableConfig(key)
  }
}
