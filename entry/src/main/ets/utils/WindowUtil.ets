import { display, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { LogUtil } from '@pura/harmony-utils';


/**
 * 窗口工具类
 */
export class WindowUtil {
  private constructor() {
  }


  private static windowStage_: window.WindowStage

  static init(windowStage: window.WindowStage) {
    WindowUtil.windowStage_ = windowStage
  }

  /**
   * 缓存窗体,关闭时需要
   */
  private static cacheWindow: window.Window;


  /**
   * 根据参数创建窗口
   */
  static async createWindow(options: WinOptions): Promise<void> {
    if (!options) {
      options = new WinOptions();
    }
    if (!options.name) {
      options.name = 'utils001';
    }
    if (options.windowType == undefined) {
      options.windowType = window.WindowType.TYPE_DIALOG;
    }
    if (!options.bgColor) {
      options.bgColor = '#33606266';
    }
    try {
      //创建窗口
      // let windowClass = await window.createWindow({
      //   name: options.name,
      //   windowType: options.windowType,
      //   ctx: getContext() as common.UIAbilityContext
      // });
      //创建窗口
      let windowClass = await  WindowUtil.windowStage_.createSubWindow(options.name);
      WindowUtil.cacheWindow = windowClass; //将窗口缓存
      await windowClass.setUIContent(options.contentRouter);
      let d = display.getDefaultDisplaySync();
      await windowClass.resize(d.width/2, d.height/2);
      windowClass.setWindowBackgroundColor(options.bgColor);
      await windowClass.showWindow();
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`WindowUtil-createWindow-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }


  //设置子窗口背景透明
  static setWindowBackgroundColor() {
    if (WindowUtil.cacheWindow) {
      WindowUtil.cacheWindow.setWindowBackgroundColor("#00000000")
    }
  }


  /**
   * 关闭窗口
   */
  static async closeWindow(): Promise<void> {
    if (WindowUtil.cacheWindow) {
      await WindowUtil.cacheWindow.destroyWindow();
    }
  }
}


/**
 * 窗口参数 */
class WinOptions {
  name?: string; //窗口名称
  windowType?: window.WindowType; //窗口类型 默认TYPE_DIALOG
  contentRouter: string = ''; //窗口要显示的路由,如:pages/index
  bgColor?: string; //窗口背景颜色
  callBack?: () => void; //回调函数
}