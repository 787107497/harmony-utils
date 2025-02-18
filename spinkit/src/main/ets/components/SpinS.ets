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
export struct SpinS {
  @Require @Param spinSize: number = 36;
  @Require @Param spinColor: ResourceColor;
  @Local round1: number = this.spinSize * 0.2
  @Local scale1: number = 1;
  @Local scale2: number = 0.3;
  @Local scale3: number = 0.4;
  @Local scale4: number = 0.5;
  @Local scale5: number = 0.6;
  @Local scale6: number = 0.7;
  @Local scale7: number = 0.8;
  @Local scale8: number = 0.9;
  @Local angle1: number = 0;

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
      .frame1Style()
      .rotate({ angle: 0 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale2, y: this.scale2 })
      }
      .frame1Style()
      .rotate({ angle: 45 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale3, y: this.scale3 })
      }
      .frame1Style()
      .rotate({ angle: 90 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale4, y: this.scale4 })
      }
      .frame1Style()
      .rotate({ angle: 135 })


      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale5, y: this.scale5 })
      }
      .frame1Style()
      .rotate({ angle: 180 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale6, y: this.scale6 })
      }
      .frame1Style()
      .rotate({ angle: 225 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale7, y: this.scale7 })
      }
      .frame1Style()
      .rotate({ angle: 270 })

      Column() {
        Canvas()
          .roundStyle()
          .scale({ x: this.scale8, y: this.scale8 })
      }
      .frame1Style()
      .rotate({ angle: 315 })
    }
    .renderFit(RenderFit.CENTER)
    .width(this.spinSize)
    .height(this.spinSize)
    .rotate({ angle: this.angle1 })
    .onAppear(() => {
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, [{
        duration: 1200,
        curve: Curve.Linear,
        event: () => {
          this.angle1 = 360
        }
      }]);
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
  frame1Style(){
    .height('100%')
    .width(this.round1)
  }
}

