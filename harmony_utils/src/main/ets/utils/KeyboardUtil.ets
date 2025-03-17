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

import { AppUtil } from './AppUtil';
import { LogUtil } from './LogUtil';
import { KeyboardCallBack } from '../entity/constraint';
import { ArrayUtil } from './ArrayUtil';

/**
 * TODO 键盘工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class KeyboardUtil {

  private static callBacks: Array<KeyboardCallBack> = new Array<KeyboardCallBack>(); //缓存的监听回调。
  private static keyboardCallBack: Callback<number> | undefined = undefined //全局的键盘监听回调


  /**
   * 拉起键盘
   * @param key 输入框类组件的key和id
   * @param uiContext 拉起键盘页面的UIContext，子窗口需要传入UIContext，不传默认为主窗口的UIContext
   */
  static show(key: string, uiContext?: UIContext) {
    (uiContext ?? AppUtil.getUIContext()).getFocusController().requestFocus(key);
  }

  /**
   * 关闭键盘
   * @param uiContext 关闭键盘页面的UIContext，子窗口需要传入UIContext，不传默认为主窗口的UIContext
   */
  static hide(uiContext?: UIContext) {
    (uiContext ?? AppUtil.getUIContext()).getFocusController().clearFocus();
  }


  /**
   * 订阅输入法软键盘显示或隐藏事件
   * @param callBack:
   *         show boolen，true-键盘显示、false-键盘隐藏;
   *         height 键盘高度。
   */
  static onKeyboardListener(callback: KeyboardCallBack): void {
    if (ArrayUtil.contain(KeyboardUtil.callBacks, callback)) {
      LogUtil.error(`KeyboardUtil-onKeyboardListener: 监听事件已存在！`);
    } else {
      KeyboardUtil.callBacks.push(callback);
    }
    if (KeyboardUtil.keyboardCallBack === undefined) {
      KeyboardUtil.keyboardCallBack = (height: number) => { //全局的键盘监听回调
        KeyboardUtil.callBacks.forEach((callback) => callback?.(height > 0, height));
      }
      AppUtil.getMainWindow().on("keyboardHeightChange", KeyboardUtil.keyboardCallBack);
    }
  }


  /**
   * 取消订阅输入法软键盘显示或隐藏事件
   * @param callBack 监听事件，不传关闭所有事件。
   */
  static removeKeyboardListener(callback?: KeyboardCallBack): void {
    if (callback && KeyboardUtil.callBacks.length > 1) {
      ArrayUtil.remove(KeyboardUtil.callBacks, callback);
    } else {
      if (KeyboardUtil.keyboardCallBack) {
        AppUtil.getMainWindow().off('keyboardHeightChange', KeyboardUtil.keyboardCallBack);
      } else {
        AppUtil.getMainWindow().off('keyboardHeightChange');
      }
      KeyboardUtil.keyboardCallBack = undefined;
      KeyboardUtil.callBacks = new Array<KeyboardCallBack>();
    }
  }


}

