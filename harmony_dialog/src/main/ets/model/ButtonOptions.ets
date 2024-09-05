/**
 * TODO Dialog按钮参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class ButtonOptions {
  value: ResourceStr = ''; //按钮的内容。
  fontColor?: ResourceColor; //按钮的字体颜色。
  action?: VoidCallback; //按钮的点击事件。
  background?: ResourceColor; //按钮的背景。
  buttonStyle?: ButtonStyleMode; //按钮的样式。默认值：2in1设备为ButtonStyleMode.NORMAL，其他设备为ButtonStyleMode.TEXTUAL。
  role?: ButtonRole; //按钮的角色。默认值：ButtonRole.NORMAL。
}
