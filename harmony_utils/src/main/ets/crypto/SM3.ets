import { crypto } from './crypto';
import { CryptoUtil } from './CryptoUtil';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';

/**
 * SM3工具类
 */
export class SM3 {


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
  static async digestSegment(data: string, resultCoding: crypto.BhCoding = 'hex', len: number = 120): Promise<string> {
    return CryptoUtil.digestSegment(data, 'SM3', resultCoding, len);
  }

  /**
   * SM3摘要，分段，同步
   * @param data 待摘要的数据
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   * @returns
   */
  static digestSegmentSync(data: string, resultCoding: crypto.BhCoding = 'hex', len: number = 120): string {
    return CryptoUtil.digestSegmentSync(data, 'SM3', resultCoding, len);
  }


  /**
   * 消息认证码计算，异步
   * @param data 传入的消息
   * @param symKey 共享对称密钥, 当symKey为string时，生成对称密钥（AES128、AES256）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   */
  static async hmac(data: string, symKey: cryptoFramework.SymKey | string = 'AES256',
    resultCoding: crypto.BhCoding = 'hex'): Promise<string> {
    return CryptoUtil.hmac(data, 'SM3', symKey, resultCoding);
  }

  /**
   * 消息认证码计算，同步
   * @param data 传入的消息
   * @param symKey 共享对称密钥, 当symKey为string时，生成对称密钥（AES128、AES256）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   */
  static hmacSync(data: string, symKey: cryptoFramework.SymKey | string = 'AES256',
    resultCoding: crypto.BhCoding = 'hex'): string {
    return CryptoUtil.hmacSync(data, 'SM3', symKey, resultCoding);
  }


  /**
   * 消息认证码计算，分段，异步
   * @param data 传入的消息
   * @param symKey 共享对称密钥, 当symKey为string时，生成对称密钥（AES128、AES256）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   */
  static async hmacSegment(data: string, symKey: cryptoFramework.SymKey | string = 'AES256',
    resultCoding: crypto.BhCoding = 'hex', len: number = 120): Promise<string> {
    return CryptoUtil.hmacSegment(data, 'SM3', symKey, resultCoding, len);
  }

  /**
   * 消息认证码计算，分段，同步
   * @param data 传入的消息
   * @param symKey 共享对称密钥, 当symKey为string时，生成对称密钥（AES128、AES256）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   */
  static hmacSegmentSync(data: string, symKey: cryptoFramework.SymKey | string = 'AES256',
    resultCoding: crypto.BhCoding = 'hex', len: number = 120): string {
    return CryptoUtil.hmacSegmentSync(data, 'SM3', symKey, resultCoding, len);
  }


}
