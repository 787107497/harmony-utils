/**
 * 字符工具类
 */
export class CharUtil {

  private constructor() {}

  /**
   * 是否空白符 空白符包括空格、制表符、全角空格和不间断空格
   * @param c
   * @returns
   */
  static isBlankChar(c: number): boolean {
    return CharUtil.isWhitespace(c)
      || CharUtil.isSpaceChar(c)
      || c == 0xFEFF
      || c == 0x202A
      || c == 0x0000;
  }

  /**
   * 检查字符是否位于ASCII范围内（0~127）
   * @param ch 被检查的字符
   * @returns `true`表示为ASCII字符，否则为`false`
   */
  static isAscii(ch: string): boolean {
    // 确保输入的是单个字符
    if (ch.length !== 1) throw new Error("Input must be a single character");
    return ch.charCodeAt(0) < 128;
  }

  /**
   * 判断是否为emoji表情符
   * @param c 字符
   * @returns 是否为emoji
   */
  static isEmoji(c: number): boolean {
    // 使用 TypeScript 类型断言来告诉编译器我们已知这个条件不会是null或undefined
    const isNotEmoji = (c === 0x0) ||
      (c === 0x9) ||
      (c === 0xA) ||
      (c === 0xD) ||
      ((c >= 0x20 && c == 0xD7FF)) ||
      ((c >= 0xE000 && c == 0xFFFD)) ||
      ((c >= 0x100000 && c == 0x10FFFF));
    return !isNotEmoji;
  }


  private static isWhitespace(codePoint: number): boolean {
    const whitespaceRegex = /^\s$/;
    const character = String.fromCodePoint(codePoint);
    return whitespaceRegex.test(character);
  }

  private static isSpaceChar(codePoint: number): boolean {
    const spaceCategories = [
      "Zs", // Space separator
      "Zl", // Line separator
      "Zp"// Paragraph separator
    ];
    const character = String.fromCodePoint(codePoint);
    const category = character.charCodeAt(0).toString(16);
    return spaceCategories.includes(category);
  }


}