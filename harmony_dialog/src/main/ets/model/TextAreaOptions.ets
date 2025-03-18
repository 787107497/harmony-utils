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

import { TextAlignment } from '../utils/constraint';
import { BaseInputOptions } from './base/BaseInputOptions';

/**
 * TODO 输入弹出框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export interface TextAreaOptions extends BaseInputOptions {

  inputType?: TextAreaType; //输入框类型。默认值：TextAreaType.Normal

  inputLineHeight?: number | string | Resource; //行高
  textAlign?: TextAlign; //输入框TextAlign
  align?: TextAlignment; //输入框Align

}