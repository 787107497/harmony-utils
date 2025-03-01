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
import { UIContext } from '@kit.ArkUI';


/**
 * TODO 半模态工具类，Base参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059
 */
export interface BaseSheetOptions extends SheetOptions {

  uiContext?: UIContext; //在UIContext实例对应的窗口中显示半模态。说明：使用openBindSheet启动的半模态页面，不支持设置、更新该属性。
  backCancel?: boolean; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。true表示关闭弹窗。false表示不关闭弹窗。默认值：true。
  autoCancel?: boolean; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹窗。默认值：true
  dialogId?: string; //弹框id，具有唯一性
  targetId?: number;


  maskColor?: ResourceColor; //半模态页面的背景蒙层颜色。
  keyboardAvoidMode?: SheetKeyboardAvoidMode; //设置半模态激活输入法时对软键盘的避让方式。默认值：TRANSLATE_AND_SCROLL。
  mode?: SheetMode; //设置半模态页面的显示层级。默认值：SheetMode.OVERLAY。

  width?: Dimension; //设置半模态页面的宽度。百分比参数方式：以父元素宽的百分比来设置半模态页面的宽度。
  height?: SheetSize | Length; //半模态高度，默认是LARGE。
  detents?: [(SheetSize | Length), (SheetSize | Length)?, (SheetSize | Length)?]; //半模态页面的切换高度档位。

  preferType?: SheetType; //半模态页面的样式。
  showClose?: boolean | Resource; //是否显示关闭图标，默认显示。Resource需要为boolean类型。
  title?: SheetTitleOptions | CustomBuilder; //半模态面板的标题。
  enableOutsideInteractive?: boolean; //半模态所在页面是否允许交互。设置为true时允许交互，不显示蒙层；设置为false时不允许交互，显示蒙层；若不进行设置，默认底部弹窗与居中弹窗不允许交互，跟手弹窗允许交互。当设置为true时，maskColor设置无效。

  blurStyle?: BlurStyle; //半模态面板的模糊背景。默认无模糊背景。
  backgroundColor?: ResourceColor; //半模态页面的背板颜色。默认值：Color.White。
  borderWidth?: Dimension | EdgeWidths | LocalizedEdgeWidths; //设置半模态页面的边框宽度。
  borderColor?: ResourceColor | EdgeColors | LocalizedEdgeColors; //设置半模态页面的边框颜色。默认值：Color.Black。如果使用borderColor属性，需要和borderWidth属性一起使用。
  borderStyle?: BorderStyle | EdgeStyles; //设置半模态页面的边框样式。默认值：BorderStyle.Solid。如果使用borderStyle属性，需要和borderWidth属性一起使用。
  shadow?: ShadowOptions | ShadowStyle; //设置半模态页面的阴影。

  dragBar?: boolean; //是否显示控制条。说明：半模态面板的detents属性设置多个不同高度并且设置生效时，默认显示控制条。否则不显示控制条。
  scrollSizeMode?: ScrollSizeMode; //设置半模态面板滑动时，内容区域刷新时机。默认值：ScrollSizeMode.FOLLOW_DETENT。

}