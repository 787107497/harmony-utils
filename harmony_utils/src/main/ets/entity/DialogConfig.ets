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

import { ImmersiveMode, LevelMode } from '@ohos.promptAction';
import { AppUtil } from '../utils/AppUtil';


/**
 * TODO 弹窗工具类（AlertDialog）默认样式参数
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export class DialogConfig {
  title: ResourceStr = '温馨提示'; //弹框标题
  subtitle?: ResourceStr; //弹框副标题
  primaryButton: ResourceStr = '取消'; //弹框左侧按钮。
  secondaryButton: ResourceStr = '确定'; //弹框右侧按钮。
  autoCancel: boolean = false; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹窗。默认值：true
  backCancel: boolean = true; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。true表示关闭弹窗。false表示不关闭弹窗。默认值：true。

  alignment: DialogAlignment = DialogAlignment.Center; //弹窗的对齐方式。
  offset: Offset = { dx: 0, dy: 0 }; //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0 , dy: 0 }
  gridCount: number = 4; //弹窗容器宽度所占用栅格数。默认值：4
  maskRect: Rectangle = { x: 0, y: 0, width: '100%', height: '100%' }; //弹窗遮蔽层区域，在遮蔽层区域内的事件不透传，在遮蔽层区域外的事件透传。
  showInSubWindow?: boolean; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
  isModal: boolean = true; //弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层。默认值：true，此时弹窗有蒙层。
  backgroundColor: ResourceColor = Color.Transparent; //弹窗背板颜色。默认值：Color.Transparent
  backgroundBlurStyle: BlurStyle = BlurStyle.COMPONENT_ULTRA_THICK; //弹窗背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK
  cornerRadius: BorderRadiuses | Dimension | LocalizedBorderRadiuses = { topLeft: '32vp', topRight: '32vp', bottomLeft: '32vp', bottomRight: '32vp' }; //设置背板的圆角半径。可分别设置4个圆角的半径。默认值：{ topLeft: '32vp', topRight: '32vp', bottomLeft: '32vp', bottomRight: '32vp' }
  borderWidth: Dimension | EdgeWidths | LocalizedEdgeWidths = 0; //可分别设置4个边框宽度。默认值：0。
  borderColor: ResourceColor | EdgeColors | LocalizedEdgeColors = Color.Black; //设置弹窗背板的边框颜色。默认值：Color.Black。
  borderStyle: BorderStyle | EdgeStyles = BorderStyle.Solid; //设置弹窗背板的边框样式。默认值：BorderStyle.Solid。
  shadow?: ShadowOptions | ShadowStyle; //设置弹窗背板的阴影。
  textStyle?: TextStyle; //设置弹窗message内容的文本样式。
  transition?: TransitionEffect; //设置弹窗显示和退出的过渡效果。
  width?: Dimension; //设置弹窗背板的宽度。弹窗宽度默认最大值：400vp。
  height?: Dimension; //设置弹窗背板的高度。

  enableHoverMode: boolean = false; //是否响应悬停态。默认值：false，默认不响应。<API14+>
  hoverModeArea?: HoverModeAreaType = AppUtil.isApiSupported(14) ? HoverModeAreaType.BOTTOM_SCREEN : undefined; //设置悬停态下弹窗的默认展示区域。默认值：HoverModeAreaType.BOTTOM_SCREEN。<API14+>
  levelMode?: LevelMode = AppUtil.isApiSupported(15) ? LevelMode.OVERLAY : undefined; //设置弹窗显示层级。默认值：LevelMode.OVERLAY。当且仅当showInSubWindow属性设置为false时生效。<API15+>
  immersiveMode?: ImmersiveMode = AppUtil.isApiSupported(18) ? ImmersiveMode.DEFAULT : undefined; //设置页面内弹窗蒙层效果。默认值：ImmersiveMode.DEFAULT。当且仅当levelMode属性设置为LevelMode.EMBEDDED时生效。<API15+>


}