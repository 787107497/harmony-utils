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

import { HmDialogOptions } from './base/HmDialogOptions';

/**
 * TODO 信息确认类弹出框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export interface ConfirmOptions extends HmDialogOptions {

  checkTips: ResourceStr; //checkbox的提示内容。
  isChecked?: boolean; //@Prop-value为true时，表示checkbox已选中，value为false时，表示未选中。默认值：false
  onCheckedChange: Callback<boolean>; //checkbox的选中状态改变事件。

}