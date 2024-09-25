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

import { CustomContentDialog } from '@kit.ArkUI';
import { BaseContentOptions } from '../model/base/BaseContentOptions';
import { CustomContentOptions } from '../model/CustomContentOptions';
import { TextAreaOptions } from '../model/TextAreaOptions';
import { CacheUtil } from '../utils/CacheUtil';
import { TextAlignment } from '../utils/constraint';


/**
 * TODO TextAreaDialog组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
@Component
export default struct TextAreaDialogView {
  private controller: TextInputController = new TextInputController()
  @Prop options: TextAreaOptions;
  @State content: CustomContentOptions | null = null;
  @State textAlignment: Alignment = Alignment.Top;

  aboutToAppear(): void {
    CacheUtil.put<string>(this.options.dialogId ?? "", this.options.text);
    this.content = {
      primaryTitle: this.options.primaryTitle,
      secondaryTitle: this.options.secondaryTitle,
      localizedContentAreaPadding: this.options.localizedContentAreaPadding,
      contentAreaPadding: this.options.contentAreaPadding,
      contentBuilder: () => {
        this.InputBuilder()
      }
    }
    this.content.buttons = this.options.buttons;
    if (this.options.align == TextAlignment.Bottom) {
      this.textAlignment = Alignment.Bottom;
    } else if (this.options.align == TextAlignment.Center) {
      this.textAlignment = Alignment.Center;
    } else {
      this.textAlignment = Alignment.Top;
    }
  }

  build() {
    CustomContentDialog(this.content as BaseContentOptions)
      .height(this.options.height)
      .width(this.options.width)
      .constraintSize({ maxWidth: this.options.maxWidth })
      .backgroundColor(this.options.backgroundColor)
      .backgroundBlurStyle(this.options.backgroundBlurStyle)
      .borderRadius(this.options.cornerRadius)
      .borderWidth(this.options.borderWidth)
      .borderColor(this.options.borderColor)
      .borderStyle(this.options.borderStyle)
  }

  @Builder
  InputBuilder() {
    TextArea({
      controller: this.controller,
      text: this.options.text,
      placeholder: this.options.placeholder ?? '请输入'
    })
      .width('100%')
      .padding({ top: 12, bottom: 12 })
      .type(this.options.inputType ?? TextAreaType.NORMAL)
      .fontSize(this.options.fontSize ?? 16)
      .fontColor(this.options.fontColor)
      .fontSize(this.options.fontSize)
      .placeholderColor(this.options.placeholderColor)
      .textAlign(this.options.textAlign)
      .align(this.textAlignment)
      .lineHeight(this.options.inputLineHeight)
      .height(this.options.inputHeight ?? 155)//默认155
      .backgroundColor(this.options.inputBackgroundColor)
      .border(this.options.inputBorder ?? { radius: 8 })
      .onChange((value: string, previewText?: PreviewText) => {
        CacheUtil.put<string>(this.options.dialogId ?? "", value ?? "")
        if (this.options.onChange) {
          this.options.onChange(value);
        }
      })
  }
}