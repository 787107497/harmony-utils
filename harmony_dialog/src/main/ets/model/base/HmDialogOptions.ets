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

import { DialogOptions } from './DialogOptions';
import { ButtonOptions } from '../ButtonOptions';
import { ActionCallBack } from '../../utils/constraint';

/**
 * TODO 确认弹出框，Base参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export interface HmDialogOptions extends DialogOptions {

  content?: ResourceStr; //弹框内容。
  primaryButton?: ButtonOptions | ResourceStr; //弹框左侧按钮。
  secondaryButton?: ButtonOptions | ResourceStr; //弹框右侧按钮。
  onAction: ActionCallBack; //按钮的CallBack事件。

}