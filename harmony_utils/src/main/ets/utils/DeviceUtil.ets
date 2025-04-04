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


import { vibrator } from '@kit.SensorServiceKit';
import { LogUtil } from './LogUtil';
import { resourceManager } from '@kit.LocalizationKit';
import { StrUtil } from './StrUtil';
import { AssetUtil } from './AssetUtil';
import { PreferencesUtil } from './PreferencesUtil';
import { RandomUtil } from './RandomUtil';
import deviceInfo from '@ohos.deviceInfo';
import { ResUtil } from './ResUtil';
import { identifier } from '@kit.AdsKit';
import { DEVICE_ID_KEY } from '../entity/constraint';


/**
 * TODO 设备相关工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class DeviceUtil {

  private static deviceId: string = ""; //设备ID


  /**
   * 获取设备ID（卸载APP后依旧不变）
   * @param rule 是否带-
   * @param generateId 自己生成的id，不传使用默认生成的id
   * @returns
   */
  static getDeviceId(rule: boolean = true, generateId?: string): string {
    let deviceId = DeviceUtil.deviceId;
    if (StrUtil.isEmpty(deviceId)) {
      if (AssetUtil.canIUse()) {
        deviceId = StrUtil.toStr(AssetUtil.getSync(DEVICE_ID_KEY));
      } else {
        deviceId = StrUtil.toStr(PreferencesUtil.getStringSync(DEVICE_ID_KEY));
        LogUtil.error(`当前设备不支持,关键资产存储服务`);
      }
      if (StrUtil.isEmpty(deviceId)) {
        if (generateId && StrUtil.isNotEmpty(generateId)) {
          deviceId = generateId;
        } else {
          deviceId = RandomUtil.generateRandomUUID(true);
        }
        if (!rule) {
          deviceId = deviceId.replace(/-/g, ''); //去除-
        }
        if (AssetUtil.canIUse()) {
          //将deviceId保存到关键资产（在应用卸载时保留）
          AssetUtil.addSync(DEVICE_ID_KEY, deviceId);
        } else {
          PreferencesUtil.putSync(DEVICE_ID_KEY, deviceId);
          LogUtil.error(`当前设备不支持,关键资产存储服务`);
        }
      }
      DeviceUtil.deviceId = deviceId;
    }
    return deviceId;
  }

  /**
   * 移除设备ID
   */
  static deleteDeviceId() {
    DeviceUtil.deviceId = '';
    if (AssetUtil.canIUse()) {
      AssetUtil.removeSync(DEVICE_ID_KEY);
    } else {
      PreferencesUtil.deleteSync(DEVICE_ID_KEY);
    }
  }


  /**
   * 获取设备品牌名称。示例：HUAWEI。
   */
  static getBrand(): string {
    return deviceInfo.brand;
  }

  /**
   * 获取认证型号。示例：ALN-AL00。
   */
  static getProductModel(): string {
    return deviceInfo.productModel;
  }

  /**
   * 获取认证型号。示例：HUAWEI ALN-AL00。
   */
  static getBrandModel(): string {
    return `${deviceInfo.brand} ${deviceInfo.productModel}`;
  }

  /**
   * 硬件版本号。示例：HL1CMSM
   */
  static getHardwareModel(): string {
    return deviceInfo.hardwareModel;
  }

  /**
   * 设备厂家名称。示例：HUAWEI
   */
  static getManufacture(): string {
    return deviceInfo.manufacture;
  }

  /**
   * 获取系统版本。
   */
  static getOsFullName(): string {
    return deviceInfo.osFullName;
  }


  /**
   * 获取产品版本。示例：ALN-AL00 5.0.0.1(XXX)
   */
  static getDisplayVersion(): string {
    return deviceInfo.displayVersion;
  }

  /**
   * 获取系统软件API版本。示例：12
   */
  static getSdkApiVersion(): number {
    return deviceInfo.sdkApiVersion;
  }

  /**
   * 获取Build版本号，标识编译构建的版本号。
   */
  static getBuildVersion(): number {
    return deviceInfo.buildVersion;
  }

  /**
   * 获取OS版本号。
   * Major版本号,示例：5；Senior版本号，示例：0；Feature版本号，示例：0。
   */
  static getOsVersion(): string {
    return `${deviceInfo.majorVersion}.${deviceInfo.seniorVersion}.${deviceInfo.featureVersion}`;
  }


  /**
   * 获取开发者匿名设备标识符。
   */
  static getODID(): string {
    return deviceInfo.ODID;
  }

  /**
   * 设备序列号。说明：可作为设备唯一识别码。示例：序列号随设备差异
   * 需要权限：ohos.permission.sec.ACCESS_UDID
   */
  getSerial(): string {
    return deviceInfo.serial;
  }

  /**
   * 设备Udid。说明：数据长度为65字节。可作为设备唯一识别码。 示例：9D6AABD147XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXE5536412
   * 需要权限：ohos.permission.sec.ACCESS_UDID
   */
  static getUdid(): string {
    return deviceInfo.udid;
  }

  /**
   * 获取开放匿名设备标识符
   * 需要权限：ohos.permission.APP_TRACKING_CONSENT
   */
  static async getOAID(): Promise<string> {
    return identifier.getOAID();
  }


  /**
   * 应用二进制接口（Abi）。示例：arm64-v8a
   */
  static getAbiList(): string {
    return deviceInfo.abiList;
  }


  /**
   * 获取系统的发布类型，取值为：Canary、Beta、Release
   */
  static getOsReleaseType(): string {
    return deviceInfo.osReleaseType;
  }


  /**
   * 获取当前设备类型
   * resourceManager.DeviceType:
   *   DEVICE_TYPE_PHONE手机。
   *   DEVICE_TYPE_TABLET 平板。
   *   DEVICE_TYPE_CAR 汽车。
   *   DEVICE_TYPE_PC 电脑。
   *   DEVICE_TYPE_TV 电视。
   *   DEVICE_TYPE_WEARABLE 穿戴。
   *   DEVICE_TYPE_2IN1 2IN1。
   * @returns
   */
  static getDeviceType(): number {
    return DeviceUtil.getDeviceCapabilitySync().deviceType;
  }

  /**
   * 获取当前设备类型
   * @returns
   */
  static getDeviceTypeStr(): string {
    let deviceType = DeviceUtil.getDeviceType();
    switch (deviceType) {
      case resourceManager.DeviceType.DEVICE_TYPE_PHONE:
        return "手机";
      case resourceManager.DeviceType.DEVICE_TYPE_TABLET:
        return "平板";
      case resourceManager.DeviceType.DEVICE_TYPE_PC:
        return "电脑";
      case resourceManager.DeviceType.DEVICE_TYPE_TV:
        return "电视";
      case resourceManager.DeviceType.DEVICE_TYPE_CAR:
        return "汽车";
      case resourceManager.DeviceType.DEVICE_TYPE_WEARABLE:
        return "穿戴";
      case resourceManager.DeviceType.DEVICE_TYPE_2IN1:
        return "2IN1";
      default:
        return ""
    }
  }


  /**
   * 获取设备的Configuration
   * @returns
   */
  static async getConfiguration(): Promise<resourceManager.Configuration> {
    return ResUtil.getConfiguration();
  }

  /**
   * 获取设备的Configuration
   * @returns
   */
  static getConfigurationSync(): resourceManager.Configuration {
    return ResUtil.getConfigurationSync();
  }

  /**
   * 获取当前设备屏幕方向。
   * resourceManager.Direction:
   *   DIRECTION_VERTICAL 0 竖屏。
   *   DIRECTION_HORIZONTAL 1 横屏。
   * @returns
   */
  static getDirection(): Number {
    return DeviceUtil.getConfigurationSync().direction
  }


  /**
   * 获取设备的DeviceCapability
   * @returns
   */
  static async getDeviceCapability(): Promise<resourceManager.DeviceCapability> {
    return ResUtil.getDeviceCapability();
  }

  /**
   * 用户获取设备的DeviceCapability
   * @returns
   */
  static getDeviceCapabilitySync(): resourceManager.DeviceCapability {
    return ResUtil.getDeviceCapabilitySync();
  }

  /**
   * 获取当前设备屏幕密度。
   * resourceManager.ScreenDensity:
   *   SCREEN_SDPI 120 小规模的屏幕密度。
   *   SCREEN_MDPI 160 中规模的屏幕密度。
   *   SCREEN_LDPI 240 大规模的屏幕密度。
   *   SCREEN_XLDPI 320 特大规模的屏幕密度。
   *   SCREEN_XXLDPI 480 超大规模的屏幕密度。
   *   SCREEN_XXXLDPI 640 超特大规模的屏幕密度。
   * @returns
   */
  static getScreenDensity(): number {
    return DeviceUtil.getDeviceCapabilitySync().screenDensity;
  }


  /**
   * 开启振动，ohos.permission.VIBRATE
   * @param duration
   * @param usage
   */
  static startVibration(duration: number = 1000, usage: vibrator.Usage = 'media'): Promise<void> {
    return vibrator.startVibration({ type: 'time', duration: duration }, { id: 0, usage: usage });
  }

  /**
   * 停止振动（按照VIBRATOR_STOP_MODE_TIME模式），ohos.permission.VIBRATE
   */
  static stopVibration(): Promise<void> {
    return vibrator.stopVibration(vibrator.VibratorStopMode.VIBRATOR_STOP_MODE_TIME);
  }




}