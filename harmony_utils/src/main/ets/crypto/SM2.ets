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
import { BusinessError } from '@kit.BasicServicesKit';
import { buffer } from '@kit.ArkTS';
import { CryptoUtil } from './CryptoUtil';
import { crypto } from './crypto';
import { CryptoHelper } from './CryptoHelper';
import { LogUtil } from '../utils/LogUtil';
import { StrUtil } from '../utils/StrUtil';

/**
 * TODO SM2加解密
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 */
export class SM2 {


  /**
   * 加密,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param pubKey 指定加密公钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合，默认SM2_256|SM3。
   * @returns
   */
  static async encrypt(data: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey,
    transformation: string = 'SM2_256|SM3'): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.encrypt(data, pubKey, null, transformation);
  }

  /**
   * 加密,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param pubKey 指定加密公钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合。
   * @returns
   */
  static encryptSync(data: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey,
    transformation: string = 'SM2_256|SM3'): cryptoFramework.DataBlob {
    return CryptoUtil.encryptSync(data, pubKey, null, transformation);
  }


  /**
   * 解密，异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合。
   * @param priKey 指定解密私钥。
   */
  static async decrypt(data: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey,
    transformation: string = 'SM2_256|SM3'): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.decrypt(data, priKey, null, transformation);
  }

  /**
   * 解密，同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param priKey 指定解密私钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合。
   */
  static decryptSync(data: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey,
    transformation: string = 'SM2_256|SM3'): cryptoFramework.DataBlob {
    return CryptoUtil.decryptSync(data, priKey, null, transformation);
  }


  /**
   * 生成非对称密钥KeyPair，异步
   * @param algName 待生成对称密钥生成器的算法名称（SM2_256、SM2）
   * @returns
   */
  static async generateKeyPair(algName: string = 'SM2_256'): Promise<cryptoFramework.KeyPair> {
    return CryptoUtil.generateKeyPair(algName);
  }

  /**
   * 生成非对称密钥KeyPair，同步
   * @param algName 待生成对称密钥生成器的算法名称（SM2_256、SM2）
   * @returns
   */
  static generateKeyPairSync(algName: string = 'SM2_256'): cryptoFramework.KeyPair {
    return CryptoUtil.generateKeyPairSync(algName);
  }


  /**
   * 获取转换的非对称密钥KeyPair，异步
   * @param pubKey 公钥字符串
   * @param priKey 私钥字符串
   * @param keyCoding 秘钥的编码方式(base64/hex/utf8/utf-8)
   * @param algName 待生成对称密钥生成器的算法名称（SM2_256、SM2）
   * @returns
   */
  static async getConvertKeyPair(pubKey: string | Uint8Array | cryptoFramework.DataBlob | null,
    priKey: string | Uint8Array | cryptoFramework.DataBlob | null, keyCoding: crypto.BhuCoding,
    algName: string = 'SM2_256'): Promise<cryptoFramework.KeyPair> {
    return CryptoUtil.getConvertKeyPair(algName, pubKey, priKey, keyCoding);
  }

  /**
   * 获取转换的非对称密钥KeyPair，同步
   * @param pubKey 公钥字符串
   * @param priKey 私钥字符串
   * @param keyCoding 秘钥的编码方式(base64/hex/utf8/utf-8)
   * @param algName 待生成对称密钥生成器的算法名称（SM2_256、SM2）
   * @returns
   */
  static getConvertKeyPairSync(pubKey: string | Uint8Array | cryptoFramework.DataBlob | null,
    priKey: string | Uint8Array | cryptoFramework.DataBlob | null, keyCoding: crypto.BhuCoding,
    algName: string = 'SM2_256'): cryptoFramework.KeyPair {
    return CryptoUtil.getConvertKeyPairSync(algName, pubKey, priKey, keyCoding);
  }


  /**
   * 获取转换SM2公钥, 将16进制的C1C2C3格式的SM2公钥转换为鸿蒙所需的ASN.1格式公钥字符串
   * @param pubKey 16进制的公钥字符串
   * @returns 转换后的公钥字符串
   */
  static getSM2PubKey(strPubKey: string): cryptoFramework.PubKey {
    strPubKey = strPubKey.startsWith("04") ? strPubKey.slice(2) : strPubKey;
    let px = strPubKey.substring(0, strPubKey.length / 2); //截取x参数
    let py = strPubKey.substring(strPubKey.length / 2); //截取y参数
    //转16进制放入对应的位置 04+x+y
    let pk: cryptoFramework.Point = {
      x: BigInt("0x" + px),
      y: BigInt("0x" + py)
    }
    //构建SM2公钥参数对象
    let keyPair: cryptoFramework.ECCPubKeySpec = {
      params: cryptoFramework.ECCKeyUtil.genECCCommonParamsSpec('NID_sm2'),
      pk: pk,
      algName: 'SM2',
      specType: cryptoFramework.AsyKeySpecType.PUBLIC_KEY_SPEC
    }
    let keyPairGenerator = cryptoFramework.createAsyKeyGeneratorBySpec(keyPair); //创建密钥生成器
    let pubKey: cryptoFramework.PubKey = keyPairGenerator.generatePubKeySync(); //生成uint8Array格式密钥,转换成鸿蒙所需公钥
    return pubKey;
  }


  /**
   * 获取转换SM2私钥
   * @param key 传入的密钥数据，未序列化的原始裸数据
   * @returns
   */
  static getSM2PriKey(key: string): cryptoFramework.PriKey {
    key = StrUtil.startsWith(key, "0x") ? key : `0x${key}`;
    let sk: bigint = BigInt(key);
    let priKey: cryptoFramework.ECCPriKeySpec = {
      params: cryptoFramework.ECCKeyUtil.genECCCommonParamsSpec('NID_sm2'),
      sk: sk,
      algName: "SM2",
      specType: cryptoFramework.AsyKeySpecType.PRIVATE_KEY_SPEC
    }
    let KeyPairGenerator = cryptoFramework.createAsyKeyGeneratorBySpec(priKey);
    return KeyPairGenerator.generatePriKeySync();
  }


  /**
   * 获取转换SM2密文格式，ASN.1格式转换为C1C2C3或C1C3C2
   * @param cipherText  ASN.1格式的SM2密文参数
   * @param cipherMode  0-C1C2C3 、1-C1C3C2，默认为0
   * @returns
   */
  static getCipherTextSpec(cipherText: cryptoFramework.DataBlob, mode: number = 0): string {
    try {
      let spec: cryptoFramework.SM2CipherTextSpec =
        cryptoFramework.SM2CryptoUtil.getCipherTextSpec(cipherText, 'C1C3C2');
      let startPre = "04";
      // bigint 转十六进制需要补零，参考BC转换
      let c1x = CryptoHelper.toHexWithPaddingZero(spec.xCoordinate);
      let c1y = CryptoHelper.toHexWithPaddingZero(spec.yCoordinate);
      let c3 = buffer.from(spec.hashData).toString('hex');
      let c2 = buffer.from(spec.cipherTextData).toString('hex');
      if (mode === 0) {
        return (startPre + c1x + c1y + c2 + c3).toUpperCase();
      } else {
        return (startPre + c1x + c1y + c3 + c2).toUpperCase();
      }
    } catch (err) {
      let e: BusinessError = err as BusinessError;
      LogUtil.error(`getCipherTextSpec error, ${e.code}, ${e.message}`);
    }
    return "";
  }


  /**
   * 对数据进行签名，异步
   * @param dataBlob 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（SM2_256|SM3、SM2|SM3）。
   * @returns
   */
  static async sign(dataBlob: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey,
    algName: string = 'SM2_256|SM3'): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.sign(dataBlob, priKey, algName);
  }

  /**
   * 对数据进行签名，同步
   * @param dataBlob 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（SM2_256|SM3、SM2|SM3）。
   * @returns
   */
  static signSync(dataBlob: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey,
    algName: string = 'SM2_256|SM3'): cryptoFramework.DataBlob {
    return CryptoUtil.signSync(dataBlob, priKey, algName);
  }


  /**
   * 对数据进行验签，异步
   * @param dataBlob 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（SM2_256|SM3、SM2|SM3）。
   * @returns
   */
  static async verify(dataBlob: cryptoFramework.DataBlob, signDataBlob: cryptoFramework.DataBlob,
    pubKey: cryptoFramework.PubKey, algName: string = 'SM2_256|SM3'): Promise<boolean> {
    return CryptoUtil.verify(dataBlob, signDataBlob, pubKey, algName);
  }

  /**
   * 对数据进行验签，同步
   * @param dataBlob 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（SM2_256|SM3、SM2|SM3）。
   * @returns
   */
  static verifySync(dataBlob: cryptoFramework.DataBlob, signDataBlob: cryptoFramework.DataBlob,
    pubKey: cryptoFramework.PubKey, algName: string = 'SM2_256|SM3'): boolean {
    return CryptoUtil.verifySync(dataBlob, signDataBlob, pubKey, algName);
  }


  /**
   * 对数据进行分段签名，异步
   * @param data 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（SM2_256|SM3、SM2|SM3）。
   * @param len 自定义的数据拆分长度，此处取128
   * @returns
   */
  static async signSegment(data: Uint8Array, priKey: cryptoFramework.PriKey, algName: string = 'SM2_256|SM3',
    len: number = 128): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.signSegment(data, priKey, algName, len);
  }

  /**
   * 对数据进行分段签名，同步
   * @param data 待签名数据
   * @param priKey 私钥
   * @param algName 指定签名算法（SM2_256|SM3、SM2|SM3）。
   * @param len 自定义的数据拆分长度，此处取64
   * @returns
   */
  static signSegmentSync(data: Uint8Array, priKey: cryptoFramework.PriKey, algName: string = 'SM2_256|SM3',
    len: number = 128): cryptoFramework.DataBlob {
    return CryptoUtil.signSegmentSync(data, priKey, algName, len);
  }


  /**
   * 对数据进行分段验签，异步
   * @param data 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（SM2_256|SM3、SM2|SM3）。
   * @param len 自定义的数据拆分长度，此处取128
   * @returns
   */
  static async verifySegment(data: Uint8Array, signDataBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey,
    algName: string = 'SM2_256|SM3', len: number = 128): Promise<boolean> {
    return CryptoUtil.verifySegment(data, signDataBlob, pubKey, algName, len);
  }

  /**
   * 对数据进行分段验签，同步
   * @param data 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param algName 指定签名算法（SM2_256|SM3、SM2|SM3）。
   * @param len 自定义的数据拆分长度，此处取128
   * @returns
   */
  static verifySegmentSync(data: Uint8Array, signDataBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey,
    algName: string = 'SM2_256|SM3', len: number = 128): boolean {
    return CryptoUtil.verifySegmentSync(data, signDataBlob, pubKey, algName, len);
  }


}