import { router } from '@kit.ArkUI';
import { AuthUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import userIAM_userAuth from '@ohos.userIAM.userAuth';
import userAuth from '@ohos.userIAM.userAuth';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';
import { Utils } from '../../utils/Utils';

/**
 * 手机的生物认证（指纹、人脸、密码）工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;


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
                ToastUtil.showToast("当前设备支持人脸识别")
              } else {
                ToastUtil.showToast("当前设备不支持人脸识别");
                LogUtil.error(JSON.stringify(status, null, 2));
              }
            })
          Button("getAvailableStatus()")
            .btnStyle()
            .onClick(() => {
              let status = AuthUtil.getAvailableStatus(userIAM_userAuth.UserAuthType.FINGERPRINT, userIAM_userAuth.AuthTrustLevel.ATL2)
              if (status.status) {
                ToastUtil.showToast("当前设备支持指纹识别")
              } else {
                ToastUtil.showToast("当前设备不支持指纹识别")
                LogUtil.error(JSON.stringify(status, null, 2));
              }
            })
          Button("getAvailableStatus()")
            .btnStyle()
            .onClick(() => {
              let status = AuthUtil.getAvailableStatus(userIAM_userAuth.UserAuthType.PIN, userIAM_userAuth.AuthTrustLevel.ATL2)
              if (status.status) {
                ToastUtil.showToast("当前设备支持口令识别")
              } else {
                ToastUtil.showToast("当前设备不支持口令识别");
                LogUtil.error(JSON.stringify(status, null, 2));
              }
            })
          Button("onStartEasy()")
            .btnStyle()
            .onClick(() => {
              AuthUtil.onStartEasy(true, (result: userAuth.UserAuthResult) => {
                let resultStr = JSON.stringify(result, null, 2);
                Utils.showSheetText(resultStr);
              });
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
                let resultStr = JSON.stringify(result, null, 2);
                Utils.showSheetText(resultStr);
              });
            })
          Button("cancel()")
            .btnStyle()
            .onClick(() => {
              AuthUtil.cancel();
            })
          Button("generateChallenge")
            .btnStyle()
            .onClick(() => {
              let challenge = AuthUtil.generateChallenge();
              Utils.showSheetText(`挑战值: ${challenge}`);
            })

         Blank().layoutWeight(1)
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