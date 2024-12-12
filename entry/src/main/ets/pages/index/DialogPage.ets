import { AreaHelper } from '@nutpi/china_area';
import { AnimationHelper, DialogAction, DialogHelper } from '@pura/harmony-dialog';
import { LogUtil, ToastUtil } from '@pura/harmony-utils';
import { SpinType } from '@pura/spinkit';
import { LabelButton } from '../../component/LabelButton';
import { DrawerOptions } from '../../utils/DrawerOptions';
import { MyCustomOptions } from '../../utils/MyCustomOptions';

/**
 * TODO 弹窗工具
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
@Preview
@Component
export struct DialogPage {
  private controller: TextInputController = new TextInputController();
  private scroller: Scroller = new Scroller();
  @State menuArray: Array<string> = ["相机", "相册", "文件管理器"];
  @State inputText: string = ""; //输入框内容
  @State progress: number = 1;
  private likes: string[] =
    ['乒乓球', '鸿蒙手机', 'ArkTS', 'Mate70Pro', '三折叠手机', '小米su7', '红米K80pro', '广东名菜龙虎斗'];
  private years: string[] = ['2020年', '2021年', '2022年', '2023年', '2024年', '2025年', '2026年', '2027年', '2028年'];
  private months: string[] = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
  private days: string[] = ['1日', '2日', '3日', '4日', '5日', '6日', '7日', '8日', '9日', '10日', '11日', '12日', '13日', '14日', '15日', '16日'];
  private multis: string[][] = [this.years, this.months, this.days];

  /**
   * 统一配置一
   */
  customConfig1() {
    DialogHelper.setDefaultConfig((config) => {
      config.uiContext = this.getUIContext()
      config.autoCancel = false; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。
      config.backCancel = false; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
      config.actionCancel = true; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。
      config.alignment = DialogAlignment.Center; //弹窗的对齐方式。
      config.offset = { dx: 0, dy: 0 }; //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0, dy: 0 }
      config.maskColor = 0x11000000; //自定义蒙层颜色。默认值 0x33000000
      config.backgroundColor = Color.White; //弹窗背板颜色。默认值：Color.White
      config.backgroundBlurStyle = BlurStyle.COMPONENT_ULTRA_THICK; //弹窗背板模糊材质
      config.cornerRadius = 35; //设置背板的圆角半径。可分别设置4个圆角的半径。

      config.title = '友好提示'; //弹框标题
      config.primaryButton = '取消'; //弹框左侧按钮。
      config.secondaryButton = '确定'; //弹框右侧按钮。
      config.imageRes = undefined; //TipsDialog用到，展示的图片。
      config.imageSize = { width: '64vp', height: '64vp' }; //TipsDialog用到，自定义图片尺寸。默认值：64*64vp

      config.loading_loadSize = 60; //加载动画或进度条的大小
      config.loading_loadColor = Color.White; //加载动画或进度条的颜色
      config.loading_content = ''; //加载动画的提示文字
      config.loading_fontSize = 16; //文字大小
      config.loading_fontColor = Color.White; //文字颜色
      config.loading_backgroundColor = '#CC094CD1'; //背景颜色，八位色值前两位为透明度
      config.loading_borderRadius = 10; //背景圆角

      config.toast_fontSize = 16; //文字大小
      config.toast_fontColor = Color.Black; //文字颜色
      config.toast_backgroundColor = '#CC56D866'; //背景颜色，建议八位色值前两位为透明度
      config.toast_borderRadius = 8; //背景圆角
      config.toast_padding = { left: 16, right: 16, top: 12, bottom: 12 }; //Padding
      config.toast_imageSize = { width: 45, height: 45 }; //Tip图片尺寸。默认值：45*45vp
      config.toast_duration = 1500; //显示时长(1500ms-10000ms)
      config.toast_durationLong = 5000; //显示时长
    });
    ToastUtil.showToast("统一配置设置成功！");

    // WindowUtil.createWindow({
    //   contentRouter:"pages/utils/ToastUtilPage"
    // })

  }

  /**
   * 统一配置二
   */
  customConfig2() {
    DialogHelper.setDefaultConfig((config) => {
      config.autoCancel = false; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。
      config.backCancel = false; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
      config.actionCancel = true; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。
      config.alignment = DialogAlignment.Bottom; //弹窗的对齐方式。
      config.offset = { dx: 0, dy: -35 }; //弹窗相对alignment所在位置的偏移量。
      config.maskColor = 0x11000000; //自定义蒙层颜色。默认值 0x33000000
      config.backgroundColor = Color.White; //弹窗背板颜色。默认值：Color.White
      config.backgroundBlurStyle = BlurStyle.COMPONENT_ULTRA_THICK; //弹窗背板模糊材质
      config.cornerRadius = 20; //设置背板的圆角半径。可分别设置4个圆角的半径。

      config.title = '提示'; //弹框标题
      config.primaryButton = '取消'; //弹框左侧按钮。
      config.secondaryButton = '确定'; //弹框右侧按钮。
      config.imageRes = undefined; //TipsDialog用到，展示的图片。
      config.imageSize = { width: '64vp', height: '64vp' }; //TipsDialog用到，自定义图片尺寸。

      config.loading_loadSize = 60; //加载动画或进度条的大小
      config.loading_loadColor = Color.White; //加载动画或进度条的颜色
      config.loading_content = ''; //加载动画的提示文字
      config.loading_fontSize = 16; //文字大小
      config.loading_fontColor = Color.White; //文字颜色
      config.loading_backgroundColor = '#CC56D866'; //背景颜色，八位色值前两位为透明度
      config.loading_borderRadius = 10; //背景圆角

      config.toast_fontSize = 16; //文字大小
      config.toast_fontColor = Color.Black; //文字颜色
      config.toast_backgroundColor = '#CC0FCEE3'; //背景颜色，建议八位色值前两位为透明度
      config.toast_borderRadius = 8; //背景圆角
      config.toast_padding = { left: 16, right: 16, top: 12, bottom: 12 }; //Padding
      config.toast_imageSize = { width: 45, height: 45 }; //Tip图片尺寸。默认值：45*45vp
      config.toast_duration = 1500; //显示时长(1500ms-10000ms)
      config.toast_durationLong = 5000; //显示时长
    });
    ToastUtil.showToast("统一配置设置成功！");
  }

  /**
   * 默认的配置
   */
  defaultConfig() {
    DialogHelper.setDefaultConfig((config) => {
      config.autoCancel = true; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹窗。默认值：true
      config.backCancel = true; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。true表示关闭弹窗。false表示不关闭弹窗。默认值：true。
      config.actionCancel = true; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。默认值：true。
      config.alignment = DialogAlignment.Center; //弹窗的对齐方式。
      config.offset = { dx: 0, dy: 0 }; //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0, dy: 0 }
      config.maskColor = 0x33000000; //自定义蒙层颜色。默认值 0x33000000
      config.backgroundColor = Color.White; //弹窗背板颜色。默认值：Color.White
      config.backgroundBlurStyle = BlurStyle.COMPONENT_ULTRA_THICK; //弹窗背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK
      config.cornerRadius = 20; //设置背板的圆角半径。可分别设置4个圆角的半径。

      config.title = '温馨提示'; //弹框标题
      config.primaryButton = '取消'; //弹框左侧按钮。
      config.secondaryButton = '确定'; //弹框右侧按钮。
      config.imageRes = undefined; //TipsDialog用到，展示的图片。
      config.imageSize = { width: '64vp', height: '64vp' }; //TipsDialog用到，自定义图片尺寸。默认值：64*64vp

      config.loading_loadSize = 60; //加载动画或进度条的大小
      config.loading_loadColor = Color.White; //加载动画或进度条的颜色
      config.loading_content = ''; //加载动画的提示文字
      config.loading_fontSize = 16; //文字大小
      config.loading_fontColor = Color.White; //文字颜色
      config.loading_backgroundColor = '#CC000000'; //背景颜色，八位色值前两位为透明度
      config.loading_borderRadius = 10; //背景圆角

      config.toast_fontSize = 16; //文字大小
      config.toast_fontColor = Color.White; //文字颜色
      config.toast_backgroundColor = '#CC000000'; //背景颜色，建议八位色值前两位为透明度
      config.toast_borderRadius = 8; //背景圆角
      config.toast_padding = { left: 16, right: 16, top: 12, bottom: 12 }; //Padding
      config.toast_imageSize = { width: 45, height: 45 }; //Tip图片尺寸。默认值：45*45vp
      config.toast_duration = 2000; //显示时长(1500ms-10000ms)
      config.toast_durationLong = 10000; //显示时长(10000ms)
    });
    ToastUtil.showToast("默认配置,设置成功！");
  }

  /**
   * 操作确认类弹出框
   */
  alertDialog(index: number) {
    if (index == 0) {
      //简单使用
      DialogHelper.showAlertDialog({
        content: "确定保存该WPS文件吗？",
        onAction: (action) => {
          if (action == DialogAction.CANCEL) {
            ToastUtil.showToast(`您点击了取消按钮`);
          } else if (action == DialogAction.SURE) {
            ToastUtil.showToast(`您点击了确认按钮`);
          }
        }
      })
    } else if (index == 1) {
      //自定义按钮颜色
      DialogHelper.showAlertDialog({
        title: "提示",
        content: "确定保存该视频文件吗？",
        // primaryButton: {
        //   value: "取消",
        //   fontColor: Color.Red
        // },
        secondaryButton: {
          value: "确认",
          fontColor: Color.Brown
        },
        onAction: (action) => {
          if (action == DialogAction.CANCEL) {
            ToastUtil.showToast(`您取消了保存`);
          } else if (action == DialogAction.SURE) {
            ToastUtil.showToast(`已保存`);
          }
        }
      })
    } else if (index == 2) {
      //自定义按钮和二级标题
      DialogHelper.showAlertDialog({
        primaryTitle: "提示",
        secondaryTitle: "保存前请确认文件",
        content: "确定保存该视频文件吗",
        primaryButton: "取消",
        secondaryButton: $r('app.string.btn_save'),
        onAction: (action) => {
          if (action == DialogAction.CANCEL) {
            ToastUtil.showToast(`您取消了保存`);
          } else if (action == DialogAction.SURE) {
            ToastUtil.showToast(`已保存`);
          }
        }
      })
    } else {
      //不带标题，不主动关闭弹框
      DialogHelper.showAlertDialog({
        title: "",
        content: "确定保存该视频文件吗",
        actionCancel: false, //点击操作按钮不关闭弹框
        autoCancel: false, //点击遮障层时，不关闭弹窗
        backCancel: false, //点击返回键，不关闭弹窗
        onAction: (action, dialogId) => {
          DialogHelper.closeDialog(dialogId); //关闭弹框
          if (action == DialogAction.CANCEL) {
            ToastUtil.showToast(`您取消了保存`);
          } else if (action == DialogAction.SURE) {
            ToastUtil.showToast(`已保存`);
          }
        }
      })
    }
  }

  /**
   * 信息确认类弹出框
   */
  confirmDialog(index: number) {
    if (index == 0) {
      //简单使用
      DialogHelper.showConfirmDialog({
        checkTips: "是否记住密码？",
        content: "您是否退出当前应用",
        onCheckedChange: (check) => {
          ToastUtil.showToast(`${check}`);
        },
        onAction: (action) => {
          ToastUtil.showToast(`${action}`);
        }
      })
    } else if (index == 1) {
      //自定义按钮
      DialogHelper.showConfirmDialog({
        checkTips: "是否记住密码？",
        content: "您是否退出当前应用",
        primaryButton: { value: "取消", fontColor: Color.Orange },
        secondaryButton: "退出",
        onCheckedChange: (check) => {
          ToastUtil.showToast(`${check}`);
        },
        onAction: (action) => {
          ToastUtil.showToast(`${action}`);
        }
      })
    } else if (index == 2) {
      //不显示标题
      DialogHelper.showConfirmDialog({
        title: "",
        checkTips: "是否记住密码？",
        content: "您是否退出当前应用",
        onCheckedChange: (check) => {
          ToastUtil.showToast(`${check}`);
        },
        onAction: (action) => {
          ToastUtil.showToast(`${action}`);
        }
      })
    } else {
      //底部弹出
      DialogHelper.showConfirmDialog({
        checkTips: "是否记住密码？",
        content: "您是否退出当前应用",
        alignment: DialogAlignment.Bottom, //底部弹出
        offset: { dx: 0, dy: -35 },
        autoCancel: false, //点击遮障层时，不关闭弹窗
        onCheckedChange: (check) => {
          ToastUtil.showToast(`${check}`);
        },
        onAction: (action) => {
          ToastUtil.showToast(`${action}`);
        }
      })
    }
  }

  /**
   * 提示弹出框
   */
  tipsDialog(index: number) {
    if (index == 0) {
      //简单使用
      DialogHelper.showTipsDialog({
        uiContext:this.getUIContext(),
        content: '想要卸载这个APP嘛?',
        showInSubWindow:false,
        onAction: (action) => {
          ToastUtil.showToast(`${action}`);
        }
      })
    } else if (index == 1) {
      //自定义图标和图标大小
      DialogHelper.showTipsDialog({
        imageRes: $r('sys.media.ohos_app_icon'),
        imageSize: { width: 50, height: 50 },
        content: '想要卸载这个APP嘛?',
        onAction: (action) => {
          ToastUtil.showToast(`${action}`);
        }
      })
    } else if (index == 2) {
      //自定义图标和按钮
      DialogHelper.showTipsDialog({
        imageRes: $r('app.media.icon_tip_warn'),
        content: '想要卸载这个APP嘛?',
        primaryButton: "卸载",
        onAction: (action) => {
          ToastUtil.showToast(`${action}`);
        }
      })
    } else {
      //自定义
      DialogHelper.showTipsDialog({
        imageRes: $r('sys.media.ohos_app_icon'),
        imageSize: { width: 50, height: 50 },
        content: '想要卸载这个APP嘛?',
        checkTips: "是否删除缓存文件",
        onCheckedChange: (check) => {
          ToastUtil.showToast(`${check}`);
        },
        primaryButton: {
          value: "取消",
          fontColor: Color.Black
        },
        secondaryButton: {
          value: "卸载",
          fontColor: Color.Red
        },
        onAction: (action) => {
          ToastUtil.showToast(`${action}`);
        }
      })
    }
  }

  /**
   * 选择类弹出框
   */
  selectDialog(index: number) {
    if (index == 0) {
      //简单使用
      DialogHelper.showSelectDialog({
        radioContent: ["文本菜单选项一", "文本菜单选项二", "文本菜单选项三", "文本菜单选项四", "文本菜单选项五"],
        onCheckedChanged: (index) => {
          ToastUtil.showToast(`${index}`);
        },
        onAction: (action, dialogId, value) => {
          ToastUtil.showToast(`${action} --- ${value}`);
        }
      })
    } else if (index == 1) {
      //自定义标题，内容，底部弹出框
      DialogHelper.showSelectDialog({
        title: "请选择",
        content: "选择您中意的文本菜单",
        alignment: DialogAlignment.Bottom, //底部弹出
        offset: { dx: 0, dy: -35 },
        autoCancel: false, //点击遮障层时，不关闭弹窗
        radioContent: ["文本菜单选项一", "文本菜单选项二", "文本菜单选项三", "文本菜单选项四", "文本菜单选项五"],
        onCheckedChanged: (index) => {
          ToastUtil.showToast(`${index}`);
        },
        onAction: (action, dialogId, value) => {
          ToastUtil.showToast(`${action} --- ${value}`);
        }
      })
    } else if (index == 2) {
      //自定义标题，内容，底部弹出框
      DialogHelper.showSelectDialog({
        title: "请选择菜单",
        content: "选择您中意的文本菜单",
        autoCancel: false, //点击遮障层时，不关闭弹窗
        radioContent: [{
          title: "文本菜单选项一",
          icon: $r('app.media.icon_tip_warn'),
          action: () => {
          }
        },
          {
            title: "文本菜单选项二",
            icon: $r('sys.media.ohos_ic_public_voice'),
            action: () => {
            }
          },
          {
            title: "文本菜单选项三",
            icon: $r('sys.media.ohos_ic_public_voice'),
            action: () => {
            }
          },
          {
            title: "文本菜单选项四",
            icon: $r('sys.media.ohos_ic_public_voice'),
            action: () => {
            }
          },
          {
            title: "文本菜单选项五",
            icon: $r('sys.media.ohos_ic_public_voice'),
            action: () => {
            }
          }],
        onCheckedChanged: (index) => {
          ToastUtil.showToast(`${index}`);
        },
        onAction: (action, dialogId, value) => {
          ToastUtil.showToast(`${action} --- ${value}`);
        }
      })
    }
  }

  /**
   * 单行文本输入弹出框
   */
  textInputDialog(index: number) {
    if (index == 0) {
      //简单使用
      DialogHelper.showTextInputDialog({
        text: this.inputText,
        onAction: (action, dialogId, content) => {
          if (action == DialogAction.SURE) {
            this.inputText = content;
            ToastUtil.showToast(content);
          }
        }
      })
    } else if (index == 1) {
      //自定义按钮、标题、边距等
      DialogHelper.showTextInputDialog({
        title: "工作人员姓名",
        placeholder: "请输入工作人员姓名",
        inputType: InputType.Normal,
        text: this.inputText,
        alignment: DialogAlignment.Bottom,
        offset: { dx: 0, dy: -35 },
        contentAreaPadding: { top: 12, bottom: 16, left: 15, right: 15 },
        buttons: ["确认"],
        onChange: (text) => {
          console.error("onChange: " + text);
        },
        onAction: (action, dialogId, content) => {
          this.inputText = content;
        }
      })
    } else if (index == 2) {
      //不带标题的
      DialogHelper.showTextInputDialog({
        title: "",
        buttons: [
          '取消',
          { value: '保存', fontColor: Color.Orange }
        ],
        alignment: DialogAlignment.Bottom,
        offset: { dx: 0, dy: -35 },
        contentAreaPadding: { top: 30, bottom: 10, left: 15, right: 15 },
        text: this.inputText,
        placeholder: "请输入人员年龄",
        inputType: InputType.Number,
        controller: this.controller,
        maxLength: 3,
        inputFilter: {
          value: "[0-9]",
          error: (value) => {
            console.error("inputFilter: " + value);
          }
        },
        onChange: (text) => {
          console.error("onChange: " + text);
        },
        onAction: (action, dialogId, content) => {
          if (action == DialogAction.SURE) {
            this.inputText = content;
            ToastUtil.showToast(content);
          } else if (action == DialogAction.CANCEL) {

          }
        }
      })
    }
  }

  /**
   * 多行文本输入弹出框
   */
  textAreaDialog(index: number) {
    if (index == 0) {
      //简单使用
      DialogHelper.showTextAreaDialog({
        text: this.inputText,
        onChange: (text) => {
          console.error("onChange: " + text);
        },
        onAction: (action, dialogId, content) => {
          if (action == DialogAction.SURE) {
            this.inputText = content;
            ToastUtil.showToast(content);
          }
        }
      })
    } else if (index == 1) {
      //自定义弹框高度
      DialogHelper.showTextAreaDialog({
        title: "评论内容",
        text: this.inputText,
        placeholder: "请输入，[a-z,A-Z,0-9]，长度20",
        maxLength: 20,
        inputFilter: {
          value: "[0-9A-Za-z]",
          error: (value) => {
            LogUtil.error("inputFilter: " + value);
          }
        },
        inputHeight: 160,
        alignment: DialogAlignment.Bottom,
        offset: { dx: 0, dy: -35 },
        buttons: [{
          value: "确认",
          fontColor: Color.Red
        }],
        autoCancel: false,
        onChange: (text) => {
          console.error("onChange: " + text);
        },
        onAction: (action, dialogId, content) => {
            this.inputText = content;
        }
      })
    } else if (index == 2) {
      //自定义弹框，多按钮，
      DialogHelper.showTextAreaDialog({
        primaryTitle: "批示操作弹框",
        secondaryTitle: "请填写批示意见",
        text: this.inputText,
        buttons: ["暂存", "提交"],
        autoCancel: false,
        onChange: (text) => {
          console.error("onChange: " + text);
        },
        onAction: (action, dialogId, content) => {
          if (action == DialogAction.SURE) {
            this.inputText = content;
            ToastUtil.showToast(content);
          }
        }
      })
    }
  }

  /**
   * 自定义内容区弹出框
   */
  customContentDialog(index: number) {
    if (index == 0) {
      //简单使用
      DialogHelper.showCustomContentDialog({
        contentBuilder: () => {
          this.customTextBuilder("我是一个自定义弹框！")
        },
        onAction: (action) => {
          ToastUtil.showToast(`${action}`);
        }
      })
    } else if (index == 1) {
      DialogHelper.showCustomContentDialog({
        primaryTitle: "爱心提示",
        secondaryTitle: "其实我是一个二级标题",
        contentBuilder: () => {
          this.customTextImgBuilder("我是一个自定义弹框！")
        },
        buttons: [
          { value: '取消', fontColor: Color.Black },
          { value: '知道了', fontColor: Color.Red }
        ],
        onAction: (action) => {
          ToastUtil.showToast(`${action}`);
        }
      })
    } else if (index == 2) {
      DialogHelper.showCustomContentDialog({
        title: "哈哈哈哈哈哈",
        contentBuilder: () => {
          this.customText2Builder("我是一个自定义弹框呀！")
        },
        buttons: [
          '取消',
          { value: '知道了', fontColor: Color.Red }
        ],
        onAction: (action) => {
          ToastUtil.showToast(`${action}`);
        }
      })
    }
  }

  /**
   * 动作面板
   */
  bottomSheetDialog(index: number) {
    if (index == 0) {
      //简单使用
      DialogHelper.showBottomSheetDialog({
        sheets: this.menuArray,
        onAction: (index) => {
          ToastUtil.showToast(`您点击了，${this.menuArray[index]}`);
        }
      })
    } else if (index == 1) {
      //带标题
      DialogHelper.showBottomSheetDialog({
        title: "请选择上传方式",
        sheets: this.menuArray,
        onAction: (index) => {
          ToastUtil.showToast(`您点击了，${this.menuArray[index]}`);
        }
      })
    } else if (index == 2) {
      //自定义按钮
      DialogHelper.showBottomSheetDialog({
        title: "请选择操作方式",
        sheets: [{
          value: "文本操作选项一",
          fontColor: Color.Red,
          fontSize: 18
        }, {
          value: "文本操作选项二",
          fontColor: Color.Blue,
          fontSize: 18
        }, {
          value: "文本操作选项三",
          fontColor: Color.Brown,
          fontSize: 18
        }, {
          value: "文本操作选项四",
          fontColor: Color.Green,
          fontSize: 18
        }],
        onAction: (index) => {
          ToastUtil.showToast(`您点击了第几个按钮，${index + 1}`);
        }
      })
    }
  }

  /**
   * 动作面板（IOS风格）
   */
  actionSheetDialog(index: number) {
    if (index == 0) {
      //简单使用
      DialogHelper.showActionSheetDialog({
        sheets: this.menuArray,
        onAction: (index) => {
          ToastUtil.showToast(`您点击了，${this.menuArray[index]}`);
        }
      })
    } else if (index == 1) {
      //带标题
      DialogHelper.showActionSheetDialog({
        title: "请选择上传方式",
        sheets: this.menuArray,
        onAction: (index) => {
          ToastUtil.showToast(`您点击了，${this.menuArray[index]}`);
        }
      })
    } else if (index == 2) {
      //自定义按钮
      DialogHelper.showActionSheetDialog({
        title: "请选择操作方式",
        sheets: [{
          value: "文本操作选项一",
          fontColor: Color.Red,
          fontSize: 18
        }, {
          value: "文本操作选项二",
          fontColor: Color.Blue,
          fontSize: 18
        }, {
          value: "文本操作选项三",
          fontColor: Color.Brown,
          fontSize: 18
        }, {
          value: "文本操作选项四",
          fontColor: Color.Green,
          fontSize: 18
        }],
        onAction: (index) => {
          ToastUtil.showToast(`您点击了第几个按钮，${index + 1}`);
        }
      })
    }
  }

  /**
   * TextPickerDialog，选择器弹框
   */
  textPickerDialog(index: number) {
    if (index == 0) {
      DialogHelper.showTextPickerDialog({
        title: "请选择",
        range: this.likes,
        onAction: (action: number, dialogId: string, value: string | string[]) => {
          if (action == DialogAction.SURE) {
            ToastUtil.showToast(`已选择：${value as string}`);
          }
        }
      })
    } else if (index == 1) {
      DialogHelper.showTextPickerDialog({
        autoCancel: false,
        title: "请选择时间",
        titleFontColor: Color.Pink,
        titleBackground: "#E6E6E6",
        primaryButton: "取消",
        secondaryButton: {
          value: "确定",
          fontColor: Color.Red,
        },
        range: this.multis,
        value: ["2025年", "6月", "8日"], //设置选中
        onAction: (action: number, dialogId: string, value: string | string[]) => {
          if (action == DialogAction.SURE) {
            ToastUtil.showToast(`已选择：${value as string}`);
          }
        },
        onChange: (value: string | string[], index: number | number[]): void => {
          LogUtil.error(`value: ${value}`);
          LogUtil.error(`index: ${index}`);
        }
      })
    } else if (index == 2) {
      let aiHuiList = AreaHelper.getCityByNameSync("安徽省");
      DialogHelper.showTextPickerDialog({
        range: aiHuiList,
        onAction: (action: number, dialogId: string, value: string | string[]) => {
          if (action == DialogAction.SURE) {
            ToastUtil.showToast(`已选择：${value as string}`);
          }
        }
      })
    } else if (index == 3) {
      let areas = AreaHelper.getAreaSync();
      DialogHelper.showTextPickerDialog({
        title: "请选择收货地址",
        range: areas,
        onAction: (action: number, dialogId: string, value: string | string[]) => {
          if (action == DialogAction.SURE) {
            ToastUtil.showToast(`已选择：${value as string}`);
          }
        }
      })
    }
  }

  /**
   * 显示自定义弹窗
   */
  customDialog(index: number) {
    if (index == 0) {
      //自定义一个左边的DrawerLayout
      let drawer: DrawerOptions = {
        width: 260,
        msg: "这是一个自定义弹框，DrawerLayout",
        alignment: DialogAlignment.CenterStart,
        offset: { dx: 0, dy: 0 },
        transition: AnimationHelper.transitionInLeft(250)
      };
      DialogHelper.showCustomDialog(wrapBuilder(DrawerBuilder), drawer);
    } else if (index == 1) {
      //自定义一个右边的DrawerLayout
      let drawer: DrawerOptions = {
        width: 260,
        msg: "这是一个自定义弹框，DrawerLayout",
        alignment: DialogAlignment.CenterEnd,
        offset: { dx: 0, dy: 0 },
        transition: AnimationHelper.transitionInRight(300)
      };
      DialogHelper.showCustomDialog(wrapBuilder(DrawerBuilder), drawer);
    } else if (index == 2) {
      //自定义一个顶部弹出框
      let custom: MyCustomOptions = {
        height: 450,
        msg: "这是一个自定义弹框，顶部弹出",
        alignment: DialogAlignment.Top,
        offset: { dx: 0, dy: 0 },
        transition: AnimationHelper.transitionInUp(150)
      };
      DialogHelper.showCustomDialog(wrapBuilder(MyCustomBuilder), custom);
    } else {
      //自定义一个底部弹出框
      let custom: MyCustomOptions = {
        height: 450,
        msg: "这是一个自定义弹框，底部弹出",
        alignment: DialogAlignment.Bottom,
        offset: { dx: 0, dy: 0 },
        transition: AnimationHelper.transitionInDown(150)
      };
      DialogHelper.showCustomDialog(wrapBuilder(MyCustomBuilder), custom);
    }
  }

  /**
   * 显示进度加载类弹出框
   */
  loadingDialog(index: number) {
    if (index == 0) {
      //简单使用
      DialogHelper.showLoadingDialog({ autoCancel: true })
    } else if (index == 1) {
      //自定义文字内容
      DialogHelper.showLoadingDialog({
        loadType: SpinType.spinP,
        loadColor: Color.White,
        loadSize: 70,
        backgroundColor: '#BB000000',
        content: "加载中…",
        fontSize: 18,
        padding: { top: 30, right: 50, bottom: 30, left: 50 },
        autoCancel: true
      })
    } else if (index == 2) {
      //自定义文字和加载动画的颜色
      DialogHelper.showLoadingDialog({
        loadType: SpinType.spinD,
        content: "努力加载中",
        loadColor: Color.White,
        backgroundColor: '#99000000',
        fontColor: Color.White,
        padding: { top: 30, right: 40, bottom: 30, left: 40 },
        borderRadius: 5
      })
    } else {
      //禁止点击返回关闭弹窗 和 禁止点击遮蔽层关闭弹窗
      DialogHelper.showLoadingDialog({
        loadType: SpinType.spinH,
        autoCancel: false,
        backCancel: false
      })
      //延时关闭
      let timeoutID = setTimeout(() => {
        DialogHelper.closeLoading(); //关闭加载框
        clearTimeout(timeoutID);
      }, 5000);
    }
  }

  /**
   * 进度条加载弹框
   */
  loadingProgress(index: number) {
    if (index == 0) {
      //简单使用
      this.progress = 50;
      DialogHelper.showLoadingProgress({
        progress: this.progress,
      });
      //模拟网络
      let intervalID = setInterval(() => {
        if (this.progress < 100) {
          this.progress = this.progress + 1
          DialogHelper.updateLoading("", this.progress)
          console.log("progress: " + this.progress);
        } else {
          DialogHelper.closeLoading(); //加载成功
          ToastUtil.showToast("加载成功啦~");
          clearInterval(intervalID);
        }
      }, 100);
    } else if (index == 1) {
      //自定义加载内容和主题色
      this.progress = 25;
      DialogHelper.showLoadingProgress({
        progress: this.progress,
        content: "努力加载中",
        loadColor: $r('app.color.color_main'),
        fontColor: Color.Brown,
        autoCancel: false,
      })
      //模拟网络
      let intervalID = setInterval(() => {
        if (this.progress < 100) {
          this.progress = this.progress + 1
          DialogHelper.updateLoading("", this.progress)
          console.log("progress: " + this.progress);
        } else {
          DialogHelper.closeLoading(); //加载成功
          ToastUtil.showToast("加载成功啦~");
          clearInterval(intervalID);
        }
      }, 300);
    }
  }

  /**
   * 自定义的吐司
   */
  toast(index: number) {
    if (index == 0) {
      //简单使用,长文本
      DialogHelper.showToast("女人什么年龄是最好？任何年龄都可以。因为每个年龄段都有不一样的美。看XX的穿搭你就会发现成熟女性的魅力，反而会更加的吸引人。难道这就是传说中的可爱在性感面前真的不值得一提吗？")
    } else if (index == 1) {
      //自定义吐司
      DialogHelper.showToast("这是一个自定义吐司", {
        fontColor: Color.Brown,
        backgroundColor: Color.Pink,
        borderRadius: 30,
      });
    } else if (index == 2) {
      //自定义吐司
      DialogHelper.showToast("这是一个自定义吐司", {
        fontColor: Color.White,
        backgroundColor: "#99FF0000",
        alignment:DialogAlignment.Bottom,
        borderRadius: 5,
        fontSize: 18,
      });
    } else {
      //自定义的长吐司
      DialogHelper.showToastLong("这是一个自定义的长吐司呀~~~", {
        fontColor: Color.White,
        backgroundColor: "#AA0066FF",
        backCancel: true,
      });
    }
  }

  /**
   * 带图标的吐司Tip
   */
  toastTip(index: number) {
    if (index == 0) {
      //简单使用
      DialogHelper.showToastTip({
        message: "操作成功",
        imageRes: $r('sys.media.ohos_ic_public_ok')
      })
    } else if (index == 1) {
      //自定义颜色和时长
      DialogHelper.showToastTip({
        message: "操作成功",
        imageRes: $r('app.media.icon_tip_info'),
        fontColor: $r('app.color.color_main'),
        duration: 1000
      })
    } else if (index == 2) {
      //自定义背景和圆角
      DialogHelper.showToastTip({
        message: "操作成功",
        imageRes: $r('app.media.icon_tip_info'),
        backgroundColor: "#EEFFB018",
        borderRadius: 6
      })
    } else {
      DialogHelper.showToastTip({
        message: "操作失败",
        imageRes: $r('app.media.icon_tip_warn')
      })
    }
  }

  build() {
    Column() {
      Text("弹框")
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column() {
          Column() {
            Text("弹框，加载框、吐司 的统一配置")
              .fontColor($r('app.color.color_main'))
              .fontWeight(FontWeight.Bold)
              .fontSize(20)
              .margin({ top: 10, left: 10, right: 10, bottom: 12 })
            Row() {
              Blank().layoutWeight(1)
              Button("配置一")
                .type(ButtonType.Capsule)
                .grayscale(0.1)
                .onClick(() => this.customConfig1())
              Blank().layoutWeight(1)
              Button("配置二")
                .type(ButtonType.Capsule)
                .opacity(0.9)
                .onClick(() => this.customConfig2())
              Blank().layoutWeight(1)
              Button("默认的配置")
                .type(ButtonType.Capsule)
                .opacity(0.9)
                .grayscale(0.1)
                .onClick(() => this.defaultConfig())
              Blank().layoutWeight(1)
            }
            .width('100%')
          }
          .width('95%')
          .backgroundColor(Color.White)
          .border({ width: 2, color: $r('app.color.color_line') })
          .shadow(ShadowStyle.OUTER_DEFAULT_SM)
          .margin({ top: 12 })
          .borderRadius(6)
          .padding({ top: 10, bottom: 10, left: 2, right: 2 })

          LabelButton({
            label: "AlertDialog",
            content: "操作确认类弹出框",
            onClickAction: (index: number): void => this.alertDialog(index)
          })
          LabelButton({
            label: "ConfirmDialog",
            content: "信息确认类弹出框",
            onClickAction: (index: number): void => this.confirmDialog(index)
          })
          LabelButton({
            label: "TipsDialog",
            content: "提示弹出框",
            onClickAction: (index: number): void => this.tipsDialog(index)
          })
          LabelButton({
            label: "SelectDialog",
            content: "选择类弹出框",
            num: 3,
            onClickAction: (index: number): void => this.selectDialog(index)
          })
          LabelButton({
            label: "TextInputDialog",
            content: "单行文本输入弹出框",
            num: 3,
            onClickAction: (index: number): void => this.textInputDialog(index)
          })
          LabelButton({
            label: "TextAreaDialog",
            content: "多行文本输入弹出框",
            num: 3,
            onClickAction: (index: number): void => this.textAreaDialog(index)
          })
          LabelButton({
            label: "CustomContentDialog",
            content: "显示自定义内容区弹出框，同时支持定义操作区按钮样式",
            num: 3,
            onClickAction: (index: number): void => this.customContentDialog(index)
          })
          LabelButton({
            label: "BottomSheetDialog",
            content: "显示动作面板",
            num: 3,
            onClickAction: (index: number): void => this.bottomSheetDialog(index)
          })
          LabelButton({
            label: "ActionSheetDialog",
            content: "显示动作面板（IOS风格）",
            num: 3,
            onClickAction: (index: number): void => this.actionSheetDialog(index)
          })
          LabelButton({
            label: "TextPickerDialog",
            content: "TextPicker-选择器弹框",
            num: 4,
            onClickAction: (index: number): void => this.textPickerDialog(index)
          })
          LabelButton({
            label: "CustomDialog",
            content: "自定义弹窗",
            onClickAction: (index: number): void => this.customDialog(index)
          })
          LabelButton({
            label: "LoadingDialog",
            content: "进度加载类弹出框",
            onClickAction: (index: number): void => this.loadingDialog(index)
          })
          LabelButton({
            label: "LoadingProgress",
            content: "进度条加载弹框",
            num: 2,
            onClickAction: (index: number): void => this.loadingProgress(index)
          })
          LabelButton({
            label: "Toast",
            content: "自定义的吐司",
            onClickAction: (index: number): void => this.toast(index)
          })
          LabelButton({
            label: "ToastTip",
            content: "带图标的吐司Tip",
            onClickAction: (index: number): void => this.toastTip(index)
          })
            .margin({ bottom: 15 })
        }
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor($r('app.color.main_background'))
    }
  }

  //自定义文本
  @Builder
  customTextBuilder(content: string) {
    Text(content)
      .fontColor(Color.Black)
      .fontSize(16)
      .padding(10)
  }

  //自定义文本和图片
  @Builder
  customTextImgBuilder(content: string) {
    Scroll() {
      Column() {
        Text(content)
          .fontColor(Color.Pink)
          .fontSize(16)
        Image($r('app.media.test_as2'))
          .width("100%")
      }
      .width("100%")
      .backgroundColor(Color.White)
      .padding(10)
    }
  }

  //自定义文本2
  @Builder
  customText2Builder(content: string) {
    Column() {
      Text(content)
        .fontColor(Color.Black)
        .fontSize(16)
        .padding(10)
      Text(content)
        .fontColor(Color.Black)
        .fontSize(16)
        .padding(10)
    }
    .width("100%")
    .padding(10)
  }
}


//自定义弹框，DrawerLayout
@Builder
function DrawerBuilder(options: DrawerOptions) {
  Column() {
    Text(options.msg)
      .fontColor(Color.Blue)
      .fontWeight(FontWeight.Bold)
      .fontSize(16)
      .padding(20)
      .margin({ top: 30 })
    Image($r('app.media.test_as1'))
      .width("100%")
      .margin({ top: 1 })
    Image($r('app.media.test_as2'))
      .width("100%")
      .margin({ top: 5 })
    Image($r('app.media.test_as3'))
      .width("100%")
      .margin({ top: 5 })

    Blank().layoutWeight(1)
    Button("关闭 DrawerLayout")
      .onClick(() => {
        DialogHelper.closeDialog(options.dialogId ?? ""); //关闭弹框
      })
    Blank().layoutWeight(1)
  }
  .height("100%")
  .width(options.width)
  .padding(10)
  .backgroundColor(Color.White)
}

//自定义弹框
@Builder
function MyCustomBuilder(options: MyCustomOptions) {
  Column() {
    Text(options.msg)
      .fontColor(Color.Blue)
      .fontWeight(FontWeight.Bold)
      .fontSize(16)
      .padding(20)
      .margin({ top: 20 })
    Image($r('app.media.test_as2'))
      .width("100%")
      .margin({ top: 5 })

    Blank().layoutWeight(1)
    Button("关闭，自定义弹框")
      .onClick(() => {
        DialogHelper.closeDialog(options.dialogId ?? ""); //关闭弹框
      })
    Blank().layoutWeight(1)
  }
  .height(options.height)
  .width("100%")
  .padding(10)
  .backgroundColor(Color.White)
}

