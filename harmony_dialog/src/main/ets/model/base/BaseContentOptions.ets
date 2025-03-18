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

/**
 * TODO 自定义内容区弹出框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export interface BaseContentOptions extends DialogOptions {

  primaryTitle?: ResourceStr; //弹出框标题。
  secondaryTitle?: ResourceStr; //弹出框辅助文本。
  localizedContentAreaPadding?: LocalizedPadding; //弹出框内容区内边距。
  contentAreaPadding?: Padding; //弹出框内容区内边距。设置了localizedContentAreaPadding属性时该属性不生效。

  onAction?: ActionStrCallBack; //按钮的CallBack事件。

  contentBuilder?: () => void; //弹出框内容，自定义

}