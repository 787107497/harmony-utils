/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-dialog
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

import { Orientation } from '../../../../Index';
import { ToastTipOptions } from '../model/ToastTipOptions';

/**
 * TODO Toast组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 */
@Component
export struct ToastTipView {
  @Prop options: ToastTipOptions;

  build() {
    if (this.options.orientation == Orientation.VERTICAL) {
      Column({ space: this.options.margin ?? 10 }) {
        Image(this.options.imageRes)
          .size(this.options.imageSize)
          .fillColor(this.options.fontColor)
          .margin(2)
        Text(this.options.message)
          .fontColor(this.options.fontColor)
          .fontSize(this.options.fontSize)
      }
      .margin(12)
      .padding(20)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .align(Alignment.Center)
      .alignSelf(ItemAlign.Center)
      .constraintSize({ minWidth: 120 })
      .backgroundColor(this.options.backgroundColor)
      .borderRadius(this.options.borderRadius)
      .shadow(ShadowStyle.OUTER_DEFAULT_SM)
    } else {
      Row({ space: this.options.margin ?? 10 }) {
        Image(this.options.imageRes)
          .size(this.options.imageSize)
          .fillColor(this.options.fontColor)
          .margin({ right: 2 })
        Text(this.options.message)
          .fontColor(this.options.fontColor)
          .fontSize(this.options.fontSize)
      }
      .margin(12)
      .padding(20)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .align(Alignment.Center)
      .alignSelf(ItemAlign.Center)
      .constraintSize({ minWidth: 120 })
      .backgroundColor(this.options.backgroundColor)
      .borderRadius(this.options.borderRadius)
      .shadow(ShadowStyle.OUTER_DEFAULT_SM)
    }
  }

}
