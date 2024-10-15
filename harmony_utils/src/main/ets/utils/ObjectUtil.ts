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

import util from '@ohos.util';
import { ArrayList, HashMap, List } from '@kit.ArkTS';

/**
 * TODO 对象工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class ObjectUtil {



  private constructor() {}


  /**
   * 获取对象的Hash值。如果是第一次获取，则计算Hash值并保存到对象的Hash域（返回随机的Hash值）；如果不是第一次获取，则从Hash域中获取并返回Hash值（同一对象多次返回值保持不变）。
   * @param object
   * @returns
   */
  static getHash(object: object): number {
    return util.getHash(object);
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
  static isNull(source: Object) {
    return source === null || source === undefined;
  }


  /**
   * 判断属性内容是否为空
   * @param property
   * @returns
   */
  static isEmpty(property: CommonAllType): Boolean {
    if (ObjectUtil.isNull(property)) {
      return true
    } else if (Array.isArray(property) || property instanceof Array) {
      return property.length == 0
    } else if (property instanceof List) {
      return property.isEmpty()
    } else if (property instanceof ArrayList) {
      return property.isEmpty()
    } else if (property instanceof HashMap) {
      return property.isEmpty()
    }
    return property == '';
  }


  /**
   * 深度拷贝对象(对于undefined等无法序列化的数据会丢失,这个后期优化，也可先使用三方库lodash的_.cloneDeep方法。)
   * @param obj 被拷贝对象
   * @returns
   */
  static deepCopy(obj: Object) {
    return JSON.parse(JSON.stringify(obj));
  }


  /**
   * obj转class ，解决obj as class后丢失方法的问题。
   */
  static objToClass<T>(clazz: new (...args: any[]) => T, obj: any): T {
    const instance = new clazz();
    Object.assign(instance, obj);
    return instance;
  }


}


export type CommonSingleType = Object | String | Number | Boolean | null | undefined; //通用单个联合类型

export type CommonAllType = CommonSingleType | Array<CommonSingleType> | ArrayList<CommonSingleType> | HashMap<CommonSingleType, CommonSingleType>; //通用所有联合类型
