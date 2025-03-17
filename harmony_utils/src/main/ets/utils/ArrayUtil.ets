/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-utils
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { StrUtil } from './StrUtil';


/**
 * TODO 集合工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class ArrayUtil {


  /**
   * 判断集合是否为非空集合。
   * @param array
   * @returns
   */
  static isNotEmpty<T>(array: T[]): boolean {
    return undefined !== array && null !== array && array.length !== 0;
  }


  /**
   * 判断集合是否为空集合。
   * @param array
   * @returns
   */
  static isEmpty<T>(array: T[]): boolean {
    return array === undefined || array === null || array.length === 0;
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
   * 将数组去重，去重后生成新的数组，原数组不变。
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
   * 数组过滤，通过filter函数实现来过滤返回需要的元素
   * @param array
   * @param filter  过滤函数
   * @returns
   */
  static filter<T>(array: T[], filter: (item: T) => boolean): T[] {
    return filter ? array.filter(filter) : array;
  }


  /**
   * 拼接数据，使用扩展运算符，不影响原数组。
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
   * 获取数组最小值（数值、字符串、日期）。
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
   * 获取数组最大值（数值、字符串、日期）。
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


  /**
   * 数组分块
   * @param array
   * @param size
   * @returns
   */
  static chunk<T>(array: T[], size: number): T[][] {
    let length = array.length;
    if (length < 1 || size < 1) {
      return [];
    }
    let index = 0;
    let resIndex = 0;
    let result = new Array<Array<T>>(Math.ceil(length / size));
    while (index < length) {
      result[resIndex++] = array.slice(index, (index += size));
    }
    return result;
  }


  /**
   * 判断集合是否包含某个值
   * @param array
   * @param value
   * @returns
   */
  static contain<T>(array: T[], value: T): boolean {
    return array.includes(value);
  }

  /**
   * 移除集合的某个值
   * @param array
   * @param value
   * @returns
   */
  static remove<T>(array: T[], value: T) {
    const index = array.indexOf(value);
    if (index !== -1) {
      array.splice(index, 1);
    }
  }


}

