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

import { AppUtil } from './AppUtil';
import { CacheUtil } from './CacheUtil';
import { LogUtil } from './LogUtil';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * TODO 键盘工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class KeyboardUtil {


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
   * @param listenerId 监听事件id，id具有唯一性，不能重复。
   * @param callBack:
   *         show boolen，true-键盘显示、false-键盘隐藏;
   *         height 键盘高度。
   * @returns 失败返回错误码，成功返回0，监听事件已存在返回-1。
   */
  static onKeyboardListener(listenerId: number, callback: KeyboardCallBack): number {
    try {
      let callBack = CacheUtil.get<NumberCallBack>(`keyboard_num_x_id_${listenerId}`);
      if (callBack != null && callBack != undefined) {
        LogUtil.error(`KeyboardUtil-onKeyboardListener: 监听事件已存在！`);
        return -1; //监听事件已存在返回-1
      } else {
        let keyboardCallBack: NumberCallBack = (height: number) => {
          if (callback) {
            callback(height > 0, height); //键盘显示
          }
        }
        CacheUtil.put<NumberCallBack>(`keyboard_num_x_id_${listenerId}`, keyboardCallBack);
        AppUtil.getMainWindow().on("keyboardHeightChange", keyboardCallBack);
        return 0; //成功返回-0
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`KeyboardUtil-onKeyboardListener-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return error.code; //失败返回-错误码
    }
  }


  /**
   * 取消订阅输入法软键盘显示或隐藏事件
   * @param listenerId 监听事件id，不传关闭所有监听。
   * @returns 失败返回错误码，成功返回0。
   */
  static removeKeyboardListener(listenerId?: number): number {
    try {
      if (listenerId) {
        let keyboardCallBack = CacheUtil.get<NumberCallBack>(`keyboard_num_x_id_${listenerId}`);
        if (keyboardCallBack != null && keyboardCallBack != undefined) {
          AppUtil.getMainWindow().off('keyboardHeightChange', keyboardCallBack);
          CacheUtil.put(`keyboard_num_x_id_${listenerId}`, null);
        }
      } else {
        AppUtil.getMainWindow().off('keyboardHeightChange');
      }
      return 0;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`KeyboardUtil-removeKeyboardListener-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return error.code; //失败返回-错误码
    }
  }


}

//KeyboardUtil回调
export declare type NumberCallBack = (height: number) => void;

export declare type KeyboardCallBack = (show: boolean, height: number) => void;