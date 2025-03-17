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


import { ActionDateCallBack, DateType } from '../utils/constraint';
import { BasePickerOptions } from './base/BasePickerOptions';


/**
 * TODO 弹窗工具类，DatePicker参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059 */
export interface DateTimePickerOptions extends BasePickerOptions {

  dateType: DateType; //选择的日期类型
  selected?: Date; // 选中日期,不传默认当前日期
  start?: Date; //开始日期（1900-01-01 00:00:00）
  end?: Date; //结束日期（2199-12-31 23:59:59）

  onAction: ActionDateCallBack; //按钮的CallBack事件。

}