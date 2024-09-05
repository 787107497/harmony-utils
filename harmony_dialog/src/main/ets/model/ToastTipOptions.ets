import { ToastOptions } from './ToastOptions';

/**
 * TODO ToastTip基本参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface ToastTipOptions extends ToastOptions {

  message: string | Resource; //吐司内容
  imageRes: ResourceStr | PixelMap; //展示的图片。
  imageSize?: SizeOptions; //自定义图片尺寸。默认值：64*64vp

}