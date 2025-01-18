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

import { promptAction } from '@kit.ArkUI';

/**
 * TODO Toast基本参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface ToastOptions {

  uiContext?: UIContext; //UIContext上下文

  message?: string | Resource; //显示的文本信息。默认字体为'Harmony Sans'，不支持设置其他字体。
  duration?: number //默认值1500ms，取值区间：1500ms-10000ms。若小于1500ms则取默认值，若大于10000ms则取上限值10000ms。
  fontColor?: ResourceColor; // 文本提示框文本颜色。默认值：Color.Black
  bottom?: string | number; //设置弹窗底部边框距离导航条的高度，ToastShowMode.TOP_MOST模式下，软键盘拉起时，如果bottom值过小，toast要被软键盘遮挡时，会自动避让至距离软键盘80vp处。ToastShowMode.DEFAULT模式下，软键盘拉起时，会上移软键盘的高度。默认值：80vp。说明：当底部没有导航条时，bottom为设置弹窗底部边框距离窗口底部的高度。设置对齐方式alignment后，bottom不生效。
  alignment?: Alignment; //对齐方式。默认值：undefined，默认底部偏上位置。
  offset?: Offset; //在对齐方式上的偏移。默认值：{ dx: 0, dy: 0 }，默认没有偏移。说明： 只支持设置px类型的数值，如需设置vp，可以将vp改成px传入。
  backgroundColor?: ResourceColor; //文本提示框背板颜色，建议八位色值前两位为透明度。默认值：Color.Transparent。说明：当设置了backgroundColor为非透明色时，backgroundBlurStyle需要设置为BlurStyle.NONE，否则颜色显示将不符合预期效果。
  backgroundBlurStyle?: BlurStyle; //文本提示框背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK。说明：设置为BlurStyle.NONE即可关闭背景虚化。当设置了backgroundBlurStyle为非NONE值时，则不要设置backgroundColor，否则颜色显示将不符合预期效果。
  shadow?: ShadowOptions | ShadowStyle; //文本提示框背板阴影。默认值：ShadowStyle.OUTER_DEFAULT_MD
  showMode?: promptAction.ToastShowMode; //设置弹窗是否显示在应用之上。默认值：ToastShowMode.DEFAULT，默认显示在应用内。

}