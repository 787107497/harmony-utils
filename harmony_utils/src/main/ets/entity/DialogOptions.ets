/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-utils
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


import { ActionCallBack } from './constraint';


/**
 * TODO 弹窗工具类（AlertDialog）基本参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export class DialogOptions {
  title?: ResourceStr; //弹框标题
  subtitle?: ResourceStr; //弹框副标题
  message: ResourceStr = ''; //弹框内容

  alignment?: DialogAlignment; //弹窗的对齐方式。
  offset?: Offset; //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0 , dy: 0 }
  gridCount?: number; //弹窗容器宽度所占用栅格数。默认值：4
  maskRect?: Rectangle; //弹窗遮蔽层区域，在遮蔽层区域内的事件不透传，在遮蔽层区域外的事件透传。
  showInSubWindow?: boolean; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
  isModal?: boolean; //弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层。默认值：true，此时弹窗有蒙层。
  backgroundColor?: ResourceColor; //弹窗背板颜色。默认值：Color.Transparent
  backgroundBlurStyle?: BlurStyle; //弹窗背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK
  cornerRadius?: BorderRadiuses | Dimension | LocalizedBorderRadiuses; //设置背板的圆角半径。可分别设置4个圆角的半径。默认值：{ topLeft: '32vp', topRight: '32vp', bottomLeft: '32vp', bottomRight: '32vp' }
  borderWidth?: Dimension | EdgeWidths | LocalizedEdgeWidths; //可分别设置4个边框宽度。默认值：0
  borderColor?: ResourceColor | EdgeColors | LocalizedEdgeColors; //设置弹窗背板的边框颜色。默认值：Color.Black
  borderStyle?: BorderStyle | EdgeStyles; //设置弹窗背板的边框样式。默认值：BorderStyle.Solid
  shadow?: ShadowOptions | ShadowStyle; //设置弹窗背板的阴影。
  textStyle?: TextStyle; //设置弹窗message内容的文本样式。
  transition?: TransitionEffect; //设置弹窗显示和退出的过渡效果。
  width?: Dimension; //设置弹窗背板的宽度。弹窗宽度默认最大值：400vp。
  height?: Dimension; //设置弹窗背板的高度。

  enableHoverMode?: boolean; //是否响应悬停态。默认值：false，默认不响应。<API14+>
  hoverModeArea?: HoverModeAreaType; //设置悬停态下弹窗的默认展示区域。默认值：HoverModeAreaType.BOTTOM_SCREEN。<API14+>
  levelMode?: LevelMode; //设置弹窗显示层级。默认值：LevelMode.OVERLAY。当且仅当showInSubWindow属性设置为false时生效。<API15+>
  levelUniqueId?: number; //设置页面级弹窗需要显示的层级下的节点uniqueId。取值范围：大于等于0的数字。当且仅当levelMode属性设置为LevelMode.EMBEDDED时生效。<API15+>
  immersiveMode?: ImmersiveMode; //设置页面内弹窗蒙层效果。默认值：ImmersiveMode.DEFAULT。当且仅当levelMode属性设置为LevelMode.EMBEDDED时生效。<API15+>
  levelOrder?: LevelOrder; //设置弹窗显示的顺序。默认值：LevelOrder.clamp(0)。不支持动态刷新顺序。<API18+>

  autoCancel?: boolean; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹窗。默认值：true
  cancel?: () => void; //点击遮障层关闭dialog时的回调。
  backCancel?: boolean = true; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。true表示关闭弹窗。false表示不关闭弹窗。默认值：true。
  onWillDismiss?: Callback<DismissDialogAction>; //交互式关闭回调函数。
  onAction?: ActionCallBack; //按钮的CallBack事件。
}


/**
 * 确认AlertDialog参数类
 */
export class ConfirmDialogOptions extends DialogOptions {
  confirm?: ButtonOptions | ResourceStr;
}


/**
 * 两个按钮的AlertDialog参数类
 */
export class PrimaryDialogOptions extends DialogOptions {
  primaryButton?: ButtonOptions | ResourceStr;
  secondaryButton?: ButtonOptions | ResourceStr;
}


/**
 * 多个按钮的AlertDialog参数类
 */
export class OptionDialogOptions extends DialogOptions {
  buttons?: Array<ButtonOptions | ResourceStr> //弹窗容器中的多个按钮。
  buttonDirection?: DialogButtonDirection //按钮排布方向默认值为DialogButtonDirection.AUTO，建议3个以上按钮使用Auto模式（两个以上按钮会切换为纵向模式，通常能显示更多按钮），非Auto模式下，3个以上按钮可能会显示不全，超出显示范围的按钮会被截断。
}


/**
 * ActionSheet参数类
 */
export class ActionSheetOptions extends DialogOptions {
  sheets: Array<SheetInfo | ResourceStr> = []; //title-选项的文本内容、icon-选项的图标、action-选项选中的回调。
  confirm?: SheetConfirm | ResourceStr;
}


/**
 * ActionSheet,confirm按钮参数类
 */
export class SheetConfirm {
  value: ResourceStr = ''; //Button的文本内容，若值为null，则该按钮不显示。
  action: () => void = () => {}; //Button选中时的回调。
  enabled?: boolean; //点击Button是否响应，默认值true。
  defaultFocus?: boolean; //设置Button是否是默认焦点，默认值false。
  style?: DialogButtonStyle; //设置Button的风格样式，默认值DialogButtonStyle.DEFAULT。
}


/**
 * 简单易用的ActionSheet的选中参数类
 */
export class SelectSheet {
  position: number = 0; //选中位置
  defaultIcon: ResourceStr = ''; //默认显示的图标
  selectIcon: ResourceStr = ''; //选中显示的图标
}


/**
 * AlertDialog按钮参数类
 */
export class ButtonOptions {
  value: ResourceStr = ''; //Button的文本内容，若值为null，则该按钮不显示。
  action: VoidCallback = () => {}; //Button选中时的回调。
  enabled?: boolean; //点击Button是否响应，默认值true。
  defaultFocus?: boolean; //设置Button是否是默认焦点，默认值false。
  style?: DialogButtonStyle; //设置Button的风格样式，默认值DialogButtonStyle.DEFAULT。
  fontColor?: ResourceColor; //Button的文本内容，若值为null，则该按钮不显示。
  backgroundColor?: ResourceColor; //Button背景颜色。
}

