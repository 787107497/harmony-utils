import { BaseDialogOptions } from '@pura/harmony-dialog';

export class LoadOptions implements BaseDialogOptions {

  dialogId?: string;
  backCancel?: boolean = false; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。true表示关闭弹窗。false表示不关闭弹窗。默认值：true。
  autoCancel: boolean = false; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹窗。默认值：true

  content: ResourceStr = '加载中'; //加载动画的提示文字
  fontSize: number | string | Resource = 15; //加载动画的文字大小
  fontColor: ResourceColor = "#FFFFFF"; //加载动画的文字颜色
  marginTop: number | string | Resource = 2 //文字与动画的间距

  padding: Padding | Length = { left: 10, right: 10, top: 10, bottom: 12 }; //padding
  backgroundColor: ResourceColor = '#CC000000'; //加载动画背景颜色，建议八位色值前两位为透明度

}