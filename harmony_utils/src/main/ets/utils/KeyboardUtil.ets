import { inputMethodEngine } from '@kit.IMEKit';
import { LogUtil } from './LogUtil';

/**
 * 输入法键盘工具类
 */
export class KeyboardUtil {

  private constructor() {}

  /**
   * 隐藏键盘
   */
  static hide() {
    let controller: TextInputController = new TextInputController()
    controller.stopEditing()
  }


  /**
   * 订阅输入法软键盘显示或隐藏事件
   * @param callBack 返回boolen，true-键盘显示、false-键盘隐藏
   */
  static onKeyboardListener(callback: (show: boolean) => void) {
    try {
      inputMethodEngine.getInputMethodAbility().on('keyboardShow', () => {
        if (callback) {
          callback(true); //键盘显示
        }
      });
      inputMethodEngine.getInputMethodAbility().on('keyboardHide', () => {
        if (callback) {
          callback(false); //键盘隐藏
        }
      });
    } catch (err) {
      LogUtil.error(`订阅输入法软键盘显示或隐藏事件-异常： ${JSON.stringify(err)}`)
    }
  }


  /**
   * 取消订阅输入法软键盘显示或隐藏事件
   */
  static removeKeyboardListener() {
    try {
      inputMethodEngine.getInputMethodAbility().off('keyboardShow');
      inputMethodEngine.getInputMethodAbility().off('keyboardHide');
    } catch (err) {
      LogUtil.error(`取消订阅输入法软键盘显示或隐藏事件-异常： ${JSON.stringify(err)}`)
    }
  }


  /**
   * 订阅文本内容变化
   * @param callback 回调函数，返回订阅的文本内容。
   */
  static onInputTextChanged(callback: (text: string) => void) {
    try {
      inputMethodEngine.getKeyboardDelegate().on('textChange', callback);
    } catch (err) {
      LogUtil.error(`订阅文本内容变化-异常： ${JSON.stringify(err)}`)
    }
  }


  /**
   * 取消订阅文本内容变化
   */
  static removeInputTextChanged() {
    try {
      inputMethodEngine.getKeyboardDelegate().off('textChange');
    } catch (err) {
      LogUtil.error(`取消订阅文本内容变化-异常： ${JSON.stringify(err)}`)
    }
  }


}