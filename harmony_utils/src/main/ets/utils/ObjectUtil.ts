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
import { ArrayList, HashMap, List } from '@kit.ArkTS';
import { CommonAllType, Constructor } from '../entity/constraints';

/**
 * TODO 对象工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class ObjectUtil {


  /**
   * 获取对象的Hash值。如果是第一次获取，则计算Hash值并保存到对象的Hash域（返回随机的Hash值）；如果不是第一次获取，则从Hash域中获取并返回Hash值（同一对象多次返回值保持不变）。
   * @param object
   * @returns
   */
  static getHash(object: Object): number {
    return util.getHash(object);
  }


  /**
   * 获取对象的Class名称
   * @param obj
   * @returns
   */
  static getClassName(obj: Object) {
    return obj.constructor.name;
  }


  /**
   * 获取对象的所有方法名
   * @param obj
   * @returns
   */
  static getMethodsNames(obj: Object) {
    const protoType = Object.getPrototypeOf(obj);
    const methodsNames: string[] = Object.getOwnPropertyNames(protoType);
    return methodsNames;
  }


  /**
   * 判断是否是String
   * @param source
   * @returns
   */
  static isString(source: string | Object | ArrayBuffer | undefined | null): boolean {
    return typeof source === 'string' || source instanceof String;
  }


  /**
   * 判断对象是否为空
   * @param source
   * @returns
   */
  static isNull(source: CommonAllType) {
    return source === null || source === undefined;
  }


  /**
   * 判断属性内容是否为空
   * @param property
   * @returns
   */
  static isEmpty(property: CommonAllType): boolean {
    if (ObjectUtil.isNull(property)) {
      return true
    } else if (Array.isArray(property) || property instanceof Array) {
      return property.length === 0
    } else if (property instanceof List) {
      return property.isEmpty()
    } else if (property instanceof ArrayList) {
      return property.isEmpty()
    } else if (property instanceof HashMap) {
      return property.isEmpty()
    }
    return property === '';
  }


  /**
   * 浅拷贝
   * @param obj
   * @returns
   */
  static shallowCopy<T>(obj: T): T {
    let newObj: Record<string, Object> = {};
    for (let key of Object.keys(obj)) {
      newObj[key] = obj[key];
    }
    return newObj as T;
  }


  /**
   * 深度拷贝
   * @param obj 被拷贝对象
   * @returns
   */
  static deepCopy<T>(obj: T): T {
    if (obj === undefined || obj === null) {
      return obj; //为undefined和null
    }
    let newObj: Record<string, Object> | Object[] = Array.isArray(obj) ? [] : {};
    for (let key of Object.keys(obj)) {
      if (typeof obj[key] === 'object') {
        newObj[key] = ObjectUtil.deepCopy(obj[key]);
      } else {
        newObj[key] = obj[key];
      }
    }
    return newObj as T;
  }


  /**
   * 合并两个或多个对象
   * @param target
   * @param source
   * @returns
   */
  static assign(target: Object, ...source: Object[]): Object {
    for (const items of source) {
      for (const key of Object.keys(items)) {
        target[key] = Reflect.get(items, key)
      }
    }
    return target;
  }


  /**
   * obj转class ，解决obj as class 后丢失方法的问题
   * @param clazz
   * @param obj
   * @returns
   */
  static objToClass<T>(clazz: Constructor<T>, obj: any): T {
    const instance = new clazz();
    Object.assign(instance, obj);
    return instance;
  }


  /**
   * 删除Record中的元素
   * @param record
   * @param key
   */
  static deleteRecord(record: Record<string, Object>, key: string) {
    delete record[key];
  }


  /**
   * 通过key获取对象值
   * @param obj
   * @param key
   * @returns
   */
  static getValue<T>(obj: Object, key: string): T {
    return obj[key] as T;
  }


  /**
   * 给对象obj动态添加或者修改属性
   * @param obj
   * @param key
   * @param value
   */
  static setValue<T>(obj: Object, key: string, value: T) {
    obj[key] = value;
  }


}