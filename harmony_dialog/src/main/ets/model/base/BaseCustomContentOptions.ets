import { DialogOptions } from './DialogOptions';

/**
 * TODO 自定义内容区弹出框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface BaseCustomContentOptions extends DialogOptions {

  primaryTitle?: ResourceStr; //弹出框标题。
  secondaryTitle?: ResourceStr; //弹出框辅助文本。
  contentBuilder: () => void; //弹出框内容。
  localizedContentAreaPadding?: LocalizedPadding; //弹出框内容区内边距。
  contentAreaPadding?: Padding; //弹出框内容区内边距。设置了localizedContentAreaPadding属性时该属性不生效。

}