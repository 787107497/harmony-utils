import { inputMethodEngine } from '@kit.IMEKit';
import { LogUtil } from './LogUtil';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * 输入法键盘工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class KeyboardUtil {

  private constructor() {}

  /**
   * 隐藏键盘
   */
  static hide(controller: TextInputController) {
    controller?.stopEditing()
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
      let error = err as BusinessError;
      LogUtil.error(`KeyboardUtil-onKeyboardListener-异常 ~ code: ${error.code} -·- message: ${error.message}`);
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
      let error = err as BusinessError;
      LogUtil.error(`KeyboardUtil-removeKeyboardListener-异常 ~ code: ${error.code} -·- message: ${error.message}`);
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
      let error = err as BusinessError;
      LogUtil.error(`KeyboardUtil-onInputTextChanged-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }


  /**
   * 取消订阅文本内容变化
   */
  static removeInputTextChanged() {
    try {
      inputMethodEngine.getKeyboardDelegate().off('textChange');
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`KeyboardUtil-removeInputTextChanged-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }


}