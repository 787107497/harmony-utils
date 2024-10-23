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
export struct SpinH {
  @State spinSize: number = 60;
  @State spinColor: ResourceColor = Color.White;
  @State scale1: number = 1;
  @State scale2: number = 1;
  @State scale3: number = 1;
  @State scale4: number = 1;
  @State scale5: number = 1;
  @State scale6: number = 1;
  @State scale7: number = 1;
  @State scale8: number = 1;
  @State scale9: number = 1;

  build() {
    Grid() {
      GridItem() {
        Canvas().chunkStyle()
      }.scale({ x: this.scale1, y: this.scale1, z: 1 })

      GridItem() {
        Canvas().chunkStyle()
      }.scale({ x: this.scale2, y: this.scale2, z: 1 })

      GridItem() {
        Canvas().chunkStyle()
      }.scale({ x: this.scale3, y: this.scale3, z: 1 })

      GridItem() {
        Canvas().chunkStyle()
      }.scale({ x: this.scale4, y: this.scale4, z: 1 })

      GridItem() {
        Canvas().chunkStyle()
      }.scale({ x: this.scale5, y: this.scale5, z: 1 })

      GridItem() {
        Canvas().chunkStyle()
      }.scale({ x: this.scale6, y: this.scale6, z: 1 })

      GridItem() {
        Canvas().chunkStyle()
      }.scale({ x: this.scale7, y: this.scale7, z: 1 })

      GridItem() {
        Canvas().chunkStyle()
      }.scale({ x: this.scale8, y: this.scale8, z: 1 })

      GridItem() {
        Canvas().chunkStyle()
      }.scale({ x: this.scale9, y: this.scale9, z: 1 })
    }
    .rowsTemplate('1fr 1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr')
    .renderFit(RenderFit.CENTER)
    .width(this.spinSize)
    .height(this.spinSize)
    .onAppear(() => {
      let keyframes0: Array<KeyframeState> = [
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale7 = 0;
          }
        },
        {
          duration: 500,
          curve: Curve.Linear,
          event: () => {
            this.scale7 = 1;
          }
        },
        {
          duration: 400,
          curve: Curve.Linear,
          event: () => {

          }
        }
      ];
      let keyframes1: Array<KeyframeState> = [
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale4 = 0;
            this.scale8 = 0;
          }
        },
        {
          duration: 500,
          curve: Curve.Linear,
          event: () => {
            this.scale4 = 1;
            this.scale8 = 1;
          }
        },
        {
          duration: 400,
          curve: Curve.Linear,
          event: () => {

          }
        }
      ];
      let keyframes2: Array<KeyframeState> = [
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale1 = 0;
            this.scale5 = 0;
            this.scale9 = 0;
          }
        },
        {
          duration: 500,
          curve: Curve.Linear,
          event: () => {
            this.scale1 = 1;
            this.scale5 = 1;
            this.scale9 = 1;
          }
        },
        {
          duration: 400,
          curve: Curve.Linear,
          event: () => {

          }
        }
      ];
      let keyframes3: Array<KeyframeState> = [
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale2 = 0;
            this.scale6 = 0;
          }
        },
        {
          duration: 500,
          curve: Curve.Linear,
          event: () => {
            this.scale2 = 1;
            this.scale6 = 1;
          }
        },
        {
          duration: 400,
          curve: Curve.Linear,
          event: () => {

          }
        }
      ];
      let keyframes4: Array<KeyframeState> = [
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale3 = 0;
          }
        },
        {
          duration: 500,
          curve: Curve.Linear,
          event: () => {
            this.scale3 = 1;
          }
        },
        {
          duration: 400,
          curve: Curve.Linear,
          event: () => {

          }
        }
      ];
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, keyframes0);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 100 }, keyframes1);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 200 }, keyframes2);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 300 }, keyframes3);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 400 }, keyframes4);
    })
  }

  @Styles
  chunkStyle(){
    .width(this.spinSize / 3)
    .height(this.spinSize / 3)
    .backgroundColor(this.spinColor)
    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  }
}

