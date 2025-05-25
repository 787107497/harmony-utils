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

import { window } from '@kit.ArkUI';
import { AppUtil } from './AppUtil';
import { LogUtil } from './LogUtil';
import { common } from '@kit.AbilityKit';

/**
 * TODO 窗口工具
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class WindowUtil {


  /**
   * 设置窗口的显示方向属性，使用Promise异步回调。
   * Orientation 窗口显示方向类型枚举:
   *   UNSPECIFIED  0  表示未定义方向模式，由系统判定。
   *   PORTRAIT  1  表示竖屏显示模式。
   *   LANDSCAPE  2  表示横屏显示模式。
   *   PORTRAIT_INVERTED  3  表示反向竖屏显示模式。
   *   LANDSCAPE_INVERTED  4  表示反向横屏显示模式。
   *   AUTO_ROTATION  5  表示传感器自动旋转模式。
   *   AUTO_ROTATION_PORTRAIT  6  表示传感器自动竖向旋转模式。
   *   AUTO_ROTATION_LANDSCAPE  7  表示传感器自动横向旋转模式。
   *   AUTO_ROTATION_RESTRICTED  8  表示受开关控制的自动旋转模式。
   *   AUTO_ROTATION_PORTRAIT_RESTRICTED  9  表示受开关控制的自动竖向旋转模式。
   *   AUTO_ROTATION_LANDSCAPE_RESTRICTED  10  表示受开关控制的自动横向旋转模式。
   *   LOCKED  11  表示锁定模式。
   * @param windowClass 不传该值，默认主窗口。
   */
  static async setPreferredOrientation(orientation: window.Orientation,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setPreferredOrientation(orientation);
  }

  /**
   * 获取窗口的显示方向属性，主窗口调用。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static getPreferredOrientation(windowClass: window.Window = AppUtil.getMainWindow()): window.Orientation {
    return windowClass.getPreferredOrientation();
  }


  /**
   * 设置窗口是否为隐私模式。设置为隐私模式的窗口，窗口内容将无法被截屏或录屏。
   * @param isPrivacyMode 窗口是否为隐私模式。true表示模式开启；false表示模式关闭。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setWindowPrivacyMode(isPrivacyMode: boolean,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowPrivacyMode(isPrivacyMode);
  }

  /**
   * 窗口是否隐私模式，默认为false。true表示模式开启；false表示模式关闭。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isPrivacyMode(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return WindowUtil.getWindowProperties(windowClass).isPrivacyMode;
  }


  /**
   * 设置窗口的布局是否为沉浸式布局（该沉浸式布局状态栏、导航栏仍然显示）。
   * @param isLayoutFullScreen true表示沉浸式布局；false表示非沉浸式布局。
   * @param windowClass 不传该值，默认主窗口。
   */
  static async setWindowLayoutFullScreen(isLayoutFullScreen: boolean,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowLayoutFullScreen(isLayoutFullScreen);
  }

  /**
   * 判断窗口是否为沉浸式，默认为false。true表示沉浸式；false表示非沉浸式。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isLayoutFullScreen(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return WindowUtil.getWindowProperties(windowClass).isLayoutFullScreen;
  }


  /**
   * 设置主窗口三键导航栏、状态栏的属性，使用Promise异步回调。
   * @param systemBarProperties 状态栏、导航栏的属性:
   *   statusBarColor 状态栏背景颜色，为十六进制RGB或ARGB颜色，不区分大小写，例如#00FF00或#FF00FF00。默认值：#0x66000000。
   *   statusBarContentColor 状态栏文字颜色。当设置此属性后， isStatusBarLightIcon属性设置无效。默认值：#0xE5FFFFFF。
   *   isStatusBarLightIcon 状态栏图标是否为高亮状态。true表示高亮；false表示不高亮。默认值：false。
   *   navigationBarColor 导航栏背景颜色，为十六进制RGB或ARGB颜色，不区分大小写，例如#00FF00或#FF00FF00。默认值：#0x66000000。
   *   navigationBarContentColor  导航栏文字颜色。当设置此属性后， isNavigationBarLightIcon属性设置无效。默认值：#0xE5FFFFFF。
   *   isNavigationBarLightIcon 导航栏图标是否为高亮状态。true表示高亮；false表示不高亮。默认值：false。
   *   enableStatusBarAnimation 是否使能状态栏属性变化时动画效果。true表示变化时使能动画效果；false表示没有使能动画效果。默认值：false。
   *   enableNavigationBarAnimation 是否使能导航栏属性变化时动画效果。true表示变化时使能动画效果；false表示没有使能动画效果。默认值：false。
   * @param windowClass 不传该值，默认主窗口。
   */
  static async setWindowSystemBarProperties(systemBarProperties: window.SystemBarProperties,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowSystemBarProperties(systemBarProperties);
  }

  /**
   * 获取主窗口三键导航栏、状态栏的属性。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static getWindowSystemBarProperties(windowClass: window.Window = AppUtil.getMainWindow()): window.SystemBarProperties {
    return windowClass.getWindowSystemBarProperties();
  }


  /**
   * 设置当前窗口是否开启沉浸式布局，该调用不会改变窗口模式和窗口大小。
   * @param enabled 是否开启沉浸式布局。true表示开启，false表示关闭。
   * @param windowClass 不传该值，默认主窗口。
   */
  static setImmersiveModeEnabledState(enabled: boolean,
    windowClass: window.Window = AppUtil.getMainWindow()) {
    windowClass.setImmersiveModeEnabledState(enabled);
  }

  /**
   * 查询当前窗口是否已经开启沉浸式布局。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static getImmersiveModeEnabledState(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return windowClass.getImmersiveModeEnabledState();
  }


  /**
   * 设置窗口灰阶，使用Promise异步回调。该接口需要在调用loadContent()或setUIContent()使窗口加载页面内容后调用。
   * @param grayScale 窗口灰阶。该参数为浮点数，取值范围为[0.0, 1.0]。0.0表示窗口图像无变化，1.0表示窗口图像完全转为灰度图像，0.0至1.0之间时效果呈线性变化。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setWindowGrayScale(grayScale: number,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowGrayScale(grayScale);
  }


  /**
   * 设置窗口的背景色。Stage模型下，该接口需要在loadContent()或setUIContent()调用生效后使用。
   * @param color 需要设置的背景色，为十六进制RGB或ARGB颜色，不区分大小写，例如#00FF00或#FF00FF00。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static setWindowBackgroundColor(color: string, windowClass: window.Window = AppUtil.getMainWindow()) {
    try {
      windowClass.setWindowBackgroundColor(color);
    } catch (err) {
      LogUtil.error(err);
    }
  }


  /**
   * 设置主窗口三键导航栏、状态栏、底部导航条的可见模式，状态栏与底部导航条通过status控制、三键导航栏通过navigation控制，使用Promise异步回调。
   * @param names 设置窗口全屏模式时状态栏、三键导航栏和底部导航条是否显示。例如，需全部显示，该参数设置为['status', 'navigation']；不设置，则默认不显示。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setWindowSystemBarEnable(names: Array<'status' | 'navigation'>,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowSystemBarEnable(names);
  }


  /**
   * 设置主窗口三键导航栏、状态栏、底部导航条的显示和隐藏，使用Promise异步回调。
   * @param name 设置窗口全屏模式时，显示或隐藏的系统栏类型。
   * @param enable 设置窗口全屏模式时，显示或隐藏的系统栏类型。
   * @param enableAnimation 设置状态栏、三键导航栏或底部导航条显示状态变化时是否使用动画，true表示使用， false表示不使用，默认值为false。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setSpecificSystemBarEnabled(name: window.SpecificSystemBar, enable: boolean,
    enableAnimation: boolean = false, windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setSpecificSystemBarEnabled(name, enable, enableAnimation);
  }


  /**
   * 设置屏幕是否为常亮状态，使用Promise异步回调。
   * @param isKeepScreenOn  true表示常亮；false表示不常亮。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setWindowKeepScreenOn(isKeepScreenOn: boolean,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowKeepScreenOn(isKeepScreenOn);
  }

  /**
   * 屏幕是否常亮，默认为false。true表示常亮；false表示不常亮。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isKeepScreenOn(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return WindowUtil.getWindowProperties(windowClass).isKeepScreenOn;
  }


  /**
   * 设置屏幕亮度值，使用Promise异步回调。
   * @param brightness  屏幕亮度值。该参数为浮点数，取值范围为[0.0, 1.0]或-1.0。1.0表示最亮，-1.0表示默认亮度。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setWindowBrightness(brightness: number,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowBrightness(brightness);
  }

  /**
   * 获取屏幕亮度。该参数为浮点数，可设置的亮度范围为[0.0, 1.0]，其取1.0时表示最大亮度值。如果窗口没有设置亮度值，表示亮度跟随系统，此时获取到的亮度值为-1。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static getBrightness(windowClass: window.Window = AppUtil.getMainWindow()): number {
    return WindowUtil.getWindowProperties(windowClass).brightness;
  }


  /**
   * 设置使用点击或其他方式使该窗口获焦的场景时，该窗口是否支持窗口焦点从点击前的获焦窗口切换到该窗口，使用Promise异步回调。
   * @param isFocusable 点击时是否支持切换焦点窗口。true表示支持；false表示不支持。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setWindowFocusable(isFocusable: boolean,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowFocusable(isFocusable);
  }

  /**
   * 窗口是否可聚焦，默认为true。true表示可聚焦；false表示不可聚焦。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isFocusable(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return WindowUtil.getWindowProperties(windowClass).focusable;
  }


  /**
   * 设置窗口是否为可触状态，使用Promise异步回调。
   * @param isTouchable 窗口是否为可触状态。true表示可触；false表示不可触。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setWindowTouchable(isTouchable: boolean,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowTouchable(isTouchable);
  }

  /**
   * 窗口是否可触摸，默认为true。true表示可触摸；false表示不可触摸。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isTouchable(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return WindowUtil.getWindowProperties(windowClass).touchable;
  }


  /**
   * 获取当前窗口的属性
   * @param windowClass 不传该值，获取主窗口的属性
   * @returns
   */
  static getWindowProperties(windowClass: window.Window = AppUtil.getMainWindow()): window.WindowProperties {
    return windowClass.getWindowProperties();
  }


  /**
   * 获取当前应用窗口内容规避的区域。如系统栏区域、刘海屏区域、手势区域、软键盘区域等与窗口内容重叠时，需要窗口内容避让的区域。
   * @param type 表示规避区类型。
   * @returns
   */
  static getWindowAvoidArea(type: window.AvoidAreaType,
    windowClass: window.Window = AppUtil.getMainWindow()): window.AvoidArea {
    return windowClass.getWindowAvoidArea(type);
  }


  /**
   * 获取窗口类型。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static getWindowType(windowClass: window.Window = AppUtil.getMainWindow()): window.WindowType {
    return WindowUtil.getWindowProperties(windowClass).type;
  }


  /**
   * 获取当前应用窗口的模式。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static getWindowStatus(windowClass: window.Window = AppUtil.getMainWindow()): window.WindowStatusType {
    return windowClass.getWindowStatus();
  }


  /**
   * 判断窗口是否全屏，默认为false。true表示全屏；false表示非全屏。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isFullScreen(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return WindowUtil.getWindowProperties(windowClass).isFullScreen;
  }


  /**
   * 判断当前窗口是否已获焦。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isFocused(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return windowClass.isFocused();
  }


  /**
   * 窗口是否透明。默认为false。true表示透明；false表示不透明。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isTransparent(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return WindowUtil.getWindowProperties(windowClass).isTransparent;
  }


  /**
   * 判断当前窗口是否已显示。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isWindowShowing(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return windowClass.isWindowShowing();
  }


  /**
   * 判断当前窗口是否支持广色域模式，使用Promise异步回调。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async isWindowSupportWideGamut(windowClass: window.Window = AppUtil.getMainWindow()): Promise<boolean> {
    return windowClass.isWindowSupportWideGamut();
  }


  /**
   * 设置模态窗口是否响应手势返回事件，非模态窗口调用返回错误码。
   * @param enabled 是否响应手势返回事件。true表示响应手势返回事件，触发onBackPress回调；false表示不响应手势返回事件，不触发onBackPress回调。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setDialogBackGestureEnabled(enabled: boolean,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setDialogBackGestureEnabled(enabled);
  }


  /**
   * 设置当前窗口是否禁用返回手势功能，仅主窗全屏模式下生效，2in1设备下不生效。<API13+>
   * @param enabled true时开启返回手势功能，false时禁用返回手势功能。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setGestureBackEnabled(enabled: boolean,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    if (AppUtil.isApiSupported(13)) {
      return windowClass.setGestureBackEnabled(enabled);
    }
  }

  /**
   * 获取当前窗口是否禁用返回手势功能，仅主窗全屏模式下生效，2in1设备不生效。<API13+>
   * @param windowClass 不传该值，默认主窗口。
   * @returns 是否已经禁用返回手势。true表示未禁用返回手势功能，false表示已禁用返回手势功能。
   */
  static isGestureBackEnabled(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    if (AppUtil.isApiSupported(13)) {
      return windowClass.isGestureBackEnabled();
    }
    return false;
  }


  /**
   * 创建子窗口或者系统窗口，使用Promise异步回调。
   * @param config 创建窗口时的参数。
   *   需要权限： 当创建窗口类型为window.WindowType.TYPE_FLOAT时，需要ohos.permission.SYSTEM_FLOAT_WINDOW权限
   * @returns
   */
  static async createWindow(config: window.Configuration): Promise<window.Window> {
    return window.createWindow(config);
  }


  /**
   * 查找name所对应的窗口。
   * @param name 窗口名字，即Configuration中的name。
   * @returns
   */
  static findWindow(name: string): window.Window {
    return window.findWindow(name);
  }


  /**
   * 获取当前应用内最上层的子窗口，若无应用子窗口，则返回应用主窗口，使用Promise异步回调。
   * @param ctx 当前应用上下文信息。
   * @returns
   */
  static async getLastWindow(ctx: common.BaseContext = AppUtil.getContext()): Promise<window.Window> {
    return window.getLastWindow(ctx);
  }


  /**
   * 在同应用内将窗口焦点从源窗口转移到目标窗口，仅支持应用主窗和子窗的焦点转移。
   * @param sourceWindowId 源窗口id，必须是获焦状态。
   * @param targetWindowId 目标窗口id。
   * @returns
   */
  static async shiftAppWindowFocus(sourceWindowId: number, targetWindowId: number): Promise<void> {
    return window.shiftAppWindowFocus(sourceWindowId, targetWindowId);
  }


}