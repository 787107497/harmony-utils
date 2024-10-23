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
export struct SpinP {
  @State spinSize: number = 60;
  @State spinColor: ResourceColor = Color.White;
  @State angle1: number = 0;
  @State angle2: number = 0;
  @State angle3: number = 0;

  build() {
    Stack() {
      Canvas()
        .width(this.spinSize)
        .height(this.spinSize)
        .border({
          width: this.spinSize * 0.08,
          radius: this.spinSize,
          color: { top: this.spinColor, right: this.spinColor, bottom: Color.Transparent, left: Color.Transparent },
        })
        .rotate({ angle: this.angle1 })

      Canvas()
        .width(this.spinSize * 0.65)
        .height(this.spinSize * 0.65)
        .border({
          width: this.spinSize * 0.08,
          radius: this.spinSize,
          color: { top: this.spinColor, right: this.spinColor, bottom: Color.Transparent, left: Color.Transparent },
        })
        .rotate({ angle: this.angle2 })

      Canvas()
        .width(this.spinSize * 0.3)
        .height(this.spinSize * 0.3)
        .border({
          width: this.spinSize * 0.08,
          radius: this.spinSize,
          color: { top: this.spinColor, right: this.spinColor, bottom: Color.Transparent, left: Color.Transparent },
        })
        .rotate({ angle: this.angle3 })
    }
    .renderFit(RenderFit.CENTER)
    .width(this.spinSize)
    .height(this.spinSize)
    .onAppear(() => {
      let keyframes1: Array<KeyframeState> = [
        {
          duration: 2000,
          curve: Curve.Linear,
          event: () => {
            this.angle1 = 360
          }
        }];
      let keyframes2: Array<KeyframeState> = [
        {
          duration: 1750,
          curve: Curve.Linear,
          event: () => {
            this.angle2 = -360
          }
        }];
      let keyframes3: Array<KeyframeState> = [
        {
          duration: 1500,
          curve: Curve.EaseInOut,
          event: () => {
            this.angle3 = 360
          }
        }];
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, keyframes1);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, keyframes2);
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, keyframes3);
    })
  }
}

