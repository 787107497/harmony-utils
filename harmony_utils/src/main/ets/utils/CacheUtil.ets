/**
 * TODO 缓存工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class CacheUtil {
  private static cache: Record<string, Object> = {}; //私有缓存对象


  /**
   * 缓存中的数据是否存在
   * @param key 存入的key
   * @returns
   */
  static has(key: string): boolean {
    let value = CacheUtil.cache[key];
    return value != null && value != undefined;
  }


  /**
   * 将数据存入缓存中
   * @param key 存入key
   * @param value 存入数据
   */
  static put<T>(key: string, value: T): void {
    CacheUtil.cache[key] = value as Object;
  }


  /**
   * 获取缓存中的数据
   * @param key 存入的key
   * @returns
   */
  static get<T>(key: string): T {
    return CacheUtil.cache[key] as T;
  }


}
