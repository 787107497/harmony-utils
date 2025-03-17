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

import { util } from '@kit.ArkTS';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';

/**
 * TODO 随机工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class RandomUtil {


  /**
   * 生成随机Boolean值
   * @return true or false
   */
  static getRandomBoolean(): boolean {
    return Math.random() >= 0.5;
  }


  /**
   * 生成随机整数（可指定范围）
   * @return 随机数
   */
  static getRandomInt(min: number = 0, max: number = Number.MAX_SAFE_INTEGER): number {
    min = Math.ceil(min); //向上取整
    max = Math.floor(max); //向下取整
    return Math.floor(Math.random() * (max - min)) + min;
  }

  /**
   * 生成指定范围内的随机数
   * @return 随机数
   */
  static getRandomNumber(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min) + min);
  }

  /**
   * 生成指定范围内的随机数 [0,limit)
   * @param limit 限制随机数的范围，不包括这个数
   * @return 随机数
   */
  static getRandomLimit(limit: number): number {
    return Math.floor(Math.random() * limit);
  }


  /**
   * 生成一个随机汉字（'\u4E00'-'\u9FFF'）
   * @return 随机的汉字字符
   */
  static getRandomChineseChar(): string {
    const start = 0x4E00; //汉字起始Unicode编码,'\u4E00'
    const end = 0x9FFF; //汉字结束Unicode编码,'\u9FFF'
    const randomCode = start + Math.floor(Math.random() * (end - start + 1)); //生成一个随机码点
    return String.fromCharCode(randomCode); //将随机码点转换为对应的汉字字符
  }

  /**
   * 生成随机汉字
   * @param length 目标长度
   * @return 随机的汉字字符串
   */
  static getRandomChinese(length: number): string {
    length = Math.floor(length);
    let chineseArray = new Array<string>(length);
    for (let i = 0; i < length; i++) {
      chineseArray[i] = RandomUtil.getRandomChineseChar();
    }
    return chineseArray.join('');
  }


  /**
   * 根据指定字符串，随机生成 指定长度的字符串
   * @param length 目标长度
   * @param chars 字符池
   * @returns
   */
  static getRandomStr(length: number, strPool: string): string {
    const strPoolLength = strPool.length;
    let randomStr = '';
    for (let i = 0; i < length; i++) {
      let randomIndex = Math.floor(Math.random() * strPoolLength); //生成一个随机索引
      randomStr += strPool[randomIndex]; //从字符池中取出随机索引对应的字符，并拼接到结果字符串
    }
    return randomStr;
  }


  /**
   * 生成一个随机颜色，十六进制
   * @returns color
   */
  static getRandomColor(): string {
    let hexadecimal = '0123456789ABCDEF';
    let color = '#';
    for (let i = 0; i < 6; i++) {
      color += hexadecimal[Math.floor(Math.random() * 16)];
    }
    return color;
  }


  /**
   * 生成随机指定长度的DataBlob
   * @param length 目标长度
   * @returns
   */
  static getRandomDataBlob(length: number): cryptoFramework.DataBlob {
    return cryptoFramework.createRandom().generateRandomSync(length);
  }

  /**
   * 生成随机指定长度的Uint8Array
   * @param length 目标长度
   * @returns
   */
  static getRandomUint8Array(length: number): Uint8Array {
    return RandomUtil.getRandomDataBlob(length).data;
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