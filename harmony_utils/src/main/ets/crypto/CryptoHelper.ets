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

import { Base64Util } from '../utils/Base64Util';
import { StrUtil } from '../utils/StrUtil';
import { crypto } from './crypto';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { buffer } from '@kit.ArkTS';
import { LogUtil } from '../utils/LogUtil';


/**
 * TODO 加解密数据类型转换
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
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
   * @param keyLen 密钥规格的最小长度，默认为0，为0时不补全。
   * @returns
   */
  static strToUint8Array(str: string, coding: crypto.BhuCoding, keyLen: number = 0): Uint8Array {
    if (coding === 'base64') { //base64
      let uint8Array = Base64Util.decodeSync(str);
      uint8Array = CryptoHelper.getUint8ArrayPaddingZero(uint8Array, keyLen)
      return uint8Array;
    } else if (coding === 'hex') { //hex-16进制类型
      let uint8Array = StrUtil.strToHex(str);
      uint8Array = CryptoHelper.getUint8ArrayPaddingZero(uint8Array, keyLen)
      return uint8Array;
    } else {
      let uint8Array = new Uint8Array(buffer.from(str, coding).buffer);
      uint8Array = CryptoHelper.getUint8ArrayPaddingZero(uint8Array, keyLen)
      return uint8Array;
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
      return buffer.from(arr).toString(coding);
    }
  }


  /**
   * 获取DataBlob类型的密钥
   * @param data 待转换的密钥。
   * @param keyCoding 秘钥的编码方式(base64/hex/utf8/utf-8)，data为字符串时用到
   * @param keyLen 密钥规格的最小长度，默认为0，为0时不补全。
   */
  static getSymKeyDataBlob(data: string | Uint8Array | cryptoFramework.DataBlob,
    keyCoding: crypto.BhuCoding = 'utf-8', keyLen: number = 0): cryptoFramework.DataBlob {
    if (typeof data === 'string') {
      return { data: CryptoHelper.strToUint8Array(data, keyCoding, keyLen) };
    } else if (data instanceof Uint8Array) {
      return { data: data };
    } else {
      return data;
    }
  }

  /**
   * 获取DataBlob类型的公钥或私钥
   * @param data 待转换的公钥或私钥。
   * @param keyCoding 秘钥的编码方式(base64/hex/utf8/utf-8)，data为字符串时用到
   */
  static getKeyDataBlob(data: string | Uint8Array | cryptoFramework.DataBlob | null,
    keyCoding: crypto.BhuCoding = 'utf-8'): cryptoFramework.DataBlob | null {
    if (data === null) {
      return null;
    } else if (typeof data === 'string') {
      return { data: CryptoHelper.strToUint8Array(data, keyCoding) };
    } else if (data instanceof Uint8Array) {
      return { data: data };
    } else {
      return data;
    }
  }


  /**
   * 根据传入的大小生成随机Uint8Array
   * @param size 生成的串长度
   * @returns
   */
  static getRandomUint8Array(size: number): Uint8Array {
    return cryptoFramework.createRandom().generateRandomSync(size).data;
  }


  /**
   * Uint8Array补零操作
   * @param len 密钥规格长度
   * @returns
   */
  static getUint8ArrayPaddingZero(uint8Array: Uint8Array, len: number = 0): Uint8Array {
    if (len > 0 && uint8Array.length < len) {
      LogUtil.error("uint8Array-补零前: " + uint8Array);
      let diff = len - uint8Array.length;
      let randArray = new Array<number>();
      for (let i = 0; i < diff; i++) {
        randArray.push(0);
      }
      let diffUint8Array = new Uint8Array(diff);
      let mergeData = new Uint8Array(len);
      mergeData.set(uint8Array);
      mergeData.set(diffUint8Array, uint8Array.length);
      LogUtil.error("uint8Array-补零后: " + mergeData);
      return mergeData;
    }
    return uint8Array;
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


  /**
   * 字符串转Hex
   * @param str
   * @returns
   */
  static stringToHex(str: string): string {
    let hex = '';
    for (let i = 0; i < str.length; i++) {
      let hexCharCode = str.charCodeAt(i).toString(16);
      // 确保每个字符的十六进制编码占两位，不足补零
      hex += ('00' + hexCharCode).slice(-2);
    }
    return hex;
  }


  /**
   * 字节流转成可理解的字符串
   * @param array
   * @returns
   */
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


}