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

import { SpinType } from '@pura/spinkit';
import { BaseDialogOptions } from './base/BaseDialogOptions';


/**
 * TODO 加载框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface LoadingOptions extends BaseDialogOptions {

  loadType?: SpinType //动画类型
  loadSize?: number; //加载动画或进度条的大小
  loadColor?: ResourceColor; //加载动画的颜色
  content?: ResourceStr; //加载动画的提示文字
  fontSize?: number | string | Resource; //加载动画的文字大小
  fontColor?: ResourceColor; //加载动画的文字颜色
  backgroundColor?: ResourceColor; //加载动画背景颜色，建议八位色值前两位为透明度
  borderRadius?: Length | BorderRadiuses; //加载动画背景圆角
  marginTop?: number | string | Resource //文字与动画的间距
  padding?: Padding | Length; //padding
  shadow?: ShadowOptions | ShadowStyle; //阴影效果，默认参数为：ShadowStyle.OUTER_DEFAULT_SM

}
