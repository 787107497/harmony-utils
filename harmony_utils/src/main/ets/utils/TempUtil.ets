/**
 * 温度转换工具类，华氏度与摄氏度相互转换
 */
export class TempUtil {

  private constructor() {}

  /**
   * 华氏度转摄氏度
   * @param f 华氏度
   * @return 摄氏度
   */
  static F2C(f: number): number {
    return (f - 32) * (5 / 9)
  }

  /**
   * 摄氏度转华氏度
   * @param c 摄氏度
   * @return 华氏度
   */
  static C2F(c: number): number {
    return c * (9 / 5) + 32
  }

}