let flag: boolean = false; //节流flag,true=已经进入执行状态了
let throttleTimer: number //节流
let debounceTimer: number //防抖

/**
 * 节流、防抖 工具类（用于点击事件，防止按钮被重复点击）
 */
export class ClickUtil {

  private constructor() {}

  /**
   * 节流：在一定时间内，只触发一次
   * @param func 要执行的回调函数
   * @param wait = 800 延时的时间 毫秒
   * @param immediate = true 是否立即执行
   */
  static throttle(func: () => void, wait: number = 800, immediate: boolean = true) {
    if (immediate) {
      if (!flag) {
        flag = true
        typeof func === 'function' && func()
        throttleTimer = setTimeout(() => {
          flag = false
          clearTimeout(throttleTimer)
        }, wait)
      }
    } else if (!flag) {
      flag = true
      throttleTimer = setTimeout(() => {
        flag = false
        typeof func === 'function' && func()
        clearTimeout(throttleTimer)
      }, wait)
    }
  }


  /**
   * 防抖：一定时间内，只有最后一次操作，再过wait毫秒后才执行函数
   * @param func 要执行的函数
   * @param wait 延时的时间
   */
  static debounce(func: () => void, wait: number = 800) {
    if (debounceTimer !== null) { //清除定时器
      clearTimeout(debounceTimer)
    }
    debounceTimer = setTimeout(() => {
      typeof func === 'function' && func()
      clearTimeout(debounceTimer)
    }, wait)
  }


}