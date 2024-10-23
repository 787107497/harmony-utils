/*
 * Copyright (C) 2024 桃花镇童长老 @pura/spinkit
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
 *
 * https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fspinkit
 */

import { SpinType } from '../SpinType';
import { SpinA } from './SpinA';
import { SpinB } from './SpinB';
import { SpinC } from './SpinC';
import { SpinD } from './SpinD';
import { SpinE } from './SpinE';
import { SpinF } from './SpinF';
import { SpinG } from './SpinG';
import { SpinH } from './SpinH';
import { SpinI } from './SpinI';
import { SpinJ } from './SpinJ';
import { SpinK } from './SpinK';
import { SpinL } from './SpinL';
import { SpinM } from './SpinM';
import { SpinN } from './SpinN';
import { SpinO } from './SpinO';
import { SpinP } from './SpinP';
import { SpinQ } from './SpinQ';
import { SpinR } from './SpinR';
import { SpinS } from './SpinS';


/**
 * TODO SpinKit动画组件
 * author: 桃花镇童长老
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fspinkit
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/spinkit
 * QQ交流群: 569512366
 */
@Component
export struct SpinKit {
  @State spinSize: number = 60;
  @State spinColor: ResourceColor = Color.White;
  @State spinType: SpinType = SpinType.spinA

  build() {
    if (this.spinType == SpinType.spinA) {
      SpinA({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinB) {
      SpinB({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinC) {
      SpinC({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinD) {
      SpinD({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinE) {
      SpinE({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinF) {
      SpinF({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinG) {
      SpinG({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinH) {
      SpinH({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinI) {
      SpinI({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinJ) {
      SpinJ({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinK) {
      SpinK({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinL) {
      SpinL({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinM) {
      SpinM({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinN) {
      SpinN({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinO) {
      SpinO({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinP) {
      SpinP({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinQ) {
      SpinQ({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinR) {
      SpinR({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinS) {
      SpinS({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinT) {
      Progress({ value: 0, total: 100, type: ProgressType.Ring })
        .height(this.spinSize).width(this.spinSize)
        .color(this.spinColor)
        .style({ strokeWidth: 10, status: ProgressStatus.LOADING })
    } else {
      LoadingProgress()
        .height(this.spinSize).width(this.spinSize)
        .color(this.spinColor)
    }
  }
}