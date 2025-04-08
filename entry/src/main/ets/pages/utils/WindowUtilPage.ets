import { router, window } from '@kit.ArkUI';
import { AppUtil, LogUtil, StrUtil, ToastUtil, WindowUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';


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
  @State isKeepScreenOn: boolean = false; //屏幕是否为常亮状态
  @State bright: number = 0.0; //屏幕亮度值
  @State statusBar: boolean = false;
  @State textStr: string = '';

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
          Button("setWindowPrivacyMode()")
            .btnStyle()
            .onClick(() => {
              this.privacyMode = this.privacyMode ? false : true;
              WindowUtil.setWindowPrivacyMode(this.privacyMode).then(() => {
                ToastUtil.showToast(`${this.privacyMode ? "你已设置隐私模式，禁止截屏、录像" : "你已取消隐私模式"}`);
              }).catch((err: BusinessError) => {
                LogUtil.error(err);
              });
            })
          Button("setWindowBackgroundColor()")
            .btnStyle()
            .onClick(() => {
              WindowUtil.setWindowBackgroundColor("#FF00F0");
              ToastUtil.showToast("设置背景色成功");
            })
          Button("setWindowLayoutFullScreen()")
            .btnStyle()
            .onClick(() => {
              this.isLayoutFullScreen = this.isLayoutFullScreen ? false : true;
              WindowUtil.setWindowLayoutFullScreen(this.isLayoutFullScreen).then(() => {
                ToastUtil.showToast(`您已设置成功！`);
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
          Button("setWindowBrightness()")
            .btnStyle()
            .onClick(() => {
              this.bright = this.bright === 1.0 ? 0.0 : 1.0;
              WindowUtil.setWindowBrightness(this.bright).then(() => {
                ToastUtil.showToast(`您已设置亮度: ${this.bright}`);
              }).catch((err: BusinessError) => {
                LogUtil.error(`异常信息-code: ${err.code} - msg: ${err.message}`)
              });
            })
          Button("setWindowFocusable()")
            .btnStyle()
            .onClick(() => {
              WindowUtil.setWindowFocusable(true).then(() => {
                ToastUtil.showToast("设置成功啦^·^");
              }).catch((err: BusinessError) => {
                ToastUtil.showToast("设置失败！");
              });
            })
          Button("setWindowTouchable()")
            .btnStyle()
            .onClick(() => {
              WindowUtil.setWindowTouchable(true).then(() => {
                ToastUtil.showToast("设置成功啦^·^");
              }).catch((err: BusinessError) => {
                ToastUtil.showToast("设置失败！");
              });
            })
          Button("getWindowProperties()")
            .btnStyle()
            .onClick(() => {
              let p = WindowUtil.getWindowProperties();
              this.textStr = `${JSON.stringify(p, null, 2)}`;
            })
          Button("getWindowType()\nisPrivacyMode()\nisTransparent()\nisFullScreen()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let windowType = WindowUtil.getWindowType();
              let isPrivacyMode = WindowUtil.isPrivacyMode();
              let isTransparent = WindowUtil.isTransparent();
              let isFullScreen = WindowUtil.isFullScreen();
              this.textStr = `windowType: ${windowType}\nisPrivacyMode: ${isPrivacyMode}\nisTransparent: ${isTransparent}\nisFullScreen: ${isFullScreen}`;
            })
          Button("isLayoutFullScreen()\ngetBrightness()\nisFocusable()\nisTouchable()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let isLayoutFullScreen = WindowUtil.isLayoutFullScreen();
              let brightness = WindowUtil.getBrightness();
              let isFocusable = WindowUtil.isFocusable();
              let isTouchable = WindowUtil.isTouchable();
              this.textStr = `isLayoutFullScreen: ${isLayoutFullScreen}\nbrightness: ${brightness}\nisFocusable: ${isFocusable}\nisTouchable: ${isTouchable}`;
            })
          Text(this.textStr)
            .visibility(StrUtil.isNotEmpty(this.textStr) ? Visibility.Visible : Visibility.None)
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