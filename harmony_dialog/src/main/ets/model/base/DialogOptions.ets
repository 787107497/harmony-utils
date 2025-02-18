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

import { ActionCallBack, ActionStrCallBack } from '../../utils/constraint';
import { BaseDialogOptions } from './BaseDialogOptions';


/**
 * TODO 弹窗工具类，Base参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059
 */
export interface DialogOptions extends BaseDialogOptions {
  title?: ResourceStr; //弹框标题
  actionCancel?: boolean; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。默认值：true。
  onAction?: ActionCallBack | ActionStrCallBack; //按钮的CallBack事件。

  height?: Dimension | Length; //设置弹窗的高度；很多弹框都是自适应高度，谨慎设置该值。
  width?: Dimension | Length; //设置弹窗的宽度，弹窗宽度默认值：'calc(100% - 32vp)'、100%。
  maxHeight?: Dimension | Length; //设置弹窗高度默认最大值；很多弹框都是自适应高度，谨慎设置该值。
  maxWidth?: Length; //弹窗宽度默认最大值：360vp。
  backgroundColor?: ResourceColor; //弹窗背板颜色。默认值：Color.White
  backgroundBlurStyle?: BlurStyle; //弹窗背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK
  cornerRadius?: Length | BorderRadiuses | LocalizedBorderRadiuses; //设置背板的圆角半径。可分别设置4个圆角的半径。
  borderWidth?: Dimension | EdgeWidths | LocalizedEdgeWidths; //可分别设置4个边框宽度。默认值：0。
  borderColor?: ResourceColor | EdgeColors | LocalizedEdgeColors; //设置弹窗背板的边框颜色。默认值：Color.Black。
  borderStyle?: BorderStyle | EdgeStyles; //设置弹窗背板的边框样式。默认值：BorderStyle.Solid。
  shadow?: ShadowOptions | ShadowStyle; //设置弹窗背板的阴影。
  theme?: Theme | CustomTheme; //主题信息，可以是CustomTheme或从onWillApplyTheme中获取的Theme实例。
  themeColorMode?: ThemeColorMode; //设置深色浅色。
}
