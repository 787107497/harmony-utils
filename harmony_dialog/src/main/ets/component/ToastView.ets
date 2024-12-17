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

import { ToastOptions } from '../model/ToastOptions';

/**
 * TODO Toast组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
@Component
export default struct ToastView {
  @Prop options: ToastOptions;

  build() {
    Column() {
      Text(this.options.message)
        .fontColor(this.options.fontColor)
        .fontSize(this.options.fontSize)
        .padding({ left: 10, right: 10 })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .align(Alignment.Center)
    .alignSelf(ItemAlign.Center)
    .constraintSize({ minWidth: 90 })
    .margin({ left: 15, right: 15 })
    .padding(this.options.padding)
    .backgroundColor(this.options.backgroundColor)
    .borderRadius(this.options.borderRadius)
    .shadow(ShadowStyle.OUTER_DEFAULT_SM)
  }

}
