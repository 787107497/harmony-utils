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

import { DialogHelper } from '../dialog/DialogHelper';
import { BottomSheetOptions } from '../model/BottomSheetOptions';
import { SheetOptions } from '../model/SheetOptions';


/**
 * TODO ActionSheetDialog组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
@Component
export default struct ActionSheetDialogView {
  @Prop options: BottomSheetOptions;
  @State title: string = ""; //标题
  @State fontSize: number | string | Resource = 16; //按钮的文字大小，字体大小16。

  aboutToAppear(): void {
    if (this.options.title) {
      if (typeof this.options.title === 'string') {
        this.title = this.options.title;
      } else {
        this.title = getContext().resourceManager.getStringSync(this.options.title.id);
      }
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
        Column() {
          Text(this.options.title)
            .fontSize(14)
            .fontColor(this.options.titleFontColor ?? $r('app.color.color_99'))
            .align(Alignment.Center)
            .textAlign(TextAlign.Center)
            .width('100%')
            .padding({ left: 10, right: 10, bottom: 15, top: 15 })
          Divider()
            .width('100%')
            .strokeWidth(1)
            .color($r('app.color.color_line'))
        }
        .width('100%')
        .visibility(this.title.length > 0 ? Visibility.Visible : Visibility.None)

        List() {
          ForEach(this.options.sheets, (sheet: SheetOptions, index: number) => {
            this.TextBuilder(sheet.value, sheet.fontColor ?? $r('app.color.color_33'), sheet.fontSize ?? 16, index)
          }, (sheet: SheetOptions, index: number) => `${index}-${sheet.value}`)
        }
        .divider({ strokeWidth: 1, color: $r('app.color.color_line') })
        .width('100%')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(this.options.backgroundColor)
      .borderRadius(this.options.cornerRadius)
      .shadow(ShadowStyle.OUTER_DEFAULT_SM)
      .width('100%')
      .margin({ bottom: 10 })

      Text(this.options.cancelValue)
        .fontSize(this.fontSize)
        .fontColor($r('app.color.color_cancel'))
        .fontWeight(FontWeight.Bold)
        .align(Alignment.Center)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 20, bottom: 20, left: 10, right: 10 })
        .backgroundColor(this.options.backgroundColor)
        .borderRadius(this.options.cornerRadius)
        .shadow(ShadowStyle.OUTER_DEFAULT_SM)
        .width('100%')
        .onClick(()=>{
          DialogHelper.closeDialog(this.options.dialogId ?? "");
        })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width(this.options.width)
    .height(this.options.height)
    .margin({ bottom: 30 })
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
          this.options.onAction(index, this.options.dialogId ?? "", "");
        }
      })
  }
}