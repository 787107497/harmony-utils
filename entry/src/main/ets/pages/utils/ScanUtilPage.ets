import { router } from '@kit.ArkUI';
import { DescribeBean } from '../../entity/DescribeBean';
import { image } from '@kit.ImageKit';
import { FileUtil, ImageUtil, ScanUtil, ToastUtil } from '@pura/harmony-utils';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * 码工具类（扫码、码图生成、图片识码）
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  private txtStr: string = "harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法";
  private readonly fileName: string = "qr_code.png";
  @State filePath: string = '';
  @State pixelMap?: image.PixelMap = undefined;
  @State scanStr1: string = '';
  @State scanStr2: string = '';
  @State scanStr3: string = '';

  @MockSetup
  mock() {
    this.describe = new DescribeBean("ScanUtil", "码工具类（扫码、码图生成、图片识码）");
  }


  aboutToAppear(): void {
    this.filePath = FileUtil.getFilesDirPath("",this.fileName)
  }

  onBackPress(): boolean {
    return false;
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("startScanForResult()")
            .btnStyle()
            .onClick(() => {
              if (ScanUtil.canIUseScan()) {
                ScanUtil.startScanForResult().then((scanResult) => {
                  this.scanStr1 = JSON.stringify(scanResult, null, 2);
                })
              } else {
                ToastUtil.showToast("当前设备不支持码能力！")
              }
            })
          Text(this.scanStr1)
            .visibility(this.scanStr1 ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("generateBarcode()")
            .btnStyle()
            .onClick(async () => {
              if (ScanUtil.canIUseScan()) {
                this.pixelMap = await ScanUtil.generateBarcode(this.txtStr);
                ImageUtil.savePixelMap(this.pixelMap, FileUtil.getFilesDirPath(""), this.fileName)
              } else {
                ToastUtil.showToast("当前设备不支持码能力！")
              }
            })
          Image(this.pixelMap)
            .visibility(this.pixelMap ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("onPickerScanForResult()")
            .btnStyle()
            .onClick(() => {
              if (ScanUtil.canIUseScan()) {
                ScanUtil.onPickerScanForResult().then((scanResult) => {
                  this.scanStr2 = JSON.stringify(scanResult, null, 2);
                })
              } else {
                ToastUtil.showToast("当前设备不支持扫码能力！")
              }
            })
          Text(this.scanStr2)
            .visibility(this.scanStr2 ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("onDetectBarCode()")
            .btnStyle()
            .onClick(() => {
              if (ScanUtil.canIUseScan()) {
                if (FileUtil.accessSync(this.filePath)) {
                  ScanUtil.onDetectBarCode(this.filePath).then((scanResult) => {
                    this.scanStr3 = JSON.stringify(scanResult, null, 2);
                  })
                } else {
                  ToastUtil.showToast("请先点击generateBarcode生成二维码图片")
                }
              } else {
                ToastUtil.showToast("当前设备不支持码能力！")
              }
            })
          Text(this.scanStr3)
            .visibility(this.scanStr3 ? Visibility.Visible : Visibility.None)
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