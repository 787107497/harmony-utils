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

import promptAction from '@ohos.promptAction';
import { ToastConfig } from '../entity/ToastConfig';
import { ToastOptions } from '../entity/ToastOptions';


/**
 * TODO 土司工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class ToastUtil {

  private constructor() {}

  private static defaultConfig: ToastConfig = new ToastConfig(); //默认样式


  /**
   * 设置默认统一样式
   * @param configs
   */
  static setDefaultConfig(configs: (config: ToastConfig) => void): void {
    configs(ToastUtil.defaultConfig);
  }


  /**
   * 弹出土司,默认时长为2s,距离底部默认为80vp
   * @param message 提示消息
   * @param options (显示时长、距离屏幕底部的位置、是否显示在应用之上)
   */
  static showToast(message: string | Resource, options?: ToastOptions) {
    if ((typeof message === 'string' && message.length > 0) || message) {
      promptAction.showToast({
        message: message,
        duration: options?.duration ?? ToastUtil.defaultConfig.duration,
        showMode: options?.showMode ?? ToastUtil.defaultConfig.showMode,
        alignment: options?.alignment ?? ToastUtil.defaultConfig.alignment,
        offset: options?.offset ?? ToastUtil.defaultConfig.offset
      })
    }
  }


  /**
   * 弹出土司,时长为:1.5s,距离底部默认为80vp
   * @param message 提示消息
   * @param options (距离屏幕底部的位置、是否显示在应用之上)
   */
  static showShort(message: string | Resource, options?: ToastOptions) {
    if ((typeof message === 'string' && message.length > 0) || message) {
      promptAction.showToast({
        message: message,
        duration: options?.duration ?? ToastUtil.defaultConfig.duration_short,
        showMode: options?.showMode ?? ToastUtil.defaultConfig.showMode,
        alignment: options?.alignment ?? ToastUtil.defaultConfig.alignment,
        offset: options?.offset ?? ToastUtil.defaultConfig.offset
      })
    }
  }


  /**
   * 弹出土司,时长为:10s,距离底部默认为80vp
   * @param message 提示消息
   * @param options (距离屏幕底部的位置、是否显示在应用之上)
   */
  static showLong(message: string | Resource, options?: ToastOptions) {
    if ((typeof message === 'string' && message.length > 0) || message) {
      promptAction.showToast({
        message: message,
        duration: options?.duration ?? ToastUtil.defaultConfig.duration_long,
        showMode: options?.showMode ?? ToastUtil.defaultConfig.showMode,
        alignment: options?.alignment ?? ToastUtil.defaultConfig.alignment,
        offset: options?.offset ?? ToastUtil.defaultConfig.offset
      })
    }
  }


}