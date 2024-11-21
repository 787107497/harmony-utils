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


/**
 * TODO PickerDialog组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
@Preview
@Component
export default struct PickerDialogView {
  // @Prop options: PickerOptions;
  private pefruits: string[] = ['peach1', 'peach2', 'peach3', 'peach4', 'peach5', 'peach6', 'peach7', 'peach8']

  aboutToAppear(): void {

  }

  build() {
    Column() {
      Row() {
        Button("取消")
          .type(ButtonType.Capsule)
          .buttonStyle(ButtonStyleMode.TEXTUAL)
          .margin({ top: 5, bottom: 5 })
        Text("11月还有多款新机发布").fontSize(16)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .margin(5)
        Button("确定")
          .type(ButtonType.Capsule)
          .buttonStyle(ButtonStyleMode.NORMAL)
          .margin({ top: 5, bottom: 5 })
      }
      .backgroundColor(Color.Gray)


      TextPicker({ range: this.pefruits })
        .width('100%')
        .margin({ top: 20, bottom: 20 })
    }

  }
}