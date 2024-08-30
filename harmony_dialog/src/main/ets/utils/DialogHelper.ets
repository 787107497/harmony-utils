import { DialogParams } from '../model/DialogParams';
import { buildAlertDialogView, tipsDialogBuilder } from './DialogView';
import { BasePromptAction } from './BasePromptAction';

/**
 * TODO Dialog帮助工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
export class DialogHelper {
  static showTipsDialog(param: DialogParams) {
    BasePromptAction.getInstance().openCustomDialog(wrapBuilder(tipsDialogBuilder), param);
  }


  static show1(param: DialogParams) {
    BasePromptAction.getInstance().openCustomDialog(wrapBuilder(buildAlertDialogView), param);
  }


  // static show(confirmInfo: ConfirmInfo, delay: number = -1,): string {
  //   let confirmSettings = new ConfirmSettings(confirmInfo)
  //   PromptActionUtils.getInstance()
  //     .openCustomDialog<ConfirmSettings>(wrapBuilder(ConfirmDialogBuilder), confirmSettings,
  //       {
  //         alignment: DialogAlignment.Center,
  //         onWillDismiss: () => {
  //         }
  //       })
  //   if (delay > 0) {
  //     setTimeout(() => {
  //       ConfirmDialogUtils.dismiss(confirmSettings.dialogId)
  //     }, delay)
  //   }
  //   return confirmSettings.dialogId
  // }


}