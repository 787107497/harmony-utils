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
 * QQ交流群: 1029219059
 */
@ComponentV2
export struct SpinR {
  @Require @Param spinSize: number = 36;
  @Require @Param spinColor: ResourceColor;
  @Local round1: number = this.spinSize * 0.2
  @Local scale1: number = 0;
  @Local scale2: number = 0;
  @Local scale3: number = 0;
  @Local scale4: number = 0;
  @Local scale5: number = 0;
  @Local scale6: number = 0;
  @Local scale7: number = 0;
  @Local scale8: number = 0;

  aboutToAppear(): void {
    this.round1 = this.spinSize * 0.2
  }

  build() {
    Stack() {
      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale1, y: this.scale1 })
      }
      .frameStyle()
      .rotate({ angle: 0 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale2, y: this.scale2 })
      }
      .frameStyle()
      .rotate({ angle: 90 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale3, y: this.scale3 })
      }
      .frameStyle()
      .rotate({ angle: 180 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale4, y: this.scale4 })
      }
      .frameStyle()
      .rotate({ angle: 270 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale5, y: this.scale5 })
      }
      .frameStyle()
      .rotate({ angle: 45 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale6, y: this.scale6 })
      }
      .frameStyle()
      .rotate({ angle: 135 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale7, y: this.scale7 })
      }
      .frameStyle()
      .rotate({ angle: 225 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale8, y: this.scale8 })
      }
      .frameStyle()
      .rotate({ angle: 315 })
    }
    .renderFit(RenderFit.CENTER)
    .width(this.spinSize)
    .height(this.spinSize)
    .onAppear(() => {
      let keyframes1: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale1 = 1
          }
        },
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale1 = 0
          }
        },
        {
          duration: 240,
          curve: Curve.Linear,
          event: () => {

          }
        }];
      let keyframes2: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale2 = 1
          }
        },
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale2 = 0
          }
        },
        {
          duration: 240,
          curve: Curve.Linear,
          event: () => {

          }
        }];
      let keyframes3: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale3 = 1
          }
        },
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale3 = 0
          }
        },
        {
          duration: 240,
          curve: Curve.Linear,
          event: () => {

          }
        }];
      let keyframes4: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale4 = 1
          }
        },
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale4 = 0
          }
        },
        {
          duration: 240,
          curve: Curve.Linear,
          event: () => {

          }
        }];

      let keyframes5: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale5 = 1
          }
        },
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale5 = 0
          }
        },
        {
          duration: 240,
          curve: Curve.Linear,
          event: () => {

          }
        }];
      let keyframes6: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale6 = 1
          }
        },
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale6 = 0
          }
        },
        {
          duration: 240,
          curve: Curve.Linear,
          event: () => {

          }
        }];
      let keyframes7: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale7 = 1
          }
        },
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale7 = 0
          }
        },
        {
          duration: 240,
          curve: Curve.Linear,
          event: () => {

          }
        }];
      let keyframes8: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale8 = 1
          }
        },
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.scale8 = 0
          }
        },
        {
          duration: 240,
          curve: Curve.Linear,
          event: () => {

          }
        }];
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, keyframes1);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -900 }, keyframes2);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -600 }, keyframes3);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -300 }, keyframes4);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -1100 }, keyframes5);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -800 }, keyframes6);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -500 }, keyframes7);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -200 }, keyframes8);
    })
  }

  @Styles
  roundStyle(){
    .width(this.round1)
    .height(this.round1)
    .borderRadius(this.round1)
    .backgroundColor(this.spinColor)
    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  }

  @Styles
  frameStyle(){
    .height('100%')
    .width(this.round1)
  }
}

