import { KeyboardAvoidMode, router, window } from '@kit.ArkUI';
import { AppUtil, DialogUtil, LogUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * APP相关工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State properties: string = '' //主窗口的属性
  @State mode: number = KeyboardAvoidMode.OFFSET; //上抬模式
  @State num: number = 4;
  @State bright: number = 0.0; //屏幕亮度值
  @State isKeepScreenOn: boolean = false; //屏幕是否为常亮状态
  @State privacyMode: boolean = false; //是否隐私模式
  @State statusBar: boolean = false;
  @State bundleInfoStr: string = ''
  @State infoStr: string = ''
  @State appInfoStr: string = ''

  @MockSetup
  mock() {
    this.describe = new DescribeBean("AppUtil", "APP相关工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("getContext()")
            .btnStyle()
            .onClick(() => {
              let context = AppUtil.getContext();
              ToastUtil.showToast("成功获取上下文")
            })
          Button("getUIContext()")
            .btnStyle()
            .onClick(() => {
              let uiContext = AppUtil.getUIContext();
              ToastUtil.showToast("成功获取UIContext")
            })
          Button("getWindowStage()")
            .btnStyle()
            .onClick(() => {
              let windowStage = AppUtil.getWindowStage();
              LogUtil.error(JSON.stringify(windowStage, null, 2));
              ToastUtil.showToast("成功获取WindowStage");
            })
          Button("getMainWindow()")
            .btnStyle()
            .onClick(() => {
              let mainWindow = AppUtil.getMainWindow();
              LogUtil.error(JSON.stringify(mainWindow, null, 2));
              ToastUtil.showToast("成功获取主窗口");
            })
          Button("setGrayScale()")
            .btnStyle()
            .onClick(() => {
              AppUtil.setGrayScale(1);
              ToastUtil.showToast("APP一键置灰成功");
            })
          Button("setStatusBar()")
            .btnStyle()
            .onClick(() => {
              this.statusBar = this.statusBar ? false : true;
              if (this.statusBar) {
                AppUtil.setStatusBar()
              } else {
                AppUtil.setStatusBar(false, true)
              }
            })
          Button("getWindowProperties()")
            .btnStyle()
            .onClick(() => {
              let p = AppUtil.getWindowProperties();
              this.properties = `${JSON.stringify(p, null, 2)}`
            })
          Text(this.properties)
            .visibility(StrUtil.isNotEmpty(this.properties) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getKeyboardAvoidMode()")
            .btnStyle()
            .onClick(() => {
              this.mode = AppUtil.getKeyboardAvoidMode();
              ToastUtil.showToast(`当前模式为: ${StrUtil.equal(this.mode, KeyboardAvoidMode.OFFSET) ? "上抬模式" :
                "压缩模式"}`)
            })
          Button("setKeyboardAvoidMode()")
            .btnStyle()
            .onClick(() => {
              AppUtil.setKeyboardAvoidMode(StrUtil.equal(this.mode, KeyboardAvoidMode.OFFSET) ?
              KeyboardAvoidMode.RESIZE : KeyboardAvoidMode.OFFSET);
              this.mode = AppUtil.getKeyboardAvoidMode();
              ToastUtil.showToast(`设置模式为: ${StrUtil.equal(this.mode, KeyboardAvoidMode.OFFSET) ? "上抬模式" :
                "压缩模式"}`)
            })
          TextInput({ placeholder: '设置模式后点击输入框查看效果' })
            .width("95%")
            .margin({ bottom: 10 })
          Button("isPortrait()")
            .btnStyle()
            .onClick(() => {
              let isPortrait = AppUtil.isPortrait();
              ToastUtil.showToast(`当前是否竖屏: ${isPortrait}`)
            })
          Button("isLandscape()")
            .btnStyle()
            .onClick(() => {
              let isLandscape = AppUtil.isLandscape();
              ToastUtil.showToast(`当前是否横屏: ${isLandscape}`)
            })
          Button("setPreferredOrientation()")
            .btnStyle()
            .onClick(() => {
              AppUtil.setPreferredOrientation(AppUtil.isLandscape() ? window.Orientation.PORTRAIT :
              window.Orientation.LANDSCAPE)
                .then(() => {
                  ToastUtil.showToast(`设置成功！`)
                })
                .catch((err: BusinessError) => {
                  LogUtil.error(`异常信息-code: ${err.code} - msg: ${err.message}`)
                });
            })
          Button("setWindowBrightness()")
            .btnStyle()
            .onClick(() => {
              this.bright = this.bright === 1.0 ? 0.0 : 1.0;
              AppUtil.setWindowBrightness(this.bright).then(() => {
                ToastUtil.showToast(`您已设置亮度: ${this.bright}`)
              }).catch((err: BusinessError) => {
                LogUtil.error(`异常信息-code: ${err.code} - msg: ${err.message}`)
              });
            })
          Button("setWindowKeepScreenOn()")
            .btnStyle()
            .onClick(() => {
              this.isKeepScreenOn = this.isKeepScreenOn ? false : true;
              AppUtil.setWindowKeepScreenOn(this.isKeepScreenOn).then(() => {
                ToastUtil.showToast(`${this.isKeepScreenOn ? "你已设置常亮" : "你已取消常亮"}`);
              }).catch((err: BusinessError) => {
                LogUtil.error(`异常信息-code: ${err.code} - msg: ${err.message}`)
              });
            })
          Button("setWindowPrivacyMode()")
            .btnStyle()
            .onClick(() => {
              this.privacyMode = this.privacyMode ? false : true;
              AppUtil.setWindowPrivacyMode(this.privacyMode).then(() => {
                ToastUtil.showToast(`${this.privacyMode ? "你已设置隐私模式，禁止截屏、录像" : "你已取消隐私模式"}`);
              }).catch((err: BusinessError) => {
                LogUtil.error(`异常信息-code: ${err.code} - msg: ${err.message}`)
              });
            })
          Button("setWindowBackgroundColor()")
            .btnStyle()
            .onClick(() => {
              AppUtil.setWindowBackgroundColor("#FF00F0")
              ToastUtil.showToast("设置背景色成功")
            })
          Button("getStatusBarHeight()")
            .btnStyle()
            .onClick(() => {
              let statusBarHeight = AppUtil.getStatusBarHeight();
              ToastUtil.showToast(`状态栏的高度为：${statusBarHeight}px`)
            })
          Button("getNavigationIndicatorHeight()")
            .btnStyle()
            .onClick(() => {
              let indicatorHeight = AppUtil.getNavigationIndicatorHeight();
              ToastUtil.showToast(`底部导航条的高度为：${indicatorHeight}px`)
            })
          Button("getBundleInfo()")
            .btnStyle()
            .onClick(async () => {
              let bundleInfo = await AppUtil.getBundleInfo();
              this.bundleInfoStr = JSON.stringify(bundleInfo, null, 2)
            })
          Text(this.bundleInfoStr)
            .visibility(StrUtil.isNotEmpty(this.bundleInfoStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getBundleName()\ngetVersionCode()\ngetVersionName()\ngetTargetVersion()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let bundleName = await AppUtil.getBundleName();
              let versionCode = await AppUtil.getVersionCode();
              let versionName = await AppUtil.getVersionName();
              let targetVersion = await AppUtil.getTargetVersion();
              this.infoStr =
                `bundleName: ${bundleName}\nversionCode: ${versionCode}\nversionName: ${versionName}\ntargetVersion: ${targetVersion}`;
            })
          Text(this.infoStr)
            .visibility(StrUtil.isNotEmpty(this.infoStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getAppInfo()")
            .btnStyle()
            .onClick(async () => {
              let appInfo = await AppUtil.getAppInfo();
              this.appInfoStr = JSON.stringify(appInfo, null, 2)
            })
          Text(this.appInfoStr)
            .visibility(StrUtil.isNotEmpty(this.appInfoStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("exit()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showPrimaryDialog({
                title: '提示',
                message: '是否退出应用？',
                primaryButton: {
                  value: '取消',
                  action: () => {
                  }
                },
                secondaryButton: {
                  value: '退出',
                  action: () => {
                    AppUtil.exit();
                  }
                }
              })
            })
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor($r('app.color.main_background'))
  }
}


@Styles
function btnStyle() {
  .width('90%')
  .margin({ top: 10, bottom: 5 })
}

@Styles
function textStyle() {
  .width('95%')
  .padding(10)
  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  .margin({ top: 5, bottom: 10 })
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}