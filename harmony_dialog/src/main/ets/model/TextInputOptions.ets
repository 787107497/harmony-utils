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

import { BaseInputOptions } from './base/BaseInputOptions';

/**
 * TODO 输入弹出框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface TextInputOptions extends BaseInputOptions {

  inputType?: InputType; //输入框类型。默认值：InputType.Normal
  showPassword?: boolean; //是否显示密码（inputType为InputType.Password起作用）
  showPasswordIcon?: boolean; //是否显示密码图标（inputType为InputType.Password起作用）
  passwordIcon?: PasswordIcon; //设置当密码输入模式时，输入框末尾的图标。支持jpg、png、bmp、heic和webp类型的图片格式。
  passwordRules?: string; //定义生成密码的规则。在触发自动填充时，所设置的密码规则会透传给密码保险箱，用于新密码的生成。
  cancelButton?: CancelButtonOptions; //设置右侧清除按钮样式。

}