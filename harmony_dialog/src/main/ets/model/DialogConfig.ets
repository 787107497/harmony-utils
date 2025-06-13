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

import { common } from '@kit.AbilityKit';
import { SpinType } from '@pura/spinkit';
import { ImmersiveMode, LevelMode } from '@kit.ArkUI';
import { Orientation } from '../utils/constraint';
import { Helper } from '../utils/Helper';


/**
 * TODO 弹窗工具类，默认样式参数
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export class DialogConfig {


  //------------------------------------公共参数---promptAction.BaseDialogOptions----------------------------------------
  uiAbilityContext?: common.UIAbilityContext; //设置UIAbilityContext
  backCancel: boolean = true; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。true表示关闭弹窗。false表示不关闭弹窗。默认值：true。
  autoCancel: boolean = true; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹窗。默认值：true
  alignment: DialogAlignment = DialogAlignment.Default; //弹窗的对齐方式。
  offset: Offset = { dx: 0, dy: 0 }; //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0, dy: 0 }
  maskRect: Rectangle = { x: 0, y: 0, width: '100%', height: '100%' }; //弹窗遮蔽层区域，在遮蔽层区域内的事件不透传，在遮蔽层区域外的事件透传。
  maskColor: ResourceColor = 0x33000000; //自定义蒙层颜色。默认值 0x33000000
  isModal: boolean = true; //弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层。默认值：true，此时弹窗有蒙层。
  showInSubWindow: boolean = false; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
  transition?: TransitionEffect; //设置弹窗显示和退出的过渡效果。
  onWillDismiss?: Callback<DismissDialogAction>; //交互式关闭回调函数。
  onDidDisappear?: VoidCallback; //弹窗消失时的事件回调。
  //-----------------------------------公共参数---promptAction.BaseDialogOptions-----------------------------------------


  //---------------------------------------弹框Dialog--------------------------------------------------------------------
  title: ResourceStr = '温馨提示'; //弹框标题
  primaryButton: ResourceStr = '取消'; //弹框左侧按钮。
  secondaryButton: ResourceStr = '确定'; //弹框右侧按钮。
  actionCancel: boolean = true; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。默认值：true。

  imageRes?: ResourceStr | PixelMap; //TipsDialog用到，展示的图片。
  imageSize: SizeOptions = { width: '64vp', height: '64vp' }; //TipsDialog用到，自定义图片尺寸。默认值：64*64vp

  width: Dimension | Length = 'calc(100% - 32vp)'; //设置弹窗的宽度，弹窗宽度默认值：'calc(100% - 32vp)'、100%。
  maxWidth?: Length = 360; //弹窗宽度默认最大值：360vp/400vp。
  cornerRadius: Length | BorderRadiuses | LocalizedBorderRadiuses = { topLeft: '16vp', topRight: '16vp', bottomLeft: '16vp', bottomRight: '16vp' }; //设置背板的圆角半径。可分别设置4个圆角的半径。
  borderWidth: Dimension | EdgeWidths | LocalizedEdgeWidths = 0; //可分别设置4个边框宽度。默认值：0。
  borderColor: ResourceColor | EdgeColors | LocalizedEdgeColors = Color.Black; //设置弹窗背板的边框颜色。默认值：Color.Black。
  borderStyle: BorderStyle | EdgeStyles = BorderStyle.Solid; //设置弹窗背板的边框样式。默认值：BorderStyle.Solid。

  backgroundColor: ResourceColor = Color.Transparent //弹窗背板颜色。默认值：Color.Transparent，，目前只支持ThemeColorMode.SYSTEM。
  backgroundBlurStyle: BlurStyle = BlurStyle.COMPONENT_ULTRA_THICK; //弹窗背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK，
  theme?: Theme | CustomTheme; //主题信息，可以是CustomTheme或从onWillApplyTheme中获取的Theme实例。
  themeColorMode: ThemeColorMode = ThemeColorMode.SYSTEM; //设置深色浅色，默认跟随系统，目前只支持ThemeColorMode.SYSTEM。

  enableHoverMode: boolean = false; //是否响应悬停态。默认值：false，默认不响应。<API14+>
  hoverModeArea: HoverModeAreaType = HoverModeAreaType.BOTTOM_SCREEN; //设置悬停态下弹窗的默认展示区域。默认值：HoverModeAreaType.BOTTOM_SCREEN。<API14+>
  levelMode?: LevelMode = Helper.isApiSupported(15) ? LevelMode.OVERLAY : undefined; //设置弹窗显示层级。默认值：LevelMode.OVERLAY。当且仅当showInSubWindow属性设置为false时生效。<API15+>
  immersiveMode?: ImmersiveMode = Helper.isApiSupported(18) ? ImmersiveMode.DEFAULT : undefined; //设置页面内弹窗蒙层效果。默认值：ImmersiveMode.DEFAULT。当且仅当levelMode属性设置为LevelMode.EMBEDDED时生效。<API15+>
  //---------------------------------------弹框Dialog-------------------------------------------------------------------


  //--------------------------------------加载框Loading------------------------------------------------------------------
  loading_loadType: SpinType = SpinType.spinZ; //动画类型
  loading_loadSize: number = 48; //加载动画或进度条的大小
  loading_loadColor: ResourceColor = "#0A51E0"; //加载动画或进度条的颜色
  loading_content: ResourceStr = ''; //加载动画的提示文字
  loading_fontSize: number | string | Resource = 15; //文字大小
  loading_fontColor: ResourceColor = Color.White; //文字颜色
  loading_backgroundColor: ResourceColor = '#CC000000'; //背景颜色，八位色值前两位为透明度
  loading_borderRadius: Length | BorderRadiuses = 10; //背景圆角
  loading_marginTop: number | string | Resource = 16; //文字与动画的间距
  loading_padding: Padding | Length = 20; //padding
  //--------------------------------------加载框Loading------------------------------------------------------------------


  //--------------------------------------选择器弹框Picker----------------------------------------------------------------
  picker_textStyle?: PickerTextStyle; //设置所有选项中除了最上、最下及选中项以外的文本颜色、字号、字体粗细。
  picker_selectedTextStyle?: PickerTextStyle; //设置选中项的文本颜色、字号、字体粗细。
  picker_disappearTextStyle?: PickerTextStyle; //设置所有选项中最上和最下两个选项的文本颜色、字号、字体粗细。
  picker_divider: DividerOptions = { strokeWidth: 1, startMargin: 0, endMargin: 0, color: $r('app.color.harmony_dialog_divider_color') }; //设置分割线样式，不设置该属性则按“默认值”展示分割线。
  picker_canLoop: boolean = true; //设置是否可循环滚动。

  picker_titleFontColor: ResourceColor = $r("app.color.harmony_dialog_title_color"); //弹框标题的字体颜色。
  picker_titleBackground: ResourceColor = $r('app.color.harmony_dialog_title_background'); //头部背景颜色
  picker_buttonFontColor: ResourceColor = $r("sys.color.ohos_id_picker_button_text_color"); //按钮颜色
  //--------------------------------------选择器弹框Picker----------------------------------------------------------------


  //--------------------------------------吐司Toast----------------------------------------------------------------------
  toast_duration: number = 2000; //显示时长(1500ms-10000ms)
  toast_durationLong: number = 10000; //显示时长(10000ms)
  toast_fontSize: number | string | Resource = 16; //文字大小
  toast_fontColor: ResourceColor = Color.White; //文字颜色
  toast_backgroundColor: ResourceColor = '#CC000000'; //背景颜色，建议八位色值前两位为透明度
  toast_alignment: Alignment | undefined = undefined; //该值仅对Toast有效，对ToastTip无效。当该值为undefined时alignment值起作用。
  toast_borderRadius: Length | BorderRadiuses = 8; //背景圆角，该值仅对ToastTip。
  toast_padding: Padding | Length = { left: 16, right: 16, top: 12, bottom: 12 }; //Padding，该值仅对ToastTip。
  toast_orientation: Orientation = Orientation.VERTICAL; //吐司布局方向，默认垂直。设置该值时，请重新设置imageSize和margin。该值仅对ToastTip。
  toast_imageSize: SizeOptions = { width: 45, height: 45 }; //Tip图片尺寸。垂直默认值：45*45vp，水平建议值：24*24vp。该值仅对ToastTip。
  toast_margin: number = 10; //吐司的图片与文字间距，该值仅对ToastTip。
  //--------------------------------------吐司Toast----------------------------------------------------------------------


}