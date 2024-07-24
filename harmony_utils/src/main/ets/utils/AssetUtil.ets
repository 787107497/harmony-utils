import { asset } from '@kit.AssetStoreKit';
import { LogUtil } from './LogUtil';
import { StrUtil } from './StrUtil';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * 关键资产存储服务
 */
export class AssetUtil {


  static async set(key: string, value: string, e10: boolean = true): Promise<boolean> {
    try {
      if (!canIUse("SystemCapability.Security.Asset")) {
        LogUtil.error(`AssetStore-当前设备不支持该模块`);
        return false;
      }
      let attr: asset.AssetMap = new Map();
      attr.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
      attr.set(asset.Tag.SECRET, StrUtil.strToUint8Array(value));
      attr.set(asset.Tag.SYNC_TYPE, asset.SyncType.THIS_DEVICE);
      attr.set(asset.Tag.CONFLICT_RESOLUTION, asset.ConflictResolution.THROW_ERROR);
      if (e10) {
        attr.set(asset.Tag.IS_PERSISTENT, e10);
      }
      let result: boolean;
      if ((await AssetUtil.has(key))) {
        result = await AssetUtil.updateAssetMap(attr, attr);
      } else {
        result = await AssetUtil.setAssetMap(attr);
      }
      if (result) {
        AppStorage.setOrCreate(key, value);
      }
      return result;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-set-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
    return false;
  }


  static async has(key: string): Promise<boolean> {
    try {
      if (!canIUse("SystemCapability.Security.Asset")) {
        LogUtil.error(`AssetStore-当前设备不支持该模块`);
        return false;
      }
      let query: asset.AssetMap = new Map();
      query.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
      query.set(asset.Tag.RETURN_TYPE, asset.ReturnType.ALL);
      const result = await AssetUtil.getAssetMap(query);
      if (!result) {
        return false;
      }
      if (result.length < 1) {
        return false;
      }
      return true;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-has-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return false;
    }
  }


  static async get(key: string): Promise<string | null> {
    try {
      if (!AssetUtil.canIUse()) {
        LogUtil.error(`AssetStore-当前设备不支持该模块`);
        return null;
      }
      // let challenge: Uint8Array = await AssetUtil.preQueryAsset(key);
      let query: asset.AssetMap = new Map();
      query.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
      query.set(asset.Tag.RETURN_TYPE, asset.ReturnType.ALL);
      const a10 = await AssetUtil.getAssetMap(query);
      if (!a10) {
        return null;
      }
      if (a10.length < 1) {
        return null;
      }
      let map: asset.AssetMap = a10[0]
      let b10 = map.get(asset.Tag.SECRET) as Uint8Array;
      // AssetUtil.postQueryAsset(challenge)
      if (b10) {
        let c10 = StrUtil.unit8ArrayToStr(b10);
        return c10
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-get-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
    return null;
  }


  static async setAssetMap(attr: asset.AssetMap): Promise<boolean> {
    try {
      await asset.add(attr);
      return true;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-setAssetMap-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return false;
    }
  }


  static async remove(key: string): Promise<boolean> {
    try {
      if (!canIUse("SystemCapability.Security.Asset")) {
        LogUtil.error(`AssetStore-当前设备不支持该模块`);
        return false;
      }
      let query: asset.AssetMap = new Map();
      query.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
      let result = await AssetUtil.removeAssetMap(query);
      if (result) {
        AppStorage.setOrCreate(key, '');
      }
      return result;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-remove-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return false;
    }
  }


  static async removeAssetMap(attr: asset.AssetMap): Promise<boolean> {
    try {
      await asset.remove(attr);
      return true;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-removeAssetMap-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return false;
    }
  }

  static async getAssetMap(query: asset.AssetMap): Promise<Array<asset.AssetMap>> {
    try {
      const z9 = await asset.query(query);
      return z9;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-getAssetMap-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return [];
    }
  }


  static async updateAssetMap(query: asset.AssetMap, y9: asset.AssetMap): Promise<boolean> {
    try {
      await asset.update(query, y9);
      return true;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AssetStore-updateAssetMap-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return false;
    }
  }


  static async preQueryAsset(key: string): Promise<Uint8Array> {
    return new Promise((resolve, reject) => {
      try {
        let query: asset.AssetMap = new Map();
        query.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
        asset.preQuery(query).then((challenge: Uint8Array) => {
          resolve(challenge);
        }).catch(() => {
          reject();
        })
      } catch (error) {
        let err = error as BusinessError;
        LogUtil.error(`AssetStore-preQueryAsset-异常 ~ ${err.code}, message is ${err.message}`);
        reject();
      }
    });
  }


  static async postQueryAsset(challenge: Uint8Array) {
    let handle: asset.AssetMap = new Map();
    handle.set(asset.Tag.AUTH_CHALLENGE, challenge);
    try {
      await asset.postQuery(handle);
    } catch (error) {
      let err = error as BusinessError;
      LogUtil.error(`AssetStore-postQueryAsset-异常 ~ ${err.code}, message is ${err.message}`);
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