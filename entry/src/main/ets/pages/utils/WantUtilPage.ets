import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { FileUtil, LogUtil, ToastUtil, WantUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * Want工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State docPath: string = '' //文件路径

  @MockSetup
  mock() {
    this.describe = new DescribeBean("WantUtil", "Want工具类");
  }

  async aboutToAppear(): Promise<void> {
    this.docPath = FileUtil.getFilesDirPath('download/wps/doc', '测试DOC文件.doc');
    FileUtil.writeEasy(this.docPath, "harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包。帮助开发者快速构建鸿蒙应用。哈哈哈哈哈哈！");
  }


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("toAppSetting()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("跳转应用设置页面！");
              WantUtil.toAppSetting();
            })
          Button("toNotificationSetting()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("跳转通知设置页面！");
              WantUtil.toNotificationSetting();
            })
          Button("toNetworkSetting()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("跳转移动网络设置页面！");
              WantUtil.toNetworkSetting();
            })
          Button("toWifiSetting()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("跳转WLAN设置页面！");
              WantUtil.toWifiSetting();
            })
          Button("toBluetoothSetting()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("跳转蓝牙设置页面！");
              WantUtil.toBluetoothSetting();
            })
          Button("toNfcSetting()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("跳转NFC设置页面！");
              WantUtil.toNfcSetting();
            })
          Button("toVolumeSetting()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("跳转声音和振动设置页面！");
              WantUtil.toVolumeSetting();
            })
          Button("toStorageSetting()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("跳转存储设置页面！");
              WantUtil.toStorageSetting();
            })
          Button("toBatterySetting()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("跳转电池设置页面！")
              WantUtil.toBatterySetting();
            })
          Button("toSetting()，URI_BIOMETRICS_AND_PASSWORD")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("跳转生物识别和密码！");
              WantUtil.toSetting(WantUtil.URI_BIOMETRICS_AND_PASSWORD);
            })
          Button("toSetting()，URI_ABOUT_DEVICE")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("跳转关于本机界面！");
              WantUtil.toSetting(WantUtil.URI_ABOUT_DEVICE);
            })

          Button("toWebBrowser()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("拉起系统浏览器中…")
              WantUtil.toWebBrowser("https://developer.huawei.com/")
                .catch((err: BusinessError) => {
                  LogUtil.error(JSON.stringify(err));
                  ToastUtil.showToast("拉起失败！");
                });
            })
          Button("toAppGalleryDetail()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("拉起应用市场对应的应用详情界面中…")
              WantUtil.toAppGalleryDetail("com.harmony.utils")
                .catch((err: BusinessError) => {
                  LogUtil.error(JSON.stringify(err));
                  ToastUtil.showToast("拉起失败！");
                });
            })
          Button("toFileManagement()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("拉起系统文件管理器中…")
              WantUtil.toFileManagement()
                .catch((err: BusinessError) => {
                  LogUtil.error(JSON.stringify(err));
                  ToastUtil.showToast("拉起失败！");
                });
            })
          Button("startMMS()")
            .btnStyle()
            .onClick(() => {
              WantUtil.startMMS("13909626520", "张三").then(() => {
                ToastUtil.showToast("拉起短信界面…")
              }).catch((err: BusinessError) => {
                LogUtil.error(JSON.stringify(err));
                ToastUtil.showToast("拉起失败！");
              });
            })
          Button("openFile()")
            .btnStyle()
            .onClick(() => {
              let uri = FileUtil.getUriFromPath(this.docPath);
              LogUtil.error("uri: "+ uri)
              WantUtil.openFile(uri).catch((error: BusinessError) => {
                ToastUtil.showToast("打开文件失败，" + error.message);
                LogUtil.error(`打开文件异常 ~ code: ${error.code} -·- message: ${error.message}`);
              });
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