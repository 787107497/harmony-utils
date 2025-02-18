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

import { DialogHelper } from '../dialog/DialogHelper';
import { BottomSheetOptions } from '../model/BottomSheetOptions';
import { SheetOptions } from '../model/SheetOptions';
import { Helper } from '../utils/Helper';


/**
 * TODO BottomSheetDialog组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 1029219059
 */
@Component
export struct BottomSheetDialogView {
  @Prop options: BottomSheetOptions;
  @State title: string = ""; //标题
  @State fontSize: number | string | Resource = 16; //按钮的文字大小，字体大小16。
  @State largeScreen: boolean = false; //是否是大屏手机，例如Pad和展开的折叠屏；默认正常手机

  aboutToAppear(): void {
    this.largeScreen=  Helper.isLargeScreen();
    if (this.options.title) {
      this.title = Helper.getResourceStr(this.options.title) ?? "";
    }
    if (this.options.sheets && this.options.sheets.length >= 1) {
      let fontSize = (this.options.sheets[0] as SheetOptions).fontSize;
      if (fontSize) {
        this.fontSize = fontSize;
      }
    }
  }


  build() {
    Column({ space: 0 }) {
      Column() {
        Text(this.title)
          .fontSize(14)
          .fontColor(this.options.titleFontColor ?? $r('app.color.harmony_dialog_title_color'))
          .align(Alignment.Center)
          .textAlign(TextAlign.Center)
          .padding({ left: 10, right: 10, bottom: 15, top: 15 })
          .width('100%')
        Divider()
          .width('100%')
          .strokeWidth(1)
          .color($r('app.color.harmony_dialog_divider_color'))
      }
      .width('100%')
      .visibility(this.title.length > 0 ? Visibility.Visible : Visibility.None)

      List() {
        ForEach(this.options.sheets, (sheet: SheetOptions, index: number) => {
          this.TextBuilder(sheet.value, sheet.fontColor ?? $r('app.color.harmony_dialog_text_color'), sheet.fontSize ?? 16, index)
        }, (sheet: SheetOptions, index: number) => `${index}-${sheet.value}`)
      }
      .divider({ strokeWidth: 1, color: $r('app.color.harmony_dialog_divider_color') })
      .width('100%')
      .layoutWeight(this.options.maxHeight ? 1 : 0)

      Divider()
        .width('100%')
        .strokeWidth(10)
        .color($r('app.color.harmony_dialog_divider_color'))

      Text(this.options.cancelValue)
        .fontSize(this.fontSize)
        .fontColor(this.options.cancelFontColor ?? $r('sys.color.ohos_id_picker_button_text_color'))
        .fontWeight(this.options.cancelFontWeight ?? FontWeight.Bold)
        .align(Alignment.Center)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 20, bottom: 20, left: 10, right: 10 })
        .margin({ bottom: this.largeScreen ? 0 : 20 })
        .onClick(()=>{
          DialogHelper.closeDialog(this.options.dialogId ?? "");
        })
    }
    .backgroundColor(this.options.backgroundColor)
    .backgroundBlurStyle(this.options.backgroundBlurStyle)
    .borderRadius(this.options.cornerRadius)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width(this.options.width)
    .height(this.options.height ?? "auto")
    .constraintSize({ maxWidth: this.options.maxWidth, maxHeight: this.options.maxHeight })
    .margin({ bottom: this.largeScreen ? 30 : 0 })
  }


  @Builder
  TextBuilder(value: ResourceStr, fontColor: ResourceColor, fontSize: number | string | Resource, index: number) {
    Text(value)
      .fontSize(fontSize)
      .fontColor(fontColor)
      .align(Alignment.Center)
      .textAlign(TextAlign.Center)
      .width('100%')
      .padding({ top: 20, bottom: 20, left: 10, right: 10 })
      .onClick(() => {
        if (this.options.actionCancel){
          DialogHelper.closeDialog(this.options.dialogId ?? "");
        }
        if (this.options.onAction) {
          this.options.onAction(index, this.options.dialogId ?? "");
        }
      })
  }


}