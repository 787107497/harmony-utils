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

// 单例对象 GlobalContext.ts
export class GlobalContext {

  private constructor() {}


  private static instance: GlobalContext;
  private _objects = new Map<string, Object>();

  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }


  public getObject(key: string): Object | undefined {
    return this._objects.get(key);
  }

  public setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass);
  }


  /**
   * 将数据存入缓存中
   */
  public put(key: string, value: Object): void {
    this._objects.set(key, value);
  }

  /**
   * 获取缓存中的数据
   */
  public get<T>(key: string): T {
    return this._objects.get(key) as T;
  }


  /**
   * 缓存中的数据是否存在
   */
  public has(key: string): boolean {
    return this._objects.has(key);
  }


  /**
   * 移除缓存
   */
  public remove(key: string) {
    this._objects.delete(key);
  }

  /**
   * 清除缓存数据
   */
  public clear() {
    return this._objects.clear();
  }


}