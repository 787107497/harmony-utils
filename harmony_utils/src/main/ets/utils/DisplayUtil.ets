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
import { AppUtil } from './AppUtil';

/**
 * TODO 屏幕相关工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
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
   * 获取主屏信息。除2in1之外的设备获取的是设备自带屏幕的Display对象；2in1设备外接屏幕时获取的是当前主屏幕的Display对象；2in1设备没有外接屏幕时获取的是自带屏幕的Display对象。<API14+>
   * @returns
   */
  static getPrimaryDisplaySync(): display.Display {
    if (AppUtil.isApiSupported(14)) {
      return display.getPrimaryDisplaySync()
    } else {
      return display.getDefaultDisplaySync()
    }
  }


  /**
   * 获取当前所有的display对象，使用Promise异步回调。
   * @returns
   */
  static async getAllDisplays(): Promise<Array<display.Display>> {
    return display.getAllDisplays();
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
   * @param callback 回调函数。表示折叠设备折叠状态。
   */
  static onFoldStatusChange(callback: Callback<display.FoldStatus>) {
    display.on('foldStatusChange', callback)
  }

  /**
   * 关闭折叠设备折叠状态变化的监听。
   * @param callback 需要取消注册的回调函数。表示折叠设备折叠状态。若无此参数，则取消注册折叠状态变化监听的所有回调函数。
   */
  static offFoldStatusChange(callback?: Callback<display.FoldStatus>) {
    display.off('foldStatusChange', callback)
  }


  /**
   * 开启折叠设备折叠角度变化的监听。如果是双折轴设备，则有两个角度值；在充电口朝下的状态下，从右到左分别是折轴一和折轴二。
   * @param callback 回调函数。表示折叠设备屏幕折叠角度值（0度~180度）。如果是双折轴设备，则数组返回两个角度值，第一个值是折轴一的折叠角度值，第二个值是折轴二的折叠角度值。
   */
  static onFoldAngleChange(callback: Callback<Array<number>>) {
    display.on('foldAngleChange', callback);
  }

  /**
   * 关闭折叠设备折叠角度变化的监听。
   * @param callback 需要取消注册的回调函数。表示折叠设备屏幕折叠角度值（0度~180度）。若无此参数，则取消注册折叠角度变化监听的所有回调函数。
   */
  static offFoldAngleChange(callback?: Callback<Array<number>>) {
    display.off('foldAngleChange', callback);
  }


  /**
   * 检查设备是否正在截屏、投屏、录屏。
   * @returns 返回当前设备是否有截屏、投屏或者录屏。true表示有截屏、投屏、录屏，否则返回false。
   */
  static isCaptured(): boolean {
    return display.isCaptured();
  }


  /**
   * 开启屏幕截屏、投屏、录屏状态变化的监听。
   * @param callback 回调函数。表示设备截屏、投屏或录屏时状态发生变化。true表示设备开始投屏或者录屏，false表示结束投屏或者录屏；截屏仅返回一次true。
   */
  static onCaptureStatusChange(callback: Callback<boolean>) {
    display.on('captureStatusChange', callback);
  }

  /**
   * 关闭屏幕截屏、投屏、录屏状态变化的监听。
   * @param callback 需要取消注册的回调函数。表示设备截屏、投屏或录屏状态发生变化。true表示设备开始投屏或者录屏，false表示结束投屏或者录屏；截屏仅返回一次true。若无此参数，则取消注册截屏、投屏、录屏状态变化监听的所有回调函数。
   */
  static offCaptureStatusChange(callback?: Callback<boolean>) {
    display.off('captureStatusChange', callback);
  }




}