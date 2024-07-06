import { vibrator } from '@kit.SensorServiceKit';
import { LogUtil } from './LogUtil';
import { resourceManager } from '@kit.LocalizationKit';
import { StrUtil } from './StrUtil';
import { AssetStore } from './other/AssetStore';
import { PreferencesUtil } from './PreferencesUtil';
import { RandomUtil } from './RandomUtil';

/**
 * 设备相关工具类
 */
export class DeviceUtil {
  private static deviceIdKey: string = "device_id_cache_harmony_key";
  private static deviceId: string = ""; //设备ID


  /**
   * 获取设备ID（卸载APP后依旧不变）
   * @param rule 是否带-
   * @param generateId 自己生成的id，不传使用默认生成的id
   * @returns
   */
  static async getDeviceId(rule: boolean = true, generateId?: string): Promise<string> {
    let deviceId = DeviceUtil.deviceId;
    if (StrUtil.isEmpty(deviceId)) {
      if (canIUse("SystemCapability.Security.Asset")) {
        deviceId = StrUtil.toStr(await AssetStore.get(DeviceUtil.deviceIdKey));
      } else {
        deviceId = StrUtil.toStr(await PreferencesUtil.get(DeviceUtil.deviceIdKey, "") as string)
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
        if (canIUse("SystemCapability.Security.Asset")) {
          //将deviceId保存到关键资产（在应用卸载时保留）
          AssetStore.set(DeviceUtil.deviceIdKey, deviceId);
        } else {
          PreferencesUtil.put(DeviceUtil.deviceIdKey, deviceId)
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
    if (canIUse("SystemCapability.Security.Asset")) {
      AssetStore.remove(DeviceUtil.deviceIdKey);
    } else {
      PreferencesUtil.delete(DeviceUtil.deviceIdKey)
      LogUtil.error(`当前设备不支持,关键资产存储服务`);
    }
  }


  /**
   * 获取设备的Configuration
   * @returns
   */
  static getConfiguration(): Promise<resourceManager.Configuration> {
    return getContext().resourceManager.getConfiguration();
  }

  /**
   * 获取设备的Configuration
   * @returns
   */
  static getConfigurationSync(): resourceManager.Configuration {
    return getContext().resourceManager.getConfigurationSync();
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
  static getDeviceCapability(): Promise<resourceManager.DeviceCapability> {
    return getContext().resourceManager.getDeviceCapability();
  }

  /**
   * 用户获取设备的DeviceCapability
   * @returns
   */
  static getDeviceCapabilitySync(): resourceManager.DeviceCapability {
    return getContext().resourceManager.getDeviceCapabilitySync();
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
   * 开启振动
   * @param duration
   * @param usage
   */
  static startVibration(duration: number = 10000, usage: vibrator.Usage = 'media'): Promise<void> {
    return vibrator.startVibration({ type: 'time', duration: duration }, { id: 0, usage: usage });
  }

  /**
   * 停止振动（按照VIBRATOR_STOP_MODE_TIME模式）
   */
  static stopVibration(): Promise<void> {
    return vibrator.stopVibration(vibrator.VibratorStopMode.VIBRATOR_STOP_MODE_TIME);
  }


}