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


import { InputFilter } from '../model/InputFilter';


/**
 * 给TextArea 设置过滤器 */
export class TextAreaModifier implements AttributeModifier<TextAreaAttribute> {
  inputFilter?: InputFilter; //通过正则表达式设置输入过滤器。

  applyNormalAttribute(instance: TextAreaAttribute): void {
    if (this.inputFilter) {
      instance.inputFilter(this.inputFilter.value, this.inputFilter.error);
    }
  }

}