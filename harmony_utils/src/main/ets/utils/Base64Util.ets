import util from '@ohos.util';

/**
 * TODO Base64工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class Base64Util{

  private constructor() {}


  /**
   * 编码，通过输入参数编码后输出Uint8Array对象。
   * @param array
   * @returns
   */
  static encodeSync(array: Uint8Array): Uint8Array {
    let base64 = new util.Base64Helper();
    let result = base64.encodeSync(array);
    return result;
  }


  /**
   * 编码，通过输入参数编码后输出对应文本。
   * @param array
   * @returns
   */
  static encodeToStrSync(array: Uint8Array, options?: util.Type): string {
    let base64 = new util.Base64Helper();
    let result = base64.encodeToStringSync(array, options);
    return result;
  }

  /**
   * 解码，通过输入参数解码后输出对应Uint8Array对象。
   * @param array
   * @returns
   */
  static decodeSync(array: Uint8Array | string, options?: util.Type): Uint8Array {
    let base64 = new util.Base64Helper();
    let result = base64.decodeSync(array, options);
    return result;
  }


  /**
   * 编码，通过输入参数编码后输出Uint8Array对象。
   * @param array
   * @returns
   */
  static encode(array: Uint8Array): Promise<Uint8Array> {
    let base64 = new util.Base64Helper();
    return base64.encode(array);
  }


  /**
   * 编码，通过输入参数编码后输出对应文本。
   * @param array
   * @returns
   */
  static encodeToStr(array: Uint8Array, options?: util.Type): Promise<string> {
    let base64 = new util.Base64Helper();
    return base64.encodeToString(array, options);
  }

  /**
   * 解码，通过输入参数解码后输出对应Uint8Array对象。
   * @param array
   * @returns
   */
  static decode(array: Uint8Array | string, options?: util.Type): Promise<Uint8Array> {
    let base64 = new util.Base64Helper();
    return base64.decode(array, options);
  }


}