/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-utils
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


export const PICKER_DEFAULT_SELECT_NUMBER: number = 9; //选择器默认选择数量


//弹框按钮的Action类型（从左往右，最多四个按钮）
export enum DialogAction {
  ONE = -1, //第一个按钮 - 取消。
  TWO = -2, //第二个按钮 - 确定。
  THREE = -3, //第三个按钮。
  FOUR = -4, //第四个按钮。
  FIVE = -5, //第五个按钮。
  SIX = -6 //第六个按钮。
}


/**
 * 弹框操作按钮Callback
 * action：
 * 1、当action小于0时，对应弹框操作按钮的Action，类型为DialogAction。
 * 2、当action大于等于0时，对选的是选项索引值。
 */
export declare type ActionCallBack = (action: number) => void;


//KeyboardUtil回调
export declare type KeyboardCallBack = (show: boolean, height: number) => void;