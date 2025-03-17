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

import { crypto } from './crypto';
import { CryptoUtil } from './CryptoUtil';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';

/**
 * TODO SM3工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 */
export class SM3 {

  private static symKey = CryptoUtil.generateSymKeySync('HMAC|SM3'); //对称密钥SymKey


  /**
   * SM3摘要，同步
   * @param data 待摘要的数据
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @returns
   */
  static async digest(data: string, resultCoding: crypto.BhCoding = 'hex'): Promise<string> {
    return CryptoUtil.digest(data, 'SM3', resultCoding);
  }

  /**
   * SM3摘要，同步
   * @param data 待摘要的数据
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @returns
   */
  static digestSync(data: string, resultCoding: crypto.BhCoding = 'hex'): string {
    return CryptoUtil.digestSync(data, 'SM3', resultCoding);
  }


  /**
   * SM3分段摘要，同步
   * @param data 待摘要的数据
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   * @returns
   */
  static async digestSegment(data: string, resultCoding: crypto.BhCoding = 'hex', len: number = 128): Promise<string> {
    return CryptoUtil.digestSegment(data, 'SM3', resultCoding, len);
  }

  /**
   * SM3分段摘要，同步
   * @param data 待摘要的数据
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   * @returns
   */
  static digestSegmentSync(data: string, resultCoding: crypto.BhCoding = 'hex', len: number = 128): string {
    return CryptoUtil.digestSegmentSync(data, 'SM3', resultCoding, len);
  }


  /**
   * 消息认证码计算，异步
   * @param data 传入的消息
   * @param symKey 共享对称密钥（SymKey）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   */
  static async hmac(data: string, symKey: cryptoFramework.SymKey = SM3.symKey,
    resultCoding: crypto.BhCoding = 'hex'): Promise<string> {
    return CryptoUtil.hmac(data, 'SM3', symKey, resultCoding);
  }

  /**
   * 消息认证码计算，同步
   * @param data 传入的消息
   * @param symKey 共享对称密钥（SymKey）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   */
  static hmacSync(data: string, symKey: cryptoFramework.SymKey = SM3.symKey,
    resultCoding: crypto.BhCoding = 'hex'): string {
    return CryptoUtil.hmacSync(data, 'SM3', symKey, resultCoding);
  }


  /**
   * 消息认证码计算，分段，异步
   * @param data 传入的消息
   * @param symKey 共享对称密钥（SymKey）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   */
  static async hmacSegment(data: string, symKey: cryptoFramework.SymKey = SM3.symKey,
    resultCoding: crypto.BhCoding = 'hex', len: number = 128): Promise<string> {
    return CryptoUtil.hmacSegment(data, 'SM3', symKey, resultCoding, len);
  }

  /**
   * 消息认证码计算，分段，同步
   * @param data 传入的消息
   * @param symKey 共享对称密钥（SymKey）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   */
  static hmacSegmentSync(data: string, symKey: cryptoFramework.SymKey = SM3.symKey,
    resultCoding: crypto.BhCoding = 'hex', len: number = 128): string {
    return CryptoUtil.hmacSegmentSync(data, 'SM3', symKey, resultCoding, len);
  }


}
