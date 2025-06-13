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
import { resourceManager } from '@kit.LocalizationKit';
import { BusinessError } from '@ohos.base';
import { deviceInfo } from '@kit.BasicServicesKit';
import {
  AbilityLifecycleCallback,
  ApplicationStateChangeCallback,
  appManager,
  common,
  Configuration,
  ConfigurationConstant,
  EnvironmentCallback,
  Want
} from '@kit.AbilityKit';
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
   * 检查API版本是否安全
   * @param apiVersion API方法支持的最低版本
   */
  static isApiSupported(apiVersion: number): boolean {
    return deviceInfo.sdkApiVersion >= apiVersion;
  }


  /**
   * 获取应用级别的上下文的能力，ApplicationContext
   * @returns
   */
  static getApplicationContext():common.ApplicationContext{
    return AppUtil.getContext().getApplicationContext();
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
   * 获取应用的Configuration
   * @returns
   */
  static getConfiguration(): Configuration {
    return AppUtil.getContext().config;
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
    AppUtil.getApplicationContext().setColorMode(colorMode);
  }

  /**
   * 获取应用的颜色模式
   * @returns
   */
  static getColorMode(): ConfigurationConstant.ColorMode | undefined {
    return AppUtil.getConfiguration().colorMode
  }


  /**
   * 设置应用的字体类型。仅支持主线程调用。
   * @param fontSizeScale
   */
  static setFont(font: string){
    AppUtil.getApplicationContext().setFont(font);
  }


  /**
   * 设置应用字体大小缩放比例。仅支持主线程调用。<API13+>
   * @param fontSizeScale 表示字体缩放比例，取值为非负数。当应用字体跟随系统且该字段取值超过fontSizeMaxScale取值时，实际生效值为fontSizeMaxScale取值。
   */
  static setFontSizeScale(fontSizeScale: number) {
    if (AppUtil.isApiSupported(13)) {
      AppUtil.getApplicationContext().setFontSizeScale(fontSizeScale);
    }
  }

  /**
   * 获取应用字体大小缩放比例。
   * @returns
   */
  static getFontSizeScale(): number | undefined {
    return AppUtil.getConfiguration().fontSizeScale;
  }


  /**
   * 设置应用的语言。仅支持主线程调用。
   * @param language 设置语言，当前支持的语言列表可以通过getSystemLanguages()获取。
   */
  static setLanguage(language: string) {
    AppUtil.getApplicationContext().setLanguage(language);
  }

  /**
   * 获取应用的语言
   * @returns
   */
  static getLanguage(): string | undefined {
    return AppUtil.getConfiguration().language;
  }


  /**
   * 应用设置自身是否支持缓存后快速启动。仅支持主线程调用。
   * @param isSupported 表示应用是否支持缓存后快速启动。true表示支持，false表示不支持。
   */
  static setSupportedProcessCache(isSupported: boolean) {
    AppUtil.getApplicationContext().setSupportedProcessCache(isSupported);
  }


  /**
   * 清理应用本身的数据，同时撤销应用向用户申请的权限。使用Promise异步回调。仅支持主线程调用。
   */
  static async clearUpApplicationData(): Promise<void> {
    return AppUtil.getContext().getApplicationContext().clearUpApplicationData();
  }


  /**
   * 终止应用的所有进程，进程退出时不会正常走完应用生命周期。使用Promise异步回调。仅支持主线程调用。
   * @param clearPageStack 表示是否清除页面堆栈。true表示清除，false表示不清除。<API14+>
   * @returns
   */
  static async killAllProcesses(clearPageStack: boolean = true): Promise<void> {
    if (AppUtil.isApiSupported(14)) {
      return AppUtil.getApplicationContext().killAllProcesses(clearPageStack);
    } else {
      return AppUtil.getApplicationContext().killAllProcesses();
    }
  }


  /**
   * 应用重启并拉起自身指定UIAbility。重启时不会收到onDestroy回调。仅支持主线程调用，且待重启的应用需要处于获焦状态。
   * @param want Want类型参数，传入需要启动的UIAbility的信息，Bundle名称不做校验。
   */
  static restartApp(want?: Want) {
    if (want === undefined) {
      want = {
        bundleName: AppUtil.getBundleName(), //设置应用bundleName
        abilityName: AppUtil.getContext().abilityInfo.name, //设置应用abilityName
      }
    }
    AppUtil.getApplicationContext().restartApp(want);
  }


  /**
   * 主动退出整个应用；调用该方法后，任务中心的任务默认不会清理，如需清理，需要配置removeMissionAfterTerminate为true。
   */
  static async exit(): Promise<void> {
    await AppUtil.getContext().terminateSelf();
    await AppUtil.killAllProcesses();
  }


  /**
   * 获取有关运行进程的信息。使用Promise异步回调。
   */
  static async getRunningProcessInformation(): Promise<Array<appManager.ProcessInformation>> {
    return AppUtil.getApplicationContext().getRunningProcessInformation();
  }


  /**
   * 注册对当前应用前后台变化的监听。使用callback异步回调。仅支持主线程调用。
   * @param callback 回调函数。可以对应用从后台切换到前台，以及前台切换到后台分别定义回调。
   */
  static onApplicationStateChange(callback: ApplicationStateChangeCallback) {
    AppUtil.getApplicationContext().on('applicationStateChange', callback);
  }

  /**
   * 取消对应用前后台切换事件的监听。使用callback异步回调。仅支持主线程调用。
   * @param callback 回调函数。取值可以为使用ApplicationContext.on('applicationStateChange')方法定义的callback回调，也可以为空。
   *   如果传入已定义的回调，则取消该监听。如果未传入参数，则取消当前应用对所有前后台切换事件的监听。
   */
  static offApplicationStateChange(callback?: ApplicationStateChangeCallback) {
    AppUtil.getApplicationContext().off('applicationStateChange', callback);
  }


  /**
   * 注册对系统环境变化的监听。使用callback异步回调。仅支持主线程调用。
   * @param callback 回调方法，提供应用上下文ApplicationContext对系统环境变量监听回调的能力。
   * @returns 返回的此次注册监听系统环境变化的ID（每次注册该ID会自增+1，当超过监听上限数量2^63-1时，返回-1）。
   */
  static onEnvironment(callback: EnvironmentCallback): number {
    return AppUtil.getApplicationContext().on('environment', callback);
  }

  /**
   * 取消对系统环境变化的监听。使用Promise异步回调。仅支持主线程调用。
   * @param callback 注册监听系统环境变化的ID。
   * @returns
   */
  static async offEnvironment(callbackId: number): Promise<void> {
    return AppUtil.getApplicationContext().off('environment', callbackId);
  }


  /**
   * 注册监听应用内生命周期。使用callback异步回调。仅支持主线程调用。
   * @param callback 回调方法，返回注册监听事件的ID。
   * @returns
   */
  static onAbilityLifecycle(callback: AbilityLifecycleCallback): number {
    return AppUtil.getApplicationContext().on('abilityLifecycle', callback);
  }

  /**
   * 取消监听应用内生命周期。使用callback异步回调。仅支持主线程调用。
   * @param callbackId 回调方法，返回注册监听事件的ID。
   * @returns
   */
  static async offAbilityLifecycle(callbackId: number): Promise<void> {
    return AppUtil.getApplicationContext().off('abilityLifecycle', callbackId);
  }


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
      LogUtil.error(err);
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
      LogUtil.error(err);
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
      }).catch((err: BusinessError) => {
        LogUtil.error(err);
      });
      windowClass.setWindowSystemBarEnable(enable ? ['status', 'navigation'] : []).then(() => {
        windowClass.setSpecificSystemBarEnabled("navigationIndicator", enable); //底部导航条。
      }).catch((err: BusinessError) => {
        LogUtil.error(err);
      });
      if (systemBarProperties) {
        windowClass.setWindowSystemBarProperties(systemBarProperties).catch((err: BusinessError) => {
          LogUtil.error(err);
        });
      }
    } catch (err) {
      LogUtil.error(err);
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
   * 获取应用包安装时间。
   * @returns
   */
  static getInstallTime(): number {
    return AppUtil.getBundleInfoSync().installTime;
  }

  /**
   * 获取应用包更新时间。
   * @returns
   */
  static getUpdateTime(): number {
    return AppUtil.getBundleInfoSync().updateTime;
  }

  /**
   * 获取应用程序签名证书文件的类型，分为debug和release两种类型。
   * @returns
   */
  static getAppProvisionType(): string {
    return AppUtil.getAppInfoSync().appProvisionType;
  }

  /**
   * 标识应用是否处于调试模式，取值为true表示应用处于调试模式，取值为false表示应用处于非调试模式。
   * @returns
   */
  static debug(): boolean {
    return AppUtil.getAppInfoSync().debug;
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