import { instanceToInstance } from 'class-transformer';

/**
 * 对象工具类
 */
export class ObjectUtil {

  private constructor() {}


  /**
   * 判断是否是String
   * @param source
   * @returns
   */
  static isString(source: string | Object | ArrayBuffer | undefined | null) {
    return typeof source === 'string' || source instanceof String;
  }


  /**
   * 判断对象是否为空
   * @param source
   * @returns
   */
  static isNull(source: Object) {
    return source === null || source === undefined;
  }


  /**
   * 深度拷贝对象
   * @param obj 被拷贝对象
   * @returns
   */
  static deepCopy(obj: Object) {
    return instanceToInstance(obj);
  }


}