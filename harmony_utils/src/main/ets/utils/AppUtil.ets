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

import bundleManager from '@ohos.bundle.bundleManager';
import { KeyboardAvoidMode, window } from '@kit.ArkUI';
import { BusinessError } from '@ohos.base';
import { resourceManager } from '@kit.LocalizationKit';
import { appRecovery, common, ConfigurationConstant, Want } from '@kit.AbilityKit';
import { LogUtil } from './LogUtil';
import { DeviceUtil } from './DeviceUtil';
import { WindowUtil } from './WindowUtil';


/**
 * TODO App相关工具类(使用该工具前请在UIAbility的onCreate方法中调用AppUtil的init方法初始化)
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class AppUtil {

  private static context: common.UIAbilityContext; //common.UIAbilityContext，上下文


  /**
   * 初始化方法,缓存全局变量，在UIAbility的onCreate方法中初始化该方法。
   * @param windowStage 窗口管理器
   */
  static init(context: common.UIAbilityContext) {
    AppUtil.context = context;
  }


  /**
   * 获取上下文，common.UIAbilityContext
   * @returns
   */
  static getContext(): common.UIAbilityContext {
    if (!AppUtil.context) {
      AppUtil.context = getContext() as common.UIAbilityContext; //兜底
      LogUtil.error("请在UIAbility的onCreate方法中调用AppUtil的init方法初始化！");
    }
    return AppUtil.context;
  }

  /**
   * 获取UIContext
   * @returns
   */
  static getUIContext(): UIContext {
    return AppUtil.getMainWindow().getUIContext();
  }

  /**
   * 获取WindowStage
   * @returns
   */
  static getWindowStage(): window.WindowStage {
    return AppUtil.getContext().windowStage;
  }

  /**
   * 获取主窗口
   */
  static getMainWindow(): window.Window {
    return AppUtil.getContext().windowStage.getMainWindowSync();
  }


  /**
   * 设置灰阶，APP一键置灰。
   * @param grayScale  该参数为浮点数，取值范围为[0.0, 1.0]。
   * @param onlyMainWindow 是否只置灰主窗口，默认false。
   * @returns
   */
  static async setGrayScale(grayScale: number = 1.0, onlyMainWindow: boolean = false): Promise<void> {
    AppUtil.getMainWindow().setWindowGrayScale(grayScale);
    if (!onlyMainWindow) {
      let subWindows = await AppUtil.getContext().windowStage.getSubWindow();
      if (subWindows && subWindows.length > 0) {
        subWindows.forEach((subWindow) => subWindow.setWindowGrayScale(grayScale));
      }
    }
  }

  /**
   * 设置应用的颜色模式。仅支持主线程调用。设置颜色模式，包括：深色模式、浅色模式、不设置（跟随系统）
   * @param colorMode
   */
  static setColorMode(colorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET) {
    AppUtil.getContext().getApplicationContext().setColorMode(colorMode);
  }

  /**
   * 设置应用的字体类型。仅支持主线程调用。
   * @param fontSizeScale
   */
  static setFont(font: string){
    AppUtil.getContext().getApplicationContext().setFont(font);
  }

  /**
   * 设置应用字体大小缩放比例。仅支持主线程调用。
   * @param fontSizeScale
   */
  // static setFontSizeScale(fontSizeScale: number){
  //   AppUtil.getContext().getApplicationContext().setFontSizeScale(fontSizeScale);
  // }


  /**
   * 获取虚拟键盘抬起时的页面避让模式（OFFSET-上抬模式、RESIZE-压缩模式）。
   */
  static getKeyboardAvoidMode(): KeyboardAvoidMode {
    let mode = AppUtil.getUIContext().getKeyboardAvoidMode();
    if (typeof mode === 'string') {
      if ('KeyBoardAvoidMode.RESIZE' === mode) {
        return KeyboardAvoidMode.RESIZE;
      } else {
        return KeyboardAvoidMode.OFFSET;
      }
    }
    return mode;
  }

  /**
   * 设置虚拟键盘弹出时，页面的避让模式。
   * @param value （OFFSET-上抬模式、RESIZE-压缩模式）
   */
  static setKeyboardAvoidMode(value: KeyboardAvoidMode): boolean {
    try {
      AppUtil.getUIContext().setKeyboardAvoidMode(value);
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AppUtil-setKeyboardAvoidMode-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return false;
    }
    return true;
  }


  /**
   * 设备当前是否以竖屏方式显示（竖屏）
   */
  static isPortrait(): Boolean {
    const direction = DeviceUtil.getDirection();
    return direction === resourceManager.Direction.DIRECTION_VERTICAL;
  }

  /**
   * 设备当前是否以横屏方式显示（横屏）
   */
  static isLandscape(): Boolean {
    const direction = DeviceUtil.getDirection();
    return direction === resourceManager.Direction.DIRECTION_HORIZONTAL;
  }


  /**
   * 获取状态栏的高度，单位为px。
   * @returns
   */
  static getStatusBarHeight(): number {
    try {
      const windowClass = AppUtil.getMainWindow();
      const avoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      return avoidArea.topRect.height;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AppUtil-getStatusBarHeight-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return 0;
    }
  }

  /**
   * 获取底部导航条的高度，单位为px。
   * @returns
   */
  static getNavigationIndicatorHeight(): number {
    try {
      const windowClass = AppUtil.getMainWindow();
      const avoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      return avoidArea.bottomRect.height;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AppUtil-getNavigationIndicatorHeight-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return 0;
    }
  }


  /**
   * 设置沉浸式状态栏
   * @param isLayoutFullScreen 窗口的布局是否为沉浸式布局（该沉浸式布局状态栏、导航栏仍然显示）。true表示沉浸式布局；false表示非沉浸式布局。
   * @param enable 设置窗口全屏模式时状态栏、导航栏或底部导航条是否显示，true表示显示 false表示隐藏。
   * @param color 设置窗口的背景颜色。
   * @param systemBarProperties 状态栏、导航栏的属性:
   *   statusBarColor 状态栏背景颜色，为十六进制RGB或ARGB颜色，不区分大小写，例如#00FF00或#FF00FF00。默认值：#0x66000000。
   *   statusBarContentColor 状态栏文字颜色。当设置此属性后， isStatusBarLightIcon属性设置无效。默认值：#0xE5FFFFFF。
   *   isStatusBarLightIcon 状态栏图标是否为高亮状态。true表示高亮；false表示不高亮。默认值：false。
   *   navigationBarColor 导航栏背景颜色，为十六进制RGB或ARGB颜色，不区分大小写，例如#00FF00或#FF00FF00。默认值：#0x66000000。
   *   navigationBarContentColor  导航栏文字颜色。当设置此属性后， isNavigationBarLightIcon属性设置无效。默认值：#0xE5FFFFFF。
   *   isNavigationBarLightIcon 导航栏图标是否为高亮状态。true表示高亮；false表示不高亮。默认值：false。
   */
  static setStatusBar(isLayoutFullScreen: boolean = true, enable: boolean = true, color: string = '#FFFFFF', systemBarProperties?: window.SystemBarProperties) {
    try {
      const windowClass = AppUtil.getMainWindow();
      windowClass.setWindowLayoutFullScreen(isLayoutFullScreen).then(() => {
        windowClass.setWindowBackgroundColor(color);
      }).catch((error: BusinessError) => {
        LogUtil.error(`AppUtil-setStatusBar-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      });
      windowClass.setWindowSystemBarEnable(enable ? ['status', 'navigation'] : []).then(() => {
        windowClass.setSpecificSystemBarEnabled("navigationIndicator", enable); //底部导航条。
      }).catch((error: BusinessError) => {
        LogUtil.error(`AppUtil-setStatusBar-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      });
      if (systemBarProperties) {
        windowClass.setWindowSystemBarProperties(systemBarProperties).catch((error: BusinessError) => {
          LogUtil.error(`AppUtil-setStatusBar-异常 ~ code: ${error.code} -·- message: ${error.message}`);
        });
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AppUtil-setStatusBar-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }


  /**
   * 获取当前应用的BundleInfo
   */
  static async getBundleInfo(): Promise<bundleManager.BundleInfo> {
    const bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_EXTENSION_ABILITY |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_REQUESTED_PERMISSION |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ROUTER_MAP |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_MENU |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SKILL |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_DISABLE;
    return bundleManager.getBundleInfoForSelf(bundleFlags);
  }

  /**
   * 获取当前应用的BundleInfo
   */
  static getBundleInfoSync(): bundleManager.BundleInfo {
    const bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_EXTENSION_ABILITY |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_REQUESTED_PERMISSION |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ROUTER_MAP |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_MENU |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SKILL |
    bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_DISABLE;
    return bundleManager.getBundleInfoForSelfSync(bundleFlags);
  }


  /**
   * 获取应用程序的配置信息
   * @returns
   */
  static async getAppInfo(): Promise<bundleManager.ApplicationInfo> {
    return (await AppUtil.getBundleInfo()).appInfo;
  }

  /**
   * 获取应用程序的配置信息
   * @returns
   */
  static getAppInfoSync(): bundleManager.ApplicationInfo {
    return AppUtil.getBundleInfoSync().appInfo;
  }


  /**
   * 获取应用包的签名信息
   * @returns
   */
  static async getSignatureInfo(): Promise<bundleManager.SignatureInfo> {
    return (await AppUtil.getBundleInfo()).signatureInfo;
  }

  /**
   * 获取应用包的签名信息
   * @returns
   */
  static getSignatureInfoSync(): bundleManager.SignatureInfo {
    return AppUtil.getBundleInfoSync().signatureInfo;
  }


  /**
   * 获取应用包的名称。
   */
  static getBundleName(): string {
    return AppUtil.getBundleInfoSync().name;
  }

  /**
   * 获取应用版本号。
   */
  static getVersionCode(): number {
    return AppUtil.getBundleInfoSync().versionCode;
  }

  /**
   * 获取应用版本名。
   */
  static getVersionName(): string {
    return AppUtil.getBundleInfoSync().versionName;
  }

  /**
   * 获取应用运行目标版本。
   */
  static getTargetVersion(): number {
    return AppUtil.getBundleInfoSync().targetVersion;
  }

  /**
   * 应用包安装时间。
   * @returns
   */
  static getInstallTime(): number {
    return AppUtil.getBundleInfoSync().installTime;
  }

  /**
   * 应用包更新时间。
   * @returns
   */
  static getUpdateTime(): number {
    return AppUtil.getBundleInfoSync().updateTime;
  }


  /**
   * 主动退出整个应用；调用该方法后，任务中心的任务默认不会清理，如需清理，需要配置removeMissionAfterTerminate为true。
   */
  static exit() {
    AppUtil.getContext().terminateSelf();
    AppUtil.getContext().getApplicationContext().killAllProcesses();
  }


  /**
   * 启用应用恢复功能，参数按顺序填入。该接口调用后，应用从启动器启动时第一个Ability支持恢复。
   * @param restart RestartFlag 应用重启标志。
   *    ALWAYS_RESTART  0  总是重启应用。
   *    RESTART_WHEN_JS_CRASH  0x0001  发生JS_CRASH时重启应用。
   *    RESTART_WHEN_APP_FREEZE  0x0002  发生APP_FREEZE时重启应用。
   *    NO_RESTART  0xFFFF  总是不重启应用。
   * @param saveOccasion SaveOccasionFlag 保存条件标志
   *    SAVE_WHEN_ERROR  0x0001  当发生应用故障时保存。
   *    SAVE_WHEN_BACKGROUND  0x0002  当应用切入后台时保存。
   * @param saveMode SaveModeFlag  状态保存标志
   *    SAVE_WITH_FILE  0x0001  每次状态保存都会写入到本地文件缓存。
   *    SAVE_WITH_SHARED_MEMORY  0x0002  状态先保存在内存中，应用故障退出时写入到本地文件缓存。
   */
  static enableAppRecovery(restart: appRecovery.RestartFlag = appRecovery.RestartFlag.ALWAYS_RESTART,
    saveOccasion: appRecovery.SaveOccasionFlag = appRecovery.SaveOccasionFlag.SAVE_WHEN_ERROR,
    saveMode: appRecovery.SaveModeFlag.SAVE_WITH_FILE = appRecovery.SaveModeFlag.SAVE_WITH_FILE) {
    appRecovery.enableAppRecovery(restart, saveOccasion, saveMode);
  }


  /**
   * 重启APP，并拉起应用启动时第一个Ability，可以配合errorManager相关接口使用。
   * 如果该Ability存在已经保存的状态，这些状态数据会在Ability的OnCreate生命周期回调的want参数中作为wantParam属性传入。
   * API10时将启动由setRestartWant指定的Ability。如果没有指定则按以下规则启动：
   *   如果当前应用前台的Ability支持恢复，则重新拉起该Ability。
   *   如果存在多个支持恢复的Ability处于前台，则只拉起最后一个。
   *   如果没有Ability处于前台，则不拉起。
   */
  static restartApp() {
    appRecovery.restartApp()
  }


  /**
   * 设置下次恢复主动拉起场景下的Ability。该Ability必须为当前包下的UIAbility。
   * @param want 通过设置Want中"bundleName"和"abilityName"字段来指定恢复重启的Ability。
   */
  static setRestartWant(want: Want) {
    appRecovery.setRestartWant(want);
  }


  /**
   * 保存当前App状态 或 主动保存Ability的状态，这个状态将在下次恢复启动时使用。可以配合errorManager相关接口使用
   * @param context UIAbilityContext  需要保存状态的UIAbility所对应的context。
   * @returns
   */
  static saveAppState(context?: common.UIAbilityContext): boolean {
    if (context) {
      return appRecovery.saveAppState(context) //主动保存Ability的状态
    } else {
      return appRecovery.saveAppState() //保存当前App状态
    }
  }



  /**
   * 获取当前窗口的属性。该方法已过时，推荐使用：WindowUtil.getWindowProperties()
   * @param windowClass 不传该值，获取主窗口的属性
   * @returns
   */
  static getWindowProperties(windowClass: window.Window = AppUtil.getMainWindow()): window.WindowProperties {
    return WindowUtil.getWindowProperties(windowClass);
  }

  /**
   * 设置窗口的显示方向属性。该方法已过时，推荐使用：WindowUtil.setPreferredOrientation()
   */
  static async setPreferredOrientation(orientation: window.Orientation, windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return WindowUtil.setPreferredOrientation(orientation, windowClass);
  }

  /**
   * 设置屏幕亮度值。该方法已过时，推荐使用：WindowUtil.setWindowBrightness()
   */
  static async setWindowBrightness(brightness: number, windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return WindowUtil.setWindowBrightness(brightness, windowClass);
  }

  /**
   * 设置屏幕是否为常亮状态。该方法已过时，推荐使用：WindowUtil.setWindowKeepScreenOn()
   */
  static async setWindowKeepScreenOn(isKeepScreenOn: boolean, windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return WindowUtil.setWindowKeepScreenOn(isKeepScreenOn, windowClass);
  }

  /**
   * 设置窗口是否为隐私模式。设置为隐私模式的窗口，窗口内容将无法被截屏或录屏。该方法已过时，推荐使用：WindowUtil.setWindowPrivacyMode()
   */
  static async setWindowPrivacyMode(isPrivacyMode: boolean, windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return WindowUtil.setWindowPrivacyMode(isPrivacyMode, windowClass);
  }

  /**
   * 设置窗口的背景色。该方法已过时，推荐使用：WindowUtil.setWindowBackgroundColor()
   */
  static setWindowBackgroundColor(color: string, windowClass: window.Window = AppUtil.getMainWindow()) {
    WindowUtil.setWindowBackgroundColor(color, windowClass);
  }

  /**
   * 设置点击时是否支持切换焦点窗口。该方法已过时，推荐使用：WindowUtil.setWindowFocusable()
   */
  static async setWindowFocusable(isFocusable: boolean, windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return WindowUtil.setWindowFocusable(isFocusable, windowClass);
  }

  /**
   * 设置窗口是否为可触状态。该方法已过时，推荐使用：WindowUtil.setWindowTouchable()
   */
  static async setWindowTouchable(isTouchable: boolean, windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return WindowUtil.setWindowTouchable(isTouchable, windowClass);
  }


}