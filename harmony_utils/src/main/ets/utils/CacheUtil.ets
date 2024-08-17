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
export namespace CacheUtil {

  /**
   * 私有缓存对象
   */
  const cache: Record<string, Object> = {};


  /**
   * 存值
   * @param key 存入key
   * @param value 存入数据
   */
  export function save<T>(key: string, value: T): void {
    cache[key] = value as Object;
  }

  /**
   * 取值
   * @param key 存入的key
   * @returns
   */
  export function get<T>(key: string): T {
    return cache[key] as T;
  }

}
