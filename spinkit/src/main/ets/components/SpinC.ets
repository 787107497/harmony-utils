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
export struct SpinC {
  @State spinSize: number = 60;
  @State spinColor: ResourceColor = Color.White;
  @State scale1: number = 0.4;
  @State scale2: number = 0.4;
  @State scale3: number = 0.4;
  @State scale4: number = 0.4;
  @State scale5: number = 0.4;

  build() {
    Row() {
      Canvas()
        .chunkStyle()
        .scale({ y: this.scale1 })

      Canvas()
        .chunkStyle()
        .scale({ y: this.scale2 })

      Canvas()
        .chunkStyle()
        .scale({ y: this.scale3 })

      Canvas()
        .chunkStyle()
        .scale({ y: this.scale4 })

      Canvas()
        .chunkStyle()
        .scale({ y: this.scale5 })
    }
    .width(this.spinSize)
    .height(this.spinSize * 0.8)
    .onAppear(() => {
      let keyframes1: Array<KeyframeState> = [
        {
          duration: 240,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale1 = 1;
          }
        },
        {
          duration: 240,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale1 = 0.4;
          }
        },
        {
          duration: 720,
          event: () => {

          }
        }
      ];
      let keyframes2: Array<KeyframeState> = [
        {
          duration: 240,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale2 = 1;
          }
        },
        {
          duration: 240,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale2 = 0.4;
          }
        },
        {
          duration: 720,
          event: () => {

          }
        }
      ];
      let keyframes3: Array<KeyframeState> = [
        {
          duration: 240,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale3 = 1;
          }
        },
        {
          duration: 240,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale3 = 0.4;
          }
        },
        {
          duration: 720,
          event: () => {

          }
        }
      ];
      let keyframes4: Array<KeyframeState> = [
        {
          duration: 240,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale4 = 1;
          }
        },
        {
          duration: 240,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale4 = 0.4;
          }
        },
        {
          duration: 720,
          event: () => {

          }
        }
      ];
      let keyframes5: Array<KeyframeState> = [
        {
          duration: 240,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale5 = 1;
          }
        },
        {
          duration: 240,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale5 = 0.4;
          }
        },
        {
          duration: 720,
          event: () => {

          }
        }
      ];
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, keyframes1);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -1100 }, keyframes2);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -1000 }, keyframes3);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -900 }, keyframes4);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: -800 }, keyframes5);
    })
  }

  @Styles
  chunkStyle(){
    .height('100%')
    .width('14%')
    .margin({ left: '3%', right: '3%' })
    .backgroundColor(this.spinColor)
    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  }
}