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
import { SpinQ } from './SpinQ';
import { SpinP } from './SpinP';
import { SpinR } from './SpinR';
import { SpinS } from './SpinS';
import { SpinT } from './SpinT';
import { SpinU } from './SpinU';
import { SpinV } from './SpinV';
import { SpinW } from './SpinW';
import { SpinX } from './SpinX';


/**
 * TODO SpinKit动画组件
 * author: 桃花镇童长老
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fspinkit
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/spinkit
 * QQ交流群: 569512366
 */
@ComponentV2
export struct SpinKit {
  @Param spinSize: number = 36;
  @Param spinColor: ResourceColor = Color.White;
  @Param spinType: SpinType = SpinType.spinA;

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
      SpinT({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinU) {
      SpinU({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinV) {
      SpinV({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinW) {
      SpinW({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinX) {
      SpinX({ spinSize: this.spinSize, spinColor: this.spinColor })
    } else if (this.spinType == SpinType.spinY) {
      Progress({ value: 0, total: 100, type: ProgressType.Ring })
        .height(this.spinSize).width(this.spinSize)
        .color(this.spinColor)
        .style({ strokeWidth: this.spinSize * 0.12, status: ProgressStatus.LOADING })
    } else {
      LoadingProgress()
        .height(this.spinSize).width(this.spinSize)
        .color(this.spinColor)
    }
  }
}