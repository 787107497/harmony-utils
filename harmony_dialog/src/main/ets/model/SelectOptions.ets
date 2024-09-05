import { DialogOptions } from './base/DialogOptions';
import { ButtonOptions } from '../model/ButtonOptions';
import { NumberCalBack } from '../utils/CallBack';


/**
 * TODO 选择类弹出框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface SelectOptions extends DialogOptions {

  content?: ResourceStr; //弹框内容。
  confirm?: ButtonOptions | ResourceStr; //选择弹出框底部按钮。
  radioContent: Array<SheetInfo> | Array<string>; //选择弹出框的子项内容列表，每个选择项支持设置文本和选中的回调事件。
  onCheckedChanged: NumberCalBack; //选择回调
}