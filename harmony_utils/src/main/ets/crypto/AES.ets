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
 * TODO AES加解密
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01 */
export class AES {


  /**
   * 加密（GCM模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param gcmParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|GCM|PKCS7、AES192|GCM|PKCS7、AES128|GCM|PKCS7）。
   * @returns
   */
  static async encryptGCM(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    gcmParams: cryptoFramework.GcmParamsSpec, transformation: string = 'AES256|GCM|PKCS7'): Promise<cryptoFramework.DataBlob> {
    let cipher = cryptoFramework.createCipher(transformation);
    await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, symKey, gcmParams);
    let encryptUpdate = await cipher.update(data);
    //GCM模式加密doFinal时传入空，获得tag数据，并更新至gcmParams对象中。
    gcmParams.authTag = await cipher.doFinal(null);
    return encryptUpdate;
  }

  /**
   * 加密（GCM模式）,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param gcmParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|GCM|PKCS7、AES192|GCM|PKCS7、AES128|GCM|PKCS7）。
   * @returns
   */
  static encryptGCMSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    gcmParams: cryptoFramework.GcmParamsSpec, transformation: string = 'AES256|GCM|PKCS7'): cryptoFramework.DataBlob {
    let cipher = cryptoFramework.createCipher(transformation);
    cipher.initSync(cryptoFramework.CryptoMode.ENCRYPT_MODE, symKey, gcmParams);
    let encryptUpdate = cipher.updateSync(data);
    //GCM模式加密doFinal时传入空，获得tag数据，并更新至gcmParams对象中。
    gcmParams.authTag = cipher.doFinalSync(null);
    return encryptUpdate;
  }


  /**
   * 解密（GCM模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param gcmParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|GCM|PKCS7、AES192|GCM|PKCS7、AES128|GCM|PKCS7）。
   * @returns
   */
  static async decryptGCM(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    gcmParams: cryptoFramework.GcmParamsSpec, transformation: string = 'AES256|GCM|PKCS7'): Promise<cryptoFramework.DataBlob> {
    let decoder = cryptoFramework.createCipher(transformation);
    await decoder.init(cryptoFramework.CryptoMode.DECRYPT_MODE, symKey, gcmParams);
    let decryptUpdate = await decoder.update(data);
    //GCM模式解密doFinal时传入空，验证init时传入的tag数据，如果验证失败会抛出异常。
    await decoder.doFinal(null)
    return decryptUpdate;
  }

  /**
   * 解密（GCM模式）,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param gcmParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|GCM|PKCS7、AES192|GCM|PKCS7、AES128|GCM|PKCS7）。
   * @returns
   */
  static decryptGCMSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    gcmParams: cryptoFramework.GcmParamsSpec, transformation: string = 'AES256|GCM|PKCS7'): cryptoFramework.DataBlob {
    let decoder = cryptoFramework.createCipher(transformation);
    decoder.initSync(cryptoFramework.CryptoMode.DECRYPT_MODE, symKey, gcmParams);
    let decryptUpdate = decoder.updateSync(data);
    //GCM模式解密doFinal时传入空，验证init时传入的tag数据，如果验证失败会抛出异常。
    decoder.doFinalSync(null)
    return decryptUpdate;
  }


  /**
   * 加密（CBC模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param ivParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|CBC|PKCS7、AES192|CBC|PKCS7、AES128|CBC|PKCS7）。
   * @returns
   */
  static async encryptCBC(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    ivParams: cryptoFramework.IvParamsSpec, transformation: string = 'AES256|CBC|PKCS7'): Promise<cryptoFramework.DataBlob> {
    return AES.encrypt(data, symKey, ivParams, transformation);
  }

  /**
   * 加密（CBC模式）,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param ivParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|CBC|PKCS7、AES192|CBC|PKCS7、AES128|CBC|PKCS7）。
   * @returns
   */
  static encryptCBCSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    ivParams: cryptoFramework.IvParamsSpec, transformation: string = 'AES256|CBC|PKCS7'): cryptoFramework.DataBlob {
    return AES.encryptSync(data, symKey, ivParams, transformation);
  }


  /**
   * 解密（CBC模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param ivParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|CBC|PKCS7、AES192|CBC|PKCS7、AES128|CBC|PKCS7）。
   * @returns
   */
  static async decryptCBC(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    ivParams: cryptoFramework.IvParamsSpec, transformation: string = 'AES256|CBC|PKCS7'): Promise<cryptoFramework.DataBlob> {
    return AES.decrypt(data, symKey, ivParams, transformation);
  }

  /**
   * 解密（CBC模式）,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param ivParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|CBC|PKCS7、AES192|CBC|PKCS7、AES128|CBC|PKCS7）。
   * @returns
   */
  static decryptCBCSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    ivParams: cryptoFramework.IvParamsSpec, transformation: string = 'AES256|CBC|PKCS7'): cryptoFramework.DataBlob {
    return AES.decryptSync(data, symKey, ivParams, transformation);
  }


  /**
   * 加密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|ECB|PKCS7、AES192|ECB|PKCS7、AES128|ECB|PKCS7）。
   * @returns
   */
  static async encryptECB(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    transformation: string = 'AES256|ECB|PKCS7'): Promise<cryptoFramework.DataBlob> {
    return AES.encrypt(data, symKey, null, transformation);
  }

  /**
   * 加密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|ECB|PKCS7、AES192|ECB|PKCS7、AES128|ECB|PKCS7）。
   * @returns
   */
  static encryptECBSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    transformation: string = 'AES256|ECB|PKCS7'): cryptoFramework.DataBlob {
    return AES.encryptSync(data, symKey, null, transformation);
  }


  /**
   * 解密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|ECB|PKCS7、AES192|ECB|PKCS7、AES128|ECB|PKCS7）。
   * @returns
   */
  static async decryptECB(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    transformation: string = 'AES256|ECB|PKCS7'): Promise<cryptoFramework.DataBlob> {
    return AES.decrypt(data, symKey, null, transformation);
  }

  /**
   * 解密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|ECB|PKCS7、AES192|ECB|PKCS7、AES128|ECB|PKCS7）。
   * @returns
   */
  static decryptECBSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    transformation: string = 'AES256|ECB|PKCS7'): cryptoFramework.DataBlob {
    return AES.decryptSync(data, symKey, null, transformation);
  }


  /**
   * 加密，异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param params 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合。
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
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合。
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
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合。
   * @returns
   */
  static async decrypt(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    params: cryptoFramework.ParamsSpec | null, transformation: string): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.decrypt(data, symKey, params, transformation);
  }

  /**
   * 解密，同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param params 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合。
   * @returns
   */
  static decryptSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    params: cryptoFramework.ParamsSpec | null, transformation: string): cryptoFramework.DataBlob {
    return CryptoUtil.decryptSync(data, symKey, params, transformation);
  }


  /**
   * 加密（GCM模式）分段，异步
   * @param dataBlob 加密或者解密的数据。dataBlob不能为null。
   * @param key 指定加密或解密的密钥。
   * @param gcmParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES128|GCM|PKCS7、AES192|GCM|PKCS7、AES256|GCM|PKCS7、、等）。
   * @param len 自定义的数据拆分长度。
   * @returns
   */
  static async encryptGCMSegment(dataBlob: cryptoFramework.DataBlob, key: cryptoFramework.Key,
    gcmParams: cryptoFramework.GcmParamsSpec, transformation: string = 'AES256|GCM|PKCS7',
    len: number = 128): Promise<cryptoFramework.DataBlob> {
    let cipher = cryptoFramework.createCipher(transformation);
    await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, key, gcmParams);
    let encryptData = new Uint8Array();
    for (let i = 0; i < dataBlob.data.length; i += len) {
      let updateData = dataBlob.data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      let updateOutput = await cipher.update(updateDataBlob); //分段update
      let mergeTData = new Uint8Array(encryptData.length + updateOutput.data.length);
      mergeTData.set(encryptData);
      mergeTData.set(updateOutput.data, encryptData.length);
      encryptData = mergeTData;
    }
    gcmParams.authTag = await cipher.doFinal(null);
    let encryptBlob: cryptoFramework.DataBlob = { data: encryptData };
    return encryptBlob;
  }

  /**
   * 加密（GCM模式）分段，同步
   * @param dataBlob 加密或者解密的数据。dataBlob不能为null。
   * @param key 指定加密或解密的密钥。
   * @param gcmParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES128|GCM|PKCS7、AES192|GCM|PKCS7、AES256|GCM|PKCS7、、等）。
   * @param len 自定义的数据拆分长度。
   * @returns
   */
  static encryptGCMSegmentSync(dataBlob: cryptoFramework.DataBlob, key: cryptoFramework.Key,
    gcmParams: cryptoFramework.GcmParamsSpec, transformation: string = 'AES256|GCM|PKCS7',
    len: number = 128): cryptoFramework.DataBlob {
    let cipher = cryptoFramework.createCipher(transformation);
    cipher.initSync(cryptoFramework.CryptoMode.ENCRYPT_MODE, key, gcmParams);
    let encryptData = new Uint8Array();
    for (let i = 0; i < dataBlob.data.length; i += len) {
      let updateData = dataBlob.data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      let updateOutput = cipher.updateSync(updateDataBlob); //分段update
      let mergeTData = new Uint8Array(encryptData.length + updateOutput.data.length);
      mergeTData.set(encryptData);
      mergeTData.set(updateOutput.data, encryptData.length);
      encryptData = mergeTData;
    }
    gcmParams.authTag = cipher.doFinalSync(null);
    let encryptBlob: cryptoFramework.DataBlob = { data: encryptData };
    return encryptBlob;
  }


  /**
   * 解密（GCM模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param gcmParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|GCM|PKCS7、AES192|GCM|PKCS7、AES128|GCM|PKCS7）。
   * @param len 自定义的数据拆分长度。
   * @returns
   */
  static async decryptGCMSegment(dataBlob: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    gcmParams: cryptoFramework.GcmParamsSpec, transformation: string = 'AES256|GCM|PKCS7',
    len: number = 128): Promise<cryptoFramework.DataBlob> {
    let decoder = cryptoFramework.createCipher(transformation);
    await decoder.init(cryptoFramework.CryptoMode.DECRYPT_MODE, symKey, gcmParams);
    let decryptData = new Uint8Array();
    for (let i = 0; i < dataBlob.data.length; i += len) {
      let updateData = dataBlob.data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      let updateOutput = await decoder.update(updateDataBlob); //分段update
      //把update的结果拼接起来，得到明文
      let mergeData = new Uint8Array(decryptData.length + updateOutput.data.length);
      mergeData.set(decryptData);
      mergeData.set(updateOutput.data, decryptData.length);
      decryptData = mergeData;
    }
    await decoder.doFinal(null);
    let decryptBlob: cryptoFramework.DataBlob = { data: decryptData };
    return decryptBlob;
  }

  /**
   * 解密（GCM模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param gcmParams 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|GCM|PKCS7、AES192|GCM|PKCS7、AES128|GCM|PKCS7）。
   * @param len 自定义的数据拆分长度。
   * @returns
   */
  static decryptGCMSegmentSync(dataBlob: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey,
    gcmParams: cryptoFramework.GcmParamsSpec, transformation: string = 'AES256|GCM|PKCS7',
    len: number = 128): cryptoFramework.DataBlob {
    let decoder = cryptoFramework.createCipher(transformation);
    decoder.initSync(cryptoFramework.CryptoMode.DECRYPT_MODE, symKey, gcmParams);
    let decryptData = new Uint8Array();
    for (let i = 0; i < dataBlob.data.length; i += len) {
      let updateData = dataBlob.data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      let updateOutput = decoder.updateSync(updateDataBlob); //分段update
      //把update的结果拼接起来，得到明文
      let mergeTData = new Uint8Array(decryptData.length + updateOutput.data.length);
      mergeTData.set(decryptData);
      mergeTData.set(updateOutput.data, decryptData.length);
      decryptData = mergeTData;
    }
    decoder.doFinalSync(null);
    let decryptBlob: cryptoFramework.DataBlob = { data: decryptData };
    return decryptBlob;
  }


  /**
   * 生成对称密钥SymKey，异步
   * @param symAlgName 待生成对称密钥生成器的算法名称（AES128、AES192、AES256）
   * @returns
   */
  static async generateSymKey(algName: string = 'AES256'): Promise<cryptoFramework.SymKey> {
    return CryptoUtil.generateSymKey(algName);
  }

  /**
   * 生成对称密钥SymKey，同步
   * @param symAlgName 待生成对称密钥生成器的算法名称（AES128、AES192、AES256）
   * @returns
   */
  static generateSymKeySync(algName: string = 'AES256'): cryptoFramework.SymKey {
    return CryptoUtil.generateSymKeySync(algName);
  }


}