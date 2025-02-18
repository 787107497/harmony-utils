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


import { TextPickerOptions } from '../model/TextPickerOptions';
import { ButtonOptions } from '../model/ButtonOptions';
import { Helper } from '../utils/Helper';
import { DialogAction } from '../utils/constraint';
import { DialogHelper } from '../dialog/DialogHelper';


/**
 * TODO TextPickerDialog组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 1029219059
 */
@Preview
@Component
export struct TextPickerDialogView {
  @Prop options: TextPickerOptions;
  @State title: string = ""; //标题
  @State primaryButton?: ButtonOptions = undefined; //弹框左侧按钮。
  @State secondaryButton?: ButtonOptions = undefined; //弹框右侧按钮。
  @State value: string | string[] = '';
  @State range: string[] | string[][] | Resource | TextPickerRangeContent[] | TextCascadePickerRangeContent[] = [];
  @State largeScreen: boolean = false; //是否是大屏手机，例如Pad和展开的折叠屏；默认正常手机


  aboutToAppear(): void {
    this.largeScreen = Helper.isLargeScreen();
    if (this.options.value) {
      this.value = this.options.value;
    } else {
      if (this.options.range instanceof Array) {
        let pickerItem = this.options.range[0];
        if (typeof pickerItem == 'string') { ///string[]
          this.value = pickerItem;
        } else if (pickerItem instanceof Array) { //string[][]
          let selected: string[] = [];
          let range = this.options.range as string[][];
          for (let index = 0; index < range.length; index++) {
            selected.push(range[index][0]);
          }
          this.value = selected;
        } else if ((pickerItem as TextPickerRangeContent).icon) { //TextPickerRangeContent
          this.value = Helper.getResourceStr(pickerItem.text ?? "") ?? ""
        } else {
          this.value = [];
          this.recursionPickerRange(this.options.range as TextCascadePickerRangeContent[])
        }
      } else { //Resource
        let array = getContext().resourceManager.getStringArrayValueSync(this.options.range);
        if (array && array.length > 0) {
          this.value = array[0];
        }
      }
    }
    if (this.options.title) {
      this.title = Helper.getResourceStr(this.options.title) ?? "";
    }
    this.primaryButton = this.options.primaryButton as ButtonOptions;
    this.secondaryButton = this.options.secondaryButton as ButtonOptions;
  }


  /**
   * 递归获取默认值
   */
  recursionPickerRange(pickerRange: TextCascadePickerRangeContent[]) {
    if (pickerRange && pickerRange.length > 0) {
      let range = pickerRange[0];
      (this.value as string[]).push(Helper.getResourceStr(range.text ?? "") ?? "");
      this.recursionPickerRange(range.children ?? []);
    }
  }


  build() {
    Column() {
      Row() {
        Button(this.primaryButton?.value)
          .buttonStyle(this.primaryButton?.buttonStyle ?? ButtonStyleMode.TEXTUAL)
          .role(this.primaryButton?.role ?? ButtonRole.NORMAL)
          .type(ButtonType.Capsule)
          .fontColor(this.primaryButton?.fontColor)
          .backgroundColor(this.primaryButton?.background ?? Color.Transparent)
          .margin({ top: 10, bottom: 10, left: 10 })
          .alignSelf(ItemAlign.Center)
          .align(Alignment.Center)
          .onClick(() => {
            if (this.options.actionCancel){
              DialogHelper.closeDialog(this.options.dialogId ?? "");
            }
            if (this.options.onAction) {
              this.options.onAction(DialogAction.ONE, this.options.dialogId ?? "", this.value);
            }
          })
        Text(this.title)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .fontColor(this.options.titleFontColor)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .ellipsisMode(EllipsisMode.END)
          .maxLines(1)
          .layoutWeight(1)
          .margin(5)
        Button(this.secondaryButton?.value)
          .buttonStyle(this.secondaryButton?.buttonStyle ?? ButtonStyleMode.TEXTUAL)
          .role(this.secondaryButton?.role ?? ButtonRole.NORMAL)
          .fontColor(this.secondaryButton?.fontColor)
          .backgroundColor(this.secondaryButton?.background ?? Color.Transparent)
          .type(ButtonType.Capsule)
          .margin({ top: 10, bottom: 10, right: 10 })
          .alignSelf(ItemAlign.Center)
          .align(Alignment.Center)
          .onClick(() => {
            if (this.options.actionCancel){
              DialogHelper.closeDialog(this.options.dialogId ?? "");
            }
            if (this.options.onAction) {
              this.options.onAction(DialogAction.TWO, this.options.dialogId ?? "", this.value);
            }
          })
      }
      .backgroundColor(this.options.titleBackground)
      .width('100%')

      TextPicker({ range: this.options.range, value: this.value })
        .textStyle(this.options.textStyle)
        .selectedTextStyle(this.options.selectedTextStyle)
        .disappearTextStyle(this.options.disappearTextStyle)
        .divider(this.options.divider)
        .canLoop(this.options.canLoop)
        .margin({ top: 20, bottom: 20 })
        .width('100%')
        .onChange((value: string | string[], index: number | number[]) => {
          this.value = value;
          if (this.options.onChange) {
            this.options.onChange(value, index)
          }
        })
    }
    .backgroundColor(this.options.backgroundColor)
    .backgroundBlurStyle(this.options.backgroundBlurStyle)
    .borderRadius(this.options.cornerRadius)
    .clip(true)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width(this.options.width)
    .constraintSize({ maxWidth: this.options.maxWidth })
    .padding({ bottom: this.largeScreen ? 0 : 25 })
    .margin({ bottom: this.largeScreen ? 30 : 0 })
  }


}