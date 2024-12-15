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
 * 给TextPicker 设置样式
 */
export class TextPickerModifier implements AttributeModifier<TextPickerAttribute> {

  textStyle?: PickerTextStyle; //设置所有选项中除了最上、最下及选中项以外的文本颜色、字号、字体粗细。
  selectedTextStyle?: PickerTextStyle; //设置选中项的文本颜色、字号、字体粗细。
  disappearTextStyle?: PickerTextStyle; //设置所有选项中最上和最下两个选项的文本颜色、字号、字体粗细。
  divider?: DividerOptions | null; //设置分割线样式，不设置该属性则按“默认值”展示分割线。
  canLoop?: boolean; //设置是否可循环滚动。

  applyNormalAttribute(instance: TextPickerAttribute): void {
    if (this.disappearTextStyle) {
      instance.disappearTextStyle(this.disappearTextStyle)
    }
    if (this.textStyle) {
      instance.textStyle(this.textStyle)
    }
    if (this.selectedTextStyle) {
      instance.selectedTextStyle(this.selectedTextStyle)
    }
    if (this.divider) {
      instance.divider(this.divider)
    }
    instance.canLoop(this.canLoop)
  }

}