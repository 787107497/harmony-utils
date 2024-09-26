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
 *
 * https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 */


import { promptAction } from '@kit.ArkUI';

/**
 * TODO Toast默认样式参数
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class ToastConfig {
  showMode: promptAction.ToastShowMode = promptAction.ToastShowMode.DEFAULT; //是否显示在应用之上。
  alignment: Alignment = Alignment.Center; //对齐方式。默认值：undefined，默认底部偏上位置。
  offset: Offset = { dx: 0, dy: 0 } //在对齐方式上的偏移。 默认值：{dx:0, dy:0}，默认没有偏移。
  duration: number = 2000; //显示时长(1500ms-10000ms)
  duration_short: number = 1500; //显示时长(1500ms)
  duration_long: number = 10000; //显示时长(10000ms)
}