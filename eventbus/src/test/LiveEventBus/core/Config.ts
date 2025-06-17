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

import Bus from '../LiveEventBus'
import Logger from '../logger/Logger'

export default class Config{
      /**
     * lifecycleObserverAlwaysActive
     * set if then observer can always receive message
     * true: observer can always receive message
     * false: observer can only receive message when resumed
     *
     * @param active
     * @return
     */
    public lifecycleObserverAlwaysActive( active:boolean):Config {
        Bus.getCore().setLifecycleObserverAlwaysActive(active);
        return this;
    }

    /**
     * @param clear
     * @return true: clear livedata when no observer observe it
     * false: not clear livedata unless app was killed
     */
    public autoClear( clear:boolean):Config {
        Bus.getCore().setAutoClear(clear);
        return this;
    }


    /**
     * setLogger, if not set, use DefaultLogger
     *
     * @param logger
     */
    public  setLogger(  logger:Logger):Config {
        Bus.getCore().setLogger(logger);
        return this;
    }

    /**
     * set logger enable or disable, default enable
     *
     * @param enable
     * @return
     */
    public  enableLogger( enable:boolean):Config {
        Bus.getCore().enableLogger(enable);
        return this;
    }
}