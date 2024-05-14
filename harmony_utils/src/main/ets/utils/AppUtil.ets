import { vibrator } from '@kit.SensorServiceKit';
import bundleManager from '@ohos.bundle.bundleManager';
import { LogUtil } from './LogUtil';
import { BusinessError } from '@ohos.base';
import { appRecovery, common, Want } from '@kit.AbilityKit';
import { display, KeyboardAvoidMode, window } from '@kit.ArkUI';


/**
 * App相关工具类(使用该工具前请在UIAbility的onWindowStageCreate方法中调用AppUtil的cacheWindowStage方法)
 */
export class AppUtil{

  private constructor() {}

  private static windowStage: window.WindowStage;


  /**
   * 缓存窗口管理器，在UIAbility的onWindowStageCreate方法中初始化该方法。
   * @param windowStage 窗口管理器
   */
  static cacheWindowStage(windowStage: window.WindowStage) {
    AppUtil.windowStage = windowStage;
  }


  /**
   * 获取主窗口
   */
  static getMainWindow(): window.Window {
    if (!AppUtil.windowStage) {
      LogUtil.error("windowStage为空，请在UIAbility的onWindowStageCreate方法中调用cacheWindowStage方法缓存windowStage！");
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
    let keyboardAvoidMode = AppUtil.getUIContext().getKeyboardAvoidMode();
    return keyboardAvoidMode;
  }

  /**
   * 设置虚拟键盘弹出时，页面的避让模式。
   * @param value （OFFSET-上抬模式、RESIZE-压缩模式）
   */
  static setKeyboardAvoidMode(value: KeyboardAvoidMode) {
    AppUtil.getUIContext().setKeyboardAvoidMode(value);
  }


  /**
   * 设备当前是否以竖屏方式显示（竖屏、反向竖屏）
   */
  static isPortrait(): Boolean {
    let orientation = display.getDefaultDisplaySync().orientation;
    return orientation == display.Orientation.PORTRAIT || orientation == display.Orientation.PORTRAIT_INVERTED;
  }

  /**
   * 设备当前是否以横屏方式显示（横屏、反向横屏）
   */
  static isLandscape(): Boolean {
    let orientation = display.getDefaultDisplaySync().orientation;
    return orientation == display.Orientation.LANDSCAPE || orientation == display.Orientation.LANDSCAPE_INVERTED;
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
  static setPreferredOrientation(orientation: window.Orientation, windowClass?: window.Window) {
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
   * 获取挖孔屏、刘海屏等不可用屏幕的状态栏的高度，单位为px。
   * @returns
   */
  static getCutoutHeight(): number {
    let windowClass = AppUtil.getMainWindow();
    let avoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_CUTOUT);
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
    }).catch((err: BusinessError) => {
      LogUtil.error('setWindowLayoutFullScreen异常信息:' + JSON.stringify(err));
    });
    windowClass.setWindowSystemBarEnable(enable ? ['status', 'navigation'] : []).then(() => {
      windowClass.setSpecificSystemBarEnabled("navigationIndicator", enable); //底部导航条。
    }).catch((err: BusinessError) => {
      LogUtil.error('setWindowSystemBarEnable异常信息:' + JSON.stringify(err));
    });
    if (systemBarProperties) {
      windowClass.setWindowSystemBarProperties(systemBarProperties);
    }
  }



  /**
   * 启用应用恢复功能，参数按顺序填入。该接口调用后，应用从启动器启动时第一个Ability支持恢复。
   * @param restart RestartFlag 应用重启标志。
   *    ALWAYS_RESTART	0	总是重启应用。
   *    RESTART_WHEN_JS_CRASH	0x0001	发生JS_CRASH时重启应用。
   *    RESTART_WHEN_APP_FREEZE	0x0002	发生APP_FREEZE时重启应用。
   *    NO_RESTART	0xFFFF	总是不重启应用。
   * @param saveOccasion SaveOccasionFlag 保存条件标志
   *    SAVE_WHEN_ERROR	0x0001	当发生应用故障时保存。
   *    SAVE_WHEN_BACKGROUND	0x0002	当应用切入后台时保存。
   * @param saveMode SaveModeFlag  状态保存标志
   *    SAVE_WITH_FILE	0x0001	每次状态保存都会写入到本地文件缓存。
   *    SAVE_WITH_SHARED_MEMORY	0x0002	状态先保存在内存中，应用故障退出时写入到本地文件缓存。
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
   * 设置下次恢复主动拉起场景下的Ability。该Ability必须为当前包下的UIAbility。
   * @param want 通过设置Want中"bundleName"和"abilityName"字段来指定恢复重启的Ability。
   */
  static setRestartWant(want: Want) {
    appRecovery.setRestartWant(want);
  }


  /**
   * 开启振动
   * @param duration
   * @param usage
   */
  static startVibration(duration: number = 10000, usage: vibrator.Usage = 'media') {
    vibrator.startVibration({ type: 'time', duration: duration }, { id: 0, usage: usage }, (error) => {
      if (error) {
        LogUtil.error("startVibration：" + JSON.stringify(error))
      }
    })
  }


  /**
   * 停止振动（按照VIBRATOR_STOP_MODE_TIME模式）
   */
  static stopVibration() {
    vibrator.stopVibration(vibrator.VibratorStopMode.VIBRATOR_STOP_MODE_TIME, (error: BusinessError) => {
      if (error) {
        LogUtil.error("stopVibration：" + JSON.stringify(error))
      }
    })
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


}