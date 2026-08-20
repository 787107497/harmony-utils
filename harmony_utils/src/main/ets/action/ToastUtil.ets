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

import promptAction from '@ohos.promptAction';
import { ToastConfig } from '../entity/ToastConfig';
import { ToastOptions } from '../entity/ToastOptions';
import { AppUtil } from '../utils/AppUtil';
import { LogUtil } from '../utils/LogUtil';


/**
 * TODO 土司工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class ToastUtil {

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
  static showToast(message: string | Resource, options: ToastOptions = new ToastOptions()) {
    ToastUtil.showInner(message, options, 0);
  }


  /**
   * 弹出土司,时长为:1.5s,距离底部默认为80vp
   * @param message 提示消息
   * @param options (距离屏幕底部的位置、是否显示在应用之上)
   */
  static showShort(message: string | Resource, options: ToastOptions = new ToastOptions()) {
    ToastUtil.showInner(message, options, 1);
  }


  /**
   * 弹出土司,时长为:10s,距离底部默认为80vp
   * @param message 提示消息
   * @param options (距离屏幕底部的位置、是否显示在应用之上)
   */
  static showLong(message: string | Resource, options: ToastOptions = new ToastOptions()) {
    ToastUtil.showInner(message, options, 2);
  }

  /**
   * 弹出 toast。Ability 优先走 UIContext；IME/Extension 无主窗口时回退 promptAction.showToast。
   */
  private static showInner(message: string | Resource, options: ToastOptions, type: number) {
    if (message || (typeof message === 'string' && message.length > 0)) {
      try {
        options = ToastUtil.initToastDefault(options, type);
        let toastOptions = options as promptAction.ShowToastOptions;
        toastOptions.message = message;
        if (options.uiContext) {
          options.uiContext.getPromptAction().showToast(toastOptions);
        } else {
          promptAction.showToast(toastOptions);
        }
      } catch (err) {
        LogUtil.error(err);
      }
    }
  }


  /**
   * 初始化DialogOptions参数
   */
  private static initToastDefault(options: ToastOptions, type: number): ToastOptions {
    if (type == 1) {
      options.duration = options.duration ?? ToastUtil.defaultConfig.duration_short;
    } else if (type == 2) {
      options.duration = options.duration ?? ToastUtil.defaultConfig.duration_long;
    } else {
      options.duration = options.duration ?? ToastUtil.defaultConfig.duration;
    }
    // IME/Extension 无 windowStage，不可走 AppUtil.getUIContext() → getMainWindowSync。
    options.uiContext = options.uiContext ?? ToastUtil.resolveUIContext();
    options.alignment = options.alignment ?? ToastUtil.defaultConfig.alignment;
    options.bottom = options.bottom ?? ToastUtil.defaultConfig.bottom;
    options.offset = options.offset ?? ToastUtil.defaultConfig.offset;
    options.textColor = options.textColor ?? ToastUtil.defaultConfig.textColor;
    options.backgroundColor = options.backgroundColor ?? ToastUtil.defaultConfig.backgroundColor;
    options.backgroundBlurStyle = options.backgroundBlurStyle ?? ToastUtil.defaultConfig.backgroundBlurStyle;
    options.shadow = options.shadow ?? ToastUtil.defaultConfig.shadow;
    options.showMode = options.showMode ?? ToastUtil.defaultConfig.showMode;
    options.enableHoverMode = options.enableHoverMode ?? ToastUtil.defaultConfig.enableHoverMode;
    options.hoverModeArea = options.hoverModeArea ?? ToastUtil.defaultConfig.hoverModeArea;
    return options;
  }

  /**
   * 安全获取 UIContext。无 windowStage 或 getMainWindowSync 不可用时返回 undefined。
   */
  private static resolveUIContext(): UIContext | undefined {
    return AppUtil.tryGetUIContext();
  }
}
