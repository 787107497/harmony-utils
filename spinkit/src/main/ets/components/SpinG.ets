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
export struct SpinG {
  @Require @Param spinSize: number;
  @Require @Param spinColor: ResourceColor;
  @Local scale1: number = 1;
  @Local scale2: number = 0.5;
  @Local scale3: number = 0;

  build() {
    Row() {
      Canvas()
        .chunkStyle()
        .scale({ x: this.scale1, y: this.scale1 })

      Canvas()
        .chunkStyle()
        .scale({ x: this.scale2, y: this.scale2 })

      Canvas()
        .chunkStyle()
        .scale({ x: this.scale3, y: this.scale3 })
    }
    .width(this.spinSize)
    .height(this.spinSize / 3)
    .onAppear(() => {
      let keyframes1: Array<KeyframeState> = [
        {
          duration: 560,
          curve: Curve.Linear,
          event: () => {
            this.scale1 = 0;
          }
        },
        {
          duration: 560,
          curve: Curve.Linear,
          event: () => {
            this.scale1 = 1;
          }
        },
        {
          duration: 280,
          event: () => {

          }
        }
      ];
      let keyframes2: Array<KeyframeState> = [
        {
          duration: 280,
          curve: Curve.Linear,
          event: () => {
            this.scale2 = 1;
          }
        },
        {
          duration: 560,
          curve: Curve.Linear,
          event: () => {
            this.scale2 = 0;
          }
        },
        {
          duration: 280,
          curve: Curve.Linear,
          event: () => {
            this.scale2 = 0.5;
          }
        },
        {
          duration: 280,
          event: () => {

          }
        }
      ];
      let keyframes3: Array<KeyframeState> = [
        {
          duration: 560,
          curve: Curve.Linear,
          event: () => {
            this.scale3 = 1;
          }
        },
        {
          duration: 560,
          curve: Curve.Linear,
          event: () => {
            this.scale3 = 0;
          }
        },
        {
          duration: 280,
          event: () => {

          }
        }
      ];
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 280 }, keyframes1);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 120 }, keyframes2);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, keyframes3);
    })
  }

  @Styles
  chunkStyle(){
    .height(this.spinSize / 3)
    .width(this.spinSize / 3)
    .borderRadius(this.spinSize / 3)
    .backgroundColor(this.spinColor)
    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  }
}