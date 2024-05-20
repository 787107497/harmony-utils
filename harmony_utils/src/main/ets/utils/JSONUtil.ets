import { ClassConstructor, instanceToPlain, plainToClass } from 'class-transformer'
import { LogUtil } from './LogUtil'

/**
 * JSON工具类
 */
export class JSONUtil {

  private constructor() {}


  /**
   * JSON字符串转Class对象
   * @param cls 类名
   * @param jsonStr JSON字符串
   * @returns
   */
  static jsonToBean<T>(cls: ClassConstructor<T>, jsonStr: string): T | null {
    try {
      return plainToClass(cls, JSON.parse(jsonStr), {
        enableImplicitConversion: false, exposeDefaultValues: true
      }) as T
    } catch (err) {
      LogUtil.error(`jsonToBean-异常信息：${JSON.parse(err)}`)
      return null
    }
  }


  /**
   * JSON字符串转Array
   * @param cls 类名
   * @param jsonStr JSON字符串
   * @returns
   */
  static jsonToArray<T>(cls: ClassConstructor<T>, jsonStr: string): Array<T> {
    try {
      return plainToClass(cls, JSON.parse(jsonStr), {
        enableImplicitConversion: false, exposeDefaultValues: true
      }) as Array<T>
    } catch (err) {
      LogUtil.error(`jsonToList-异常信息：${JSON.parse(err)}`)
      return []
    }
  }


  /**
   * 对象转字符串
   * @param data
   * @returns 字符串
   */
  static beanToJsonStr(data: Object | Array<Object | String | Number | Boolean> | null | undefined): string {
    try {
      if (data == null || data == undefined) {
        return ''
      }
      return JSON.stringify(instanceToPlain(data))
    } catch (err) {
      LogUtil.error(`beanToJsonStr-异常信息：${JSON.parse(err)}`)
      return ""
    }
  }


  /**
   * JSON转Map
   * @param jsonStr
   * @returns
   */
  static jsonToMap(jsonStr: string): Map<string, Object> {
    return new Map(Object.entries(JSON.parse(jsonStr)));
  }


  /**
   * 判断是否是字符串格式json
   * @param str 待验证字符串
   * @returns
   */
  static isJSONStr(str: string): boolean {
    try {
      JSON.parse(str);
      return true;
    } catch (error) {
      return false;
    }
  }


}