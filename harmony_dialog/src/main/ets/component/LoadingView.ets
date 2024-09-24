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
 *
 * https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 */

import { LoadingOptions } from '../model/LoadingOptions';

/**
 * TODO Loading组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
@Component
export default struct LoadingView {
  @Prop options: LoadingOptions;
  @State content: string = '';

  aboutToAppear(): void {
    if (this.options.content) {
      if (typeof this.options.content === 'string') {
        this.content = this.options.content;
      } else {
        this.content = getContext().resourceManager.getStringSync(this.options.content.id);
      }
    }
  }

  build() {
    Column() {
      LoadingProgress()
        .height(this.options.loadSize)
        .width(this.options.loadSize)
        .color(this.options.loadColor)
      Text(this.options.content)
        .textAlign(TextAlign.Center)
        .margin({ top: 5 })
        .fontSize(this.options.fontSize)
        .fontColor(this.options.fontColor)
        .visibility(this.content.length > 0 ? Visibility.Visible : Visibility.None)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .margin(12)
    .constraintSize({ minWidth: 100, minHeight: 100 })
    .padding(20)
    .backgroundColor(this.options.backgroundColor)
    .borderRadius(this.options.borderRadius)
    .shadow(ShadowStyle.OUTER_DEFAULT_SM)
  }
}