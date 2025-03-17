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

import cryptoFramework from '@ohos.security.cryptoFramework';
import { CryptoUtil } from './CryptoUtil';

/**
 * TODO DES加解密
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 */
export class DES {

  /**
   * 加密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static async encryptECB(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): Promise<cryptoFramework.DataBlob> {
    return DES.encrypt(data, symKey, null, '3DES192|ECB|PKCS7');
  }

  /**
   * 加密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static encryptECBSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): cryptoFramework.DataBlob {
    return DES.encryptSync(data, symKey, null, '3DES192|ECB|PKCS7');
  }


  /**
   * 解密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static async decryptECB(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): Promise<cryptoFramework.DataBlob> {
    return DES.decrypt(data, symKey, null, '3DES192|ECB|PKCS7');
  }

  /**
   * 解密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static decryptECBSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): cryptoFramework.DataBlob {
    return DES.decryptSync(data, symKey, null, '3DES192|ECB|PKCS7');
  }


  /**
   * 加密（CBC模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static async encryptCBC(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    params: cryptoFramework.ParamsSpec): Promise<cryptoFramework.DataBlob> {
    return DES.encrypt(data, symKey, params, '3DES192|CBC|PKCS7');
  }

  /**
   * 加密（CBC模式）,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static encryptCBCSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    params: cryptoFramework.ParamsSpec): cryptoFramework.DataBlob {
    return DES.encryptSync(data, symKey, params, '3DES192|CBC|PKCS7');
  }


  /**
   * 解密（CBC模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static async decryptCBC(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    params: cryptoFramework.ParamsSpec): Promise<cryptoFramework.DataBlob> {
    return DES.decrypt(data, symKey, params, '3DES192|CBC|PKCS7');
  }

  /**
   * 解密（CBC模式）,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param params 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|CBC|PKCS7、AES192|CBC|PKCS7、AES128|CBC|PKCS7）。
   * @returns
   */
  static decryptCBCSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    params: cryptoFramework.ParamsSpec): cryptoFramework.DataBlob {
    return DES.decryptSync(data, symKey, params, '3DES192|CBC|PKCS7');
  }


  /**
   * 加密，异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param params 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（3DES192|ECB|PKCS7、3DES192|CBC|PKCS7、等）。
   * @returns
   */
  static async encrypt(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    params: cryptoFramework.ParamsSpec | null, transformation: string): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.encrypt(data, symKey, params, transformation);
  }

  /**
   * 加密，同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param params 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（3DES192|ECB|PKCS7、3DES192|CBC|PKCS7、等）。
   * @returns
   */
  static encryptSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    params: cryptoFramework.ParamsSpec | null, transformation: string): cryptoFramework.DataBlob {
    return CryptoUtil.encryptSync(data, symKey, params, transformation);
  }


  /**
   * 解密，异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param params 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（3DES192|ECB|PKCS7、3DES192|CBC|PKCS7、等）。
   * @returns
   */
  static async decrypt(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey, params: cryptoFramework.ParamsSpec | null, transformation: string): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.decrypt(data, symKey, params, transformation);
  }

  /**
   * 解密，同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param params 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（3DES192|ECB|PKCS7、3DES192|CBC|PKCS7、等）。
   * @returns
   */
  static decryptSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,params: cryptoFramework.ParamsSpec | null,  transformation: string): cryptoFramework.DataBlob {
    return CryptoUtil.decryptSync(data, symKey, params, transformation);
  }


  /**
   * 生成对称密钥SymKey，异步
   * @param symAlgName 待生成对称密钥生成器的算法名称（3DES192）
   * @returns
   */
  static async generateSymKey(): Promise<cryptoFramework.SymKey> {
    return CryptoUtil.generateSymKey('3DES192');
  }

  /**
   * 生成对称密钥SymKey，同步
   * @param symAlgName 待生成对称密钥生成器的算法名称（3DES192）
   * @returns
   */
  static generateSymKeySync(): cryptoFramework.SymKey {
    return CryptoUtil.generateSymKeySync('3DES192');
  }


}