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

import { distributedKVStore } from '@kit.ArkData';
import { AppUtil } from './AppUtil';
import { BusinessError } from '@kit.BasicServicesKit';


/**
 * TODO 键值型数据库工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class KvUtil {

  private static kvStore: distributedKVStore.SingleKVStore; //KVStore数据库实例


  /**
   * 获取KVStore数据库
   * @returns
   */
  private static async getKvStore(): Promise<distributedKVStore.SingleKVStore> {
    if (!KvUtil.kvStore) {
      const kvManager = distributedKVStore.createKVManager({
        context: AppUtil.getContext(),
        bundleName: AppUtil.getBundleName()
      });
      const options: distributedKVStore.Options = {
        createIfMissing: true, //当数据库文件不存在时是否创建数据库
        encrypt: true, //设置数据库文件是否加密
        backup: false, //设置数据库文件是否备份
        autoSync: false, //设置数据库是否为跨设备自动同步
        kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION, //设置要创建的数据库类型
        securityLevel: distributedKVStore.SecurityLevel.S1  //设置数据库安全级别
      };
      KvUtil.kvStore = await kvManager.getKVStore<distributedKVStore.SingleKVStore>("harmony_utils_store", options);
    }
    return KvUtil.kvStore;
  }


  /**
   * 添加指定类型的键值对到数据库。
   * @param key 要添加数据的Key
   * @param value  要添加数据的value，支持Uint8Array、number 、 string 、boolean。
   * @param callback
   */
  static async put(key: string, value: Uint8Array | string | number | boolean): Promise<void> {
    let kvStore = await KvUtil.getKvStore();
    return kvStore.put(key, value);
  }


  /**
   * 获取指定键的值。
   * @param key 要查询数据的Key
   * @param callback
   */
  static async get(key: string, defValue?: string | number | boolean | Uint8Array): Promise<string | number | boolean | Uint8Array | undefined> {
    let kvStore = await KvUtil.getKvStore();
    return kvStore.get(key).catch((e: BusinessError) => {
      return defValue;
    });
  }

  /**
   * 获取指定键的值。
   * @param key 要查询数据的Key
   * @param callback
   */
  static async getString(key: string, defValue: string = ''): Promise<string> {
    let value = await KvUtil.get(key, defValue);
    return value as string;
  }

  /**
   * 获取指定键的值。
   * @param key 要查询数据的Key
   * @param callback
   */
  static async getNumber(key: string, defValue: number = 0): Promise<number> {
    let value = await KvUtil.get(key, defValue);
    return value as number;
  }

  /**
   * 获取指定键的值。
   * @param key 要查询数据的Key
   * @param callback
   */
  static async getBoolean(key: string, defValue?: boolean): Promise<boolean> {
    let value = await KvUtil.get(key, defValue);
    return value as boolean;
  }

  /**
   * 获取指定键的值。
   * @param key 要查询数据的Key
   * @param callback
   */
  static async getUint8Array(key: string, defValue?: Uint8Array): Promise<Uint8Array> {
    let value = await KvUtil.get(key, defValue);
    return value as Uint8Array;
  }


  /**
   * 从数据库中删除指定键值的数据。
   * @param key 要删除数据的Key
   */
  static async delete(key: string): Promise<void> {
    let kvStore = await KvUtil.getKvStore();
    return kvStore.delete(key);
  }

  /**
   * 批量插入键值对到SingleKVStore数据库中
   * @param entries 表示要批量插入的键值对。一个entries对象中允许的最大数据量为512M。
   * @returns
   */
  static async putBatch(entries: distributedKVStore.Entry[]): Promise<void> {
    let kvStore = await KvUtil.getKvStore();
    return kvStore.putBatch(entries);
  }


  /**
   * 批量删除SingleKVStore数据库中的键值对
   * @param keys 表示要批量删除的键值对，不能为空。
   * @returns
   */
  static async deleteBatch(keys: string[]): Promise<void> {
    let kvStore = await KvUtil.getKvStore();
    return kvStore.deleteBatch(keys);
  }


  /**
   * 获取匹配指定键前缀的所有键值对
   * @param keyPrefix 表示要匹配的键前缀。不能包含'^',包含'^'的话将导致谓词失效，查询结果会返回数据库中的所有数据。
   * @returns
   */
  static async getEntries(keyPrefix: string): Promise<distributedKVStore.Entry[]> {
    let kvStore = await KvUtil.getKvStore();
    return kvStore.getEntries(keyPrefix);
  }


  /**
   * 以指定名称备份数据库
   * @param file 备份数据库的指定名称。
   * @returns
   */
  static async backup(file: string): Promise<void> {
    let kvStore = await KvUtil.getKvStore();
    return kvStore.backup(file);
  }


  /**
   * 从指定的数据库文件恢复数据库
   * @param file 指定的数据库文件名称
   * @returns
   */
  static async restore(file: string): Promise<void> {
    let kvStore = await KvUtil.getKvStore();
    return kvStore.restore(file);
  }


  /**
   * 根据指定名称删除备份文件
   * @param files 删除备份文件所指定的名称
   * @returns
   */
  static async deleteBackup(files: Array<string>): Promise<Array<[string, number]>> {
    let kvStore = await KvUtil.getKvStore();
    return kvStore.deleteBackup(files);
  }


  /**
   * 订阅指定类型的数据变更通知
   * @param type 表示订阅的类型
   * @param listener 回调函数。成功返回数据变更时通知的对象。
   */
  static async onDataChange(type: distributedKVStore.SubscribeType,
    listener: Callback<distributedKVStore.ChangeNotification>) {
    let kvStore = await KvUtil.getKvStore();
    kvStore.on('dataChange', type, listener);
  }


  /**
   * 取消订阅数据变更通知
   * @param listener 取消订阅的函数。如不设置callback，则取消所有已订阅的函数。
   */
  static async offDataChange(listener?: Callback<distributedKVStore.ChangeNotification>) {
    let kvStore = await KvUtil.getKvStore();
    if (listener) {
      kvStore.off('dataChange', listener);
    } else {
      kvStore.off('dataChange');
    }
  }


}