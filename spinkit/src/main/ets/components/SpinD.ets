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
export struct SpinD {
  @State spinSize: number = 60;
  @State spinColor: ResourceColor = Color.White;
  @State x1: number = 0;
  @State y1: number = 0;
  @State scale1: number = 1;
  @State angle1: number = 0;
  @State x2: number = this.spinSize * 0.65;
  @State y2: number = this.spinSize * 0.65;
  @State scale2: number = 1;
  @State angle2: number = 0;

  aboutToAppear(): void {
    this.x2 = this.spinSize * 0.65;
    this.y2 = this.spinSize * 0.65;
  }

  build() {
    RelativeContainer() {
      Canvas()
        .chunkStyle()
        .translate({ x: this.x1, y: this.y1 })
        .scale({ x: this.scale1, y: this.scale1 })
        .rotate({ angle: this.angle1 })

      Canvas()
        .chunkStyle()
        .translate({ x: this.x2, y: this.y2 })
        .scale({ x: this.scale2, y: this.scale2 })
        .rotate({ angle: this.angle2 })
    }
    .width(this.spinSize)
    .height(this.spinSize)
    .onAppear(() => {
      let keyframes1: Array<KeyframeState> = [
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale1 = 0.5;
            this.angle1 = -90
            this.x1 = this.spinSize * 0.65
          }
        },
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale1 = 1;
            this.angle1 = -180
            this.x1 = this.spinSize * 0.65
            this.y1 = this.spinSize * 0.65
          }
        },
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale1 = 0.5;
            this.angle1 = -270;
            this.x1 = 0
            this.y1 = this.spinSize * 0.65
          }
        },
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale1 = 1;
            this.angle1 = -360
            this.x1 = 0
            this.y1 = 0
          }
        }];
      let keyframes2: Array<KeyframeState> = [
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale2 = 0.5;
            this.angle2 = -90;
            this.x2 = 0
            this.y2 = this.spinSize * 0.65
          }
        },
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale2 = 1;
            this.angle2 = -180
            this.x2 = 0
            this.y2 = 0
          }
        },
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale2 = 0.5;
            this.angle2 = -270
            this.x2 = this.spinSize * 0.65
          }
        },
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.scale2 = 1;
            this.angle2 = -360
            this.x2 = this.spinSize * 0.65
            this.y2 = this.spinSize * 0.65
          }
        }
      ];
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, keyframes1);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, keyframes2);
    })
  }

  @Styles
  chunkStyle(){
    .height(this.spinSize * 0.35)
    .width(this.spinSize * 0.35)
    .backgroundColor(this.spinColor)
    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  }
}