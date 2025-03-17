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

/**
 * TODO 字符工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class CharUtil {


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
   * 判断是否空白符 空白符包括空格、制表符、全角空格和不间断空格
   * @param c
   * @returns
   */
  static isBlankChar(c: number): boolean {
    return CharUtil.isWhitespace(c.toString())
      || CharUtil.isSpaceChar(c.toString())
      || c === 0xFEFF || c === 0x202A || c === 0x0000;
  }


  /**
   * 判断字符是否位于ASCII范围内（其中0-31是控制字符，32-127表示从A到Z的字母字符）
   * @param char 字符
   * @returns
   */
  static isAscii(char: string): boolean {
    if (char.length === 1) { //确保输入的是单个字符
      return char.charCodeAt(0) < 128;
    } else {
      return false;
    }
  }


}