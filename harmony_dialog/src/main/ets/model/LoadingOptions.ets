import { BaseDialogOptions } from './base/BaseDialogOptions';


/**
 * TODO 加载框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface LoadingOptions extends BaseDialogOptions {

  loadSize?: number; //加载动画或进度条的大小
  loadColor?: ResourceColor; //加载动画的颜色
  content?: ResourceStr; //加载动画的提示文字
  fontSize?: number | string | Resource; //加载动画的文字大小
  fontColor?: ResourceColor; //加载动画的文字颜色
  backgroundColor?: ResourceColor; //加载动画背景颜色，建议八位色值前两位为透明度
  borderRadius?: Length | BorderRadiuses; //加载动画背景圆角

}
