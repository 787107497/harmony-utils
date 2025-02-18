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
export struct SpinJ {
  @Require @Param spinSize: number = 36;
  @Require @Param spinColor: ResourceColor;
  @Local scaleSize: number = this.spinSize * 0.75;
  @Local tran1: number = 0;
  private oldSize: number = this.spinSize;


  aboutToAppear(): void {
    this.oldSize = this.spinSize;
    this.scaleSize = this.spinSize * 0.75;
  }

  build() {
    Stack() {
      Grid() {
        GridItem() {
          Canvas().chunkStyle()
        }.translate({ x: this.tran1 })

        GridItem() {
          Canvas().chunkStyle()
        }.translate({ x: this.tran1 })

        GridItem() {
          Canvas().chunkStyle()
        }.translate({ y: this.tran1 })

        GridItem() {
          Canvas().chunkStyle()
        }.translate({ y: -this.tran1 })

        GridItem() {
          Canvas().chunkStyle()
        }

        GridItem() {
          Canvas().chunkStyle()
        }.translate({ y: this.tran1 })

        GridItem() {
          Canvas().chunkStyle()
        }.translate({ y: -this.tran1 })

        GridItem() {
          Canvas().chunkStyle()
        }.translate({ x: -this.tran1 })

        GridItem() {
          Canvas().chunkStyle()
        }.translate({ x: -this.tran1 })
      }
      .rowsTemplate('1fr 1fr 1fr')
      .columnsTemplate('1fr 1fr 1fr')
      .width(this.scaleSize)
      .height(this.scaleSize)
    }
    .width(this.oldSize)
    .height(this.oldSize)
    .alignContent(Alignment.Center)
    .onAppear(() => {
      this.getUIContext().keyframeAnimateTo({ iterations: -1, delay: 0 }, [
        {
          duration: 500,
          curve: Curve.EaseInOut,
          event: () => {
            this.tran1 = 0
            this.scaleSize = this.oldSize * 1.1
          }
        },
        {
          duration: 190,
          curve: Curve.Linear,
          event: () => {
            this.tran1 = this.oldSize / 3
          }
        },
        {
          duration: 0,
          curve: Curve.Linear,
          event: () => {
            this.tran1 = 0
          }
        },
        {
          duration: 10,
          curve: Curve.Linear,
          event: () => {

          }
        },
        {
          duration: 500,
          curve: Curve.EaseIn,
          event: () => {
            this.scaleSize = this.oldSize * 0.75
            this.tran1 = 0
          }
        }
      ])
    })
  }

  @Styles
  chunkStyle(){
    .width(this.oldSize * 0.25)
    .height(this.oldSize * 0.25)
    .backgroundColor(this.spinColor)
    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  }
}

