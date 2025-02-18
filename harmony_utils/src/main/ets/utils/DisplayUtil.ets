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

import { display } from '@kit.ArkUI';
import { Callback } from '@kit.BasicServicesKit';

/**
 * TODO 屏幕相关工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059
 */
export class DisplayUtil {


  /**
   * 获取当前默认的display对象。
   * @returns
   */
  static getDefaultDisplaySync(): display.Display {
    return display.getDefaultDisplaySync()
  }


  /**
   * 获取设备的屏幕宽度，单位为px。
   * @returns
   */
  static getWidth(): number {
    return DisplayUtil.getDefaultDisplaySync().width;
  }

  /**
   * 获取设备的屏幕高度，单位为px。
   * @returns
   */
  static getHeight(): number {
    return DisplayUtil.getDefaultDisplaySync().height;
  }


  /**
   * 获取设备当前显示的方向
   * Orientation:
   *   PORTRAIT  0  表示设备当前以竖屏方式显示。
   *   LANDSCAPE  1  表示设备当前以横屏方式显示。
   *   PORTRAIT_INVERTED  2  表示设备当前以反向竖屏方式显示。
   *   LANDSCAPE_INVERTED  3  表示设备当前以反向横屏方式显示。
   * @returns
   */
  static getOrientation(): display.Orientation {
    return DisplayUtil.getDefaultDisplaySync().orientation;
  }


  /**
   * 获取设备的状态
   * DisplayState:
   *   STATE_UNKNOWN  0  表示显示设备状态未知。
   *   STATE_OFF  1  表示显示设备状态为关闭。
   *   STATE_ON  2  表示显示设备状态为开启。
   *   STATE_DOZE  3  表示显示设备为低电耗模式。
   *   STATE_DOZE_SUSPEND  4  表示显示设备为睡眠模式，CPU为挂起状态。
   *   STATE_VR  5  表示显示设备为VR模式。
   *   STATE_ON_SUSPEND  6 表示显示设备为开启状态，CPU为挂起状态。
   * @returns
   */
  static getDisplayState(): display.DisplayState {
    return DisplayUtil.getDefaultDisplaySync().state;
  }


  /**
   * 获取挖孔屏、刘海屏、瀑布屏等不可用屏幕区域信息。使用Promise异步回调。建议应用布局规避该区域。
   * @returns
   */
  static async getCutoutRect(): Promise<display.Rect> {
    let cutoutInfo = await DisplayUtil.getDefaultDisplaySync().getCutoutInfo()
    return cutoutInfo.boundingRects[0]
  }

  /**
   * 获取挖孔屏、刘海屏等不可用屏幕区域的高度。单位px。
   * @returns
   */
  static async getCutoutHeight(): Promise<number> {
    let rect = await DisplayUtil.getCutoutRect();
    if (rect) {
      return rect.height;
    }
    return 0;
  }


  /**
   * 检查设备是否可折叠。
   * @returns
   */
  static isFoldable(): boolean {
    return display.isFoldable();
  }


  /**
   * 获取可折叠设备的当前折叠状态。
   * FoldStatus:
   *   FOLD_STATUS_UNKNOWN  0  表示设备当前折叠状态未知。
   *   FOLD_STATUS_EXPANDED 1  表示设备当前折叠状态为完全展开。
   *   FOLD_STATUS_FOLDED  2  表示设备当前折叠状态为折叠。
   *   FOLD_STATUS_HALF_FOLDED  3  表示设备当前折叠状态为半折叠。半折叠指完全展开和折叠之间的状态。
   * @returns
   * @returns
   */
  static getFoldStatus(): display.FoldStatus {
    return display.getFoldStatus();
  }


  /**
   * 获取可折叠设备的显示模式。
   * FoldDisplayMode:
   *   FOLD_DISPLAY_MODE_UNKNOWN  0  表示设备当前折叠显示模式未知。
   *   FOLD_DISPLAY_MODE_FULL  1  表示设备当前全屏显示。
   *   FOLD_DISPLAY_MODE_MAIN  2  表示设备当前主屏幕显示。
   *   FOLD_DISPLAY_MODE_SUB  3  表示设备当前子屏幕显示。
   *   FOLD_DISPLAY_MODE_COORDINATION  4  表示设备当前双屏协同显示。
   * @returns
   */
  static getFoldDisplayMode(): display.FoldDisplayMode {
    return display.getFoldDisplayMode();
  }


  /**
   * 开启折叠设备折叠状态变化的监听。
   * @param callback
   */
  static onFoldStatusChange(callback: Callback<display.FoldStatus>) {
    display.on('foldStatusChange', callback)
  }

  /**
   * 关闭折叠设备折叠状态变化的监听。
   * @param callback
   */
  static offFoldStatusChange(callback?: Callback<display.FoldStatus>) {
    display.off('foldStatusChange', callback)
  }


}