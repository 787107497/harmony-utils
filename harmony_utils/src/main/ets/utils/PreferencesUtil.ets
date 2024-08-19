import preferences from '@ohos.data.preferences';
import dataPreferences from '@ohos.data.preferences';
import { AppUtil } from './AppUtil';


/**
 * TODO Preferences工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class PreferencesUtil {
  private constructor() {}

  private static defaultPreferenceName: string = "SP_HARMONY_UTILS_PREFERENCES";
  private static preferences: preferences.Preferences;

  /**
   * 初始化
   * @param name Preferences实例的名称。
   */
  static init(preferenceName: string) {
    if (!PreferencesUtil.preferences || preferenceName !== PreferencesUtil.defaultPreferenceName) {
      PreferencesUtil.defaultPreferenceName = preferenceName;
      PreferencesUtil.preferences = dataPreferences.getPreferencesSync(AppUtil.getContext(), { name: preferenceName });
    }
  }


  /**
   * 获取Preferences实例
   * @param name
   * @returns
   */
  private static getPreferencesSync(preferenceName: string = PreferencesUtil.defaultPreferenceName): preferences.Preferences {
    if (preferenceName !== PreferencesUtil.defaultPreferenceName) {
      return dataPreferences.getPreferencesSync(AppUtil.getContext(), { name: preferenceName });
    } else if (!PreferencesUtil.preferences) {
      PreferencesUtil.preferences = dataPreferences.getPreferencesSync(AppUtil.getContext(), { name: preferenceName });
    }
    return PreferencesUtil.preferences;
  }

  /**
   * 获取Preferences实例
   * @param name
   * @returns
   */
  private static async getPreferences(preferenceName: string = PreferencesUtil.defaultPreferenceName): Promise<preferences.Preferences> {
    if (preferenceName !== PreferencesUtil.defaultPreferenceName) {
      return await dataPreferences.getPreferences(AppUtil.getContext(), preferenceName);
    } else if (!PreferencesUtil.preferences) {
      PreferencesUtil.preferences = await dataPreferences.getPreferences(AppUtil.getContext(), preferenceName);
    }
    return PreferencesUtil.preferences;
  }


  /**
   * 将数据缓存
   * @param key
   * @param value
   */
  static putSync(key: string, value: preferences.ValueType,
    preferenceName: string = PreferencesUtil.defaultPreferenceName) {
    let preferences = PreferencesUtil.getPreferencesSync(preferenceName); //获取实例
    preferences.putSync(key, value);
    preferences.flush(); //此处一定要flush，要不然不能永久序列化到本地
  }

  /**
   * 将数据缓存
   * @param key
   * @param value
   */
  static async put(key: string, value: preferences.ValueType,
    preferenceName: string = PreferencesUtil.defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName); //获取实例
    await preferences.put(key, value);
    await preferences.flush(); //此处一定要flush，要不然不能永久序列化到本地
  }


  /**
   * 获取缓存值
   * @param key
   * @param defValue
   * @returns
   */
  static getSync(key: string, defValue: preferences.ValueType,
    preferenceName: string = PreferencesUtil.defaultPreferenceName): preferences.ValueType {
    let preferences = PreferencesUtil.getPreferencesSync(preferenceName); //获取实例
    return preferences.getSync(key, defValue);
  }

  /**
   * 获取缓存值
   * @param key
   * @param defValue
   * @returns
   */
  static async get(key: string, defValue: preferences.ValueType,
    preferenceName: string = PreferencesUtil.defaultPreferenceName): Promise<preferences.ValueType> {
    let preferences = await PreferencesUtil.getPreferences(preferenceName); //获取实例
    return preferences.get(key, defValue);
  }


  /**
   * 获取string类型的缓存值
   * @param key
   * @returns
   */
  static getStringSync(key: string, preferenceName: string = PreferencesUtil.defaultPreferenceName): string {
    return PreferencesUtil.getSync(key, "", preferenceName) as string;
  }

  /**
   * 获取string类型的缓存值
   * @param key
   * @returns
   */
  static async getString(key: string, preferenceName: string = PreferencesUtil.defaultPreferenceName): Promise<string> {
    return (await PreferencesUtil.get(key, "", preferenceName)) as string;
  }


  /**
   * 获取number类型的缓存值
   * @param key
   * @returns
   */
  static getNumberSync(key: string, preferenceName: string = PreferencesUtil.defaultPreferenceName): number {
    return PreferencesUtil.getSync(key, 0, preferenceName) as number;
  }

  /**
   * 获取number类型的缓存值
   * @param key
   * @returns
   */
  static async getNumber(key: string, preferenceName: string = PreferencesUtil.defaultPreferenceName): Promise<number> {
    return (await PreferencesUtil.get(key, 0, preferenceName)) as number;
  }


  /**
   * 获取boolean类型的缓存值
   * @param key
   * @returns
   */
  static getBooleanSync(key: string, preferenceName: string = PreferencesUtil.defaultPreferenceName): boolean {
    return PreferencesUtil.getSync(key, false, preferenceName) as boolean;
  }

  /**
   * 获取boolean类型的缓存值
   * @param key
   * @returns
   */
  static async getBoolean(key: string,
    preferenceName: string = PreferencesUtil.defaultPreferenceName): Promise<boolean> {
    return (await PreferencesUtil.get(key, false, preferenceName)) as boolean;
  }


  /**
   * 检查缓存的Preferences实例中是否包含名为给定Key的存储键值对
   * @param key
   * @returns
   */
  static hasSync(key: string, preferenceName: string = PreferencesUtil.defaultPreferenceName) {
    return PreferencesUtil.getPreferencesSync(preferenceName).hasSync(key);
  }

  /**
   * 检查缓存的Preferences实例中是否包含名为给定Key的存储键值对
   * @param key
   * @returns
   */
  static async has(key: string, preferenceName: string = PreferencesUtil.defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName); //获取实例
    return await preferences.has(key);
  }


  /**
   * 删除缓存值
   * @param key
   * @param preferenceName
   * @returns
   */
  static deleteSync(key: string, preferenceName: string = PreferencesUtil.defaultPreferenceName) {
    let preferences = PreferencesUtil.getPreferencesSync(preferenceName); //获取实例
    preferences.deleteSync(key);
    preferences.flush() //此处一定要flush，要不然不能永久序列化到本地
  }

  /**
   * 删除缓存值
   * @param key
   * @param preferenceName
   * @returns
   */
  static async delete(key: string, preferenceName: string = PreferencesUtil.defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName); //获取实例
    await preferences.delete(key);
    return await preferences.flush() //此处一定要flush，要不然不能永久序列化到本地
  }


  /**
   * 清空缓存的Preferences实例中的所有数据
   * @param preferenceName
   * @returns
   */
  static clearSync(preferenceName: string = PreferencesUtil.defaultPreferenceName) {
    let preferences = PreferencesUtil.getPreferencesSync(preferenceName); //获取实例
    preferences.clearSync();
    preferences.flush() //此处一定要flush，要不然不能永久序列化到本地
  }

  /**
   * 清除缓存的Preferences实例中的所有数据
   * @param preferenceName
   * @returns
   */
  static async clear(preferenceName: string = PreferencesUtil.defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName); //获取实例
    await preferences.clear();
    return await preferences.flush() //此处一定要flush，要不然不能永久序列化到本地
  }


  /**
   * 从缓存中移出指定的Preferences实例，若Preferences实例有对应的持久化文件，则同时删除其持久化文件。
   * @param context
   * @param name Preferences实例的名称。
   */
  static deletePreferences(context: Context, name: string) {
    dataPreferences.deletePreferences(context, name);
  }
}