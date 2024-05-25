import preferences from '@ohos.data.preferences'
import dataPreferences from '@ohos.data.preferences'
import { AppUtil } from './AppUtil'


const defaultPreferenceName: string = "SP_HARMONY_UTILS_PREFERENCES"

/**
 * Preferences工具类
 */
export class PreferencesUtil{

  private constructor() {}


  /**
   * 获取Preferences实例
   * @param name
   * @returns
   */
  private static async getPreferences(name: string = defaultPreferenceName): Promise<preferences.Preferences> {
    return dataPreferences.getPreferences(AppUtil.getContext(), name);
  }

  /**
   * 将数据缓存
   * @param key
   * @param value
   * @param preferenceName
   */
  static async put(key: string, value: preferences.ValueType, preferenceName: string = defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName); //获取实例
    await preferences.put(key, value);
    await preferences.flush(); //此处一定要flush，要不然不能永久序列化到本地
  }

  /**
   * 获取缓存值
   * @param key
   * @param defValue
   * @param preferenceName
   * @returns
   */
  static async get(key: string, defValue: preferences.ValueType, preferenceName: string = defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName); //获取实例
    return preferences.get(key, defValue);
  }

  /**
   * 获取string类型的缓存值
   * @param key
   * @returns
   */
  static async getString(key: string): Promise<string> {
    return (await PreferencesUtil.get(key, "")) as string;
  }

  /**
   * 获取number类型的缓存值
   * @param key
   * @returns
   */
  static async getNumber(key: string) {
    return (await PreferencesUtil.get(key, 0)) as number;
  }

  /**
   * 获取boolean类型的缓存值
   * @param key
   * @param defValue
   * @param preferenceName
   * @returns
   */
  static async getBoolean(key: string) {
    return (await PreferencesUtil.get(key, false)) as boolean;
  }

  /**
   * 检查缓存的Preferences实例中是否包含名为给定Key的存储键值对
   * @param key
   * @param preferenceName
   * @returns
   */
  static async has(key: string, preferenceName: string = defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName); //获取实例
    return await preferences.has(key);
  }

  /**
   * 删除缓存值
   * @param key
   * @param preferenceName
   * @returns
   */
  static async delete(key: string, preferenceName: string = defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName); //获取实例
    await preferences.delete(key);
    return await preferences.flush() //此处一定要flush，要不然不能永久序列化到本地
  }

  /**
   * 清空缓存
   * @param preferenceName
   * @returns
   */
  static async clear(preferenceName: string = defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName); //获取实例
    await preferences.clear();
    return await preferences.flush() //此处一定要flush，要不然不能永久序列化到本地
  }


}