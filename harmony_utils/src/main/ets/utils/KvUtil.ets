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

import { distributedKVStore } from '@kit.ArkData';
import { AppUtil } from './AppUtil';


/**
 * TODO 键值型数据库工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class KvUtil {
  private constructor() {}

  private static kvStore: distributedKVStore.SingleKVStore; //KVStore数据库实例


  /**
   * 获取KVStore数据库
   * @returns
   */
  private static async getKvStore(): Promise<distributedKVStore.SingleKVStore> {
    if (!KvUtil.kvStore) {
      let kvManager = distributedKVStore.createKVManager({
        context: AppUtil.getContext(),
        bundleName: AppUtil.getBundleName()
      });
      let options: distributedKVStore.Options = {
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
    return (await KvUtil.getKvStore()).put(key, value);
  }

  /**
   * 获取指定键的值。
   * @param key 要查询数据的Key
   * @param callback
   */
  static async get(key: string): Promise<string | number | boolean | Uint8Array> {
    return (await KvUtil.getKvStore()).get(key);
  }


  /**
   * 从数据库中删除指定键值的数据。
   * @param key 要删除数据的Key
   */
  static async delete(key: string): Promise<void> {
    return (await KvUtil.getKvStore()).delete(key);
  }

  /**
   * 批量插入键值对到SingleKVStore数据库中
   * @param entries 表示要批量插入的键值对。一个entries对象中允许的最大数据量为512M。
   * @returns
   */
  static async putBatch(entries: distributedKVStore.Entry[]): Promise<void> {
    return (await KvUtil.getKvStore()).putBatch(entries);
  }


  /**
   * 批量删除SingleKVStore数据库中的键值对
   * @param keys 表示要批量删除的键值对，不能为空。
   * @returns
   */
  static async deleteBatch(keys: string[]): Promise<void> {
    return (await KvUtil.getKvStore()).deleteBatch(keys);
  }


  /**
   * 获取匹配指定键前缀的所有键值对
   * @param keyPrefix 表示要匹配的键前缀。不能包含'^',包含'^'的话将导致谓词失效，查询结果会返回数据库中的所有数据。
   * @returns
   */
  static async getEntries(keyPrefix: string): Promise<distributedKVStore.Entry[]> {
    return (await KvUtil.getKvStore()).getEntries(keyPrefix);
  }


  /**
   * 以指定名称备份数据库
   * @param file 备份数据库的指定名称。
   * @returns
   */
  static async backup(file: string): Promise<void> {
    return (await KvUtil.getKvStore()).backup(file);
  }


  /**
   * 从指定的数据库文件恢复数据库
   * @param file 指定的数据库文件名称
   * @returns
   */
  static async restore(file: string): Promise<void> {
    return (await KvUtil.getKvStore()).restore(file);
  }


  /**
   * 根据指定名称删除备份文件
   * @param files 删除备份文件所指定的名称
   * @returns
   */
  static async deleteBackup(files: Array<string>): Promise<Array<[string, number]>> {
    return (await KvUtil.getKvStore()).deleteBackup(files);
  }


  /**
   * 订阅指定类型的数据变更通知
   * @param type 表示订阅的类型
   * @param listener 回调函数。成功返回数据变更时通知的对象。
   */
  static async onDataChange(type: distributedKVStore.SubscribeType,
    listener: Callback<distributedKVStore.ChangeNotification>) {
    (await KvUtil.getKvStore()).on('dataChange', type, listener);
  }


  /**
   * 取消订阅数据变更通知
   * @param listener 取消订阅的函数。如不设置callback，则取消所有已订阅的函数。
   */
  static async offDataChange(listener?: Callback<distributedKVStore.ChangeNotification>) {
    if (listener) {
      (await KvUtil.getKvStore()).off('dataChange', listener);
    } else {
      (await KvUtil.getKvStore()).off('dataChange');
    }
  }


}