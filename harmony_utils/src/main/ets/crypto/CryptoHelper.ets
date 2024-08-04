import { Base64Util } from '../utils/Base64Util';
import { StrUtil } from '../utils/StrUtil';
import { crypto } from './crypto';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { buffer } from '@kit.ArkTS';


/**
 * 加解密数据类型转换
 */
export class CryptoHelper {


  /**
   * 字符串转DataBlob
   * @param str 字符串
   * @param coding 编码方式(base64/hex/utf8/utf-8)。
   * @returns
   */
  static strToDataBlob(str: string, coding: crypto.BhuCoding): cryptoFramework.DataBlob {
    let dataBlob: cryptoFramework.DataBlob = { data: CryptoHelper.strToUint8Array(str, coding) };
    return dataBlob;
  }

  /**
   * DataBlob转字符串
   * @param dataBlob DataBlob
   * @param coding 编码方式(base64/hex/utf8/utf-8)。
   * @returns
   */
  static dataBlobToStr(dataBlob: cryptoFramework.DataBlob, coding: crypto.BhuCoding): string {
    return CryptoHelper.uint8ArrayToStr(dataBlob.data, coding);
  }


  /**
   * 字符串转Uint8Array
   * @param symKey 字符串
   * @param coding 编码方式(base64/hex/utf8/utf-8)。
   * @returns
   */
  static strToUint8Array(str: string, coding: crypto.BhuCoding): Uint8Array {
    if (coding === 'base64') { //base64
      return Base64Util.decodeSync(str);
    } else if (coding === 'hex') { //hex-16进制类型
      return StrUtil.strToHex(str);
    } else {
      return StrUtil.strToUint8Array(str, coding);
    }
  }

  /**
   * Uint8Array转字符串
   * @param arr Uint8Array
   * @param coding 编码方式(base64/hex/utf8/utf-8)。
   * @returns
   */
  static uint8ArrayToStr(arr: Uint8Array, coding: crypto.BhuCoding): string {
    if (coding === 'base64') { //base64
      return Base64Util.encodeToStrSync(arr);
    } else if (coding === 'hex') { //hex-16进制类型
      return StrUtil.hexToStr(arr);
    } else {
      return StrUtil.unit8ArrayToStr(arr, coding);
    }
  }


  // 字符串转成字节流
  static stringToUint8Array(str: string) {
    return new Uint8Array(buffer.from(str, 'utf-8').buffer);
  }

  // 字节流转成可理解的字符串
  static uint8ArrayToString(array: Uint8Array) {
    // 将UTF-8编码转换成Unicode编码
    let out: string = '';
    let index: number = 0;
    let len: number = array.length;
    while (index < len) {
      let character = array[index++];
      switch (character >> 4) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
          out += String.fromCharCode(character);
          break;
        case 12:
        case 13:
          out += String.fromCharCode(((character & 0x1F) << 6) | (array[index++] & 0x3F));
          break;
        case 14:
          out += String.fromCharCode(((character & 0x0F) << 12) | ((array[index++] & 0x3F) << 6) |
            ((array[index++] & 0x3F) << 0));
          break;
        default:
          break;
      }
    }
    return out;
  }


  /**
   * 根据传入的大小生成随机Uint8Array
   * @param size 生成的串长度
   * @returns
   */
  static getRandomUint8Array(size: number): Uint8Array {
    let randArray = new Array<number>();
    for (let i = 0; i < size; i++) {
      randArray.push(Math.floor(Math.random() * 256));
    }
    return new Uint8Array(randArray);
  }


  /**
   * 补零操作
   */
  static toHexWithPaddingZero(val: bigint) {
    let length = 64;
    let c1x = val.toString(16);
    if (c1x.length > length) {
      return c1x;
    }
    let padLength = length - c1x.length;
    let returnVal = '';
    for (let i = 0; i < padLength; i++) {
      returnVal += '0'
    }
    return returnVal += c1x;
  }


}