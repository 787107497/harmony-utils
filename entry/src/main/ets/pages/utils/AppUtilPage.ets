import { font, KeyboardAvoidMode, router } from '@kit.ArkUI';
import { AppUtil, DialogUtil, LogUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';
import { ConfigurationConstant } from '@kit.AbilityKit';

/**
 * APP相关工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State mode: number = KeyboardAvoidMode.OFFSET; //上抬模式
  @State bright: number = 0.0; //屏幕亮度值
  @State isKeepScreenOn: boolean = false; //屏幕是否为常亮状态
  @State privacyMode: boolean = false; //是否隐私模式
  @State statusBar: boolean = false;
  @State infoStr: string = ''
  @State blGray: boolean = false; //置灰状态
  @State colorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT; //深浅色模式


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
              ToastUtil.showToast("成功获取上下文");
            })
          Button("getUIContext()")
            .btnStyle()
            .onClick(() => {
              let uiContext = AppUtil.getUIContext();
              ToastUtil.showToast("成功获取UIContext");
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
              if (!this.blGray) {
                this.blGray = true;
                AppUtil.setGrayScale(1);
                ToastUtil.showToast("一键置灰成功");
              } else {
                this.blGray = false;
                AppUtil.setGrayScale(0);
                ToastUtil.showToast("取消置灰成功");
              }
            })
          Button("setColorMode()")
            .btnStyle()
            .onClick(() => {
              if (this.colorMode !== ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
                this.colorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT;
                AppUtil.setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT);
              } else {
                this.colorMode = ConfigurationConstant.ColorMode.COLOR_MODE_DARK;
                AppUtil.setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_DARK);
              }
            })
          Button("setFont()")
            .btnStyle()
            .onClick(() => {
              font.registerFont({ familyName: 'WCSF', familySrc: $rawfile('wcsf.ttf') })
              AppUtil.setFont('WCSF');
            })
          Button("getKeyboardAvoidMode()")
            .btnStyle()
            .onClick(() => {
              this.mode = AppUtil.getKeyboardAvoidMode();
              ToastUtil.showToast(`当前模式为: ${StrUtil.equal(this.mode, KeyboardAvoidMode.OFFSET) ? "上抬模式" : "压缩模式"}`)
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
          Button("setStatusBar()")
            .btnStyle()
            .onClick(() => {
              this.statusBar = this.statusBar ? false : true;
              if (this.statusBar) {
                AppUtil.setStatusBar();
              } else {
                AppUtil.setStatusBar(false, true);
              }
            })
          Button("getBundleInfo()")
            .btnStyle()
            .onClick(async () => {
              let bundleInfo = await AppUtil.getBundleInfo();
              this.infoStr = JSON.stringify(bundleInfo, null, 2)
            })
          Button("getAppInfoSync()")
            .btnStyle()
            .onClick(() => {
              let bundleInfo = AppUtil.getAppInfoSync();
              this.infoStr = JSON.stringify(bundleInfo, null, 2)
            })
          Button("getSignatureInfo()")
            .btnStyle()
            .onClick(async () => {
              let bundleInfo = await AppUtil.getSignatureInfo();
              this.infoStr = JSON.stringify(bundleInfo, null, 2)
            })
          Button("getBundleName()\ngetVersionCode()\ngetVersionName()\ngetTargetVersion()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let bundleName = AppUtil.getBundleName();
              let versionCode = AppUtil.getVersionCode();
              let versionName = AppUtil.getVersionName();
              let targetVersion = AppUtil.getTargetVersion();
              this.infoStr = `bundleName: ${bundleName}\nversionCode: ${versionCode}\nversionName: ${versionName}\ntargetVersion: ${targetVersion}`;
            })
          Button("getInstallTime()\ngetUpdateTime()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let installTime = AppUtil.getInstallTime();
              let updateTime = AppUtil.getUpdateTime();
              this.infoStr = `installTime: ${installTime}\nupdateTime: ${updateTime}`;
            })
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
          Text(this.infoStr)
            .visibility(StrUtil.isNotEmpty(this.infoStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
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