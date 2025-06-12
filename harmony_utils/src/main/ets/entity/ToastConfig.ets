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


import { promptAction } from '@kit.ArkUI';

/**
 * TODO Toast默认样式参数
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export class ToastConfig {
  duration: number = 2000; //显示时长(1500ms-10000ms)
  duration_short: number = 1500; //显示时长(1500ms)
  duration_long: number = 10000; //显示时长(10000ms)
  alignment: Alignment | undefined = undefined; //对齐方式。默认值：undefined，默认底部偏上位置。
  bottom: string | number = '80vp'; //设置弹窗底部边框距离导航条的高度，ToastShowMode.TOP_MOST模式下，软键盘拉起时，如果bottom值过小，toast要被软键盘遮挡时，会自动避让至距离软键盘80vp处。ToastShowMode.DEFAULT模式下，软键盘拉起时，会上移软键盘的高度。默认值：80vp。说明：当底部没有导航条时，bottom为设置弹窗底部边框距离窗口底部的高度。设置对齐方式alignment后，bottom不生效。
  offset: Offset = { dx: 0, dy: 0 }; //在对齐方式上的偏移。 默认值：{dx:0, dy:0}，默认没有偏移。
  textColor: ResourceColor = Color.White; // 文本提示框文本颜色。默认值：Color.Black
  backgroundColor: ResourceColor = '#CC000000'; //文本提示框背板颜色，建议八位色值前两位为透明度。默认值：Color.Transparent。说明：当设置了backgroundColor为非透明色时，backgroundBlurStyle需要设置为BlurStyle.NONE，否则颜色显示将不符合预期效果。
  backgroundBlurStyle: BlurStyle = BlurStyle.NONE; //文本提示框背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK。说明：设置为BlurStyle.NONE即可关闭背景虚化。当设置了backgroundBlurStyle为非NONE值时，则不要设置backgroundColor，否则颜色显示将不符合预期效果。
  shadow: ShadowOptions | ShadowStyle = ShadowStyle.OUTER_DEFAULT_MD; //文本提示框背板阴影。默认值：ShadowStyle.OUTER_DEFAULT_MD
  showMode: promptAction.ToastShowMode = promptAction.ToastShowMode.DEFAULT; //是否显示在应用之上。
  enableHoverMode: boolean = false; //是否响应悬停态。默认值：false，默认不响应。<API14+>
  hoverModeArea: HoverModeAreaType = HoverModeAreaType.BOTTOM_SCREEN; //响应悬停态时，弹窗的显示区域。默认值：HoverModeAreaType.BOTTOM_SCREEN，默认显示在下半屏。<API14+>

}