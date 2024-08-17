import { crypto } from './crypto';
import { CryptoUtil } from './CryptoUtil';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';

/**
 * SM3工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
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
   * SM3摘要，分段，同步
   * @param data 待摘要的数据
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   * @returns
   */
  static async digestSegment(data: string, resultCoding: crypto.BhCoding = 'hex', len: number = 128): Promise<string> {
    return CryptoUtil.digestSegment(data, 'SM3', resultCoding, len);
  }

  /**
   * SM3摘要，分段，同步
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
