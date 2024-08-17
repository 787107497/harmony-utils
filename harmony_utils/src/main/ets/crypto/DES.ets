import cryptoFramework from '@ohos.security.cryptoFramework';
import { CryptoUtil } from './CryptoUtil';

/**
 * TODO DES加解密
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class DES {

  /**
   * 加密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static async encryptECB(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): Promise<cryptoFramework.DataBlob> {
    return DES.encrypt(data, symKey, '3DES192|ECB|PKCS7');
  }

  /**
   * 加密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static encryptECBSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): cryptoFramework.DataBlob {
    return DES.encryptSync(data, symKey, '3DES192|ECB|PKCS7');
  }


  /**
   * 解密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static async decryptECB(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): Promise<cryptoFramework.DataBlob> {
    return DES.decrypt(data, symKey, '3DES192|ECB|PKCS7');
  }

  /**
   * 解密（ECB模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static decryptECBSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): cryptoFramework.DataBlob {
    return DES.decryptSync(data, symKey, '3DES192|ECB|PKCS7');
  }


  /**
   * 加密（CBC模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static async encryptCBC(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): Promise<cryptoFramework.DataBlob> {
    return DES.encrypt(data, symKey, '3DES192|CBC|PKCS7');
  }

  /**
   * 加密（CBC模式）,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static encryptCBCSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): cryptoFramework.DataBlob {
    return DES.encryptSync(data, symKey, '3DES192|CBC|PKCS7');
  }


  /**
   * 解密（CBC模式）,异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @returns
   */
  static async decryptCBC(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): Promise<cryptoFramework.DataBlob> {
    return DES.decrypt(data, symKey, '3DES192|CBC|PKCS7');
  }

  /**
   * 解密（CBC模式）,同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（AES256|CBC|PKCS7、AES192|CBC|PKCS7、AES128|CBC|PKCS7）。
   * @returns
   */
  static decryptCBCSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey): cryptoFramework.DataBlob {
    return DES.decryptSync(data, symKey, '3DES192|CBC|PKCS7');
  }


  /**
   * 加密，异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（3DES192|ECB|PKCS7、3DES192|CBC|PKCS7、等）。
   * @returns
   */
  static async encrypt(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey, transformation: string): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.encrypt(data, symKey, null, transformation);
  }

  /**
   * 加密，同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（3DES192|ECB|PKCS7、3DES192|CBC|PKCS7、等）。
   * @returns
   */
  static encryptSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey, transformation: string): cryptoFramework.DataBlob {
    return CryptoUtil.encryptSync(data, symKey, null, transformation);
  }


  /**
   * 解密，异步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（3DES192|ECB|PKCS7、3DES192|CBC|PKCS7、等）。
   * @returns
   */
  static async decrypt(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey, transformation: string): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.decrypt(data, symKey, null, transformation);
  }

  /**
   * 解密，同步
   * @param data 加密或者解密的数据。data不能为null。
   * @param symKey 指定加密或解密的密钥。
   * @param transformation 待生成Cipher的算法名称（含密钥长度）、加密模式以及填充方法的组合（3DES192|ECB|PKCS7、3DES192|CBC|PKCS7、等）。
   * @returns
   */
  static decryptSync(data: cryptoFramework.DataBlob, symKey: cryptoFramework.SymKey, transformation: string): cryptoFramework.DataBlob {
    return CryptoUtil.decryptSync(data, symKey, null, transformation);
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