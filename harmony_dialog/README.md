# harmony-dialog (API12 - 5.0.3.800)

## 🏆简介与推荐

[harmony-dialog](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog)
一款极为简单易用的零侵入弹窗，仅需一行代码即可轻松实现，无论在何处都能够轻松弹出。其涵盖了
AlertDialog、TipsDialog、ConfirmDialog、SelectDialog、CustomContentDialog、TextInputDialog、TextAreaDialog、BottomSheetDialog、ActionSheetDialog、CustomDialog、LoadingDialog、LoadingProgress、Toast、ToastTip
等多种类型，能够满足各种不同的弹窗开发需求。

[harmony-utils](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils)
一款功能丰富且极易上手的HarmonyOS工具库，借助众多实用工具类，致力于助力开发者迅速构建鸿蒙应用。

[SpinKit](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fspinkit) 是一个适用于OpenHarmony/HarmonyOS的加载动画库。

## 🌞下载安装

`ohpm i @pura/harmony-dialog`

OpenHarmony ohpm
环境配置等更多内容，请参考[如何安装 OpenHarmony ohpm 包](https://ohpm.openharmony.cn/#/cn/help/downloadandinstall)
<br>

## 📚API详解

| DialogHelper方法          | 介绍                                              |
|:------------------------|:------------------------------------------------|
| setDefaultConfig        | 设置默认统一样式                                        |
| showAlertDialog         | 显示操作确认类弹出框                                      |
| showConfirmDialog       | 显示信息确认类弹出框                                      |
| showTipsDialog          | 显示提示弹出框，即为带图形确认框                                |
| showSelectDialog        | 显示选择类弹出框                                        |
| showTextInputDialog     | 显示单行文本输入弹框                                      |
| showTextAreaDialog      | 显示多行文本输入弹框                                      |
| showCustomContentDialog | 显示自定义内容区弹出框，同时支持定义操作区按钮样式                       |
| showBottomSheetDialog   | 显示动作面板                                          |
| showActionSheetDialog   | 显示动作面板（IOS风格）                                   |
| showTextPickerDialog    | 显示选择器弹框；入参参考TextPicker组件                        |
| showCustomDialog        | 显示自定义弹窗                                         |
| update                  | 刷新自定义弹窗                                         |
| isShowing               | 当前弹窗是否显示                                        |
| closeDialog             | 关闭弹框                                            |
| showLoadingDialog       | 显示进度加载类弹出框                                      |
| showLoadingProgress     | 显示进度条加载弹框                                       |
| updateLoading           | 刷新加载弹框                                          |
| isShowLoading           | 加载弹框是否显示（showLoadingDialog、showLoadingProgress） |
| closeLoading            | 关闭加载弹框（showLoadingDialog、showLoadingProgress）   |
| getLoadingDialogId      | 获取加载弹框ID                                        |
| showToast               | 显示吐司                                            |
| showToastLong           | 显示长吐司                                           |
| showToastTip            | 显示带图形吐司                                         |
| generateId              | 生成弹框id                                          |

<br/>

| AnimationHelper方法 | 介绍        |
|:------------------|:----------|
| transitionInUp    | InUp动画    |
| transitionInDown  | InDown动画  |
| transitionInLeft  | InLeft动画  |
| transitionInRight | InRight动画 |

## 📚使用说明🙏

 ```
  在有子窗口的情况下并且子窗口没有占满全屏的情况下，必须按照下面代码代码初始化和调用
 
    //必须在UIAbility的onCreate方法里初始化context。
    DialogHelper.setDefaultConfig((config) => {
      config.uiContext = this.context;
    })
    
    //在子窗口 使用弹框需要传入uiContext
    DialogHelper.showTipsDialog({
      uiContext:this.getUIContext(), //子窗口需要传入UIContext
      content: '想要卸载这个APP嘛?',
      onAction: (action) => {
        ToastUtil.showToast(`${action}`);
      }
    })
 ```

## 📚示例代码 [使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/index/DialogPage.ets)

 ```
    //设置默认的统一配置，在UIAbility的onCreate方法里初始化
    DialogHelper.setDefaultConfig((config) => {
      config.uiContext = this.context  //必须初始化上下文
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
 ```

 ```
    //操作确认类弹出框
    DialogHelper.showAlertDialog({
      content: "确定保存该WPS文件吗？",
      onAction: (action) => {
        if (action == DialogAction.ONE) {
          ToastUtil.showToast(`您点击了取消按钮`);
        } else if (action == DialogAction.TWO) {
          ToastUtil.showToast(`您点击了确认按钮`);
        }
      }
    })
    

    //信息确认类弹出框
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
    
    
    //提示弹出框
    DialogHelper.showTipsDialog({
      content: '想要卸载这个APP嘛?',
      onAction: (action) => {
        ToastUtil.showToast(`${action}`);
      }
    })
    
    
    //选择类弹出框
    DialogHelper.showSelectDialog({
      radioContent: ["文本菜单选项一", "文本菜单选项二", "文本菜单选项三", "文本菜单选项四", "文本菜单选项五"],
      onCheckedChanged: (index) => {
        ToastUtil.showToast(`${index}`);
      },
      onAction: (action, dialogId, value) => {
        ToastUtil.showToast(`${action} --- ${value}`);
      }
    })
 ```

 ```
    //单行文本输入弹出框
    DialogHelper.showTextInputDialog({
      text: this.inputText,
      onChange: (text) => {
        console.error("onChange: " + text);
      },
      onAction: (action, dialogId, content) => {
        if (action == DialogAction.TWO) {
          this.inputText = content;
        }
      }
    })
    
    
    //多行文本输入弹出框
    DialogHelper.showTextAreaDialog({
      text: this.inputText,
      onChange: (text) => {
        console.error("onChange: " + text);
      },
      onAction: (action, dialogId, content) => {
        if (action == DialogAction.TWO) {
          this.inputText = content;
        }
      }
    })
    
    
    //自定义内容区弹出框
    DialogHelper.showCustomContentDialog({
      contentBuilder: () => {
        this.customTextBuilder("我是一个自定义弹框！")
      },
      onAction: (action) => {
        ToastUtil.showToast(`${action}`);
      }
    })
 ```

 ```
    //动作面板
    DialogHelper.showBottomSheetDialog({
      title: "请选择上传方式",
      sheets: ["相机", "相册", "文件管理器"],
      onAction: (index) => {
        ToastUtil.showToast(`您点击了，${this.menuArray[index]}`);
      }
    })
    
    
    //动作面板（IOS风格）
    DialogHelper.showActionSheetDialog({
      title: "请选择上传方式",
      sheets: ["相机", "相册", "文件管理器"],
      onAction: (index) => {
        ToastUtil.showToast(`您点击了，${this.menuArray[index]}`);
      }
    })
 ```

 ```
    //进度加载类弹出框
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

    
    //进度条加载弹框
    DialogHelper.showLoadingProgress({ progress: this.progress })
 ```

 ```  
    //吐司
    DialogHelper.showToast("这是一个自定义吐司")
    DialogHelper.showToastLong("这是一个自定义的长吐司呀")
    
    
    //吐司Tip
    DialogHelper.showToastTip({
      message: "操作成功",
      imageRes: $r('sys.media.ohos_ic_public_ok')
    })
 ```

 ```
   //自定义弹窗
    let drawer: DrawerOptions = {
      width: 260,
      msg: "这是一个自定义弹框，DrawerLayout",
      alignment: DialogAlignment.CenterStart,
      offset: { dx: 0, dy: 0 },
      transition: AnimationHelper.transitionInLeft(250)
    }
    DialogHelper.showCustomDialog(wrapBuilder(DrawerBuilder), drawer)
 ```

## 🍎沟通与交流🙏

使用过程中发现任何问题都可以提 [Issue](https://gitee.com/tongyuyan/harmony-utils/issues) 给我们；   
当然，我们也非常欢迎你给我们发 [PR](https://gitee.com/tongyuyan/harmony-utils/pulls) 。

[https://gitee.com/tongyuyan/harmony-utils](https://gitee.com/tongyuyan/harmony-utils)   
[https://github.com/787107497](https://github.com/787107497)

鸿蒙技术交流QQ群：569512366

## 🌞友情推荐

#### [《ArkUI实战》](https://www.arkui.club)深入浅出介绍鸿蒙应用开发，帮助数百万开发者学习鸿蒙与仓颉。

#### [CjCalendar](https://ohpm.openharmony.cn/#/cn/detail/cjcalendar) 是一款日常开发常用的日历组件，内部集成常规、单选、时间范围选择、多选、自定义日期每项显示等。

#### [《鸿蒙NEXT实战教程》](https://www.bilibili.com/cheese/play/ss25125)鸿蒙next实战教学，不废话，手把手教你从零开始搭建获得next模拟器资格和查阅文档，学习当下最新的next技术。 [鸿蒙next ArkUI 技术博客专栏](https://juejin.cn/column/7308434349426556979)旨在分享鸿蒙next最前沿的技术博客 ，希望广大群友能愉快的学习鸿蒙next开发。

## 🌏开源协议

本项目基于 [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.html) ，在拷贝和借鉴代码时，请大家务必注明出处。
