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



import { Decimal } from '@kit.ArkTS';
import { Any, Value } from '../entity/constraint';


/**
 * TODO number工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class NumberUtil {


  /**
   * 检查值是否为NaN
   * @param value
   * @returns
   */
  static isNaN(value: Any): boolean {
    return Number.isNaN(value);
  }

  /**
   * 检查值是否为有限数字
   * @param value
   * @returns
   */
  static isFinite(value: Any): boolean {
    return Number.isFinite(value);
  }

  /**
   * 检查值是否为整数
   * @param value
   * @returns
   */
  static isInteger(value: Any): boolean {
    return Number.isInteger(value);
  }

  /**
   * 检查值是否为安全整数
   * @param value
   * @returns
   */
  static isSafeInteger(value: Any): boolean {
    return Number.isSafeInteger(value);
  }


  /**
   * 判断是否是数值
   * @param value 需要判断的参数
   */
  static isNumber(value: Any): boolean {
    return (typeof value === "number") && !NumberUtil.isNaN(value);
  }


  /**
   * 检查数字是否为偶数
   * @param {number} num - 要检查的数字
   * @returns {boolean} 如果是偶数返回 true，否则返回 false
   */
  static isEven(num: number): boolean {
    return num % 2 === 0;
  }

  /**
   * 检查数字是否为奇数
   * @param {number} num - 要检查的数字
   * @returns {boolean} 如果是奇数返回 true，否则返回 false
   */
  static isOdd(num: number): boolean {
    return num % 2 !== 0;
  }


  /**
   * 将字符串转换为Number。
   * @param value 要转换的字符串
   * @param defaultValue 异常时给默认值
   * @returns
   */
  static toNumber(value: string, defaultValue: number = Number.NaN): number {
    let num = Number(value).valueOf();
    if (isNaN(num)) {
      return defaultValue;
    }
    return num
  }


  /**
   * 将字符串转换为整数。
   * @param value 要转换的字符串
   * @param defaultValue 异常时给默认值
   * @returns
   */
  static toInt(value: string, defaultValue: number = Number.NaN): number {
    const parseValue = parseInt(value);
    if (isNaN(parseValue)) {
      return defaultValue;
    }
    return parseValue;
  }


  /**
   * 将字符串转换为浮点数。
   * @param value 要转换的字符串
   * @param defaultValue 异常时给默认值
   * @returns
   */
  static toFloat(value: string, defaultValue: number = Number.NaN): number {
    const parseValue = parseFloat(value);
    if (isNaN(parseValue)) {
      return defaultValue;
    }
    return parseValue;
  }


  /**
   * 计算数字的平均值
   * @param numbers - 要计算的数字列表
   * @returns 平均值
   */
  static average(...numbers: number[]): number {
    if (numbers.length > 0) {
      const sum = numbers.reduce((acc, num) => acc + num, 0);
      return sum / numbers.length;
    }
    return 0;
  }


  /**
   * 加法
   * @param x
   * @param y
   * @returns
   */
  static add(x: number, y: number): number {
    return NumberUtil.addDecimal(x, y).toNumber();
  }

  /**
   * 减法
   * @param x
   * @param y
   * @returns
   */
  static sub(x: number, y: number): number {
    return NumberUtil.subDecimal(x, y).toNumber();
  }

  /**
   * 求和
   * @param x
   * @param y
   * @returns
   */
  static sum(...n: number[]): number {
    return NumberUtil.sumDecimal(...n).toNumber();
  }


  /**
   * 构造Decimal
   * @param value
   * @returns
   */
  static toDecimal(value: Value): Decimal {
    return new Decimal(value);
  }


  /**
   * 加法Decimal
   * @param x
   * @param y
   * @returns
   */
  static addDecimal(x: Value, y: Value): Decimal {
    return Decimal.add(x, y);
  }

  /**
   * 减法Decimal
   * @param x
   * @param y
   * @returns
   */
  static subDecimal(x: Value, y: Value): Decimal {
    return Decimal.sub(x, y);
  }

  /**
   * 求和Decimal
   * @param x
   * @param y
   * @returns
   */
  static sumDecimal(...n: Value[]): Decimal {
    return Decimal.sum(...n);
  }


}