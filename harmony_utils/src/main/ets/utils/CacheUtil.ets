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


import { ObjectUtil } from './ObjectUtil';


/**
 * TODO 缓存工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class CacheUtil {
  private static cache: Record<string, Object> = {}; //私有缓存对象


  /**
   * 获取缓存中的数据
   * @param key 存入的key
   * @returns
   */
  static get<T>(key: string): T {
    return CacheUtil.cache[key] as T;
  }


  /**
   * 将数据存入缓存中
   * @param key 存入key
   * @param value 存入数据
   */
  static put<T>(key: string, value: T): void {
    CacheUtil.cache[key] = value as Object;
  }


  /**
   * 删除对应的缓存
   */
  static remove(key: string) {
    ObjectUtil.deleteRecord(CacheUtil.cache, key);
  }


  /**
   * 缓存中的数据是否存在
   * @param key 存入的key
   * @returns
   */
  static has(key: string): boolean {
    let keys = Object.keys(CacheUtil.cache);
    return keys.indexOf(key) >= 0
  }

  /**
   * 判断缓存是否为空
   * @returns
   */
  static isEmpty(): boolean {
    let keys = Object.keys(CacheUtil.cache);
    return keys.length <= 0;
  }

  /**
   * 清除缓存数据
   */
  static clear(): void {
    CacheUtil.cache = {};
  }


}
