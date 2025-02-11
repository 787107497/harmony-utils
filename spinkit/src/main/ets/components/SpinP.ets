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
export struct SpinP {
  @Require @Param spinSize: number = 36;
  @Require @Param spinColor: ResourceColor;
  @Local round1: number = this.spinSize * 0.2
  @Local opacity1: number = 0;
  @Local opacity2: number = 0;
  @Local opacity3: number = 0;
  @Local opacity4: number = 0;
  @Local opacity5: number = 0;
  @Local opacity6: number = 0;
  @Local opacity7: number = 0;
  @Local opacity8: number = 0;
  @Local opacity9: number = 0;

  aboutToAppear(): void {
    this.round1 = this.spinSize * 0.2
  }

  build() {
    Stack() {
      Column() {
        Canvas()
          .roundStyle()
          .opacity(this.opacity1)
      }
      .frameStyle()
      .rotate({ angle: 0 })

      Column() {
        Canvas()
          .roundStyle()
          .opacity(this.opacity2)
      }
      .frameStyle()
      .rotate({ angle: 40 })

      Column() {
        Canvas()
          .roundStyle()
          .opacity(this.opacity3)
      }
      .frameStyle()
      .rotate({ angle: 80 })

      Column() {
        Canvas()
          .roundStyle()
          .opacity(this.opacity4)
      }
      .frameStyle()
      .rotate({ angle: 120 })

      Column() {
        Canvas()
          .roundStyle()
          .opacity(this.opacity5)
      }
      .frameStyle()
      .rotate({ angle: 160 })

      Column() {
        Canvas()
          .roundStyle()
          .opacity(this.opacity6)
      }
      .frameStyle()
      .rotate({ angle: 200 })

      Column() {
        Canvas()
          .roundStyle()
          .opacity(this.opacity7)
      }
      .frameStyle()
      .rotate({ angle: 240 })

      Column() {
        Canvas()
          .roundStyle()
          .opacity(this.opacity8)
      }
      .frameStyle()
      .rotate({ angle: 280 })

      Column() {
        Canvas()
          .roundStyle()
          .opacity(this.opacity9)
      }
      .frameStyle()
      .rotate({ angle: 320 })

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
            this.opacity1 = 1
          }
        },
        {
          duration: 720,
          curve: Curve.Linear,
          event: () => {
            this.opacity1 = 0
          }
        }];
      let keyframes2: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.opacity2 = 1
          }
        },
        {
          duration: 720,
          curve: Curve.Linear,
          event: () => {
            this.opacity2 = 0
          }
        }];
      let keyframes3: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.opacity3 = 1
          }
        },
        {
          duration: 720,
          curve: Curve.Linear,
          event: () => {
            this.opacity3 = 0
          }
        }];
      let keyframes4: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.opacity4 = 1
          }
        },
        {
          duration: 720,
          curve: Curve.Linear,
          event: () => {
            this.opacity4 = 0
          }
        }];
      let keyframes5: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.opacity5 = 1
          }
        },
        {
          duration: 720,
          curve: Curve.Linear,
          event: () => {
            this.opacity5 = 0
          }
        }];
      let keyframes6: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.opacity6 = 1
          }
        },
        {
          duration: 720,
          curve: Curve.Linear,
          event: () => {
            this.opacity6 = 0
          }
        }];
      let keyframes7: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.opacity7 = 1
          }
        },
        {
          duration: 720,
          curve: Curve.Linear,
          event: () => {
            this.opacity7 = 0
          }
        }];
      let keyframes8: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.opacity8 = 1
          }
        },
        {
          duration: 720,
          curve: Curve.Linear,
          event: () => {
            this.opacity8 = 0
          }
        }];
      let keyframes9: Array<KeyframeState> = [
        {
          duration: 480,
          curve: Curve.Linear,
          event: () => {
            this.opacity9 = 1
          }
        },
        {
          duration: 720,
          curve: Curve.Linear,
          event: () => {
            this.opacity9 = 0
          }
        }];
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, keyframes1);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -1067 }, keyframes2);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -934 }, keyframes3);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -801 }, keyframes4);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -668 }, keyframes5);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -535 }, keyframes6);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -402 }, keyframes7);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -268 }, keyframes8);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -134 }, keyframes9);

    })
  }

  @Styles
  roundStyle(){
    .width(this.round1 / 2)
    .height(this.round1 * 1.2)
    .borderRadius(0)
    .backgroundColor(this.spinColor)
    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  }

  @Styles
  frameStyle(){
    .height('100%')
    .width(this.round1)
  }
}
