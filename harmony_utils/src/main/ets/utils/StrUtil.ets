import { CharUtil } from './CharUtil';
import util from '@ohos.util';
import { buffer } from '@kit.ArkTS';
import { Base64Util } from './Base64Util';
import { i18n } from '@kit.LocalizationKit';


/**
 * 字符串工具类
 */
export class StrUtil {

  private constructor() {}


  /**
   * 字符串是否为空(undefined、null)
   * @param str 被检测的字符串
   * @returns 是否为空
   */
  static isNull(str: string | undefined | null): boolean {
    return str == undefined || str == null;
  }

  /**
   * 判断字符串是否为非空。true为非空空，否则false
   * @param str
   * @returns
   */
  static isNotNull(str: string | undefined | null) {
    return false == StrUtil.isNull(str);
  }


  /**
   * 字符串是否为空(undefined、null、字符串长度为0)
   * @param str 被检测的字符串
   * @return 是否为空
   */
  static isEmpty(str: string | undefined | null): boolean {
    return str == undefined || str == null || str.length == 0;
  }

  /**
   * 判断字符串是否为非空。true为非空空，否则false
   * @param str
   * @returns
   */
  static isNotEmpty(str: string | undefined | null) {
    return false == StrUtil.isEmpty(str);
  }


  /**
   * 判断字符串是否为空和空白符(空白符包括空格、制表符、全角空格和不间断空格)。true为空，否则false
   * @param str
   * @returns
   */
  static isBlank(str: string | undefined | null): boolean {
    let length: number;
    if ((str == undefined) || (str == null) || ((length = str.length) == 0)) {
      return true;
    }
    for (let i = 0; i < length; i++) {
      if (false == CharUtil.isBlankChar(str.charCodeAt(i))) {
        return false;  //只要有一个非空字符即为非空字符串
      }
    }
    return true;
  }

  /**
   * 判断字符串是否为非空和空白符(空白符包括空格、制表符、全角空格和不间断空格)true为非空，否则false
   * @param str
   * @returns
   */
  static isNotBlank(str: string | undefined | null): boolean {
    return false == StrUtil.isBlank(str);
  }


  /**
   * 格式化字符串
   * @param source
   * @param defaultValue
   * @returns
   */
  static toStr(source: string | null | undefined, defaultValue = "") {
    if (source == null || source == undefined) {
      return defaultValue;
    }
    return String(source);
  }


  /**
   * 替换字符串中匹配的正则为给定的字符串
   * @param str   待替换的字符串
   * @param pattern  要匹配的内容正则或字符串
   * @param replacement 替换的内容
   * @returns 返回替换后的字符串
   */
  static replace(str: string, pattern: RegExp | string, replacement: string = ''): string {
    return str.replace(pattern, replacement);
  }

  /**
   * 替换字符串中所有匹配的正则为给定的字符串
   * @param str   待替换的字符串
   * @param pattern  要匹配的内容正则或字符串
   * @param replacement 替换的内容
   * @returns 返回替换后的字符串
   */
  static replaceAll(str: string, pattern: RegExp | string, replacement: string = ''): string {
    return str.replaceAll(pattern, replacement);
  }

  /**
   * 检查字符串是否以给定的字符串开头
   * @param string 要检索的字符串
   * @param target 要检索字符
   * @param position 检索的位置
   * @returns 如果字符串以字符串开头，那么返回 true，否则返回 false
   */
  static startsWith(string: string = '', target: string, position: number = 0): boolean {
    return string.startsWith(target, position);
  }


  /**
   * 检查字符串是否以给定的字符串结尾
   * @param str 要检索的字符串
   * @param target 要检索字符
   * @param position 检索的位置
   * @returns 如果字符串以字符串结尾，那么返回 true，否则返回 false
   */
  static endsWith(str: string = '', target: string, position: number = str.length): boolean {
    return str.endsWith(target, position);
  }


  /**
   * 将字符串重复指定次数
   * @param str  要重复的字符串
   * @param n  重复的次数
   * @returns
   */
  static repeat(str: string = '', n: number = 1): string {
    return str.repeat(n);
  }


  /**
   * 转换整个字符串的字符为小写
   * @param str 要转换的字符串
   * @returns 返回小写的字符串
   */
  static toLower(str: string = ''): string {
    return str.toLowerCase();
  }


  /**
   * 转换整个字符串的字符为大写
   * @param str 要转换的字符串
   * @returns 返回小写的字符串
   */
  static toUpper(str: string = ''): string {
    return str.toUpperCase();
  }


  /**
   * 转换字符串首字母为大写，剩下为小写
   * @param str 待转换的字符串
   * @returns 转换后的
   */
  static capitalize(str: string = ''): string {
    if (!str) {
      return '';
    }
    const firstChar = str.charAt(0).toUpperCase();
    const restChars = str.slice(1).toLowerCase();
    return firstChar + restChars;
  }


  /**
   * 判断两个传入的数值或者是字符串是否相等
   * @param source
   * @param target
   * @returns
   */
  static equal(source: string | number, target: string | number): boolean {
    return source === target;
  }

  /**
   * 判断两个传入的数值或者是字符串是否不相等
   * @param source
   * @param target
   * @returns
   */
  static notEqual(source: string | number, target: string | number): boolean {
    return false == StrUtil.equal(source, target);
  }


  /**
   * 字符串转Uint8Array
   * @param src 字符串
   * @returns Uint8Array
   */
  public static strToUint8Array(src: string, encoding: buffer.BufferEncoding = 'utf-8'): Uint8Array {
    let textEncoder = new util.TextEncoder(encoding);
    let result = textEncoder.encodeInto(src);
    return result;
  }

  /**
   * Uint8Array转字符串
   * @param src Uint8Array
   * @returns 字符串
   */
  static unit8ArrayToStr(src: Uint8Array, encoding: buffer.BufferEncoding = 'utf-8'): string {
    let textDecoder = util.TextDecoder.create(encoding, { ignoreBOM: true })
    let result = textDecoder.decodeWithStream(src, { stream: true });
    return result;
  }


  /**
   * 16进制字符串转换unit8Array
   * @param hexStr
   * @returns
   */
  static strToHex(hexStr: string): Uint8Array {
    return new Uint8Array(buffer.from(hexStr, 'hex').buffer);
  }

  /**
   * 16进制unit8Array转字符串
   * @param arr
   * @returns
   */
  static hexToStr(arr: Uint8Array): string {
    return buffer.from(arr).toString('hex');
  }


  /**
   * 字符串转Base64字符串
   * @param src 字符串
   * @returns
   */
  static strToBase64(src: string): string {
    let uint8Array = StrUtil.strToUint8Array(src);
    let result = Base64Util.encodeToStrSync(uint8Array);
    return result;
  }


  /**
   * Base64字符串转字符串
   * @param base64Str Base64字符串
   * @returns
   */
  static base64ToStr(base64Str: string): string {
    let uint8Array = Base64Util.decodeSync(base64Str);
    let result = StrUtil.unit8ArrayToStr(uint8Array);
    return result;
  }


  /**
   * 字符串转ArrayBuffer
   * @param str
   * @returns
   */
  static strToBuffer(src: string, encoding: buffer.BufferEncoding = 'utf-8'): ArrayBuffer {
    let buf = buffer.from(src, encoding);
    return buf.buffer;
  }

  /**
   * ArrayBuffer转字符串
   * @param str
   * @returns
   */
  static bufferToStr(src: ArrayBuffer, encoding: buffer.BufferEncoding = 'utf-8'): string {
    let buf = buffer.from(src);
    let result = buf.toString(encoding);
    return result;
  }


  /**
   * ArrayBuffer转Uint8Array
   * @param str
   * @returns
   */
  static bufferToUint8Array(src: ArrayBuffer): Uint8Array {
    return new Uint8Array(src);
  }

  /**
   * Uint8Array转ArrayBuffer
   * @param str
   * @returns
   */
  static unit8ArrayToBuffer(src: Uint8Array): ArrayBuffer {
    // return buffer.from(src).buffer;
    return src.buffer as ArrayBuffer;
  }


  /**
   * 判断传入的电话号码格式是否正确。
   * @param phone
   * country string 表示电话号码所属国家或地区代码。
   * options PhoneNumberFormatOptions 电话号码格式化对象的相关选项。默认值：NATIONAL。
   * @returns
   */
  static isPhone(phone: string, country: string = "CN", option?: i18n.PhoneNumberFormatOptions): boolean {
    let phoneNumberFormat: i18n.PhoneNumberFormat = new i18n.PhoneNumberFormat(country, option);
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
    let phoneNumberFormat: i18n.PhoneNumberFormat = new i18n.PhoneNumberFormat(country, option);
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
  static getPhoneLocationName(phone: string, locale: string = "zh-CN", country: string = "CN", option?: i18n.PhoneNumberFormatOptions): string {
    let phoneNumberFormat: i18n.PhoneNumberFormat = new i18n.PhoneNumberFormat(country, option);
    return phoneNumberFormat.getLocationName(phone, locale);
  }


  /**
   * 给定内容是否匹配正则
   * @param content 内容
   * @param regex   正则
   */
  static isMatch(content: string, pattern: string): boolean {
    if (content == undefined || content == null) {
      return false;
    } else {
      return new RegExp(pattern).test(content);
    }
  }

  /**
   * 判断传入的邮箱格式是否正确
   * @param content
   * @returns
   */
  static isEmail(content: string): boolean {
    const pattern: string = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)])"; //邮件，符合RFC 5322规范，正则来自：http://emailregex.com/
    return StrUtil.isMatch(content, pattern);
  }


  /**
   * 获取系统错误码对应的详细信息
   * @param errno 错误码
   * @returns
   */
  static getErrnoToString(errno: number): string {
    return util.errnoToString(errno);
  }


}
