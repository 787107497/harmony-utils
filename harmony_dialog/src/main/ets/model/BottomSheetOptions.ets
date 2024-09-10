import { BaseDialogOptions } from './base/BaseDialogOptions';
import { SheetOptions } from '../model/SheetOptions';
import { ActionCallBack } from '../utils/constraint';

/**
 * TODO BottomSheet弹框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface BottomSheetOptions extends BaseDialogOptions {

  title?: ResourceStr; //弹框标题
  titleFontColor?: ResourceColor; //弹框标题的字体颜色。
  cancelValue?: ResourceStr; //取消按钮
  sheets: Array<SheetOptions> | Array<ResourceStr>; //BottomSheet弹出框操作区按钮。
  onAction: ActionCallBack; //按钮的CallBack事件。

  actionCancel?: boolean; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。默认值：true。
  height?: Dimension; //设置弹窗的高度。
  width?: Dimension; //设置弹窗的宽度。弹窗宽度默认最大值：400vp。
  backgroundColor?: ResourceColor; //弹窗背板颜色。默认值：Color.White
  backgroundBlurStyle?: BlurStyle; //弹窗背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK
  cornerRadius?: Length; //设置背板的圆角半径。可分别设置4个圆角的半径，默认15。
}