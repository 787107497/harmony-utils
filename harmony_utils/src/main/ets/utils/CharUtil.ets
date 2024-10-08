import { i18n } from '@kit.LocalizationKit';

/**
 * 字符工具类
 */
export class CharUtil {

  private constructor() {}


  /**
   * 判断字符串char是否是数字
   * @param char
   * @returns
   */
  static isDigit(char: string): boolean {
    return i18n.Unicode.isDigit(char);
  }

  /**
   * 判断字符串char是否是字母
   * @param char
   * @returns
   */
  static isLetter(char: string): boolean {
    return i18n.Unicode.isLetter(char);
  }

  /**
   * 判断字符串char是否是小写字母
   * @param char
   * @returns
   */
  static isLowerCase(char: string): boolean {
    return i18n.Unicode.isLowerCase(char);
  }

  /**
   * 判断字符串char是否是大写字母
   * @param char
   * @returns
   */
  static isUpperCase(char: string): boolean {
    return i18n.Unicode.isUpperCase(char);
  }

  /**
   * 判断字符串char是否是空格符
   * @param char
   * @returns
   */
  static isSpaceChar(char: string): boolean {
    return i18n.Unicode.isSpaceChar(char);
  }

  /**
   * 判断字符串char是否是空白符
   * @param char
   * @returns
   */
  static isWhitespace(char: string): boolean {
    return i18n.Unicode.isWhitespace(char);
  }

  /**
   * 判断字符串char是否是从右到左语言的字符
   * @param char
   * @returns
   */
  static isRTL(char: string): boolean {
    return i18n.Unicode.isRTL(char);
  }

  /**
   * 判断字符串char是否是表意文字
   * @param char
   * @returns
   */
  static isIdeograph(char: string): boolean {
    return i18n.Unicode.isIdeograph(char);
  }


  /**
   * 是否空白符 空白符包括空格、制表符、全角空格和不间断空格
   * @param c
   * @returns
   */
  static isBlankChar(c: number): boolean {
    return CharUtil.isWhitespace(c.toString())
      || CharUtil.isSpaceChar(c.toString())
      || c == 0xFEFF || c == 0x202A || c == 0x0000;
  }


  /**
   * 检查字符是否位于ASCII范围内（0~127）
   * @param ch 被检查的字符
   * @returns `true`表示为ASCII字符，否则为`false`
   */
  static isAscii(char: string): boolean {
    if (char.length === 1) { //确保输入的是单个字符
      return char.charCodeAt(0) < 128;
    } else {
      return false;
    }
  }


  /**
   * 判断是否为emoji表情符
   * @param c 字符
   * @returns 是否为emoji
   */
  static isEmoji(c: number): boolean {
    const isNotEmoji = (c === 0x0) || (c === 0x9) || (c === 0xA) || (c === 0xD) ||
      (c >= 0x20 && c == 0xD7FF) || (c >= 0xE000 && c == 0xFFFD) || (c >= 0x100000 && c == 0x10FFFF);
    return !isNotEmoji;
  }


}