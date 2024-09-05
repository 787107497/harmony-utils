import { BaseDialogOptions } from './base/BaseDialogOptions';

/**
 * TODO Toast基本参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface ToastOptions extends BaseDialogOptions {

  message?: string | Resource; //吐司内容
  duration?: number; //显示时长(1500ms-10000ms)
  fontSize?: number | string | Resource; //文字大小
  fontColor?: ResourceColor; //文字颜色
  backgroundColor?: ResourceColor; //背景颜色，建议八位色值前两位为透明度
  borderRadius?: Length | BorderRadiuses; //背景圆角
  padding?: Padding | Length; //Padding

}