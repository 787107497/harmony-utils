import { ActionCallBack } from '../../utils/CallBack';


/**
 * TODO 弹窗工具类，Base参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface BaseDialogOptions {
  onAction?: ActionCallBack; //按钮的CallBack事件。
  backCancel?: boolean; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。true表示关闭弹窗。false表示不关闭弹窗。默认值：true。

  dialogId?: string; //弹框id，具有唯一性
  alignment?: DialogAlignment; //弹窗的对齐方式。
  offset?: Offset; //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0, dy: 0 }
  maskRect?: Rectangle; //弹窗遮蔽层区域，在遮蔽层区域内的事件不透传，在遮蔽层区域外的事件透传。
  maskColor?: ResourceColor; //自定义蒙层颜色。默认值 0x33000000
  isModal?: boolean; //弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层。默认值：true，此时弹窗有蒙层。
  showInSubWindow?: boolean; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
  autoCancel?: boolean; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹窗。默认值：true
  transition?: TransitionEffect; //设置弹窗显示和退出的过渡效果。
  onWillAppear?: VoidCallback; //弹窗显示动效前的事件回调。
  onWillDisappear?: VoidCallback; //弹窗退出动效前的事件回调。
  onDidAppear?: VoidCallback; //弹窗弹出时的事件回调。
  onDidDisappear?: VoidCallback; //弹窗消失时的事件回调。
  onWillDismiss?: Callback<DismissDialogAction>; //交互式关闭回调函数。

}