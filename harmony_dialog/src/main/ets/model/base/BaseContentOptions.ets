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


import { ActionStrCallBack } from '../../utils/constraint';
import { DialogOptions } from './DialogOptions';
import { ButtonOptions } from '@kit.ArkUI'

/**
 * TODO 自定义内容区弹出框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059
 */
export interface BaseContentOptions extends DialogOptions {

  primaryTitle?: ResourceStr; //弹出框标题。
  secondaryTitle?: ResourceStr; //弹出框辅助文本。
  localizedContentAreaPadding?: LocalizedPadding; //弹出框内容区内边距。
  contentAreaPadding?: Padding; //弹出框内容区内边距。设置了localizedContentAreaPadding属性时该属性不生效。

  // buttons?: Array<ButtonOptions>; //弹出框操作区按钮，最多支持4个按钮。
  onAction?: ActionStrCallBack; //按钮的CallBack事件。

  contentBuilder?: () => void; //弹出框内容，自定义

}