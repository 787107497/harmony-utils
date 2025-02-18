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

import { Orientation } from '../utils/constraint';
import { BaseDialogOptions } from './base/BaseDialogOptions';

/**
 * TODO ToastTip基本参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059
 */
export interface ToastTipOptions extends BaseDialogOptions {

  message?: string | Resource; //吐司内容
  duration?: number; //显示时长(1500ms-10000ms)
  fontSize?: number | string | Resource; //文字大小
  fontColor?: ResourceColor; //文字颜色
  backgroundColor?: ResourceColor; //背景颜色，建议八位色值前两位为透明度
  borderRadius?: Length | BorderRadiuses; //背景圆角
  padding?: Padding | Length; //Padding

  imageRes: ResourceStr | PixelMap; //展示的图片。
  imageSize?: SizeOptions; //自定义图片尺寸。默认值：64*64vp
  orientation?: Orientation; //吐司布局方向，默认垂直。设置该值时，请重新设置imageSize和margin。
  margin?: number; //吐司的图片与文字间距。

}