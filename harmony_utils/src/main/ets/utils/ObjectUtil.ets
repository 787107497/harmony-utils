import { instanceToInstance } from 'class-transformer';
import util from '@ohos.util';

/**
 * 对象工具类
 */
export class ObjectUtil {

  private constructor() {}


  /**
   * 获取对象的Hash值。如果是第一次获取，则计算Hash值并保存到对象的Hash域（返回随机的Hash值）；如果不是第一次获取，则从Hash域中获取并返回Hash值（同一对象多次返回值保持不变）。
   * @param object
   * @returns
   */
  static getHash(object: object): number {
    return util.getHash(object);
  }


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