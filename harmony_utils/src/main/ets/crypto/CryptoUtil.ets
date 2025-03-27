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
import { CryptoHelper } from './CryptoHelper';


/**
 * TODO 加解密公用工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 */
export class CryptoUtil {


  /**
   * 加密，异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param key 指定加密或解密的密钥。
   * @param params 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合。
   * @returns
   */
  static async encrypt(data: cryptoFramework.DataBlob, key: cryptoFramework.Key,
    params: cryptoFramework.ParamsSpec | null, transformation: string): Promise<cryptoFramework.DataBlob> {
    let cipher = cryptoFramework.createCipher(transformation);
    await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, key, params);
    let cipherData = await cipher.doFinal(data);
    return cipherData;
  }

  /**
   * 加密，同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param key 指定加密或解密的密钥。
   * @param params 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合。
   * @returns
   */
  static encryptSync(data: cryptoFramework.DataBlob, key: cryptoFramework.Key,
    params: cryptoFramework.ParamsSpec | null, transformation: string): cryptoFramework.DataBlob {
    let cipher = cryptoFramework.createCipher(transformation);
    cipher.initSync(cryptoFramework.CryptoMode.ENCRYPT_MODE, key, params);
    let cipherData = cipher.doFinalSync(data);
    return cipherData;
  }


  /**
   * 解密，异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param key 指定加密或解密的密钥。
   * @param params 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合。
   * @returns
   */
  static async decrypt(data: cryptoFramework.DataBlob, key: cryptoFramework.Key,
    params: cryptoFramework.ParamsSpec | null, transformation: string): Promise<cryptoFramework.DataBlob> {
    let decoder = cryptoFramework.createCipher(transformation);
    await decoder.init(cryptoFramework.CryptoMode.DECRYPT_MODE, key, params);
    let decryptData = await decoder.doFinal(data);
    return decryptData;
  }

  /**
   * 解密，同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param key 指定加密或解密的密钥。
   * @param params 指定加密或解密的参数，对于ECB等没有参数的算法模式，可以传入null。API 10之前只支持ParamsSpec， API 10之后增加支持null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合。
   * @returns
   */
  static decryptSync(data: cryptoFramework.DataBlob, key: cryptoFramework.Key,
    params: cryptoFramework.ParamsSpec | null, transformation: string): cryptoFramework.DataBlob {
    let decoder = cryptoFramework.createCipher(transformation);
    decoder.initSync(cryptoFramework.CryptoMode.DECRYPT_MODE, key, params);
    let decryptData = decoder.doFinalSync(data);
    return decryptData;
  }


  /**
   * 生成对称密钥SymKey，异步
   * @param algName 待生成对称密钥生成器的算法名称（AES128、AES192、AES256、3DES192、SM4_128、HMAC、HMAC|SHA1、HMAC|SHA256、HMAC|SHA512、HMAC|SM3、等）
   * @returns
   */
  static async generateSymKey(algName: string): Promise<cryptoFramework.SymKey> {
    let symKeyGenerator = cryptoFramework.createSymKeyGenerator(algName); //创建对称密钥生成器
    let symKey = await symKeyGenerator.generateSymKey(); //获取该对称密钥生成器随机生成的密钥
    return symKey;
  }

  /**
   * 生成对称密钥SymKey，同步
   * @param algName 待生成对称密钥生成器的算法名称（AES128、AES192、AES256、3DES192、SM4_128、HMAC、HMAC|SHA1、HMAC|SHA256、HMAC|SHA512、HMAC|SM3、等）
   * @returns
   */
  static generateSymKeySync(algName: string): cryptoFramework.SymKey {
    let symKeyGenerator = cryptoFramework.createSymKeyGenerator(algName); //创建对称密钥生成器
    let symKey = symKeyGenerator.generateSymKeySync(); //获取该对称密钥生成器随机生成的密钥
    return symKey;
  }


  /**
   * 获取转换的对称密钥SymKey，异步
   * @param key 字符串key
   * @param algName 待生成对称密钥生成器的算法名称（AES128、AES192、AES256、3DES192、SM4_128、HMAC、HMAC|SHA1、HMAC|SHA256、HMAC|SHA512、HMAC|SM3、等）
   * @param keyCoding 秘钥的编码方式(base64/hex/utf8/utf-8)
   * @param keyLen 密钥规格的最小长度，默认为0，为0时不补全。
   * @returns
   */
  static async getConvertSymKey(algName: string, key: string | Uint8Array | cryptoFramework.DataBlob,
    keyCoding: crypto.BhuCoding, keyLen: number = 0): Promise<cryptoFramework.SymKey> {
    let symKeyBlob: cryptoFramework.DataBlob = CryptoHelper.getSymKeyDataBlob(key, keyCoding, keyLen);
    let aesGenerator = cryptoFramework.createSymKeyGenerator(algName);
    let symKey = await aesGenerator.convertKey(symKeyBlob);
    return symKey;
  }

  /**
   * 获取转换的对称密钥SymKey，同步
   * @param key 字符串key
   * @param algName 待生成对称密钥生成器的算法名称（AES128、AES192、AES256、3DES192、SM4_128、HMAC、HMAC|SHA1、HMAC|SHA256、HMAC|SHA512、HMAC|SM3、等）
   * @param keyCoding 秘钥的编码方式(base64/hex/utf8/utf-8)
   * @param keyLen 密钥规格的最小长度，默认为0，为0时不补全。
   * @returns
   */
  static getConvertSymKeySync(algName: string, key: string | Uint8Array | cryptoFramework.DataBlob,
    keyCoding: crypto.BhuCoding, keyLen: number = 0): cryptoFramework.SymKey {
    let symKeyBlob: cryptoFramework.DataBlob = CryptoHelper.getSymKeyDataBlob(key, keyCoding, keyLen);
    let aesGenerator = cryptoFramework.createSymKeyGenerator(algName);
    let symKey = aesGenerator.convertKeySync(symKeyBlob);
    return symKey;
  }


  /**
   * 生成非对称密钥KeyPair，异步
   * @param algName 待生成对称密钥生成器的算法名称（SM2_256、RSA1024|PRIMES_2、RSA2048|PRIMES_2、ECC256、等）。
   * @returns
   */
  static async generateKeyPair(algName: string): Promise<cryptoFramework.KeyPair> {
    let asyKeyGenerator = cryptoFramework.createAsyKeyGenerator(algName); //非对称密钥生成器的对象。
    let keyPair = await asyKeyGenerator.generateKeyPair() //获取该非对称密钥生成器随机生成的密钥
    return keyPair;
  }

  /**
   * 生成非对称密钥KeyPair，同步
   * @param algName 待生成对称密钥生成器的算法名称（SM2_256、RSA1024|PRIMES_2、RSA2048|PRIMES_2、ECC256、等）。
   * @returns
   */
  static generateKeyPairSync(algName: string): cryptoFramework.KeyPair {
    let asyKeyGenerator = cryptoFramework.createAsyKeyGenerator(algName); //非对称密钥生成器的对象。
    let keyPair = asyKeyGenerator.generateKeyPairSync() //获取该非对称密钥生成器随机生成的密钥
    return keyPair;
  }


  /**
   * 获取转换的非对称密钥KeyPair，异步
   * @param algName 待生成对称密钥生成器的算法名称（SM2_256、RSA1024|PRIMES_2、RSA2048|PRIMES_2、ECC256、等）
   * @param pubKey 公钥字符串
   * @param priKey 私钥字符串
   * @param keyCoding 秘钥的编码方式(base64/hex/utf8/utf-8)
   * @returns
   */
  static async getConvertKeyPair(algName: string, pubKey: string | Uint8Array | cryptoFramework.DataBlob | null,
    priKey: string | Uint8Array | cryptoFramework.DataBlob | null, keyCoding: crypto.BhuCoding): Promise<cryptoFramework.KeyPair> {
    let pubKeyBlob: cryptoFramework.DataBlob | null = CryptoHelper.getKeyDataBlob(pubKey, keyCoding);
    let priKeyBlob: cryptoFramework.DataBlob | null = CryptoHelper.getKeyDataBlob(priKey, keyCoding);
    let asyKeyGenerator = cryptoFramework.createAsyKeyGenerator(algName); //非对称密钥生成器的对象。
    let keyPair = await asyKeyGenerator.convertKey(pubKeyBlob, priKeyBlob); //获取该非对称密钥生成器随机生成的密钥
    return keyPair;
  }

  /**
   * 获取转换的非对称密钥KeyPair，同步
   * @param algName 待生成对称密钥生成器的算法名称（SM2_256、RSA1024|PRIMES_2、RSA2048|PRIMES_2、ECC256、等）
   * @param pubKey 公钥字符串
   * @param priKey 私钥字符串
   * @param keyCoding 秘钥的编码方式(base64/hex/utf8/utf-8)
   * @returns
   */
  static getConvertKeyPairSync(algName: string, pubKey: string | Uint8Array | cryptoFramework.DataBlob | null,
    priKey: string | Uint8Array | cryptoFramework.DataBlob | null,
    keyCoding: crypto.BhuCoding): cryptoFramework.KeyPair {
    let pubKeyBlob: cryptoFramework.DataBlob | null = CryptoHelper.getKeyDataBlob(pubKey, keyCoding);
    let priKeyBlob: cryptoFramework.DataBlob | null = CryptoHelper.getKeyDataBlob(priKey, keyCoding);
    let asyKeyGenerator = cryptoFramework.createAsyKeyGenerator(algName); //非对称密钥生成器的对象。
    let keyPair = asyKeyGenerator.convertKeySync(pubKeyBlob, priKeyBlob); //获取该非对称密钥生成器随机生成的密钥
    return keyPair;
  }


  /**
   * 获取指定数据生成非对称密钥。
   * @param algName
   * @param pubKey 指定的公钥材料。如果公钥不需要转换，可直接传入null。
   * @param priKey 指定的私钥材料。如果私钥不需要转换，可直接传入null。注：公钥和私钥材料不能同时为null。
   * @returns
   */
  static async getPemKeyPair(algName: string, pubKey: string, priKey: string): Promise<cryptoFramework.KeyPair>  {
    let asyKeyGenerator = cryptoFramework.createAsyKeyGenerator(algName);
    let keyPair = await asyKeyGenerator.convertPemKey(pubKey, priKey);
    // let pubStr = keyPair.pubKey.getEncodedPem('X509');
    // let priStr = keyPair.priKey.getEncodedPem('PKCS8');
    return keyPair;
  }


  /**
   * 生成IvParamsSpec
   * @returns
   */
  static generateIvParamsSpec(): cryptoFramework.IvParamsSpec {
    let dataIv = CryptoHelper.getRandomUint8Array(16);
    let ivBlob: cryptoFramework.DataBlob = { data: dataIv };
    let ivParamsSpec: cryptoFramework.IvParamsSpec = { algName: "IvParamsSpec", iv: ivBlob };
    return ivParamsSpec;
  }

  /**
   * 获取转换IvParamsSpec
   * @param ivStr 字符串iv
   * @param ivCoding 编码方式(base64/hex/utf8/utf-8)
   * @returns
   */
  static getIvParamsSpec(ivStr: string, ivCoding: crypto.BhuCoding): cryptoFramework.IvParamsSpec {
    let ivBlob: cryptoFramework.DataBlob = { data: CryptoHelper.strToUint8Array(ivStr, ivCoding) };
    let ivParamsSpec: cryptoFramework.IvParamsSpec = { algName: "IvParamsSpec", iv: ivBlob };
    return ivParamsSpec;
  }


  /**
   * 生成GcmParamsSpec
   */
  static generateGcmParamsSpec(): cryptoFramework.GcmParamsSpec {
    let ivBlob: cryptoFramework.DataBlob = { data: CryptoHelper.getRandomUint8Array(12) };
    let aadBlob: cryptoFramework.DataBlob = { data: CryptoHelper.getRandomUint8Array(8) };
    let tagBlob: cryptoFramework.DataBlob = { data: CryptoHelper.getRandomUint8Array(16) };
    //GCM的authTag在加密时从doFinal结果中获取，在解密时填入init函数的params参数中
    let gcmParamsSpec: cryptoFramework.GcmParamsSpec = {
      iv: ivBlob,
      aad: aadBlob,
      authTag: tagBlob,
      algName: "GcmParamsSpec"
    };
    return gcmParamsSpec;
  }


  /**
   * 获取转换GcmParamsSpec
   */
  static getGcmParamsSpec(iv: Uint8Array, aad: Uint8Array, authTag: Uint8Array): cryptoFramework.GcmParamsSpec {
    //GCM的authTag在加密时从doFinal结果中获取，在解密时填入init函数的params参数中
    let gcmParamsSpec: cryptoFramework.GcmParamsSpec = {
      iv: { data: iv },
      aad: { data: aad },
      authTag: { data: authTag },
      algName: "GcmParamsSpec"
    };
    return gcmParamsSpec;
  }


  /**
   * 对数据进行签名，异步
   * @param dataBlob 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、ECC256|SHA256、SM2_256|SM3、、等）。
   * @returns
   */
  static async sign(dataBlob: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey, algName: string): Promise<cryptoFramework.DataBlob> {
    let signer = cryptoFramework.createSign(algName);
    await signer.init(priKey);
    let signData = await signer.sign(dataBlob);
    return signData;
  }

  /**
   * 对数据进行签名，同步
   * @param dataBlob 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、ECC256|SHA256、SM2_256|SM3、、等）。
   * @returns
   */
  static signSync(dataBlob: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey, algName: string): cryptoFramework.DataBlob {
    let signer = cryptoFramework.createSign(algName);
    signer.initSync(priKey);
    let signData = signer.signSync(dataBlob);
    return signData;
  }


  /**
   * 对数据进行验签，异步
   * @param dataBlob 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、ECC256|SHA256、SM2_256|SM3、、等）。
   * @returns
   */
  static async verify(dataBlob: cryptoFramework.DataBlob, signDataBlob: cryptoFramework.DataBlob,
    pubKey: cryptoFramework.PubKey, algName: string): Promise<boolean> {
    let verifier = cryptoFramework.createVerify(algName);
    await verifier.init(pubKey);
    let res = await verifier.verify(dataBlob, signDataBlob);
    return res;
  }

  /**
   * 对数据进行验签，同步
   * @param dataBlob 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、ECC256|SHA256、SM2_256|SM3、、等）。
   * @returns
   */
  static verifySync(dataBlob: cryptoFramework.DataBlob, signDataBlob: cryptoFramework.DataBlob,
    pubKey: cryptoFramework.PubKey, algName: string): boolean {
    let verifier = cryptoFramework.createVerify(algName);
    verifier.initSync(pubKey);
    let res = verifier.verifySync(dataBlob, signDataBlob);
    return res;
  }


  /**
   * 对数据进行分段签名，异步
   * @param data 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、ECC256|SHA256、SM2_256|SM3、、等）。
   * @param len 自定义的数据拆分长度。
   * @returns
   */
  static async signSegment(data: Uint8Array, priKey: cryptoFramework.PriKey, algName: string, len: number): Promise<cryptoFramework.DataBlob> {
    let signer = cryptoFramework.createSign(algName);
    await signer.init(priKey);
    for (let i = 0; i < data.length; i += len) {
      let updateData = data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      await signer.update(updateDataBlob); //分段update
    }
    //已通过分段传入所有明文，故此处sign传入null
    let signData = await signer.sign(null);
    return signData;
  }

  /**
   * 对数据进行分段签名，同步
   * @param data 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、ECC256|SHA256、SM2_256|SM3、、等）。
   * @param len 自定义的数据拆分长度。
   * @returns
   */
  static signSegmentSync(data: Uint8Array, priKey: cryptoFramework.PriKey, algName: string, len: number): cryptoFramework.DataBlob {
    let signer = cryptoFramework.createSign(algName);
    signer.initSync(priKey);
    for (let i = 0; i < data.length; i += len) {
      let updateData = data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      signer.updateSync(updateDataBlob); //分段update
    }
    //已通过分段传入所有明文，故此处sign传入null
    let signData = signer.signSync(null);
    return signData;
  }


  /**
   * 对数据进行分段验签，异步
   * @param data 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、ECC256|SHA256、SM2_256|SM3、、等）。
   * @param len 自定义的数据拆分长度。
   * @returns
   */
  static async verifySegment(data: Uint8Array, signDataBlob: cryptoFramework.DataBlob,
    pubKey: cryptoFramework.PubKey, algName: string, len: number): Promise<boolean> {
    let verifier = cryptoFramework.createVerify(algName);
    await verifier.init(pubKey);
    for (let i = 0; i < data.length; i += len) {
      let updateData = data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      await verifier.update(updateDataBlob); //分段update
    }
    //已通过分段传入所有明文，故此处verify第一个参数传入null
    let res = await verifier.verify(null, signDataBlob);
    return res;
  }

  /**
   * 对数据进行分段验签，同步
   * @param data 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（RSA1024|PKCS1|SHA256、RSA2048|PKCS1|SHA256、ECC256|SHA256、SM2_256|SM3、、等）。
   * @param len 自定义的数据拆分长度。
   * @returns
   */
  static verifySegmentSync(data: Uint8Array, signDataBlob: cryptoFramework.DataBlob,
    pubKey: cryptoFramework.PubKey, algName: string, len: number): boolean {
    let verifier = cryptoFramework.createVerify(algName);
    verifier.initSync(pubKey);
    for (let i = 0; i < data.length; i += len) {
      let updateData = data.subarray(i, i + len);
      let updateDataBlob: cryptoFramework.DataBlob = { data: updateData };
      verifier.updateSync(updateDataBlob); //分段update
    }
    //已通过分段传入所有明文，故此处verify第一个参数传入null
    let res = verifier.verifySync(null, signDataBlob);
    return res;
  }


  /**
   * 密钥协商，异步
   * @param algName 密钥协商算法规格（ECC256、X25519、DH_modp1536、等）
   * @param pubKey 公钥（一般为外部传入）
   * @param priKey 私钥
   * @param coding 编码方式(base64/hex/utf8/utf-8)
   * @returns 共享密钥
   */
  static async dynamicKey(algName: string, pubKey: Uint8Array | string, priKey: Uint8Array | string, coding: crypto.BhuCoding): Promise<string> {
    if (typeof pubKey === 'string') {
      pubKey = CryptoHelper.strToUint8Array(pubKey, coding);
    }
    if (typeof priKey === 'string') {
      priKey = CryptoHelper.strToUint8Array(priKey, coding);
    }
    let asyKeyGenerator = cryptoFramework.createAsyKeyGenerator(algName); //非对称密钥生成器的对象。
    let keyPairA = await asyKeyGenerator.convertKey({ data: pubKey }, null); //转换公私钥
    let keyPairB = await asyKeyGenerator.convertKey(null, { data: priKey }); //转换私钥
    let keyAgreement = cryptoFramework.createKeyAgreement(algName); //使用密钥协商方法之前需要创建该实例进行操作
    let secret = await keyAgreement.generateSecret(keyPairB.priKey, keyPairA.pubKey); //传入的私钥与公钥进行密钥协商
    if (secret.data) {
      return CryptoHelper.uint8ArrayToStr(secret.data, coding);
    }
    return "";
  }

  /**
   * 密钥协商，同步
   * @param algName 密钥协商算法规格（ECC256、X25519、DH_modp1536、等）
   * @param pubKey 公钥（一般为外部传入）
   * @param priKey 私钥
   * @param coding 编码方式(base64/hex/utf8/utf-8)
   * @returns 共享密钥
   */
  static dynamicKeySync(algName: string, pubKey: Uint8Array | string, priKey: Uint8Array | string, coding: crypto.BhuCoding): string {
    if (typeof pubKey === 'string') {
      pubKey = CryptoHelper.strToUint8Array(pubKey, coding);
    }
    if (typeof priKey === 'string') {
      priKey = CryptoHelper.strToUint8Array(priKey, coding);
    }
    let asyKeyGenerator = cryptoFramework.createAsyKeyGenerator(algName); //非对称密钥生成器的对象。
    let keyPairA = asyKeyGenerator.convertKeySync({ data: pubKey }, null); //转换公私钥
    let keyPairB = asyKeyGenerator.convertKeySync(null, { data: priKey }); //转换私钥
    let keyAgreement = cryptoFramework.createKeyAgreement(algName); //使用密钥协商方法之前需要创建该实例进行操作
    let secret = keyAgreement.generateSecretSync(keyPairB.priKey, keyPairA.pubKey); //传入的私钥与公钥进行密钥协商
    if (secret.data) {
      return CryptoHelper.uint8ArrayToStr(secret.data, coding);
    }
    return "";
  }


  /**
   * 摘要，异步
   * @param data 待摘要的数据
   * @param algName 摘要算法名（SHA1、SHA224、SHA256、SHA384、SHA512、MD5、SM3）。
   * @param resultCoding 摘要的编码方式(base64/hex)
   * @returns
   */
  static async digest(data: string, algName: string, resultCoding: crypto.BhCoding = 'hex'): Promise<string> {
    let md = cryptoFramework.createMd(algName);
    //数据量较少时，可以只做一次update，将数据全部传入，接口未对入参长度做限制
    await md.update({ data: CryptoHelper.strToUint8Array(data, 'utf-8') });
    let dataBlob = await md.digest();
    let result = CryptoHelper.uint8ArrayToStr(dataBlob.data, resultCoding);
    return result;
  }

  /**
   * 摘要，同步
   * @param data 待摘要的数据
   * @param algName 摘要算法名（SHA1、SHA224、SHA256、SHA384、SHA512、MD5、SM3）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @returns
   */
  static digestSync(data: string, algName: string, resultCoding: crypto.BhCoding = 'hex'): string {
    let md = cryptoFramework.createMd(algName);
    //数据量较少时，可以只做一次update，将数据全部传入，接口未对入参长度做限制
    md.updateSync({ data: CryptoHelper.strToUint8Array(data, 'utf-8') });
    let dataBlob = md.digestSync();
    let result = CryptoHelper.uint8ArrayToStr(dataBlob.data, resultCoding);
    return result;
  }


  /**
   * 摘要，分段，同步
   * @param data 待摘要的数据
   * @param algName 摘要算法名（SHA1、SHA224、SHA256、SHA384、SHA512、MD5、SM3）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   * @returns
   */
  static async digestSegment(data: string, algName: string, resultCoding: crypto.BhCoding = 'hex', len: number = 128): Promise<string> {
    let md = cryptoFramework.createMd(algName);
    let messageData = CryptoHelper.strToUint8Array(data, 'utf-8');
    for (let i = 0; i < messageData.length; i += len) {
      let updateMessage = messageData.subarray(i, i + len);
      let updateMessageBlob: cryptoFramework.DataBlob = { data: updateMessage };
      await md.update(updateMessageBlob);
    }
    let dataBlob = await md.digest();
    let result = CryptoHelper.uint8ArrayToStr(dataBlob.data, resultCoding);
    return result;
  }

  /**
   * 摘要，分段，同步
   * @param data 待摘要的数据
   * @param algName 摘要算法名（SHA1、SHA224、SHA256、SHA384、SHA512、MD5、SM3）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   * @returns
   */
  static digestSegmentSync(data: string, algName: string, resultCoding: crypto.BhCoding = 'hex', len: number = 128): string {
    let md = cryptoFramework.createMd(algName);
    let messageData = CryptoHelper.strToUint8Array(data, 'utf-8');
    for (let i = 0; i < messageData.length; i += len) {
      let updateMessage = messageData.subarray(i, i + len);
      let updateMessageBlob: cryptoFramework.DataBlob = { data: updateMessage };
      md.updateSync(updateMessageBlob);
    }
    let dataBlob = md.digestSync();
    let result = CryptoHelper.uint8ArrayToStr(dataBlob.data, resultCoding);
    return result;
  }


  /**
   * 消息认证码计算，异步
   * @param data 传入的消息
   * @param algName 指定摘要算法（SHA1、SHA224、SHA256、SHA384、SHA512、MD5、SM3）。
   * @param symKey 共享对称密钥（SymKey）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   */
  static async hmac(data: string, algName: string, symKey: cryptoFramework.SymKey,
    resultCoding: crypto.BhCoding = 'hex'): Promise<string> {
    let mac = cryptoFramework.createMac(algName);
    await mac.init(symKey); //使用对称密钥初始化Mac计算
    //数据量较少时，可以只做一次update，将数据全部传入，接口未对入参长度做限制
    await mac.update({ data: CryptoHelper.strToUint8Array(data, 'utf-8') }); //传入消息进行Mac更新计算
    let dataBlob = await mac.doFinal(); //通过注册回调函数返回Mac的计算结果
    let result = CryptoHelper.uint8ArrayToStr(dataBlob.data, resultCoding);
    return result;
  }

  /**
   * 消息认证码计算，同步
   * @param data 传入的消息
   * @param algName 指定摘要算法（SHA1、SHA224、SHA256、SHA384、SHA512、MD5、SM3）。
   * @param symKey 共享对称密钥（SymKey）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   */
  static hmacSync(data: string, algName: string, symKey: cryptoFramework.SymKey,
    resultCoding: crypto.BhCoding = 'hex'): string {
    let mac = cryptoFramework.createMac(algName);
    mac.initSync(symKey); //使用对称密钥初始化Mac计算
    //数据量较少时，可以只做一次update，将数据全部传入，接口未对入参长度做限制
    mac.updateSync({ data: CryptoHelper.strToUint8Array(data, 'utf-8') }); //传入消息进行Mac更新计算
    let dataBlob = mac.doFinalSync(); //通过注册回调函数返回Mac的计算结果
    let result = CryptoHelper.uint8ArrayToStr(dataBlob.data, resultCoding);
    return result;
  }


  /**
   * 消息认证码计算，分段，异步
   * @param data 传入的消息
   * @param algName 指定摘要算法（SHA1、SHA224、SHA256、SHA384、SHA512、MD5、SM3）。
   * @param symKey 共享对称密钥（SymKey）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   */
  static async hmacSegment(data: string, algName: string, symKey: cryptoFramework.SymKey,
    resultCoding: crypto.BhCoding = 'hex', len: number = 128): Promise<string> {
    let messageData = CryptoHelper.strToUint8Array(data, 'utf-8');
    let mac = cryptoFramework.createMac(algName);
    await mac.init(symKey); //使用对称密钥初始化Mac计算
    for (let i = 0; i < messageData.length; i += len) {
      let updateMessage = messageData.subarray(i, i + len);
      let updateMessageBlob: cryptoFramework.DataBlob = { data: updateMessage };
      await mac.update(updateMessageBlob); //传入消息进行Mac更新计算
    }
    let dataBlob = await mac.doFinal(); //通过注册回调函数返回Mac的计算结果
    let result = CryptoHelper.uint8ArrayToStr(dataBlob.data, resultCoding);
    return result;
  }

  /**
   * 消息认证码计算，分段，同步
   * @param data 传入的消息
   * @param algName 指定摘要算法（SHA1、SHA224、SHA256、SHA384、SHA512、MD5、SM3）。
   * @param symKey 共享对称密钥（SymKey）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   */
  static hmacSegmentSync(data: string, algName: string, symKey: cryptoFramework.SymKey,
    resultCoding: crypto.BhCoding = 'hex', len: number = 128): string {
    if (typeof symKey === 'string') {
      symKey = CryptoUtil.generateSymKeySync(symKey); //生成对称密钥
    }
    let messageData = CryptoHelper.strToUint8Array(data, 'utf-8');
    let mac = cryptoFramework.createMac(algName);
    mac.initSync(symKey); //使用对称密钥初始化Mac计算
    for (let i = 0; i < messageData.length; i += len) {
      let updateMessage = messageData.subarray(i, i + len);
      let updateMessageBlob: cryptoFramework.DataBlob = { data: updateMessage };
      mac.updateSync(updateMessageBlob); //传入消息进行Mac更新计算
    }
    let dataBlob = mac.doFinalSync(); //通过注册回调函数返回Mac的计算结果
    let result = CryptoHelper.uint8ArrayToStr(dataBlob.data, resultCoding);
    return result;
  }



}