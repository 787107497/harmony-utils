import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { CryptoUtil } from './CryptoUtil';
import { crypto } from './crypto';


/**
 * ECDSA密钥对签名验签
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class ECDSA{


  /**
   * 对数据进行签名，异步
   * @param dataBlob 待签名数据
   * @param priKey 私钥
   * @returns
   */
  static async sign(dataBlob: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.sign(dataBlob,priKey,'ECC256|SHA256')
  }

  /**
   * 对数据进行签名，同步
   * @param dataBlob 待签名数据
   * @param priKey 私钥
   * @returns
   */
  static signSync(dataBlob: cryptoFramework.DataBlob, priKey: cryptoFramework.PriKey): cryptoFramework.DataBlob {
    return CryptoUtil.signSync(dataBlob, priKey, 'ECC256|SHA256');
  }


  /**
   * 对数据进行验签，异步
   * @param dataBlob 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @returns
   */
  static async verify(dataBlob: cryptoFramework.DataBlob, signDataBlob: cryptoFramework.DataBlob,
    pubKey: cryptoFramework.PubKey): Promise<boolean> {
    return CryptoUtil.verify(dataBlob, signDataBlob, pubKey, 'ECC256|SHA256');
  }

  /**
   * 对数据进行验签，同步
   * @param dataBlob 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @returns
   */
  static verifySync(dataBlob: cryptoFramework.DataBlob, signDataBlob: cryptoFramework.DataBlob,
    pubKey: cryptoFramework.PubKey): boolean {
    return CryptoUtil.verifySync(dataBlob, signDataBlob, pubKey, 'ECC256|SHA256');
  }


  /**
   * 对数据进行分段签名，异步
   * @param data 待签名数据
   * @param priKey 私钥
   * @param len 自定义的数据拆分长度，此处取64
   * @returns
   */
  static async signSegment(data: Uint8Array, priKey: cryptoFramework.PriKey, len: number = 64): Promise<cryptoFramework.DataBlob> {
    return CryptoUtil.signSegment(data, priKey, 'ECC256|SHA256', len);
  }

  /**
   * 对数据进行分段签名，同步
   * @param data 待签名数据
   * @param priKey 私钥
   * @param len 自定义的数据拆分长度，此处取64
   * @returns
   */
  static signSegmentSync(data: Uint8Array, priKey: cryptoFramework.PriKey, len: number = 64): cryptoFramework.DataBlob {
    return CryptoUtil.signSegmentSync(data, priKey, 'ECC256|SHA256', len);
  }


  /**
   * 对数据进行分段验签，异步
   * @param data 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param len 自定义的数据拆分长度，此处取64
   * @returns
   */
  static async verifySegment(data: Uint8Array, signDataBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey,
    len: number = 64): Promise<boolean> {
    return CryptoUtil.verifySegment(data, signDataBlob, pubKey, 'ECC256|SHA256', len);
  }

  /**
   * 对数据进行分段验签，同步
   * @param data 待验签数据
   * @param signDataBlob 签名数据
   * @param pubKey 公钥
   * @param len 自定义的数据拆分长度，此处取64
   * @returns
   */
  static verifySegmentSync(data: Uint8Array, signDataBlob: cryptoFramework.DataBlob, pubKey: cryptoFramework.PubKey,
    len: number = 64): boolean {
    return CryptoUtil.verifySegmentSync(data, signDataBlob, pubKey, 'ECC256|SHA256', len);
  }


}