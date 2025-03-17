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

import util from '@ohos.util';

/**
 * TODO Base64工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class Base64Util {


  /**
   * 编码，通过输入参数编码后输出Uint8Array对象。
   * @param array
   * @returns
   */
  static encode(array: Uint8Array): Promise<Uint8Array> {
    const base64 = new util.Base64Helper();
    return base64.encode(array);
  }

  /**
   * 编码，通过输入参数编码后输出Uint8Array对象。
   * @param array
   * @returns
   */
  static encodeSync(array: Uint8Array): Uint8Array {
    const base64 = new util.Base64Helper();
    const result = base64.encodeSync(array);
    return result;
  }


  /**
   * 编码，通过输入参数编码后输出对应文本。
   * @param array
   * @returns
   */
  static encodeToStr(array: Uint8Array, options?: util.Type): Promise<string> {
    const base64 = new util.Base64Helper();
    return base64.encodeToString(array, options);
  }

  /**
   * 编码，通过输入参数编码后输出对应文本。
   * @param array
   * @returns
   */
  static encodeToStrSync(array: Uint8Array, options?: util.Type): string {
    const base64 = new util.Base64Helper();
    const result = base64.encodeToStringSync(array, options);
    return result;
  }


  /**
   * 解码，通过输入参数解码后输出对应Uint8Array对象。
   * @param array
   * @returns
   */
  static decode(array: Uint8Array | string, options?: util.Type): Promise<Uint8Array> {
    const base64 = new util.Base64Helper();
    return base64.decode(array, options);
  }

  /**
   * 解码，通过输入参数解码后输出对应Uint8Array对象。
   * @param array
   * @returns
   */
  static decodeSync(array: Uint8Array | string, options?: util.Type): Uint8Array {
    const base64 = new util.Base64Helper();
    const result = base64.decodeSync(array, options);
    return result;
  }


}