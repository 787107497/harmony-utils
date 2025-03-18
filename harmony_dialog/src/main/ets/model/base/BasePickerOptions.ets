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


import { BaseDialogOptions } from './BaseDialogOptions';
import { ButtonOptions } from '../ButtonOptions';


/**
 * TODO 弹窗工具类，Picker参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export interface BasePickerOptions extends BaseDialogOptions {

  title?: ResourceStr; //弹框标题
  titleFontColor?: ResourceColor; //弹框标题的字体颜色。
  titleBackground?: ResourceColor; //头部背景颜色
  primaryButton?: ButtonOptions | ResourceStr; //弹框左侧按钮。
  secondaryButton?: ButtonOptions | ResourceStr; //弹框右侧按钮。

  actionCancel?: boolean; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。默认值：true。
  width?: Dimension | Length; //设置弹窗的宽度，弹窗宽度默认值：'100%'。
  maxWidth?: Length; //弹窗宽度默认最大值：360vp。
  backgroundColor?: ResourceColor; //弹窗背板颜色。默认值：Color.Transparent
  backgroundBlurStyle?: BlurStyle; //弹窗背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK
  cornerRadius?: Length; //设置背板的圆角半径。可分别设置4个圆角的半径，默认15。
  shadow?: ShadowOptions | ShadowStyle; //设置弹窗背板的阴影。
  theme?: Theme | CustomTheme; //主题信息，可以是CustomTheme或从onWillApplyTheme中获取的Theme实例。
  themeColorMode?: ThemeColorMode; //设置深色浅色。

  textStyle?: PickerTextStyle; //设置所有选项中除了最上、最下及选中项以外的文本颜色、字号、字体粗细。
  selectedTextStyle?: PickerTextStyle; //设置选中项的文本颜色、字号、字体粗细。
  disappearTextStyle?: PickerTextStyle; //设置所有选项中最上和最下两个选项的文本颜色、字号、字体粗细。
  divider?: DividerOptions | null; //设置分割线样式，不设置该属性则按“默认值”展示分割线。
  canLoop?: boolean; //设置是否可循环滚动。

}