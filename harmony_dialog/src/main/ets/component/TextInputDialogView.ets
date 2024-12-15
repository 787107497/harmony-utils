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

import { TextInputOptions } from '../model/TextInputOptions';
import { CustomContentDialog } from '@kit.ArkUI';
import { BaseContentOptions } from '../model/base/BaseContentOptions';
import { CustomContentOptions } from '../model/CustomContentOptions';
import { TextInputModifier } from '../utils/TextInputModifier';
import { CacheHelper } from '../utils/CacheHelper';


/**
 * TODO TextInputDialog组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
@Component
export default struct TextInputDialogView {
  private controller: TextInputController = new TextInputController();
  @Prop options: TextInputOptions;
  @State modifier: TextInputModifier = new TextInputModifier();
  @State content: CustomContentOptions | null = null;
  @State text: string = '';


  aboutToAppear(): void {
    this.text = this.options.text ?? "";
    this.modifier.inputFilter = this.options.inputFilter;
    if (this.options.controller) {
      this.controller = this.options.controller;
    }
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
    CacheHelper.put(`${CacheHelper.CACHE_LABEL}${this.options.dialogId ?? ""}`, this.text);
  }

  build() {
    CustomContentDialog(this.content as BaseContentOptions)
      .height(this.options.height)
      .width(this.options.width)
      .constraintSize({ maxWidth: this.options.maxWidth, maxHeight: this.options.maxHeight })
      .backgroundColor(this.options.backgroundColor)
      .backgroundBlurStyle(this.options.backgroundBlurStyle)
      .borderRadius(this.options.cornerRadius)
      .borderWidth(this.options.borderWidth)
      .borderColor(this.options.borderColor)
      .borderStyle(this.options.borderStyle)
  }


  @Builder
  InputBuilder() {
    TextInput({
      controller: this.controller,
      text: $$this.text,
      placeholder: this.options.placeholder ?? '请输入'
    })
      .type(this.options.inputType ?? InputType.Normal)
      .defaultFocus(this.options.defaultFocus)
      .fontSize(this.options.fontSize)
      .fontColor(this.options.fontColor)
      .fontSize(this.options.fontSize)
      .placeholderColor(this.options.placeholderColor)
      .height(this.options.inputHeight)
      .backgroundColor(this.options.inputBackgroundColor)
      .border(this.options.inputBorder)
      .maxLength(this.options.maxLength == 0 ? Infinity : this.options.maxLength)
      .attributeModifier(this.modifier)
      .onChange((value: string, previewText?: PreviewText) => {
        CacheHelper.put(`${CacheHelper.CACHE_LABEL}${this.options.dialogId ?? ""}`, value ?? "");
        if (this.options.onChange) {
          this.options.onChange(value);
        }
      })
  }


}