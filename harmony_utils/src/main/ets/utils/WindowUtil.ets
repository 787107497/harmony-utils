import { display, window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { LogUtil } from './LogUtil';
import { BusinessError } from '@kit.BasicServicesKit';


/**
 * 窗口工具类
 */
export class WindowUtil {

  private constructor() {}


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
      options.name = 'subWindow';
    }
    if (options.windowType == undefined) {
      options.windowType = window.WindowType.TYPE_DIALOG;
    }
    if (!options.bgColor) {
      options.bgColor = '#33606266';
    }
    try {
      //创建窗口
      let windowClass = await window.createWindow({
        name: options.name,
        windowType: options.windowType,
        ctx: getContext() as common.UIAbilityContext
      });
      //将窗口缓存
      WindowUtil.cacheWindow = windowClass;
      await windowClass.setUIContent(options.contentRouter);
      //获取屏幕四大角
      let d = display.getDefaultDisplaySync();
      //设置窗口大小
      await windowClass.resize(d.width, d.height);
      // 设置窗口背景颜色
      windowClass.setWindowBackgroundColor(options.bgColor);
      //显示窗口
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
   * @returns
   */
  static async closeWindow(): Promise<void> {
    if (WindowUtil.cacheWindow) {
      await WindowUtil.cacheWindow.destroyWindow();
    }
  }


}



/**
 * 窗口入参对象
 */
class WinOptions {
  /**
   * 窗口名称 默认eftool
   */
  name?: string;
  /**
   * 窗口类型 默认TYPE_DIALOG
   */
  windowType?: window.WindowType;
  /**
   *窗口要显示的路由  如:pages/Welcome需要在main_pages.json中声明
   */
  contentRouter: string = '';
  /**
   * 窗口背景颜色,默认#33606266
   */
  bgColor?: string;
  /**
   * 窗口创建回调函数
   */
  callBack?: () => void;
}