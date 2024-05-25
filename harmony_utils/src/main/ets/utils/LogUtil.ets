import hilog from '@ohos.hilog'
import { BusinessError } from '@kit.BasicServicesKit'

const LOGGER_DOMAIN: number = 0x0000
const LOGGER_TAG: string = 'HarmonyLogUtil'

/**
 * 日志工具类
 */
export class LogUtil {
  private static domain: number = LOGGER_DOMAIN
  private static tag: string = LOGGER_TAG //日志Tag
  private static format: string = '%{public}s'
  private static showLog: boolean = true //是否显示打印日志


  /**
   * 初始化日志参数（该方法建议在Ability里调用）
   * @param domain
   * @param tag
   * @param showLog
   */
  static init(domain: number = LOGGER_DOMAIN, tag: string = LOGGER_TAG, showLog: boolean = true) {
    LogUtil.domain = domain
    LogUtil.tag = tag
    LogUtil.showLog = showLog
  }

  /**
   * 设置日志对应的领域标识，范围是0x0~0xFFFF。（该方法建议在Ability里调用）
   * @param domain
   */
  static setDomain(domain: number = LOGGER_DOMAIN) {
    LogUtil.domain = domain
  }

  /**
   * 设置日志标识（该方法建议在Ability里调用）
   * @param tag
   */
  static setTag(tag: string = LOGGER_TAG) {
    LogUtil.tag = tag
  }

  /**
   * 是否打印日志（该方法建议在Ability里调用）
   * @param showLog
   */
  static setShowLog(showLog: boolean = true) {
    LogUtil.showLog = showLog
  }

  /**
   * 打印DEBUG级别日志
   * @param args
   */
  static debug(...args: string[]): void {
    if (LogUtil.showLog) {
      hilog.debug(LogUtil.domain, LogUtil.tag, LogUtil.format.repeat(args.length), args)
    }
  }

  /**
   * 打印INFO级别日志
   * @param args
   */
  static info(...args: string[]): void {
    if (LogUtil.showLog) {
      hilog.info(LogUtil.domain, LogUtil.tag, LogUtil.format.repeat(args.length), args)
    }
  }

  /**
   * 打印WARN级别日志
   * @param args
   */
  static warn(...args: string[]): void {
    if (LogUtil.showLog) {
      hilog.warn(LogUtil.domain, LogUtil.tag, LogUtil.format.repeat(args.length), args)
    }
  }

  /**
   * 打印ERROR级别日志
   * @param args
   */
  static error(...args: string[]): void {
    if (LogUtil.showLog) {
      hilog.error(LogUtil.domain, LogUtil.tag, LogUtil.format.repeat(args.length), args)
    }
  }

  /**
   * 打印FATAL级别日志
   * @param args
   */
  static fatal(...args: string[]): void {
    if (LogUtil.showLog) {
      hilog.fatal(LogUtil.domain, LogUtil.tag, LogUtil.format.repeat(args.length), args)
    }
  }


  /**
   * 打印JSON对象和JSON字符串
   * @param obj
   */
  static print(obj: object | string) {
    try {
      if (typeof obj === 'object') {
        let str = JSON.stringify(obj, null, 2)
        let arr: string[] = str.split('\n')
        for (let index = 0; index < arr.length; index++) {
          console.debug(arr[index])
        }
      } else {
        obj = JSON.parse(obj)
        let str = JSON.stringify(obj, null, 2)
        let arr = str.split('\n')
        for (let index = 0; index < arr.length; index++) {
          console.debug(arr[index])
        }
      }
    } catch (err) {
      let error = err as BusinessError; //异常了，说明不是JSON字符串
      LogUtil.error(`LogUtil-print-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }


}

// export default new LogUtil() //单例（在ES6模块中，当你使用 import 导入一个模块时，实际上是在导入该模块的值的一个引用。这意味着在另一个模块中修改该值会影响原始模块中的值。）