import promptAction from '@ohos.promptAction';


const TOAST_DURATION: number = 2000; //显示时长(1500ms-10000ms)
const TOAST_DURATION_SHORT: number = 1500; //显示时长(1500ms)
const TOAST_DURATION_LONG: number = 10000; //显示时长(10000ms)
const TOAST_BOTTOM: string = '80vp'; //距离屏幕底部的位置


/**
 * 土司工具类
 */
export class ToastUtil {

  private constructor() {}


  /**
   * 弹出土司,默认时长为2s,距离底部默认为80vp
   * @param message 提示消息
   * @param options (显示时长、距离屏幕底部的位置、是否显示在应用之上)
   */
  static showToast(message: string | Resource, options?: ToastOptions) {
    if ((typeof message === 'string' && message.length > 0) || message) {
      if (!options) {
        options = new ToastOptions()
      }
      promptAction.showToast({
        message: message,
        duration: options.duration,
        bottom: options.bottom,
        showMode: options.showMode
      })
    }
  }


  /**
   * 弹出土司,时长为:1.5s,距离底部默认为80vp
   * @param message 提示消息
   * @param options (距离屏幕底部的位置、是否显示在应用之上)
   */
  static showShort(message: string | Resource, options?: ToastOptions) {
    if ((typeof message === 'string' && message.length > 0) || message) {
      if (!options) {
        options = new ToastOptions()
      }
      promptAction.showToast({
        message: message,
        duration: TOAST_DURATION_SHORT,
        bottom: options.bottom,
        showMode: options.showMode
      })
    }
  }


  /**
   * 弹出土司,时长为:10s,距离底部默认为80vp
   * @param message 提示消息
   * @param options (距离屏幕底部的位置、是否显示在应用之上)
   */
  static showLong(message: string | Resource, options?: ToastOptions) {
    if ((typeof message === 'string' && message.length > 0) || message) {
      if (!options) {
        options = new ToastOptions()
      }
      promptAction.showToast({
        message: message,
        duration: TOAST_DURATION_LONG,
        bottom: options.bottom,
        showMode: options.showMode,
      })
    }
  }

}


/**
 * Toast参数类
 */
export class ToastOptions {
  duration?: number = TOAST_DURATION; //显示时长(1500ms-10000ms)
  bottom?: string | number = TOAST_BOTTOM; //距离屏幕底部的位置
  showMode?: promptAction.ToastShowMode = promptAction.ToastShowMode.TOP_MOST; //是否显示在应用之上
}