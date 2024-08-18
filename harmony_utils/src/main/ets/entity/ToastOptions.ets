import { promptAction } from '@kit.ArkUI';

/**
 * TODO Toast基本参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class ToastOptions {
  duration?: number; //显示时长(1500ms-10000ms)
  bottom?: string | number; //距离屏幕底部的位置
  showMode?: promptAction.ToastShowMode; //是否显示在应用之上
  alignment?: Alignment; //对齐方式。默认值：undefined，默认底部偏上位置。
  offset?: Offset //在对齐方式上的偏移。 默认值：{dx:0, dy:0}，默认没有偏移。
}