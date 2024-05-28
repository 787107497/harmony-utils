import bundleManager from '@ohos.bundle.bundleManager';
import { LogUtil } from './LogUtil';
import { BusinessError } from '@ohos.base';
import { KeyboardAvoidMode, window } from '@kit.ArkUI';
import { DeviceUtil } from './DeviceUtil';
import { resourceManager } from '@kit.LocalizationKit';
import { common, Want } from '@kit.AbilityKit';


/**
 * App相关工具类(使用该工具前请在UIAbility的onWindowStageCreate方法中调用AppUtil的init方法初始化)
 */
export class AppUtil{

  private constructor() {}

  private static readonly uri_info: string = 'application_info_entry' //应用设置页面
  private static readonly uri_network: string = "mobile_network_entry"; //移动网络设置页面
  private static readonly uri_notification: string = "systemui_notification_settings"; //通知设置页面
  private static readonly uri_bluetooth: string = "bluetooth_entry"; //蓝牙设置页面
  private static readonly uri_nfc: string = "nfc_settings"; //NFC设置页面
  private static context: common.UIAbilityContext; //common.UIAbilityContext，上下文
  private static windowStage: window.WindowStage;


  /**
   * 初始化方法,缓存全局变量，在UIAbility的onWindowStageCreate方法中初始化该方法。
   * @param windowStage 窗口管理器
   */
  static init(context: common.UIAbilityContext, windowStage: window.WindowStage) {
    AppUtil.context = context;
    AppUtil.windowStage = windowStage;
  }

  /**
   * 获取上下文，common.UIAbilityContext
   * @returns
   */
  static getContext(): common.UIAbilityContext {
    if (!AppUtil.context) {
      AppUtil.context = getContext() as common.UIAbilityContext; //兜底
      LogUtil.error("context为空，请在UIAbility的onWindowStageCreate方法中调用AppUtil的init方法初始化！");
    }
    return AppUtil.context;
  }

  /**
   * 获取主窗口
   */
  static getMainWindow(): window.Window {
    if (!AppUtil.windowStage) {
      LogUtil.error("windowStage为空，请在UIAbility的onWindowStageCreate方法中调用AppUtil的init方法初始化！");
    }
    return AppUtil.windowStage.getMainWindowSync();
  }

  /**
   * 获取UIContext
   * @returns
   */
  static getUIContext(): UIContext {
    return AppUtil.getMainWindow().getUIContext();
  }

  /**
   * 获取当前窗口的属性
   * @param windowClass 不传该值，获取主窗口的属性
   * @returns
   */
  static getWindowProperties(windowClass?: window.Window): window.WindowProperties {
    if (!windowClass) {
      windowClass = AppUtil.getMainWindow()
    }
    return windowClass.getWindowProperties();
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
  static setKeyboardAvoidMode(value: KeyboardAvoidMode) {
    AppUtil.getUIContext().setKeyboardAvoidMode(value);
  }


  /**
   * 设备当前是否以竖屏方式显示（竖屏）
   */
  static isPortrait(): Boolean {
    let direction = DeviceUtil.getDirection();
    return direction == resourceManager.Direction.DIRECTION_VERTICAL;
  }

  /**
   * 设备当前是否以横屏方式显示（横屏）
   */
  static isLandscape(): Boolean {
    let direction = DeviceUtil.getDirection();
    return direction == resourceManager.Direction.DIRECTION_HORIZONTAL;
  }


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
   */
  static setPreferredOrientation(orientation: window.Orientation, windowClass?: window.Window): Promise<void> {
    if (!windowClass) {
      windowClass = AppUtil.getMainWindow();
    }
    return windowClass.setPreferredOrientation(orientation);
  }


  /**
   * 设置屏幕亮度值，使用Promise异步回调。
   * @param brightness  屏幕亮度值。该参数为浮点数，取值范围为[0.0, 1.0]或-1.0。1.0表示最亮，-1.0表示默认亮度。
   * @returns
   */
  static setWindowBrightness(brightness: number, windowClass?: window.Window): Promise<void> {
    if (!windowClass) {
      windowClass = AppUtil.getMainWindow();
    }
    return windowClass.setWindowBrightness(brightness);
  }


  /**
   * 设置屏幕是否为常亮状态，使用Promise异步回调。
   * @param isKeepScreenOn  true表示常亮；false表示不常亮。
   * @returns
   */
  static setWindowKeepScreenOn(isKeepScreenOn: boolean, windowClass?: window.Window): Promise<void> {
    if (!windowClass) {
      windowClass = AppUtil.getMainWindow();
    }
    return windowClass.setWindowKeepScreenOn(isKeepScreenOn);
  }


  /**
   * 设置窗口是否为隐私模式。设置为隐私模式的窗口，窗口内容将无法被截屏或录屏。
   * @param isPrivacyMode 窗口是否为隐私模式。true表示模式开启；false表示模式关闭。
   * @returns
   */
  static setWindowPrivacyMode(isPrivacyMode: boolean, windowClass?: window.Window): Promise<void> {
    if (!windowClass) {
      windowClass = AppUtil.getMainWindow();
    }
    return windowClass.setWindowPrivacyMode(isPrivacyMode);
  }


  /**
   * 设置窗口的背景色。Stage模型下，该接口需要在loadContent()或setUIContent()调用生效后使用。
   * @param color 需要设置的背景色，为十六进制RGB或ARGB颜色，不区分大小写，例如#00FF00或#FF00FF00。
   * @returns
   */
  static setWindowBackgroundColor(color: string, windowClass?: window.Window) {
    if (!windowClass) {
      windowClass = AppUtil.getMainWindow();
    }
    return windowClass.setWindowBackgroundColor(color);
  }

  /**
   * 设置点击时是否支持切换焦点窗口，使用Promise异步回调。
   * @param isFocusable 点击时是否支持切换焦点窗口。true表示支持；false表示不支持。
   * @returns
   */
  static setWindowFocusable(isFocusable: boolean, windowClass?: window.Window): Promise<void> {
    if (!windowClass) {
      windowClass = AppUtil.getMainWindow();
    }
    return windowClass.setWindowFocusable(isFocusable);
  }

  /**
   * 设置窗口是否为可触状态，使用Promise异步回调。
   * @param isTouchable 窗口是否为可触状态。true表示可触；false表示不可触。
   * @returns
   */
  static setWindowTouchable(isTouchable: boolean, windowClass?: window.Window): Promise<void> {
    if (!windowClass) {
      windowClass = AppUtil.getMainWindow();
    }
    return windowClass.setWindowTouchable(isTouchable);
  }


  /**
   * 获取状态栏的高度，单位为px。
   * @returns
   */
  static getStatusBarHeight(): number {
    let windowClass = AppUtil.getMainWindow();
    let avoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
    return avoidArea.topRect.height;
  }

  /**
   * 获取底部导航条的高度，单位为px。
   * @returns
   */
  static getNavigationIndicatorHeight(): number {
    let windowClass = AppUtil.getMainWindow();
    let avoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
    return avoidArea.bottomRect.height;
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
    let windowClass = AppUtil.getMainWindow();
    windowClass.setWindowLayoutFullScreen(isLayoutFullScreen).then(() => {
      windowClass.setWindowBackgroundColor(color);
    }).catch((error: BusinessError) => {
      LogUtil.error(`setWindowLayoutFullScreen-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    });
    windowClass.setWindowSystemBarEnable(enable ? ['status', 'navigation'] : []).then(() => {
      windowClass.setSpecificSystemBarEnabled("navigationIndicator", enable); //底部导航条。
    }).catch((error: BusinessError) => {
      LogUtil.error(`setWindowSystemBarEnable-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    });
    if (systemBarProperties) {
      windowClass.setWindowSystemBarProperties(systemBarProperties).catch((error: BusinessError) => {
        LogUtil.error(`setWindowSystemBarProperties-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      });
    }
  }


  /**
   * 获取当前应用的BundleInfo
   * @returns
   */
  static async getBundleInfo(): Promise<bundleManager.BundleInfo> {
    return await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
  }


  /**
   * 获取应用程序的配置信息
   * @returns
   */
  static async getAppInfo() {
    let bundleInfo: bundleManager.BundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
    return bundleInfo.appInfo;
  }


  /**
   * 跳转应用设置页面（调用此方法到设置，手动开启权限）
   */
  static async toAppSetting(uri: string = AppUtil.uri_info): Promise<void> {
    let context = AppUtil.getContext();
    let want: Want = {
      bundleName: 'com.huawei.hmos.settings', //设置应用bundleName
      abilityName: 'com.huawei.hmos.settings.MainAbility', //设置应用abilityName
      uri: uri, //目标页面
      parameters: {
        bundleName: context.abilityInfo.bundleName, //拉起方应用包名
        pushParams: context.abilityInfo.bundleName, //拉起方应用包名
      }
    }
    return await context.startAbility(want)
  }

  /**
   * 跳转移动网络设置页面
   */
  static toNetworkSetting(): Promise<void> {
    return AppUtil.toAppSetting(AppUtil.uri_network);
  }

  /**
   * 跳转通知设置页面
   */
  static toNotificationSetting(): Promise<void> {
    return AppUtil.toAppSetting(AppUtil.uri_notification);
  }

  /**
   * 跳转蓝牙设置页面
   */
  static toBluetoothSetting(): Promise<void> {
    return AppUtil.toAppSetting(AppUtil.uri_bluetooth);
  }

  /**
   * 跳转NFC设置页面
   */
  static toNfcSetting(): Promise<void> {
    return AppUtil.toAppSetting(AppUtil.uri_nfc);
  }


}