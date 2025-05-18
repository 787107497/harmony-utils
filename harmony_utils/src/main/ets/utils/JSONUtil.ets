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

import { JSON } from '@kit.ArkTS';
import { LogUtil } from './LogUtil';
import { ObjectUtil } from './ObjectUtil';
import { Constructor } from '../entity/constraints';
import { StrUtil } from '../utils/StrUtil';


/**
 * TODO JSON工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class JSONUtil {


  /**
   * JSON字符串转Class对象
   * @param jsonStr JSON字符串
   * @param cls 类名
   * @returns
   */
  static jsonToBean<T>(jsonStr: string, clazz?: Constructor<T>, reviver?: JSON.Transformer, options?: JSON.ParseOptions): T | null {
    try {
      if (StrUtil.isEmpty(jsonStr)) {
        return null;
      }
      if (!options) {
        options = { bigIntMode: JSON.BigIntMode.PARSE_AS_BIGINT };
      }
      const bean = JSON.parse(jsonStr, reviver, options) as T;
      if (clazz) {
        return ObjectUtil.objToClass(clazz, bean);
      }
      return bean;
    } catch (err) {
      LogUtil.error(err);
      return null
    }
  }


  /**
   * 对象转JSON字符串
   * @param data
   * @returns JSON字符串
   */
  static beanToJsonStr(data: Object | Array<Object | String | Number | Boolean> | null | undefined): string {
    try {
      if (data == null || data == undefined) {
        return ''
      }
      return JSON.stringify(data);
    } catch (err) {
      LogUtil.error(err);
      return ""
    }
  }


  /**
   * JSON字符串转Array
   * @param cls 类名
   * @param jsonStr JSON字符串
   * @returns
   */
  static jsonToArray<T>(jsonStr: string): Array<T> {
    try {
      return JSON.parse(jsonStr) as Array<T>
    } catch (err) {
      LogUtil.error(err);
      return []
    }
  }


  /**
   * JSON转Map
   * @param jsonStr
   * @returns
   */
  static jsonToMap(jsonStr: string): Map<string, Object> {
    try {
      let commRecord = JSON.parse(jsonStr) as Record<string, Object>;
      return new Map(Object.entries(commRecord));
    } catch (err) {
      LogUtil.error(err);
      return new Map();
    }
  }


  /**
   * Map转JSON字符串
   * @param data
   * @returns JSON字符串
   */
  static mapToJsonStr(map: Map<string, Object>): string {
    try {
      let jsonObject: Record<string, Object> = {};
      map.forEach((value, key) => {
        if (key !== undefined && value !== undefined) {
          jsonObject[key] = value;
        }
      })
      return JSON.stringify(jsonObject);
    } catch (err) {
      LogUtil.error(err);
      return ""
    }
  }


  /**
   * 判断是否是字符串格式json
   * @param str 待验证字符串
   * @returns
   */
  static isJSONStr(str: string): boolean {
    try {
      JSON.parse(str);
      return true;
    } catch (error) {
      return false;
    }
  }


}