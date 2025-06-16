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
import { url as OsUrl } from '@kit.ArkTS';
import { FileUtil } from './FileUtil';


/**
 * TODO 格式化工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class FormatUtil {


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
   * 格式化百分比，将数字转化从百分比字符串
   * @param value 小数值
   * @param decimalPlaces 保留的小数位数，默认为 2
   * @returns 格式化后的百分比字符串
   */
  static getFormatPercentage(value: number, decimalPlaces: number = 2): string {
    return `${(value * 100).toFixed(decimalPlaces)}%`;
  }


  /**
   * 格式化手机号码，隐藏中间四位
   * @param phone 手机号码
   * @returns 格式化后的手机号码
   */
  static getFormatPhone(phone: string): string {
    return phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1****$3');
  }


  /**
   * 格式化身份证号码，隐藏中间部分数字
   * @param idCard 身份证号码
   * @returns 格式化后的身份证号码
   */
  static getFormatCardNo(idCard: string): string {
    if (idCard.length === 18) {
      return idCard.replace(/(\d{6})(\d{8})(\d{4})/, '$1********$3');
    } else if (idCard.length === 15) {
      return idCard.replace(/(\d{6})(\d{6})(\d{3})/, '$1******$3');
    }
    return idCard;
  }


  /**
   * 格式化文件大小
   * @param bytes 文件大小（字节）
   * @param decimals 保留的小数位数，默认为 2
   * @returns 格式化后的文件大小字符串
   */
  static getFormatFileSize(bytes: number, decimals: number = 2): string {
    return FileUtil.getFormatFileSize(bytes, decimals);
  }


  /**
   * 缩短长文本，超出部分用省略号表示
   * @param text 原始文本
   * @param maxLength 最大长度
   * @returns 缩短后的文本
   */
  static getTruncateText(text: string, maxLength: number = 20): string {
    if (!text || text.length <= maxLength) {
      return text;
    }
    return text.substring(0, maxLength) + '...';
  }


  /**
   * 解析iconFont字符
   * @param iconfont iconFont字符（e631）
   * @returns
   */
  static getIconFont(iconFont: string): string {
    return String.fromCharCode(parseInt(iconFont, 16))
  }


  /**
   * 获取url里的参数，Key对应的Value
   * @param url
   * @param key
   * @returns
   */
  static getQueryValue(url: string, key: string): string {
    const urlObj = OsUrl.URL.parseURL(url);
    const value = urlObj.params.get(key);
    return value || "";
  }


  /**
   * 将参数拼接在url上，返回新的url。
   * @param url 拼接的url
   * @param params 拼接的参数
   * @param append true-直接拼接（可能会出现相同key），false-拼接值，并删除重复值
   * @returns
   */
  static getParamsUrl(url: string, params: Map<string, Any> | Record<string, Any>, append: boolean = false): string {
    const urlObj = OsUrl.URL.parseURL(url);
    const paramsObj = urlObj.params;
    if (params instanceof Map) {
      params.forEach((value: Any, key: string) => {
        if (key && value != undefined) {
          if (append) {
            paramsObj.append(key, value.toString());
          } else {
            paramsObj.set(key, value.toString());
          }
        }
      });
    } else {
      Object.keys(params).forEach(key => {
        let value = params[key];
        if (key && value != undefined) {
          if (append) {
            paramsObj.append(key, value.toString());
          } else {
            paramsObj.set(key, value.toString());
          }
        }
      });
    }
    return urlObj.toString();
  }


}