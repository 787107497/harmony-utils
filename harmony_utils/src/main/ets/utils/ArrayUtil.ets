/**
 * 数组工具类
 */
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
   * 去除集合中的空值
   * @param arr 待处理的集合
   * @returns 处理后的集合
   */
  static removeEmpty(arr: string[]): string[] {
    return arr.filter((value) => value !== null && value !== undefined && value !== '');
  }


  /**
   * 去除传入集合的每个值的前后空格
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
   * 反转数组，会修改原始数组。
   * @param <T>  数组元素类型
   * @param array  数组
   * @return 变更后的原数组
   */
  static reverse<T>(array: T[]): T[] {
    return array.reverse();
  }


  /**
   * 通过传入的filter实现来过滤返回需要的元素
   * @param array
   * @param filter  过滤函数
   * @returns
   */
  static filter<T>(array: T[], filter: (item: T) => boolean): T[] {
    return filter ? array.filter(filter) : array;
  }


  /**
   * 将新元素添加到已有数组中 添加新元素会生成一个新的数组，不影响原数组。
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
   * 将元素值设置为数组的某个位置，当给定的index大于数组长度，则追加。
   * @param <T>    数组元素类型
   * @param buffer 已有数组
   * @param index  位置，大于长度追加，否则替换
   * @param value  新值
   * @return 新数组或原有数组
   */
  static setOrAppend<T>(buffer: T[], index: number, value: T): T[] {
    if (index < 0) {
      return [value, ...buffer];
    } else if (index >= buffer.length) {
      return [...buffer, value];
    } else {
      return buffer.map((item, i) => (i === index ? value : item));
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

