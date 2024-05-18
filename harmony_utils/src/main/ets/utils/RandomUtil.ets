import { util } from '@kit.ArkTS';

/**
 * 随机工具类
 */
export class RandomUtil {

  private constructor() {}


  /**
   * 生成随机数number值
   * @return 随机数
   */
  static randomInt(): number {
    return Math.floor(Math.random() * Number.MAX_SAFE_INTEGER);
  }


  /**
   * 生成指定范围内的随机数 [0,limit)
   * @param limit 限制随机数的范围，不包括这个数
   * @return 随机数
   */
  static randomLimit(limit: number): number {
    return Math.floor(Math.random() * limit);
  }


  /**
   * 生成指定范围内的随机数
   * @param min 最小数（包含）
   * @param max 最大数（不包含）
   * @return 随机数
   */
  static randomNumber(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min) + min);
  }


  /**
   * 生成随机Boolean值
   * @return true or false
   */
  static randomBoolean(): boolean {
    return Math.random() < 0.5;
  }


  /**
   * 根据指定字符串，随机生成 指定长度的字符串
   * @param num
   * @param chars
   * @returns
   */
  static randomStr(num: number, chars: string): string {
    let maxPos = chars.length;
    let pwd = '';
    for (let i = 0; i < num; i++) {
      pwd += chars.charAt(Math.floor(Math.random() * maxPos));
    }
    return pwd;
  }


  /**
   * 生成随机汉字（'\u4E00'-'\u9FFF'）
   * @return 随机的汉字字符
   */
  static randomChinese(): string {
    const start = parseInt('4e00', 16); // 第一个汉字的 Unicode 编码
    const end = parseInt('9fa5', 16); // 最后一个汉字的 Unicode 编码
    const randomCode = Math.floor(Math.random() * (end - start) + start);
    return String.fromCharCode(randomCode);
  }


  /**
   * 生成随机颜色，十六进制
   * @returns color
   */
  static randomColor(): string {
    const color = Math.floor(Math.random() * 16777215).toString(16)
    return `#${color}`
  }


  /**
   * 生成36位UUID，带-
   */
  static generateUUID36(): string {
    const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
    const uuid = new Array<string>(36);
    let rand = 0;
    for (let i = 0; i < 36; i++) {
      if (i === 8 || i === 13 || i === 18 || i === 23) {
        uuid[i] = '-';
      } else if (i === 14) {
        uuid[i] = '4';
      } else {
        if (rand <= 0x02) {
          rand = 0x2000000 + (Math.random() * 0x1000000) | 0;
        }
        const r = rand & 0xf;
        rand = rand >> 4;
        uuid[i] = chars[(i === 19) ? (r & 0x3) | 0x8 : r];
      }
    }
    return uuid.join('');
  }


  /**
   * 生成32位UUID，带-
   */
  static generateUUID32(): string {
    const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
    const uuid = new Array<string>(32);
    let rand = 0;
    for (let i = 0; i < 32; i++) {
      if (i === 8 || i === 12 || i === 16 || i === 20) {
        uuid[i] = '-';
      } else {
        if (rand <= 0x02) {
          rand = 0x2000000 + (Math.random() * 0x1000000) | 0;
        }
        const r = rand & 0xf;
        rand = rand >> 4;
        uuid[i] = chars[(i === 12) ? (r & 0x3) | 0x8 : r];
      }
    }
    return uuid.join('');
  }


  /**
   * 使用加密安全随机数生成器生成随机的RFC 4122版本4的string类型UUID。
   * @param entropyCache 是否使用已缓存的UUID， 默认true。
   * @returns
   */
  static generateRandomUUID(entropyCache: boolean = true): string {
    let uuid = util.generateRandomUUID(entropyCache);
    return uuid;
  }


  /**
   * 使用加密安全随机数生成器生成随机的RFC 4122版本4的Uint8Array类型UUID。
   * @param entropyCache
   * @returns 是否使用已缓存的UUID， 默认true。
   */
  static generateRandomBinaryUUID(entropyCache: boolean = true): Uint8Array {
    let uuid = util.generateRandomBinaryUUID(entropyCache);
    return uuid;
  }


}