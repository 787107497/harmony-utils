import { CacheUtil } from './CacheUtil';
import { DateUtil } from './DateUtil';

/**
 * TODO 节流、防抖 工具类（用于点击事件，防止按钮被重复点击）
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class ClickUtil {

  private constructor() {}

  private static throttleTimeoutID: number; //节流timeoutID
  private static flag: boolean = false; //节流flag,true=已经进入执行状态了
  private static defaultId: string = DateUtil.getTodayTime().toString(); //防抖Id


  /**
   * 节流：在一定时间内，只触发一次
   * @param func 要执行的回调函数
   * @param wait = 1500 延时的时间 毫秒
   * @param immediate = true 是否立即执行
   */
  static throttle(func: () => void, wait: number = 1000, immediate: boolean = true) {
    if (immediate) {
      if (!ClickUtil.flag) {
        ClickUtil.flag = true;
        typeof func === 'function' && func();
        ClickUtil.throttleTimeoutID = setTimeout(() => {
          ClickUtil.flag = false;
          clearTimeout(ClickUtil.throttleTimeoutID);
        }, wait);
      }
    } else {
      if (!ClickUtil.flag) {
        ClickUtil.flag = true;
        ClickUtil.throttleTimeoutID = setTimeout(() => {
          ClickUtil.flag = false;
          typeof func === 'function' && func();
          clearTimeout(ClickUtil.throttleTimeoutID);
        }, wait);
      }
    }
  }


  /**
   * 防抖：一定时间内，只有最后一次操作，再过wait毫秒后才执行函数
   * @param func 要执行的函数
   * @param wait 延时的时间
   * @param clickId 设置的点击事件id，用于区分多个点击事件，不传默认单个点击事件
   */
  static debounce(func: () => void, wait: number = 1000, clickId: string = ClickUtil.defaultId) {
    let cacheID = CacheUtil.get<number>(`ClickUtil_debounce_timeoutID_${clickId}`); //获取id
    if (cacheID !== undefined && cacheID !== null) {
      clearTimeout(cacheID);
    }
    let timeoutID = setTimeout(() => {
      typeof func === 'function' && func();
      clearTimeout(timeoutID);
    }, wait);
    CacheUtil.save<number>(`ClickUtil_debounce_timeoutID_${clickId}`, timeoutID); //缓存id
  }


}