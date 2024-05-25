import { image } from '@kit.ImageKit';
import { componentSnapshot, window } from '@kit.ArkUI';
import { AppUtil } from './AppUtil';

/**
 * 组件截图和窗口截图工具类
 */
export class SnapshotUtil {

  private constructor() {}


  /**
   * 获取已加载的组件的截图，传入组件的组件id，找到对应组件进行截图。通过Promise返回结果。
   * @param id 目标组件的组件标识,组件的唯一标识id
   * @returns
   */
  static get(id: string): Promise<image.PixelMap> {
    return componentSnapshot.get(id);
  }


  /**
   * 在应用后台渲染CustomBuilder自定义组件，并输出其截图。通过Promise返回结果并支持获取离屏组件绘制区域坐标和大小。
   * @param builder 自定义组件构建函数。
   * @returns
   */
  static createFromBuilder(builder: CustomBuilder): Promise<image.PixelMap> {
    return componentSnapshot.createFromBuilder(builder);
  }


  /**
   * 获取窗口截图，使用Promise异步回调。
   * @param windowClass
   * @returns
   */
  static async snapshot(windowClass?: window.Window): Promise<image.PixelMap> {
    if (!windowClass) {
      windowClass = AppUtil.getMainWindow()
    }
    return windowClass.snapshot();
  }


}