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


import { PickerOptions } from '../model/PickerOptions';
import { ButtonOptions } from '../model/ButtonOptions';
import { Utils } from '../utils/Utils';
import { JSON } from '@kit.ArkTS';


/**
 * TODO TextPickerDialog组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
@Preview
@Component
export default struct TextPickerDialogView {
  @Prop options: PickerOptions;
  @State title: string = ""; //标题
  @State primaryButton?: ButtonOptions = undefined; //弹框左侧按钮。
  @State secondaryButton?: ButtonOptions = undefined; //弹框右侧按钮。
  @State range: string[] | string[][] | Resource | TextPickerRangeContent[] | TextCascadePickerRangeContent[] = [];

  aboutToAppear(): void {
    this.range = this.options.range ?? [];
    if (this.options.title) {
      this.title = Utils.getResourceStr(this.options.title) ?? "";
    }
    this.primaryButton = this.options.primaryButton as ButtonOptions;
    this.secondaryButton = this.options.secondaryButton as ButtonOptions;

    console.error("primaryButton： " + JSON.stringify(this.primaryButton))
    console.error("secondaryButton： " + JSON.stringify(this.secondaryButton))
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
        Text(this.title)
          .fontSize(16)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .margin(5)
          .fontColor($r("sys.color.ohos_id_picker_title_text_color"))
        Button(this.secondaryButton?.value)
          .buttonStyle(this.secondaryButton?.buttonStyle ?? ButtonStyleMode.TEXTUAL)
          .role(this.secondaryButton?.role ?? ButtonRole.NORMAL)
          .fontColor(this.secondaryButton?.fontColor)
          .backgroundColor(this.secondaryButton?.background ?? Color.Transparent)
          .type(ButtonType.Capsule)
          .margin({ top: 10, bottom: 10, right: 10 })
      }
      .backgroundColor("#F9F9F9")

      // value: ResourceStr = ''; //按钮的内容。
      // fontColor?: ResourceColor; //按钮的字体颜色。
      // action?: VoidCallback; //按钮的点击事件，大多数按钮不需要实现这个点击事件
      // background?: ResourceColor; //按钮的背景。
      // buttonStyle?: ButtonStyleMode; //按钮的样式。默认值：2in1设备为ButtonStyleMode.NORMAL，其他设备为ButtonStyleMode.TEXTUAL。
      // role?: ButtonRole; //按钮的角色。默认值：ButtonRole.NORMAL。

      TextPicker({ range: this.range, value: this.options.value, selected: this.options.selected })
        .width('100%')
        .margin({ top: 20, bottom: 20 })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.options.backgroundColor)
    .constraintSize({ maxWidth: this.options.maxWidth })
    .padding({ bottom: 25 })
  }
}