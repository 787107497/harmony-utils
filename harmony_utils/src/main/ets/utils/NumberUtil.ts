/**
 * number工具类
 */
export class NumberUtil {

  private constructor() {}


  /**
   * 判断是否是数值
   * @param value 需要判断的参数
   */
  static isNumber(value: any): boolean {
    return typeof (value) === "number" && !isNaN(value);
  }


  /**
   * 将字符串转换为整数。
   * @param value
   * @param defaultValue
   * @returns
   */
  static toInt(value: string, defaultValue: number = 0): number {
    try {
      const parsedValue = parseInt(value);
      if (isNaN(parsedValue)) {
        return defaultValue;
      }
      return parsedValue;
    } catch (e) {
      return defaultValue
    }
  }


  /**
   * 将字符串转换为浮点数。
   * @param value
   * @param defaultValue
   * @returns
   */
  static toFloat(value: string, defaultValue: number = 0): number {
    try {
      const parsedValue = parseFloat(value);
      if (isNaN(parsedValue)) {
        return defaultValue;
      }
      return parsedValue;
    } catch (e) {
      return defaultValue
    }
  }


}