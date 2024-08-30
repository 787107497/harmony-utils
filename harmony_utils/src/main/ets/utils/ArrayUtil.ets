/**
 * TODO 数组工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
import { StrUtil } from './StrUtil';

export class ArrayUtil {

  private constructor() {}


  /**
   * 集合是否为非空集合，不空为true否则false。
   * @param array
   * @returns
   */
  static isNotEmpty<T>(array: T[]): boolean {
    return undefined != array && null != array && array.length != 0;
  }


  /**
   * 集合是否为空集合,空为true否则false
   * @param array
   * @returns
   */
  static isEmpty<T>(array: T[]): boolean {
    return array == undefined || array == null || array.length == 0;
  }


  /**
   * 去除字符串数组中的空值
   * @param arr 待处理的集合
   * @returns 处理后的集合
   */
  static removeEmpty(arr: string[]): string[] {
    return arr.filter((value) => StrUtil.isNotEmpty(value));
  }


  /**
   * 去除字符串数组的每个值的前后空格
   * @param strs
   * @returns
   */
  static trim(strs: String[]): String[] {
    return strs.map((value) => value.trim());
  }


  /**
   * 数组去重，去重后生成新的数组，原数组不变。
   * @param array    数组
   * @return 去重后的数组
   */
  static distinct<T>(array: Array<T>): T[] {
    return Array.from(new Set(array));
  }


  /**
   * 将数组反转，会修改原始数组。
   * @param <T>  数组元素类型
   * @param array  数组
   * @return 变更后的原数组
   */
  static reverse<T>(array: T[]): T[] {
    return array.reverse();
  }


  /**
   * 数组过滤，filter函数
   * @param array
   * @param filter  过滤函数
   * @returns
   */
  static filter<T>(array: T[], filter: (item: T) => boolean): T[] {
    return filter ? array.filter(filter) : array;
  }


  /**
   * 将新元素添加到已有数组中，使用扩展运算符，不影响原数组。
   * @param source
   * @param item
   * @returns
   */
  static append<T>(source: T[], item: T | T[]): T[] {
    if (Array.isArray(item)) {
      return [...source, ...item];
    } else {
      return [...source, item];
    }
  }


  /**
   * 获取数组（数值、字符串、日期）最小值。
   * @param array
   * @returns
   */
  static min<T extends number | string | Date>(array: T[]): T | null {
    if (array.length === 0) {
      return null;
    }
    let minValue = array[0];
    for (let i = 1; i < array.length; i++) {
      if (array[i] < minValue) {
        minValue = array[i];
      }
    }
    return minValue;
  }


  /**
   * 获取数组（数值、字符串、日期）最大值。
   * @param array
   * @returns
   */
  static max<T extends number | string | Date>(array: T[]): T | null {
    if (array.length === 0) {
      return null;
    }
    let maxValue = array[0];
    for (let i = 1; i < array.length; i++) {
      if (array[i] > maxValue) {
        maxValue = array[i];
      }
    }
    return maxValue;
  }


  /**
   * 平铺二维数组。
   * @param arrays  数组
   * @returns 返回一个新的数组
   */
  static flatten(arrays: string[][]): string[] {
    return arrays.flat();
  }


  /**
   * 平铺二维数组，并去重。
   * @param arrays  数组
   * @returns 返回一个新的数组
   */
  static union(arrays: string[][]): string[] {
    return Array.from(new Set(arrays.flat()));
  }


}

