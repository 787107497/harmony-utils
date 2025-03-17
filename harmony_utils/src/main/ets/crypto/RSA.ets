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

import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { crypto } from './crypto';
import { CryptoUtil } from './CryptoUtil';


/**
 * TODO RSA加解密
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 */
export class RSA {
  /**
   * 加密,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param pubKey 指定加密公钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（RSA1024|PKCS1、RSA2048|PKCS1、等）。
   * @returns
   */
  static async encrypt(data: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey,
    transformation: crypto.RSA_TRAN = 'RSA1024|PKCS1'): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.encrypt(data, pubKey, null, transformation);
  }

  /**
   * 加密,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param pubKey 指定加密公钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（RSA1024|PKCS1、RSA2048|PKCS1、等）。
   * @returns
   */
  static encryptSync(data: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey,
    transformation: crypto.RSA_TRAN = 'RSA1024|PKCS1'): cryptoFramework.DataBlob {
    return CryptoUtil.encryptSync(data, pubKey, null, transformation);
  }


  /**
   * 解密,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param priKey 指定解密私钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（RSA1024|PKCS1、RSA2048|PKCS1、等）。
   */
  static async decrypt(data: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey,
    transformation: crypto.RSA_TRAN = 'RSA1024|PKCS1'): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.decrypt(data, priKey, null, transformation);
  }

  /**
   * 解密,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param priKey 指定解密私钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（RSA1024|PKCS1、RSA2048|PKCS1、等）。
   */
  static decryptSync(data: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey,
    transformation: crypto.RSA_TRAN = 'RSA1024|PKCS1'): cryptoFramework.DataBlob {
    return CryptoUtil.decryptSync(data, priKey, null, transformation);
  }


  /**
   * 加密,分段,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param pubKey 指定加密公钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（RSA1024|PKCS1、RSA2048|PKCS1、等）。
   * @param len 自定义的数据拆分长度。
   * @returns
   */
  static async encryptSegment(dataBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey,
    transformation: crypto.RSA_TRAN = 'RSA1024|PKCS1', len: number = 64): Promise<cryptoFramework.DataBlob> {
    let cipher = cryptoFramework.createCipher(transformation);
    await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, pubKey, null);
    let encryptData = new Uint8Array();
    for (let i = 0; i < dataBlob.data.length; i += len) {
      let updateData = dataBlob.data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      let updateOutput = await cipher.doFinal(updateDataBlob); //循环调用doFinal进行加密
      if (updateOutput != null && updateOutput.data != null) {
        let mergeData = new Uint8Array(encryptData.length + updateOutput.data.length);
        mergeData.set(encryptData);
        mergeData.set(updateOutput.data, encryptData.length);
        encryptData = mergeData;
      }
    }
    let cipherBlob: cryptoFramework.DataBlob = { data: encryptData };
    return cipherBlob;
  }

  /**
   * 加密,分段,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param pubKey 指定加密公钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（RSA1024|PKCS1、RSA2048|PKCS1、等）。
   * @param len 自定义的数据拆分长度。
   * @returns
   */
  static encryptSegmentSync(dataBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey,
    transformation: crypto.RSA_TRAN = 'RSA1024|PKCS1', len: number = 64): cryptoFramework.DataBlob {
    let cipher = cryptoFramework.createCipher(transformation);
    cipher.initSync(cryptoFramework.CryptoMode.ENCRYPT_MODE, pubKey, null);
    let encryptData = new Uint8Array();
    for (let i = 0; i < dataBlob.data.length; i += len) {
      let updateData = dataBlob.data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      let updateOutput = cipher.doFinalSync(updateDataBlob); //循环调用doFinal进行加密
      let mergeData = new Uint8Array(encryptData.length + updateOutput.data.length);
      mergeData.set(encryptData);
      mergeData.set(updateOutput.data, encryptData.length);
      encryptData = mergeData;
    }
    let cipherBlob: cryptoFramework.DataBlob = { data: encryptData };
    return cipherBlob;
  }


  /**
   * 解密,分段,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param priKey 指定解密私钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（RSA1024|PKCS1、RSA2048|PKCS1、等）。
   * @param len 自定义的数据拆分长度。
   */
  static async decryptSegment(dataBlob: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey,
    transformation: crypto.RSA_TRAN = 'RSA1024|PKCS1', len: number = 128): Promise<cryptoFramework.DataBlob> {
    let cipher = cryptoFramework.createCipher(transformation);
    await cipher.init(cryptoFramework.CryptoMode.DECRYPT_MODE, priKey, null);
    let decryptData = new Uint8Array();
    for (let i = 0; i < dataBlob.data.length; i += len) {
      let updateData = dataBlob.data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      let updateOutput = await cipher.doFinal(updateDataBlob);
      if (updateOutput != null && updateOutput.data != null) {
        let mergeData = new Uint8Array(decryptData.length + updateOutput.data.length);
        mergeData.set(decryptData);
        mergeData.set(updateOutput.data, decryptData.length);
        decryptData = mergeData;
      }
    }
    let decryptBlob: cryptoFramework.DataBlob = { data: decryptData };
    return decryptBlob;
  }

  /**
   * 解密,分段,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param priKey 指定解密私钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（RSA1024|PKCS1、RSA2048|PKCS1、等）。
   * @param len 自定义的数据拆分长度。
   */
  static decryptSegmentSync(dataBlob: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey,
    transformation: crypto.RSA_TRAN = 'RSA1024|PKCS1', len: number = 128): cryptoFramework.DataBlob {
    let cipher = cryptoFramework.createCipher(transformation);
    cipher.initSync(cryptoFramework.CryptoMode.DECRYPT_MODE, priKey, null);
    let decryptData = new Uint8Array();
    for (let i = 0; i < dataBlob.data.length; i += len) {
      let updateData = dataBlob.data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      let updateOutput = cipher.doFinalSync(updateDataBlob);
      let mergeData = new Uint8Array(decryptData.length + updateOutput.data.length);
      mergeData.set(decryptData);
      mergeData.set(updateOutput.data, decryptData.length);
      decryptData = mergeData;
    }
    let decryptBlob: cryptoFramework.DataBlob = { data: decryptData };
    return decryptBlob;
  }


  /**
   * 生成非对称密钥KeyPair，异步
   * @param algName 待生成对称密钥生成器的算法名称（RSA1024、RSA2048、等）。
   * @returns
   */
  static async generateKeyPair(algName: crypto.RSA_AlG = 'RSA1024|PRIMES_2'): Promise<cryptoFramework.KeyPair> {
    return CryptoUtil.generateKeyPair(algName);
  }

  /**
   * 生成非对称密钥KeyPair，同步
   * @param algName 待生成对称密钥生成器的算法名称（RSA1024、RSA2048、等）。
   * @returns
   */
  static generateKeyPairSync(algName: crypto.RSA_AlG = 'RSA1024|PRIMES_2'): cryptoFramework.KeyPair {
    return CryptoUtil.generateKeyPairSync(algName);
  }

  /**
   * 获取转换的非对称密钥KeyPair，异步
   * @param pubKey 公钥字符串
   * @param priKey 私钥字符串
   * @param keyCoding 秘钥的编码方式(base64/hex/utf8/utf-8)
   * @param algName 待生成对称密钥生成器的算法名称
   * @returns
   */
  static async getConvertKeyPair(pubKey: string | Uint8Array | cryptoFramework.DataBlob | null,
    priKey: string | Uint8Array | cryptoFramework.DataBlob | null, keyCoding: crypto.BhuCoding,
    algName: crypto.RSA_AlG = 'RSA1024|PRIMES_2'): Promise<cryptoFramework.KeyPair> {
    return CryptoUtil.getConvertKeyPair(algName, pubKey, priKey, keyCoding);
  }

  /**
   * 获取转换的非对称密钥KeyPair，同步
   * @param pubKey 公钥字符串
   * @param priKey 私钥字符串
   * @param keyCoding 秘钥的编码方式(base64/hex/utf8/utf-8)
   * @param algName 待生成对称密钥生成器的算法名称
   * @returns
   */
  static getConvertKeyPairSync(pubKey: string | Uint8Array | cryptoFramework.DataBlob | null,
    priKey: string | Uint8Array | cryptoFramework.DataBlob | null, keyCoding: crypto.BhuCoding,
    algName: crypto.RSA_AlG = 'RSA1024|PRIMES_2'): cryptoFramework.KeyPair {
    return CryptoUtil.getConvertKeyPairSync(algName, pubKey, priKey, keyCoding);
  }



  /**
   * 对数据进行签名，异步
   * @param dataBlob 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、等）。
   * @returns
   */
  static async sign(dataBlob: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey, algName: string = 'RSA1024|PKCS1|SHA256'): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.sign(dataBlob,priKey,algName)
  }

  /**
   * 对数据进行签名，同步
   * @param dataBlob 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、等）。
   * @returns
   */
  static signSync(dataBlob: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey, algName: string = 'RSA1024|PKCS1|SHA256'): cryptoFramework.DataBlob {
    return CryptoUtil.signSync(dataBlob, priKey, algName);
  }


  /**
   * 对数据进行验签，异步
   * @param dataBlob 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、等）。
   * @returns
   */
  static async verify(dataBlob: cryptoFramework.DataBlob, signDataBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey, algName: string = 'RSA1024|PKCS1|SHA256'): Promise<boolean> {
    return CryptoUtil.verify(dataBlob, signDataBlob, pubKey, algName);
  }

  /**
   * 对数据进行验签，同步
   * @param dataBlob 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、、等）。
   * @returns
   */
  static verifySync(dataBlob: cryptoFramework.DataBlob, signDataBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey, algName: string = 'RSA1024|PKCS1|SHA256'): boolean {
    return CryptoUtil.verifySync(dataBlob, signDataBlob, pubKey, algName);
  }


  /**
   * 对数据进行分段签名，异步
   * @param data 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、、等）。
   * @param len 自定义的数据拆分长度，此处取64
   * @returns
   */
  static async signSegment(data: Uint8Array, priKey: cryptoFramework.PriKey, algName: string = 'RSA1024|PKCS1|SHA256', len: number = 64): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.signSegment(data, priKey, algName, len);
  }

  /**
   * 对数据进行分段签名，同步
   * @param data 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、、等）。
   * @param len 自定义的数据拆分长度，此处取64
   * @returns
   */
  static signSegmentSync(data: Uint8Array, priKey: cryptoFramework.PriKey, algName: string = 'RSA1024|PKCS1|SHA256', len: number = 64): cryptoFramework.DataBlob {
    return CryptoUtil.signSegmentSync(data, priKey, algName, len);
  }


  /**
   * 对数据进行分段验签，异步
   * @param data 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、、等）。
   * @param len 自定义的数据拆分长度，此处取64
   * @returns
   */
  static async verifySegment(data: Uint8Array, signDataBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey, algName: string = 'RSA1024|PKCS1|SHA256', len: number = 64): Promise<boolean> {
    return CryptoUtil.verifySegment(data, signDataBlob, pubKey, algName, len);
  }

  /**
   * 对数据进行分段验签，同步
   * @param data 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、、等）。
   * @param len 自定义的数据拆分长度，此处取64
   * @returns
   */
  static verifySegmentSync(data: Uint8Array, signDataBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey, algName: string = 'RSA1024|PKCS1|SHA256', len: number = 64): boolean {
    return CryptoUtil.verifySegmentSync(data, signDataBlob, pubKey, algName, len);
  }


  /**
   * 对数据进行签名恢复原始数据，异步，目前仅RSA支持
   * @param signData 已签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA1024|PKCS1|NoHash|OnlySign、RSA1024|PKCS1|NoHash|Recover、等）。
   * @returns
   */
  static async recover(signData: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey, algName: string = 'RSA1024|PKCS1|NoHash|Recover'): Promise<cryptoFramework.DataBlob | null> {
    let verifier = cryptoFramework.createVerify(algName);
    await verifier.init(pubKey);
    let rawSignData = await verifier.recover(signData);
    return rawSignData;
  }

  /**
   * 对数据进行签名恢复原始数据，同步，目前仅RSA支持
   * @param signDataBlob 已签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA1024|PKCS1|NoHash|OnlySign、RSA1024|PKCS1|NoHash|Recover、等）。
   * @returns
   */
  static recoverSync(signDataBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey, algName: string = 'RSA1024|PKCS1|NoHash|Recover') {
    let verifier = cryptoFramework.createVerify(algName);
    verifier.initSync(pubKey);
    let rawSignData = verifier.recoverSync(signDataBlob);
    return rawSignData;
  }


}