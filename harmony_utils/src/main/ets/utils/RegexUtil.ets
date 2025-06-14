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


import { FormatUtil } from './FormatUtil';


/**
 * TODO 正则工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class RegexUtil {

  /**
   * 英文字母 、数字和下划线
   */
  static readonly REG_GENERAL: string = "^\\w+$";
  /**
   * 数字
   */
  static readonly REG_NUMBERS: string = "^\\d+$";
  /**
   * 字母
   */
  static readonly REG_WORD: string = "^[a-zA-Z]+$";
  /**
   * 单个中文汉字
   * 参照维基百科汉字Unicode范围(https://zh.wikipedia.org/wiki/%E6%B1%89%E5%AD%97)
   */
  static readonly REG_CHINESE: string = "^[\u2E80-\u2EFF\u2F00-\u2FDF\u31C0-\u31EF\u3400-\u4DBF\u4E00-\u9FFF\uF900-\uFAFF\uD840\uDC00-\uD869\uDEDF\uD869\uDF00-\uD86D\uDF3F\uD86D\uDF40-\uD86E\uDC1F\uD86E\uDC20-\uD873\uDEAF\uD87E\uDC00-\uD87E\uDE1F]$";
  /**
   * 中文汉字
   */
  static readonly REG_CHINESES: string = RegexUtil.REG_CHINESE + "+";
  /**
   * 分组
   */
  static readonly REG_GROUP_VAR: string = "^\\$(\\d+)$";
  /**
   * IP v4 采用分组方式便于解析地址的每一个段
   */
  static readonly REG_IPV4: string = "^(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)$";
  /**
   * IP v6
   */
  static readonly REG_IPV6: string = "^(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]+|::(ffff(:0{1,4})?:)?((25[0-5]|(2[0-4]|1?[0-9])?[0-9])\\.){3}(25[0-5]|(2[0-4]|1?[0-9])?[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1?[0-9])?[0-9])\\.){3}(25[0-5]|(2[0-4]|1?[0-9])?[0-9]))$";
  /**
   * 货币
   */
  static readonly REG_MONEY: string = "^(\\d+(?:\\.\\d+)?)$";
  /**
   * 邮件，符合RFC 5322规范，正则来自：http://emailregex.com/
   */
  static readonly REG_EMAIL: string = "^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)])$";
  /**
   * 移动电话
   */
  static readonly REG_MOBILE: string = "^(?:0|86|\\+86)?1[3-9]\\d{9}$";
  /**
   * 中国香港移动电话
   * eg: 中国香港： +852 5100 4810， 三位区域码+10位数字, 中国香港手机号码8位数
   * eg: 中国大陆： +86  180 4953 1399，2位区域码标示+13位数字
   * 中国大陆 +86 Mainland China
   * 中国香港 +852 Hong Kong
   * 中国澳门 +853 Macao
   * 中国台湾 +886 Taiwan
   */
  static readonly REG_MOBILE_HK: string = "^(?:0|852|\\+852)?\\d{8}$";
  /**
   * 中国台湾移动电话
   * eg: 中国台湾： +886 09 60 000000， 三位区域码+号码以数字09开头 + 8位数字, 中国台湾手机号码10位数
   * 中国台湾 +886 Taiwan 国际域名缩写：TW
   */
  static readonly REG_MOBILE_TW: string = "^(?:0|886|\\+886)?(?:|-)09\\d{8}$";
  /**
   * 中国澳门移动电话
   * eg: 中国台湾： +853 68 00000， 三位区域码 +号码以数字6开头 + 7位数字, 中国台湾手机号码8位数
   * 中国澳门 +853 Macao 国际域名缩写：MO
   */
  static readonly REG_MOBILE_MO: string = "^(?:0|853|\\+853)?(?:|-)6\\d{7}$";
  /**
   * 座机号码
   */
  static readonly REG_TEL: string = "^(010|02\\d|0[3-9]\\d{2})-?(\\d{6,8})$";
  /**
   * 座机号码+400+800电话
   */
  static readonly REG_TEL_400_800: string = "^0\\d{2,3}[\\- ]?[1-9]\\d{6,7}|[48]00[\\- ]?[1-9]\\d{6}$";
  /**
   * 18位身份证号码
   */
  static readonly REG_CITIZEN_ID: string = "^[1-9]\\d{5}[1-2]\\d{3}((0\\d)|(1[0-2]))(([012]\\d)|3[0-1])\\d{3}(\\d|X|x)$";
  /**
   * 邮编，兼容港澳台
   */
  static readonly REG_ZIP_CODE: string = "^(0[1-7]|1[0-356]|2[0-7]|3[0-6]|4[0-7]|5[0-7]|6[0-7]|7[0-5]|8[0-9]|9[0-8])\\d{4}|99907[78]$";
  /**
   * 生日
   */
  static readonly REG_BIRTHDAY: string = "^(\\d{2,4})([/\\-.年]?)(\\d{1,2})([/\\-.月]?)(\\d{1,2})日?$";
  /**
   * URI
   * 定义见：https://www.ietf.org/rfc/rfc3986.html#appendix-B
   */
  static readonly REG_URI: string = "^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\\?([^#]*))?(#(.*))?$";
  /**
   * URL
   */
  static readonly REG_URL: string = "^[a-zA-Z]+://[\\w-+&@#/%?=~_|!:,.;]*[\\w-+&@#/%=~_|]$";
  /**
   * Http URL（来自：http://urlregex.com/）
   * 此正则同时支持FTP、File等协议的URL
   */
  static readonly REG_URL_HTTP: string = "^(https?|ftp|file)://[\\w-+&@#/%?=~_|!:,.;]*[\\w-+&@#/%=~_|]$";
  /**
   * 中文字、英文字母、数字和下划线
   */
  static readonly REG_GENERAL_WITH_CHINESE: string = "^[\u4E00-\u9FFF\\w]+$";
  /**
   * UUID
   */
  static readonly REG_UUID: string = "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$";
  /**
   * 不带横线的UUID
   */
  static readonly REG_UUID_SIMPLE: string = "^[0-9a-fA-F]{32}$";
  /**
   * MAC地址正则
   */
  static readonly REG_MAC_ADDRESS: string = "^((?:[a-fA-F0-9]{1,2}[:-]){5}[a-fA-F0-9]{1,2})|0x(\\d{12}).+ETHER$";
  /**
   * 16进制字符串
   */
  static readonly REG_HEX: string = "^[a-fA-F0-9]+$";
  /**
   * 时间正则
   */
  static readonly REG_TIME: string = "^\\d{1,2}:\\d{1,2}(:\\d{1,2})?$";
  /**
   * 中国车牌号码（兼容新能源车牌）
   */
  static readonly REG_PLATE_NUMBER: string = "^(([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z](([0-9]{5}[ABCDEFGHJK])|([ABCDEFGHJK]([A-HJ-NP-Z0-9])[0-9]{4})))|" +
      "([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领]\\d{3}\\d{1,3}[领])|" +
      "([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z][A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳使领]))$";
  /**
   * 社会统一信用代码
   * 第一部分：登记管理部门代码1位 (数字或大写英文字母)
   * 第二部分：机构类别代码1位 (数字或大写英文字母)
   * 第三部分：登记管理机关行政区划码6位 (数字)
   * 第四部分：主体标识码（组织机构代码）9位 (数字或大写英文字母)
   * 第五部分：校验码1位 (数字或大写英文字母)
   */
  static readonly REG_CREDIT_CODE: string = "^[0-9A-HJ-NPQRTUWXY]{2}\\d{6}[0-9A-HJ-NPQRTUWXY]{10}$";
  /**
   * 车架号
   * 别名：车辆识别代号 车辆识别码
   * 十七位码、车架号
   * 车辆的唯一标示
   */
  static readonly REG_CAR_VIN: string = "^[A-HJ-NPR-Z0-9]{8}[0-9X][A-HJ-NPR-Z0-9]{2}\\d{6}$";
  /**
   * 驾驶证  别名：驾驶证档案编号、行驶证编号
   * 12位数字字符串
   * 仅限：中国驾驶证档案编号
   */
  static readonly REG_CAR_DRIVING_LICENCE: string = "^[0-9]{12}$";
  /**
   * 中文姓名
   */
  static readonly REG_CHINESE_NAME: string = "^[\u2E80-\u9FFF·]{2,60}$";
  /**
   * 判断字符串是否包含表情（匹配单个emoji或多个组合emoji的正则表达式）
   * 注意：这个正则表达式可能不是完美的，因为新的emoji不断被添加到Unicode标准中
   */
  static readonly REG_EMOJI: string = "/(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])/g";



  /**
   * 给定内容是否匹配正则（配合RegexUtil里的正则常量一起使用）
   * @param content 内容
   * @param regex   正则
   */
  static isMatch(content: string, pattern: string): boolean {
    if (content === undefined || content === null) {
      return false;
    } else {
      return new RegExp(pattern).test(content);
    }
  }


  /**
   * 判断传入的电话号码格式是否正确。
   * @param phone 电话号码
   */
  static isPhone(phone: string): boolean {
    return FormatUtil.isPhone(phone);
  }


  /**
   * 检查字符串是否只包含数字字符
   * @param str - 要检查的字符串
   * @returns 如果字符串只包含数字则返回 true，否则返回 false
   */
  static isDigits(str: string): boolean {
    if (typeof str !== 'string' || str.length === 0) {
      return false;
    }
    return RegexUtil.isMatch(str, RegexUtil.REG_NUMBERS);
  }


  /**
   * 判断传入的邮箱格式是否正确
   * @param content
   * @returns
   */
  static isEmail(content: string): boolean {
    return RegexUtil.isMatch(content, RegexUtil.REG_EMAIL);
  }


  /**
   * 判断字符串是否包含表情（匹配单个emoji或多个组合emoji的正则表达式）
   * 注意：这个正则表达式可能不是完美的，因为新的emoji不断被添加到Unicode标准中
   * @param content
   * @returns
   */
  static isEmoji(content: string): boolean {
    return RegexUtil.isMatch(content, RegexUtil.REG_EMOJI);
  }


  /**
   * 验证身份证号码的有效性
   * @param id
   * @returns
   */
  static isValidCard(id: string): boolean {
    if (id.length === 18) {
      const factor = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
      const lastLetter = ["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"];
      id = id.toLowerCase();
      const lastChar = id.charAt(17).toLowerCase();
      let sum = 0;
      id.substring(0, 17).split('').forEach((value, index) => {
        sum += factor[index] * parseInt(value, 10);
      });
      const mod = sum % lastLetter.length;
      return lastLetter[mod] === lastChar;
    } else if (id.length === 15) {
      const regex15 = "^[1-9]\\d{5}\\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01])\\d{3}$";
      return RegexUtil.isMatch(id, regex15);
    }
    return false;
  }


}