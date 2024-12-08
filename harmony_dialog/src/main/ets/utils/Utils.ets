import { common } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

/**
 * 工具类
 */
export class Utils {

  /**
   * 获取按钮的字符串
   * @param resource
   * @returns
   */
  static getResourceStr(resource: ResourceStr | ButtonOptions | SheetInfo): string | null {
    try {
      if (typeof resource === 'string') {
        return resource;
      } else {
        return getContext().resourceManager.getStringSync((resource as Resource).id);
      }
    } catch (e) {
      return null
    }
  }


  /**
   * 获取底部导航条的高度，单位为vp。
   * @returns
   */
  static getNavigationIndicatorHeight(uiContext: common.UIAbilityContext): number {
    try {
      let windowClass = uiContext.windowStage.getMainWindowSync();
      let avoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      let height = avoidArea.bottomRect.height;
      return px2vp(height);
    } catch (err) {
      return 30;
    }
  }
}
