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

import { asset } from '@kit.AssetStoreKit';
import { LogUtil } from './LogUtil';
import { StrUtil } from './StrUtil';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * TODO 关键资产存储服务工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class AssetUtil {


  /**
   * 新增一条关键资产
   * @param key 关键资产别名key
   * @param value 关键资产明文
   * @param e10 在应用卸载时是否需要保留关键资产
   * @returns
   */
  static async add(key: string, value: string, e10: boolean = true): Promise<boolean> {
    try {
      if (!AssetUtil.canIUse()) {
        LogUtil.error(`AssetStore-当前设备不支持该模块`);
        return false;
      }
      let attr: asset.AssetMap = new Map();
      attr.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
      attr.set(asset.Tag.SECRET, StrUtil.strToUint8Array(value));
      attr.set(asset.Tag.SYNC_TYPE, asset.SyncType.THIS_DEVICE);
      attr.set(asset.Tag.CONFLICT_RESOLUTION, asset.ConflictResolution.OVERWRITE); //新增关键资产时的冲突,覆盖原有的关键资产
      if (e10) {
        attr.set(asset.Tag.IS_PERSISTENT, e10); //在应用卸载时是否需要保留关键资产
      }
      await asset.add(attr);
      return true;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-add-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return false;
    }
  }


  /**
   * 新增一条关键资产,同步
   * @param key 关键资产别名key
   * @param value 关键资产明文
   * @param e10 在应用卸载时是否需要保留关键资产
   * @returns
   */
  static addSync(key: string, value: string, e10: boolean = true): boolean {
    try {
      if (!AssetUtil.canIUse()) {
        LogUtil.error(`AssetStore-当前设备不支持该模块`);
        return false;
      }
      let attr: asset.AssetMap = new Map();
      attr.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
      attr.set(asset.Tag.SECRET, StrUtil.strToUint8Array(value));
      attr.set(asset.Tag.SYNC_TYPE, asset.SyncType.THIS_DEVICE);
      attr.set(asset.Tag.CONFLICT_RESOLUTION, asset.ConflictResolution.OVERWRITE); //新增关键资产时的冲突,覆盖原有的关键资产
      if (e10) {
        attr.set(asset.Tag.IS_PERSISTENT, e10); //在应用卸载时是否需要保留关键资产
      }
      asset.addSync(attr);
      return true;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-addSync-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return false;
    }
  }


  /**
   * 查询关键资产
   * @param key
   * @returns
   */
  static async get(key: string): Promise<string> {
    try {
      if (!AssetUtil.canIUse()) {
        LogUtil.error(`AssetStore-当前设备不支持该模块`);
        return "";
      }
      let query: asset.AssetMap = new Map();
      query.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
      query.set(asset.Tag.RETURN_TYPE, asset.ReturnType.ALL);
      const a10 = await asset.query(query);
      if (!a10 || a10.length < 1) {
        return "";
      }
      let map: asset.AssetMap = a10[0]
      let b10 = map.get(asset.Tag.SECRET) as Uint8Array;
      if (b10) {
        let c10 = StrUtil.unit8ArrayToStr(b10);
        return c10;
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-get-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
    return "";
  }


  /**
   * 查询关键资产，同步
   * @param key
   * @returns
   */
  static getSync(key: string): string {
    try {
      if (!AssetUtil.canIUse()) {
        LogUtil.error(`AssetStore-当前设备不支持该模块`);
        return "";
      }
      let query: asset.AssetMap = new Map();
      query.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
      query.set(asset.Tag.RETURN_TYPE, asset.ReturnType.ALL);
      const a10 = asset.querySync(query);
      if (!a10 || a10.length < 1) {
        return "";
      }
      let map: asset.AssetMap = a10[0]
      let b10 = map.get(asset.Tag.SECRET) as Uint8Array;
      if (b10) {
        let c10 = StrUtil.unit8ArrayToStr(b10);
        return c10;
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-getSync-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
    return "";
  }


  /**
   * 删除关键资产
   * @param key
   * @returns
   */
  static async remove(key: string): Promise<boolean> {
    try {
      if (!AssetUtil.canIUse()) {
        LogUtil.error(`AssetStore-当前设备不支持该模块`);
        return false;
      }
      let query: asset.AssetMap = new Map();
      query.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
      await asset.remove(query);
      return true;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-remove-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return false;
    }
  }


  /**
   * 删除关键资产，同步
   * @param key
   * @returns
   */
  static removeSync(key: string): boolean {
    try {
      if (!AssetUtil.canIUse()) {
        LogUtil.error(`AssetStore-当前设备不支持该模块`);
        return false;
      }
      let query: asset.AssetMap = new Map();
      query.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
      asset.removeSync(query);
      return true;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-removeSync-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return false;
    }
  }


  /**
   * 当前设备是否支持该模块
   * @returns
   */
  static canIUse() {
    return canIUse("SystemCapability.Security.Asset")
  }


}