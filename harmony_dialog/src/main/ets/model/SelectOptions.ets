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

import { DialogOptions } from './base/DialogOptions';
import { ButtonOptions } from './ButtonOptions';
import { ActionStrCallBack, NumberCalBack } from '../utils/constraint';


/**
 * TODO 选择类弹出框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export interface SelectOptions extends DialogOptions {

  selectedIndex?: number; //设置选中索引
  content?: ResourceStr; //弹框内容。
  confirm?: ButtonOptions | ResourceStr; //选择弹出框底部按钮。
  radioContent: Array<SheetInfo> | Array<ResourceStr>; //选择弹出框的子项内容列表，每个选择项支持设置文本和选中的回调事件。
  onCheckedChanged: NumberCalBack; //选择回调
  onAction: ActionStrCallBack; //按钮的CallBack事件。

}