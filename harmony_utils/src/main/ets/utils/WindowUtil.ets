import { window } from '@kit.ArkUI';
import { AppUtil } from './AppUtil';
import { LogUtil } from './LogUtil';

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
   * 设置窗口的布局是否为沉浸式布局（该沉浸式布局状态栏、导航栏仍然显示）。
   * @param isLayoutFullScreen true表示沉浸式布局；false表示非沉浸式布局。
   * @param windowClass 不传该值，默认主窗口。
   */
  static async setWindowLayoutFullScreen(isLayoutFullScreen: boolean,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowLayoutFullScreen(isLayoutFullScreen);
  }



  /**
   * 设置窗口的布局是否为沉浸式布局（该沉浸式布局状态栏、导航栏仍然显示）。
   * @param systemBarProperties 状态栏、导航栏的属性:
   *   statusBarColor 状态栏背景颜色，为十六进制RGB或ARGB颜色，不区分大小写，例如#00FF00或#FF00FF00。默认值：#0x66000000。
   *   statusBarContentColor 状态栏文字颜色。当设置此属性后， isStatusBarLightIcon属性设置无效。默认值：#0xE5FFFFFF。
   *   isStatusBarLightIcon 状态栏图标是否为高亮状态。true表示高亮；false表示不高亮。默认值：false。
   *   navigationBarColor 导航栏背景颜色，为十六进制RGB或ARGB颜色，不区分大小写，例如#00FF00或#FF00FF00。默认值：#0x66000000。
   *   navigationBarContentColor  导航栏文字颜色。当设置此属性后， isNavigationBarLightIcon属性设置无效。默认值：#0xE5FFFFFF。
   *   isNavigationBarLightIcon 导航栏图标是否为高亮状态。true表示高亮；false表示不高亮。默认值：false。
   * @param windowClass 不传该值，默认主窗口。
   */
  static async setWindowSystemBarProperties(systemBarProperties: window.SystemBarProperties,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowSystemBarProperties(systemBarProperties);
  }


  /**
   * 设置屏幕是否为常亮状态，使用Promise异步回调。
   * @param isKeepScreenOn  true表示常亮；false表示不常亮。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setWindowSystemBarEnable(systemBarProperties: window.SystemBarProperties,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowSystemBarEnable(systemBarProperties);
  }


  /**
   * 设置屏幕是否为常亮状态，使用Promise异步回调。
   * @param isKeepScreenOn  true表示常亮；false表示不常亮。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setWindowSystemBarProperties(systemBarProperties: window.SystemBarProperties,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowSystemBarProperties(systemBarProperties);
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
   * 设置点击时是否支持切换焦点窗口，使用Promise异步回调。
   * @param isFocusable 点击时是否支持切换焦点窗口。true表示支持；false表示不支持。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static async setWindowFocusable(isFocusable: boolean,
    windowClass: window.Window = AppUtil.getMainWindow()): Promise<void> {
    return windowClass.setWindowFocusable(isFocusable);
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
   * 获取当前窗口的属性
   * @param windowClass 不传该值，获取主窗口的属性
   * @returns
   */
  static getWindowProperties(windowClass: window.Window = AppUtil.getMainWindow()): window.WindowProperties {
    return windowClass.getWindowProperties();
  }


  /**
   * 获取窗口类型。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static getWindowType(windowClass: window.Window = AppUtil.getMainWindow()): window.WindowType {
    return AppUtil.getWindowProperties(windowClass).type;
  }


  /**
   * 窗口是否隐私模式，默认为false。true表示模式开启；false表示模式关闭。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isPrivacyMode(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return AppUtil.getWindowProperties(windowClass).isPrivacyMode;
  }


  /**
   * 窗口是否透明。默认为false。true表示透明；false表示不透明。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isTransparent(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return AppUtil.getWindowProperties(windowClass).isTransparent;
  }


  /**
   * 判断窗口是否全屏，默认为false。true表示全屏；false表示非全屏。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isFullScreen(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return AppUtil.getWindowProperties(windowClass).isFullScreen;
  }


  /**
   * 判断窗口是否为沉浸式，默认为false。true表示沉浸式；false表示非沉浸式。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isLayoutFullScreen(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return AppUtil.getWindowProperties(windowClass).isLayoutFullScreen;
  }


  /**
   * 获取屏幕亮度。该参数为浮点数，可设置的亮度范围为[0.0, 1.0]，其取1.0时表示最大亮度值。如果窗口没有设置亮度值，表示亮度跟随系统，此时获取到的亮度值为-1。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static getBrightness(windowClass: window.Window = AppUtil.getMainWindow()): number {
    return AppUtil.getWindowProperties(windowClass).brightness;
  }


  /**
   * 窗口是否可聚焦，默认为true。true表示可聚焦；false表示不可聚焦。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isFocusable(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return AppUtil.getWindowProperties(windowClass).focusable;
  }


  /**
   * 窗口是否可触摸，默认为true。true表示可触摸；false表示不可触摸。
   * @param windowClass 不传该值，默认主窗口。
   * @returns
   */
  static isTouchable(windowClass: window.Window = AppUtil.getMainWindow()): boolean {
    return AppUtil.getWindowProperties(windowClass).touchable;
  }


}