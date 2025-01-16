import { router } from '@kit.ArkUI';
import { AuthUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import userIAM_userAuth from '@ohos.userIAM.userAuth';
import userAuth from '@ohos.userIAM.userAuth';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * 手机的生物认证（指纹、人脸、密码）工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State errorStr: string = ''
  @State resultStr: string = ''

  @MockSetup
  mock() {
    this.describe = new DescribeBean("AuthUtil", "手机的生物认证（指纹、人脸、密码）工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("getAvailableStatus()")
            .btnStyle()
            .onClick(() => {
              let status = AuthUtil.getAvailableStatus(userIAM_userAuth.UserAuthType.FACE, userIAM_userAuth.AuthTrustLevel.ATL1)
              if (status.status) {
                this.errorStr = ''
                ToastUtil.showToast("当前设备支持人脸识别")
              } else {
                this.errorStr = JSON.stringify(status, null, 2);
                ToastUtil.showToast("当前设备不支持人脸识别")
              }
            })
          Button("getAvailableStatus()")
            .btnStyle()
            .onClick(() => {
              let status = AuthUtil.getAvailableStatus(userIAM_userAuth.UserAuthType.FINGERPRINT, userIAM_userAuth.AuthTrustLevel.ATL2)
              if (status.status) {
                this.errorStr = ''
                ToastUtil.showToast("当前设备支持指纹识别")
              } else {
                this.errorStr = JSON.stringify(status, null, 2);
                ToastUtil.showToast("当前设备不支持指纹识别")
              }
            })
          Button("getAvailableStatus()")
            .btnStyle()
            .onClick(() => {
              let status = AuthUtil.getAvailableStatus(userIAM_userAuth.UserAuthType.PIN, userIAM_userAuth.AuthTrustLevel.ATL2)
              if (status.status) {
                this.errorStr = ''
                ToastUtil.showToast("当前设备支持口令识别")
              } else {
                this.errorStr = JSON.stringify(status, null, 2);
                ToastUtil.showToast("当前设备不支持口令识别")
              }
            })
          Text(this.errorStr)
            .visibility(StrUtil.isNotEmpty(this.errorStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("onStartEasy()")
            .btnStyle()
            .onClick(() => {
              AuthUtil.onStartEasy(true, (result: userAuth.UserAuthResult) => {
                this.resultStr = JSON.stringify(result, null, 2);
              })
            })
          Button("onStart()")
            .btnStyle()
            .onClick(() => {
              AuthUtil.onStart({
                authType: [userAuth.UserAuthType.FACE],
                authTrustLevel: userAuth.AuthTrustLevel.ATL3,
                title: '请验证人脸',
                showTip: true
              }, (result) => {
                this.resultStr = JSON.stringify(result, null, 2);
              })
            })
          Button("cancel()")
            .btnStyle()
            .onClick(() => {
              AuthUtil.cancel()
            })
          Text(this.resultStr)
            .visibility(StrUtil.isNotEmpty(this.resultStr) ? Visibility.Visible : Visibility.None)
            .textStyle()

          Text('').layoutWeight(1)
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
  .backgroundColor(Color.White)
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}