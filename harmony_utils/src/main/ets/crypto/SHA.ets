import { crypto } from './crypto';
import { CryptoUtil } from './CryptoUtil';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';

/**
 * SHA工具类
 */
export class SHA{

  /**
   * SHA摘要，同步
   * @param data 待摘要的数据
   * @param algName 摘要算法名（SHA1、SHA224、SHA256、SHA384、SHA512）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @returns
   */
  static async digest(data: string, algName: crypto.SHA = 'SHA256',
    resultCoding: crypto.BhCoding = 'hex'): Promise<string> {
    return CryptoUtil.digest(data, algName, resultCoding);
  }

  /**
   * SHA摘要，同步
   * @param data 待摘要的数据
   * @param algName 摘要算法名（SHA1、SHA224、SHA256、SHA384、SHA512）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @returns
   */
  static digestSync(data: string, algName: crypto.SHA = 'SHA256',
    resultCoding: crypto.BhCoding = 'hex'): string {
    return CryptoUtil.digestSync(data, algName, resultCoding);
  }


  /**
   * SHA摘要，分段，同步
   * @param data 待摘要的数据
   * @param algName 摘要算法名（SHA1、SHA224、SHA256、SHA384、SHA512）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   * @returns
   */
  static async digestSegment(data: string, algName: crypto.SHA = 'SHA256',
    resultCoding: crypto.BhCoding = 'hex', len: number = 120): Promise<string> {
    return CryptoUtil.digestSegment(data, algName, resultCoding, len);
  }

  /**
   * SHA摘要，分段，同步
   * @param data 待摘要的数据
   * @param algName 摘要算法名（SHA1、SHA224、SHA256、SHA384、SHA512）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   * @returns
   */
  static digestSegmentSync(data: string, algName: crypto.SHA = 'SHA256',
    resultCoding: crypto.BhCoding = 'hex', len: number = 120): string {
    return CryptoUtil.digestSegmentSync(data, algName, resultCoding, len);
  }


  /**
   * 消息认证码计算，异步
   * @param data 传入的消息
   * @param algName 指定摘要算法（SHA1、SHA224、SHA256、SHA384、SHA512）。
   * @param symKey 共享对称密钥, 当symKey为string时，生成对称密钥（AES128、AES256）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   */
  static async hmac(data: string, algName: crypto.SHA = 'SHA256', symKey: cryptoFramework.SymKey | string = 'AES256',
    resultCoding: crypto.BhCoding = 'hex'): Promise<string> {
    return CryptoUtil.hmac(data, algName, symKey, resultCoding);
  }

  /**
   * 消息认证码计算，同步
   * @param data 传入的消息
   * @param algName 指定摘要算法（SHA1、SHA224、SHA256、SHA384、SHA512）。
   * @param symKey 共享对称密钥, 当symKey为string时，生成对称密钥（AES128、AES256）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   */
  static hmacSync(data: string, algName: crypto.SHA = 'SHA256', symKey: cryptoFramework.SymKey | string = 'AES256',
    resultCoding: crypto.BhCoding = 'hex'): string {
    return CryptoUtil.hmacSync(data, algName, symKey, resultCoding);
  }


  /**
   * 消息认证码计算，分段，异步
   * @param data 传入的消息
   * @param algName 指定摘要算法（SHA1、SHA224、SHA256、SHA384、SHA512）。
   * @param symKey 共享对称密钥, 当symKey为string时，生成对称密钥（AES128、AES256）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   */
  static async hmacSegment(data: string, algName: crypto.SHA = 'SHA256',
    symKey: cryptoFramework.SymKey | string = 'AES256', resultCoding: crypto.BhCoding = 'hex',
    len: number = 120): Promise<string> {
    return CryptoUtil.hmacSegment(data, algName, symKey, resultCoding, len);
  }

  /**
   * 消息认证码计算，分段，同步
   * @param data 传入的消息
   * @param algName 指定摘要算法（SHA1、SHA224、SHA256、SHA384、SHA512）。
   * @param symKey 共享对称密钥, 当symKey为string时，生成对称密钥（AES128、AES256）。
   * @param resultCoding 摘要的编码方式（base64/hex），默认不传为hex。
   * @param len 自定义的数据拆分长度
   */
  static hmacSegmentSync(data: string, algName: crypto.SHA = 'SHA256',
    symKey: cryptoFramework.SymKey | string = 'AES256', resultCoding: crypto.BhCoding = 'hex',
    len: number = 120): string {
    return CryptoUtil.hmacSegmentSync(data, algName, symKey, resultCoding, len);
  }


}
