import preferences from '@ohos.data.preferences'
import dataPreferences from '@ohos.data.preferences'


const defaultPreferenceName: string = "SP_EYE_PREFERENCES"

/**
 * Preferences工具类
 */
export class PreferencesUtil{

  private constructor() {}

  static readonly context = getContext()


  /**
   * 获取Preferences实例
   * @param name
   * @returns
   */
  private static async getPreferences(name: string = defaultPreferenceName): Promise<preferences.Preferences> {
    return dataPreferences.getPreferences(PreferencesUtil.context, name)
  }

  /**
   * 将数据缓存
   * @param key
   * @param value
   * @param preferenceName
   */
  static async put(key: string, value: preferences.ValueType, preferenceName: string = defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName) //获取实例
    await preferences.put(key, value)
    await preferences.flush() //此处一定要flush，要不然不能永久序列化到本地
  }

  /**
   * 获取缓存值
   * @param key
   * @param defValue
   * @param preferenceName
   * @returns
   */
  static async get(key: string, defValue: preferences.ValueType, preferenceName: string = defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName) //获取实例
    return preferences.get(key, defValue)
  }

  /**
   * 获取string类型的缓存值
   * @param key
   * @returns
   */
  static getString(key: string, callback: (value: string) => void) {
    PreferencesUtil.get(key, "").then((value) => {
      if (callback) {
        callback(value as string)
      }
    })
  }

  /**
   * 获取number类型的缓存值
   * @param key
   * @returns
   */
  static async getNumber(key: string, callback: (value: number) => void) {
    PreferencesUtil.get(key, 0).then((value) => {
      if (callback) {
        callback(value as number)
      }
    })
  }

  /**
   * 获取boolean类型的缓存值
   * @param key
   * @param defValue
   * @param preferenceName
   * @returns
   */
  static async getBoolean(key: string, callback: (value: boolean) => void) {
    PreferencesUtil.get(key, false).then((value) => {
      if (callback) {
        callback(value as boolean)
      }
    })
  }

  /**
   * 检查缓存的Preferences实例中是否包含名为给定Key的存储键值对
   * @param key
   * @param preferenceName
   * @returns
   */
  static async has(key: string, preferenceName: string = defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName) //获取实例
    return await preferences.has(key)
  }

  /**
   * 删除缓存值
   * @param key
   * @param preferenceName
   * @returns
   */
  static async delete(key: string, preferenceName: string = defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName) //获取实例
    return await preferences.delete(key)
  }

  /**
   * 清空缓存
   * @param preferenceName
   * @returns
   */
  static async clear(preferenceName: string = defaultPreferenceName) {
    let preferences = await PreferencesUtil.getPreferences(preferenceName) //获取实例
    return await preferences.clear()
  }


}