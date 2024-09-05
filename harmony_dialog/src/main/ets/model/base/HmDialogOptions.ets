import { DialogOptions } from './DialogOptions';
import { ButtonOptions } from '../ButtonOptions';

/**
 * TODO 确认弹出框，Base参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface HmDialogOptions extends DialogOptions {

  content: ResourceStr; //弹框内容。
  primaryButton?: ButtonOptions | ResourceStr; //弹框左侧按钮。
  secondaryButton?: ButtonOptions | ResourceStr; //弹框右侧按钮。

}