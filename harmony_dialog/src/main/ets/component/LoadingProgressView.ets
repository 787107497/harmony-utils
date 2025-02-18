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

import { LoadingProgressOptions } from '../model/LoadingProgressOptions';
import { Helper } from '../utils/Helper';

/**
 * TODO LoadingProgress组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 1029219059
 */
@Component
export struct LoadingProgressView {
  @Prop options: LoadingProgressOptions;
  @State content: string = '';

  aboutToAppear(): void {
    if (this.options.content) {
      this.content = Helper.getResourceStr(this.options.content) ?? "";
    }
  }

  build() {
    Column() {
      Stack() {
        Progress({ value: this.options.progress, total: 100, type: ProgressType.Ring })
          .width('100%')
          .height('100%')
          .color(this.options.loadColor)
          .backgroundColor("#66FFFFFF")
          .style({ strokeWidth: 6, enableSmoothEffect: false })
        Text(`${this.options.progress > 100 ? 100 : this.options.progress}%`)
          .width('100%')
          .height('100%')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.options.loadColor)
          .textAlign(TextAlign.Center)
      }
      .height((this.options.loadSize))
      .width((this.options.loadSize))

      Text(this.options.content)
        .textAlign(TextAlign.Center)
        .margin({ top: 12 })
        .fontSize(this.options.fontSize)
        .fontColor(this.options.fontColor)
        .visibility(this.content.length > 0 ? Visibility.Visible : Visibility.None)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .margin(5)
    .padding(this.options.padding)
    .backgroundColor(this.options.backgroundColor)
    .borderRadius(this.options.borderRadius)
    .shadow(this.options.shadow)
    .constraintSize({
      minWidth: (this.content.length > 0 ? 116 : 96),
      minHeight: (this.content.length > 0 ? 116 : 96)
    })
  }


}