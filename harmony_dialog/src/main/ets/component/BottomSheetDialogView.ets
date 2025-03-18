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
import { ActionSheetOptions } from '../model/ActionSheetOptions';
import { DialogThemeColorMode } from '../utils/constraint';
import { Helper } from '../utils/Helper';
import { display } from '@kit.ArkUI';


/**
 * TODO BottomSheetDialog组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 */
@Component
export struct BottomSheetDialogView {
  @Prop options: BottomSheetOptions;
  @State title: string = ""; //标题
  @State fontSize: number | string | Resource = 16; //按钮的文字大小，字体大小16。
  @State statusBarHeight: number = 0; //状态栏高度
  @State indicatorHeight: number = 0; //底部导航条的高度
  @State isLargeScreen: boolean = false; //是否是大屏
  @StorageProp(DialogThemeColorMode) themeColorMode: ThemeColorMode =
    this.options.themeColorMode ?? ThemeColorMode.SYSTEM; //设置深色浅色，默认跟随系统。
  private foldStatusCallback: Callback<display.FoldStatus> = (foldStatus: display.FoldStatus) => {
    this.isLargeScreen = Helper.isLargeScreen();
  }

  aboutToAppear(): void {
    if (this.options.title) {
      this.title = Helper.getResourceStr(this.options.title) ?? "";
    }
    if (this.options.sheets && this.options.sheets.length >= 1) {
      let fontSize = (this.options.sheets[0] as ActionSheetOptions).fontSize;
      if (fontSize) {
        this.fontSize = fontSize;
      }
    }
    this.statusBarHeight = Helper.getStatusBarHeight();
    this.indicatorHeight = Helper.getIndicatorHeight();
    this.isLargeScreen = Helper.isLargeScreen();
    //开启折叠设备折叠状态变化的监听。
    display.on('foldStatusChange', this.foldStatusCallback);
  }

  aboutToDisappear(): void {
    //关闭折叠设备折叠状态变化的监听。
    display.off('foldStatusChange', this.foldStatusCallback);
  }


  build() {
    WithTheme({ colorMode: this.themeColorMode }) {
      List() {
        ListItemGroup({ header: this.headBuilder(), footer: this.footBuilder() }) {
          ForEach(this.options.sheets, (sheet: ActionSheetOptions, index: number) => {
            this.itemBuilder(sheet.value, sheet.fontColor ?? $r('app.color.harmony_dialog_text_color'),
              sheet.fontSize ?? 16, index)
          }, (sheet: ActionSheetOptions, index: number) => `${index}-${sheet.value}`)
        }
        .divider({ strokeWidth: 1, color: $r('app.color.harmony_dialog_divider_color') })
        .backgroundColor(Color.Transparent)
      }
      .sticky(StickyStyle.Header | StickyStyle.Footer)
      .edgeEffect(EdgeEffect.None)
      .width(this.options.width)
      .height(this.options.height ?? "auto")
      .constraintSize({ maxWidth: this.options.maxWidth, maxHeight: this.options.maxHeight })
      .margin({ top: this.statusBarHeight, bottom: this.isLargeScreen ? this.indicatorHeight : 0 })
      .backgroundColor(this.options.backgroundColor)
      .backgroundBlurStyle(this.options.backgroundBlurStyle)
      .borderRadius(this.options.cornerRadius)
      .clip(true)
    }
  }


  //列表Item
  @Builder
  itemBuilder(value: ResourceStr, fontColor: ResourceColor, fontSize: number | string | Resource, index: number) {
    Text(value)
      .fontSize(fontSize)
      .fontColor(fontColor)
      .align(Alignment.Center)
      .textAlign(TextAlign.Center)
      .padding({ top: 18, bottom: 18, left: 10, right: 10 })
      .width('100%')
      .backgroundColor(this.options.backgroundColor)
      .backgroundBlurStyle(this.options.backgroundBlurStyle)
      .onClick(() => {
        if (this.options.actionCancel){
          DialogHelper.closeDialog(this.options.dialogId ?? "");
        }
        if (this.options.onAction) {
          this.options.onAction(index, this.options.dialogId ?? "");
        }
      })
  }


  //标题
  @Builder
  headBuilder() {
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
    .backgroundColor(this.options.backgroundColor)
    .backgroundBlurStyle(this.options.backgroundBlurStyle)
    .visibility(this.title.length > 0 ? Visibility.Visible : Visibility.None)
  }


  //底部按钮
  @Builder
  footBuilder() {
    Column({ space: 0 }) {
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
        .padding({ top: 18, bottom: this.isLargeScreen ? 18 : 10, left: 10, right: 10 })
        .margin({ bottom: this.isLargeScreen ? 0 : Helper.getIndicatorHeight() })
        .onClick(() => {
          DialogHelper.closeDialog(this.options.dialogId ?? "");
        })
    }
    .width('100%')
    .backgroundColor(this.options.backgroundColor)
    .backgroundBlurStyle(this.options.backgroundBlurStyle)
  }


}