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


import { Any } from '../entity/constraint';
import { StrUtil } from './StrUtil';
import { util } from '@kit.ArkTS';


/**
 * TODO 类型检查工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/06/14
 */
export class TypeUtil {


  /**
   * 判断是否是Boolean类型
   */
  static isBoolean(value: Object): boolean {
    return typeof value === 'boolean';
  }

  /**
   * 判断是否是Number类型
   */
  static isNumber(value: Any): boolean {
    return typeof value === 'number';
  }

  /**
   * 判断是否是String类型
   */
  static isString(value: Any): boolean {
    return typeof value === 'string';
  }

  /**
   * 判断是否是Object类型
   */
  static isObject(value: Any): boolean {
    return typeof value === 'object';
  }

  /**
   * 判断是否是数组类型
   */
  static isArray(value: Any): boolean {
    return Array.isArray(value)
  }

  /**
   * 判断是否是Resource类型
   */
  static isResource(value: Any) {
    if (value) {
      const res = value as Resource;
      return StrUtil.isNotNull(res?.id) && StrUtil.isNotNull(res?.bundleName) && StrUtil.isNotNull(res?.moduleName);
    }
    return false;
  }

  /**
   * 判断是否是ResourceStr类型
   */
  static isResourceStr(value: Any) {
    return TypeUtil.isString(value) || TypeUtil.isResource(value);
  }


  /**
   * 判断是否是函数类型
   */
  static isFunction(value: Object): boolean {
    return typeof value === 'function';
  }


  /**
   * 检查是否为Map类型。
   * @param value
   * @returns
   */
  static isMap(value: Object): boolean {
    return new util.types().isMap(value);
  }

  /**
   * 检查是否为WeakMap类型。
   * @param value
   * @returns
   */
  static isWeakMap(value: Object): boolean {
    return new util.types().isWeakMap(value);
  }


  /**
   * 检查是否为Set类型。
   * @param value
   * @returns
   */
  static isSet(value: Object): boolean {
    return new util.types().isSet(value);
  }

  /**
   * 检查是否为WeakSet类型。
   * @param value
   * @returns
   */
  static isWeakSet(value: Object): boolean {
    return new util.types().isWeakSet(value);
  }


  /**
   * 检查是否为Date类型。
   * @param value
   * @returns
   */
  static isDate(value: Object): boolean {
    return new util.types().isDate(value);
  }


  /**
   * 检查是否为ArrayBuffer类型。
   * @param value
   * @returns
   */
  static isArrayBuffer(value: Object): boolean {
    return new util.types().isArrayBuffer(value);
  }

  /**
   * 检查是否为SharedArrayBuffer类型。
   * @param value
   * @returns
   */
  static isSharedArrayBuffer(value: Object): boolean {
    return new util.types().isSharedArrayBuffer(value);
  }

  /**
   * 检查是否为ArrayBuffer或SharedArrayBuffer类型。
   * @param value
   * @returns
   */
  static isAnyArrayBuffer(value: Object): boolean {
    return new util.types().isAnyArrayBuffer(value);
  }


  /**
   * 检查是否为Uint8Array数组类型。
   * @param value
   * @returns
   */
  static isUint8Array(value: Object): boolean {
    return new util.types().isUint8Array(value);
  }

  /**
   * 检查是否为Uint16Array数组类型。
   * @param value
   * @returns
   */
  static isUint16Array(value: Object): boolean {
    return new util.types().isUint16Array(value);
  }

  /**
   * 检查是否为Uint32Array数组类型。
   * @param value
   * @returns
   */
  static isUint32Array(value: Object): boolean {
    return new util.types().isUint32Array(value);
  }


  /**
   * 检查是否为Int8Array数组类型。
   * @param value
   * @returns
   */
  static isInt8Array(value: Object): boolean {
    return new util.types().isInt8Array(value);
  }

  /**
   * 检查是否为Int16Array数组类型。
   * @param value
   * @returns
   */
  static isInt16Array(value: Object): boolean {
    return new util.types().isInt16Array(value);
  }

  /**
   * 检查是否为Int32Array数组类型。
   * @param value
   * @returns
   */
  static isInt32Array(value: Object): boolean {
    return new util.types().isInt32Array(value);
  }


  /**
   * 检查是否为TypedArray类型。TypedArray类型，包括Int8Array、Int16Array、Int32Array、Uint8Array、Uint8ClampedArray、Uint16Array、Uint32Array、Float32Array、Float64Array、BigInt64Array、BigUint64Array。
   * @param value
   * @returns
   */
  static isTypedArray(value: Object): boolean {
    return new util.types().isTypedArray(value);
  }


  /**
   * 检查是否为异步函数类型。
   * @param value
   * @returns
   */
  static isAsyncFunction(value: Object): boolean {
    return new util.types().isAsyncFunction(value);
  }


  /**
   * 检查是否为Promise类型。
   * @param value
   * @returns
   */
  static isPromise(value: Object): boolean {
    return new util.types().isPromise(value);
  }


  /**
   * 检查是否为Proxy类型。
   * @param value
   * @returns
   */
  static isProxy(value: Object): boolean {
    return new util.types().isProxy(value);
  }


  /**
   * 检查是否为RegExp类型。
   * @param value
   * @returns
   */
  static isRegExp(value: Object): boolean {
    return new util.types().isRegExp(value);
  }


  /**
   * 检查是否为DataView类型。
   * @param value
   * @returns
   */
  static isDataView(value: Object): boolean {
    return new util.types().isDataView(value);
  }


  /**
   * 检查是否为native External类型。
   * @param value
   * @returns
   */
  static isExternal(value: Object): boolean {
    return new util.types().isExternal(value);
  }


  /**
   * 检查是否为Error类型。
   * @param value
   * @returns
   */
  static isNativeError(value: Object): boolean {
    return new util.types().isNativeError(value);
  }


}