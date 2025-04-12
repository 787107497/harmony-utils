import { router, window } from '@kit.ArkUI';
import { AppUtil, LogUtil, StrUtil, ToastUtil, WindowUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';
import { DialogHelper } from '@pura/harmony-dialog';
import { Utils } from '../../utils/Utils';
import { JSON } from '@kit.ArkTS';


/**
 * 窗口相关工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State privacyMode: boolean = false; //是否隐私模式
  @State isLayoutFullScreen: boolean = false; //是否沉浸式布局
  @State blImmersive: boolean = false; //是否开启沉浸式布局
  @State blGrayScale: boolean = false; //是否灰阶
  @State blFullScreen: boolean = false; //是否全屏
  @State isKeepScreenOn: boolean = false; //屏幕是否为常亮状态
  @State bright: number = 0.2; //屏幕亮度值
  @State blFocusable: boolean = false; //窗口是否可聚焦
  @State blTouchable: boolean = false; //窗口是否可触摸


  @MockSetup
  mock() {
    this.describe = new DescribeBean("AppUtil", "窗口相关工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("setPreferredOrientation()")
            .btnStyle()
            .onClick(() => {
              WindowUtil.setPreferredOrientation(AppUtil.isLandscape() ? window.Orientation.PORTRAIT : window.Orientation.LANDSCAPE)
                .then(() => {
                  ToastUtil.showToast(`设置成功！`)
                }).catch((err: BusinessError) => {
                  LogUtil.error(err);
                });
            })
          Button("getPreferredOrientation()")
            .btnStyle()
            .onClick(() => {
              let orientation = WindowUtil.getPreferredOrientation();
              DialogHelper.showToast(`窗口屏幕方向：${orientation}`);
            })
          Button("setWindowPrivacyMode()")
            .btnStyle()
            .onClick(() => {
              this.privacyMode = this.privacyMode ? false : true;
              WindowUtil.setWindowPrivacyMode(this.privacyMode).then(() => {
                ToastUtil.showToast(`${this.privacyMode ? "您已设置隐私模式，禁止截屏、录像" : "您已取消隐私模式"}`);
              }).catch((err: BusinessError) => {
                LogUtil.error(err);
              });
            })
          Button("isPrivacyMode()")
            .btnStyle()
            .onClick(() => {
              let isPrivacyMode = WindowUtil.isPrivacyMode();
              ToastUtil.showToast(`窗口是否隐私模式：${isPrivacyMode}`);
            })
          Button("setWindowLayoutFullScreen()")
            .btnStyle()
            .onClick(() => {
              this.isLayoutFullScreen = this.isLayoutFullScreen ? false : true;
              WindowUtil.setWindowLayoutFullScreen(this.isLayoutFullScreen).then(() => {
                ToastUtil.showToast(`沉浸式布局已设置成功！`);
              }).catch((err: BusinessError) => {
                LogUtil.error(err);
              });
            })
          Button("isLayoutFullScreen()")
            .btnStyle()
            .onClick(() => {
              let isLayoutFullScreen = WindowUtil.isLayoutFullScreen();
              ToastUtil.showToast(`窗口是否为沉浸式：${isLayoutFullScreen}`);
            })
          Button("setWindowSystemBarProperties()")
            .btnStyle()
            .onClick(() => {
              WindowUtil.setWindowSystemBarProperties({
                statusBarColor: '#F00FF0',
                statusBarContentColor: '#0FF00F',
                isStatusBarLightIcon: true,
                navigationBarColor: '#F06060',
                navigationBarContentColor: "#0606F0",
                isNavigationBarLightIcon: true
              }).then(() => {
                ToastUtil.showToast("设置成功！");
              }).catch((err: BusinessError) => {
                LogUtil.error(err);
              });
            })
          Button("getWindowSystemBarProperties()")
            .btnStyle()
            .onClick(() => {
              let properties = WindowUtil.getWindowSystemBarProperties();
              let jsonStr = JSON.stringify(properties, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("setImmersiveModeEnabledState()")
            .btnStyle()
            .onClick(() => {
              this.blImmersive = this.blImmersive ? false : true;
              WindowUtil.setImmersiveModeEnabledState(this.blImmersive);
              ToastUtil.showToast("设置成功！");
            })
          Button("getImmersiveModeEnabledState()")
            .btnStyle()
            .onClick(() => {
              let enabled = WindowUtil.getImmersiveModeEnabledState();
              ToastUtil.showToast(`是否开启沉浸式布局：${enabled}`);
            })
          Button("setWindowGrayScale()")
            .btnStyle()
            .onClick(() => {
              this.blGrayScale = !this.blGrayScale;
              let grayScale = this.blGrayScale ? 1.0 : 0;
              WindowUtil.setWindowGrayScale(grayScale);
              ToastUtil.showToast(`窗口灰阶：${grayScale}`);
            })
          Button("setWindowBackgroundColor()")
            .btnStyle()
            .onClick(() => {
              WindowUtil.setWindowBackgroundColor('#9932CC');
              ToastUtil.showToast("设置背景色成功！");
            })
          Button("setWindowSystemBarEnable()")
            .btnStyle()
            .onClick(() => {
              this.blFullScreen = !this.blFullScreen;
              WindowUtil.setWindowSystemBarEnable(this.blFullScreen ? [] : ['status', 'navigation']).then(() => {
                ToastUtil.showToast(`设置成功！`);
              }).catch((err: BusinessError) => {
                LogUtil.error(err);
              });
            })
          Button("setSpecificSystemBarEnabled()")
            .btnStyle()
            .onClick(() => {
              let name: window.SpecificSystemBar = this.blFullScreen ? 'status' : 'navigationIndicator';
              WindowUtil.setSpecificSystemBarEnabled(name, this.blFullScreen).then(() => {
                ToastUtil.showToast(`设置成功！`);
              }).catch((err: BusinessError) => {
                LogUtil.error(err);
              });
            })
          Button("setWindowKeepScreenOn()")
            .btnStyle()
            .onClick(() => {
              this.isKeepScreenOn = this.isKeepScreenOn ? false : true;
              WindowUtil.setWindowKeepScreenOn(this.isKeepScreenOn).then(() => {
                ToastUtil.showToast(`${this.isKeepScreenOn ? "你已设置常亮" : "你已取消常亮"}`);
              }).catch((err: BusinessError) => {
                LogUtil.error(err);
              });
            })
          Button("isKeepScreenOn()")
            .btnStyle()
            .onClick(() => {
              let isKeepScreenOn = WindowUtil.isKeepScreenOn();
              ToastUtil.showToast(`屏幕是否常亮：${isKeepScreenOn}`);
            })
          Button("setWindowBrightness()")
            .btnStyle()
            .onClick(() => {
              this.bright = this.bright === 1.0 ? 0.2 : 1.0;
              WindowUtil.setWindowBrightness(this.bright).then(() => {
                ToastUtil.showToast(`您已设置亮度: ${this.bright}`);
              }).catch((err: BusinessError) => {
                LogUtil.error(`异常信息-code: ${err.code} - msg: ${err.message}`)
              });
            })
          Button("getBrightness()")
            .btnStyle()
            .onClick(() => {
              let brightness = WindowUtil.getBrightness();
              ToastUtil.showToast(`屏幕亮度：${brightness}`);
            })
          Button("setWindowFocusable()")
            .btnStyle()
            .onClick(() => {
              this.blFocusable = !this.blFocusable;
              WindowUtil.setWindowFocusable(this.blFocusable).then(() => {
                ToastUtil.showToast("设置成功啦^·^");
              }).catch((err: BusinessError) => {
                ToastUtil.showToast("设置失败！");
              });
            })
          Button("isFocusable()")
            .btnStyle()
            .onClick(() => {
              let isFocusable = WindowUtil.isFocusable();
              ToastUtil.showToast(`窗口是否可聚焦：${isFocusable}`);
            })
          Button("setWindowTouchable()")
            .btnStyle()
            .onClick(() => {
              this.blTouchable = !this.blTouchable;
              WindowUtil.setWindowTouchable(this.blTouchable).then(() => {
                ToastUtil.showToast("设置成功啦^·^");
              }).catch((err: BusinessError) => {
                ToastUtil.showToast("设置失败！");
              });
            })
          Button("isTouchable()")
            .btnStyle()
            .onClick(() => {
              let isTouchable = WindowUtil.isTouchable();
              ToastUtil.showToast(`窗口是否可触摸：${isTouchable}`);
            })
          Button("getWindowProperties()")
            .btnStyle()
            .onClick(() => {
              let properties = WindowUtil.getWindowProperties();
              let jsonStr = `${JSON.stringify(properties, null, 2)}`;
              Utils.showSheetText(jsonStr);
            })
          Button("getWindowAvoidArea()")
            .btnStyle()
            .onClick(() => {
              let area = WindowUtil.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
              let jsonStr = `${JSON.stringify(area, null, 2)}`;
              Utils.showSheetText(jsonStr);
            })
          Button("getWindowType()\ngetWindowStatus()\nisTransparent()\nisFullScreen()\nisTransparent()\nisWindowShowing()\nisWindowSupportWideGamut()")
            .labelStyle({ maxLines: 8 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let windowType = WindowUtil.getWindowType();
              let status = WindowUtil.getWindowStatus();
              let isFocused = WindowUtil.isFocused();
              let isFullScreen = WindowUtil.isFullScreen();
              let isTransparent = WindowUtil.isTransparent();
              let isWindowShowing = WindowUtil.isWindowShowing();
              let isWindowSupportWideGamut = await WindowUtil.isWindowSupportWideGamut();
              let textStr = `windowType: ${windowType}\nWindowStatus: ${status}\nisFocused: ${isFocused}\nisFullScreen: ${isFullScreen}`;
              textStr = textStr + `\nisTransparent: ${isTransparent}\nisWindowShowing: ${isWindowShowing}\nisWindowSupportWideGamut: ${isWindowSupportWideGamut}`;
              Utils.showSheetText(textStr);
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