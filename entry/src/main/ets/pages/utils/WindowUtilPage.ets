import { router, window } from '@kit.ArkUI';
import { AppUtil, LogUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
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
  @State bright: number = 0.0; //屏幕亮度值
  @State isKeepScreenOn: boolean = false; //屏幕是否为常亮状态
  @State privacyMode: boolean = false; //是否隐私模式
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
                ToastUtil.showToast(`您已设置亮度: ${this.bright}`);
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
              AppUtil.setWindowBackgroundColor("#FF00F0");
              ToastUtil.showToast("设置背景色成功");
            })
          Button("setWindowFocusable()")
            .btnStyle()
            .onClick(() => {
              AppUtil.setWindowFocusable(true).then(() => {
                ToastUtil.showToast("设置成功啦^·^");
              }).catch((err:BusinessError) => {
                ToastUtil.showToast("设置失败！");
              });
            })
          Button("setWindowTouchable()")
            .btnStyle()
            .onClick(() => {
              AppUtil.setWindowTouchable(true).then(() => {
                ToastUtil.showToast("设置成功啦^·^");
              }).catch((err:BusinessError) => {
                ToastUtil.showToast("设置失败！");
              });
            })

          Button("getWindowProperties()")
            .btnStyle()
            .onClick(() => {
              let p = AppUtil.getWindowProperties();
              this.textStr = `${JSON.stringify(p, null, 2)}`;
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