/**
 * 温度转换工具类，华氏度与摄氏度相互转换
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
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