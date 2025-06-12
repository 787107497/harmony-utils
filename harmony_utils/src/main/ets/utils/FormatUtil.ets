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


import { i18n } from '@kit.LocalizationKit';
import { Any } from '../entity/constraint';
import { StrUtil } from './StrUtil';


/**
 * TODO 格式化工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class FormatUtil {


  /**
   * 判断是否是Boolean类型
   */
  static isBoolean(value: Any): boolean {
    return typeof value === 'boolean';
  }

  /**
   * 判断是否是Number类型
   */
  static isNumber(value: Any): boolean {
    return typeof value === 'number';
  }

  /**
   * 判断是否是String类型
   */
  static isString(value: Any): boolean {
    return typeof value === 'string';
  }

  /**
   * 判断是否是Object类型
   */
  static isObject(value: Any): boolean {
    return typeof value === 'object';
  }

  /**
   * 判断是否是数组类型
   */
  static isArray(value: Any): boolean {
    return Array.isArray(value)
  }

  /**
   * 判断是否是Resource类型
   */
  static isResource(value: Any) {
    if (value) {
      const res = value as Resource;
      return StrUtil.isNotNull(res?.id) && StrUtil.isNotNull(res?.bundleName) && StrUtil.isNotNull(res?.moduleName);
    }
    return false;
  }

  /**
   * 判断是否是ResourceStr类型
   */
  static isResourceStr(value: Any) {
    return FormatUtil.isString(value) || FormatUtil.isResource(value);
  }


  /**
   * 判断传入的电话号码格式是否正确。
   * @param phone
   * country string 表示电话号码所属国家或地区代码。
   * options PhoneNumberFormatOptions 电话号码格式化对象的相关选项。默认值：NATIONAL。
   * @returns
   */
  static isPhone(phone: string, country: string = "CN", option?: i18n.PhoneNumberFormatOptions): boolean {
    const phoneNumberFormat: i18n.PhoneNumberFormat = new i18n.PhoneNumberFormat(country, option);
    return phoneNumberFormat.isValidNumber(phone);
  }

  /**
   * 对电话号码进行格式化
   * @param phone
   * country string 表示电话号码所属国家或地区代码。
   * options PhoneNumberFormatOptions 电话号码格式化对象的相关选项。默认值：NATIONAL。
   * @returns
   */
  static getPhoneFormat(phone: string, country: string = "CN", option?: i18n.PhoneNumberFormatOptions): string {
    const phoneNumberFormat: i18n.PhoneNumberFormat = new i18n.PhoneNumberFormat(country, option);
    return phoneNumberFormat.format(phone);
  }

  /**
   * 获取电话号码归属地
   * @param phone
   * @param locale string 区域ID
   * country string 表示电话号码所属国家或地区代码。
   * options PhoneNumberFormatOptions 电话号码格式化对象的相关选项。默认值：NATIONAL。
   * @returns
   */
  static getPhoneLocationName(phone: string, locale: string = "zh-CN", country: string = "CN",
    option?: i18n.PhoneNumberFormatOptions): string {
    const phoneNumberFormat: i18n.PhoneNumberFormat = new i18n.PhoneNumberFormat(country, option);
    return phoneNumberFormat.getLocationName(phone, locale);
  }


  /**
   * 将输入字符串从源格式转换为目标格式（中文汉字转为拼音）
   * @param text 输入字符串
   * @returns
   */
  static transliterator(text: string): string {
    const transliterator = i18n.Transliterator.getInstance('Any-Latn');
    return transliterator.transform(text);
  }


  /**
   * 解析iconFont字符
   * @param iconfont iconFont字符（e631）
   * @returns
   */
  static getIconFont(iconFont: string): string {
    return String.fromCharCode(parseInt(iconFont, 16))
  }



}