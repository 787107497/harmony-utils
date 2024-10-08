import preferences from '@ohos.data.preferences'
import dataPreferences from '@ohos.data.preferences'
import { AppUtil } from './AppUtil'


/**
 * Preferences工具类
 */
export class PreferencesUtil {

  private constructor() {}

  private static defaultPreferenceName: string = "SP_HARMONY_UTILS_PREFERENCES"
  private static preferences: preferences.Preferences


  /**
   * 获取Preferences实例
   * @param name
   * @returns
   */
  private static getPreferencesSync(): preferences.Preferences {
    if (!PreferencesUtil.preferences) {
      PreferencesUtil.preferences = dataPreferences.getPreferencesSync(AppUtil.getContext(),
        { name: PreferencesUtil.defaultPreferenceName });
    }
    return PreferencesUtil.preferences;
  }

  /**
   * 获取Preferences实例
   * @param name
   * @returns
   */
  private static async getPreferences(): Promise<preferences.Preferences> {
    if (!PreferencesUtil.preferences) {
      PreferencesUtil.preferences =
        await dataPreferences.getPreferences(AppUtil.getContext(), PreferencesUtil.defaultPreferenceName);
    }
    return PreferencesUtil.preferences;
  }


  /**
   * 初始化
   * @param name Preferences实例的名称。
   */
  static init(name: string) {
    PreferencesUtil.defaultPreferenceName = name;
  }


  /**
   * 将数据缓存
   * @param key
   * @param value
   */
  static putSync(key: string, value: preferences.ValueType) {
    let preferences = PreferencesUtil.getPreferencesSync(); //获取实例
    preferences.putSync(key, value);
    preferences.flush(); //此处一定要flush，要不然不能永久序列化到本地
  }

  /**
   * 将数据缓存
   * @param key
   * @param value
   */
  static async put(key: string, value: preferences.ValueType) {
    let preferences = await PreferencesUtil.getPreferences(); //获取实例
    await preferences.put(key, value);
    await preferences.flush(); //此处一定要flush，要不然不能永久序列化到本地
  }


  /**
   * 获取缓存值
   * @param key
   * @param defValue
   * @returns
   */
  static getSync(key: string, defValue: preferences.ValueType): preferences.ValueType {
    let preferences = PreferencesUtil.getPreferencesSync(); //获取实例
    return preferences.getSync(key, defValue);
  }

  /**
   * 获取缓存值
   * @param key
   * @param defValue
   * @returns
   */
  static async get(key: string, defValue: preferences.ValueType): Promise<preferences.ValueType> {
    let preferences = await PreferencesUtil.getPreferences(); //获取实例
    return preferences.get(key, defValue);
  }


  /**
   * 获取string类型的缓存值
   * @param key
   * @returns
   */
  static getStringSync(key: string): string {
    return PreferencesUtil.getSync(key, "") as string;
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
  static getNumberSync(key: string): number {
    return PreferencesUtil.getSync(key, 0) as number;
  }

  /**
   * 获取number类型的缓存值
   * @param key
   * @returns
   */
  static async getNumber(key: string): Promise<number> {
    return (await PreferencesUtil.get(key, 0)) as number;
  }


  /**
   * 获取boolean类型的缓存值
   * @param key
   * @returns
   */
  static getBooleanSync(key: string): boolean {
    return PreferencesUtil.getSync(key, false) as boolean;
  }

  /**
   * 获取boolean类型的缓存值
   * @param key
   * @returns
   */
  static async getBoolean(key: string): Promise<boolean> {
    return (await PreferencesUtil.get(key, false)) as boolean;
  }


  /**
   * 检查缓存的Preferences实例中是否包含名为给定Key的存储键值对
   * @param key
   * @returns
   */
  static hasSync(key: string) {
    return PreferencesUtil.getPreferencesSync().hasSync(key);
  }

  /**
   * 检查缓存的Preferences实例中是否包含名为给定Key的存储键值对
   * @param key
   * @returns
   */
  static async has(key: string) {
    let preferences = await PreferencesUtil.getPreferences(); //获取实例
    return await preferences.has(key);
  }


  /**
   * 删除缓存值
   * @param key
   * @param preferenceName
   * @returns
   */
  static deleteSync(key: string) {
    let preferences = PreferencesUtil.getPreferencesSync(); //获取实例
    preferences.deleteSync(key);
    preferences.flush() //此处一定要flush，要不然不能永久序列化到本地
  }

  /**
   * 删除缓存值
   * @param key
   * @param preferenceName
   * @returns
   */
  static async delete(key: string) {
    let preferences = await PreferencesUtil.getPreferences(); //获取实例
    await preferences.delete(key);
    return await preferences.flush() //此处一定要flush，要不然不能永久序列化到本地
  }


  /**
   * 清空缓存的Preferences实例中的所有数据
   * @param preferenceName
   * @returns
   */
  static clearSync() {
    let preferences = PreferencesUtil.getPreferencesSync(); //获取实例
    preferences.clearSync();
    preferences.flush() //此处一定要flush，要不然不能永久序列化到本地
  }

  /**
   * 清除缓存的Preferences实例中的所有数据
   * @param preferenceName
   * @returns
   */
  static async clear() {
    let preferences = await PreferencesUtil.getPreferences(); //获取实例
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