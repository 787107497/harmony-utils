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

import State from './State';
import { LogUtil } from '../logger/LogUtil';

export class Lifecycle{

  private mState:State;
  constructor(state:State){
    this.mState = state;
  }

  public markState(state :State):void{
    LogUtil.log('markState:'+state + ' this.mState:'+this.mState);
    this.mState = state;
  }

  public getCurrentState():State{
    return this.mState;
  }

  /**
   * 比较当前状态是否大于或等于给定的 {@code状态}。
   * @param state
   */
  public isAtLeast(state:State):boolean{
    LogUtil.log('isAtLeast:'+state + ' this.mState:'+this.mState);
    return this.mState - state >= 0;
  }
}


export interface LifecycleOwner {
  /**
     * Returns the Lifecycle of the provider.
     *
     * @return The lifecycle of the provider.
     */
  getLifecycle(): Lifecycle
}

export default LifecycleOwner
