import { display } from '@kit.ArkUI';
import { BusinessError, Callback } from '@kit.BasicServicesKit';
import { LogUtil } from './LogUtil';

/**
 * 屏幕相关工具类
 */
export class DisplayUtil {

  private constructor() {}


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
  static getWidth(): display.FoldStatus {
    return DisplayUtil.getDefaultDisplaySync().width;
  }

  /**
   * 获取设备的屏幕高度，单位为px。
   * @returns
   */
  static getHeight(): display.FoldStatus {
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
  static offFoldStatusChange(callback: Callback<display.FoldStatus>) {
    try {
      display.off('foldStatusChange', callback)
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`DisplayUtil-offFoldStatusChange-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }


}