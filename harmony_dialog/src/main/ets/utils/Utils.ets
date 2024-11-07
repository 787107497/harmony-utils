
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


}
