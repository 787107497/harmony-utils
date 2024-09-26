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
 *
 * https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 */

import { ClassConstructor, instanceToPlain, plainToClass } from 'class-transformer';
import { LogUtil } from './LogUtil';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * TODO JSON工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class JSONUtil {

  private constructor() {}


  /**
   * JSON字符串转Class对象
   * @param cls 类名
   * @param jsonStr JSON字符串
   * @returns
   */
  static jsonToBean<T>(cls: ClassConstructor<T>, jsonStr: string): T | null {
    try {
      return plainToClass(cls, JSON.parse(jsonStr), { enableImplicitConversion: false, exposeDefaultValues: true }) as T
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`JSONUtil-jsonToBean-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return null
    }
  }


  /**
   * JSON字符串转Array
   * @param cls 类名
   * @param jsonStr JSON字符串
   * @returns
   */
  static jsonToArray<T>(cls: ClassConstructor<T>, jsonStr: string): Array<T> {
    try {
      return plainToClass(cls, JSON.parse(jsonStr), { enableImplicitConversion: false, exposeDefaultValues: true }) as Array<T>
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`JSONUtil-jsonToArray-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return []
    }
  }


  /**
   * 对象转字符串
   * @param data
   * @returns 字符串
   */
  static beanToJsonStr(data: Object | Array<Object | String | Number | Boolean> | null | undefined): string {
    try {
      if (data == null || data == undefined) {
        return ''
      }
      return JSON.stringify(instanceToPlain(data))
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`JSONUtil-beanToJsonStr-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return ""
    }
  }


  /**
   * JSON转Map
   * @param jsonStr
   * @returns
   */
  static jsonToMap(jsonStr: string): Map<string, Object> {
    return new Map(Object.entries(JSON.parse(jsonStr)));
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