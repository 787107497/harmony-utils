import { asset } from '@kit.AssetStoreKit';
import { LogUtil } from '../LogUtil';
import { StrUtil } from '../StrUtil';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * 关键资产存储服务
 */
export class AssetStore {


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
      if ((await AssetStore.has(key))) {
        result = await AssetStore.updateAssetMap(attr, attr);
      } else {
        result = await AssetStore.setAssetMap(attr);
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
      const result = await AssetStore.getAssetMap(query);
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
      if (!canIUse("SystemCapability.Security.Asset")) {
        LogUtil.error(`AssetStore-当前设备不支持该模块`);
        return null;
      }
      let query: asset.AssetMap = new Map();
      query.set(asset.Tag.ALIAS, StrUtil.strToUint8Array(key));
      query.set(asset.Tag.RETURN_TYPE, asset.ReturnType.ALL);
      const a10 = await AssetStore.getAssetMap(query);
      if (!a10) {
        return null;
      }
      if (a10.length < 1) {
        return null;
      }
      let map: asset.AssetMap = a10[0]
      let b10 = map.get(asset.Tag.SECRET) as Uint8Array;
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
      let result = await AssetStore.removeAssetMap(query);
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


}