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
      promptAction.showToast({
        message: message,
        duration: options?.duration ?? TOAST_DURATION,
        bottom: options?.bottom ?? TOAST_BOTTOM,
        showMode: options?.showMode ?? promptAction.ToastShowMode.DEFAULT,
        alignment: options?.alignment ?? Alignment.Center,
        offset: options?.offset
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
      promptAction.showToast({
        message: message,
        duration: TOAST_DURATION_SHORT,
        bottom: options?.bottom ?? TOAST_BOTTOM,
        showMode: options?.showMode ?? promptAction.ToastShowMode.DEFAULT,
        alignment: options?.alignment ?? Alignment.Center,
        offset: options?.offset
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
      promptAction.showToast({
        message: message,
        duration: TOAST_DURATION_LONG,
        bottom: options?.bottom ?? TOAST_BOTTOM,
        showMode: options?.showMode ?? promptAction.ToastShowMode.DEFAULT,
        alignment: options?.alignment,
        offset: options?.offset
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
  showMode?: promptAction.ToastShowMode = promptAction.ToastShowMode.DEFAULT; //是否显示在应用之上
  alignment?: Alignment; // 对齐方式。默认值：undefined，默认底部偏上位置。
  offset?: Offset //在对齐方式上的偏移。 默认值：{dx:0, dy:0}，默认没有偏移。
}