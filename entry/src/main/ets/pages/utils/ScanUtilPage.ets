import { router } from '@kit.ArkUI';
import { DescribeBean } from '../../model/DescribeBean';
import { FileUtil, ImageUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';
import { BusinessError } from '@kit.BasicServicesKit';
import { ScanUtil } from '@pura/picker_utils';
import { Utils } from '../../utils/Utils';
import { detectBarcode } from '@kit.ScanKit';

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
                  let scanStr1 = JSON.stringify(scanResult, null, 2);
                  Utils.showSheetText(scanStr1);
                });
              } else {
                ToastUtil.showToast("当前设备不支持码能力！")
              }
            })
          Button("generateBarcode()")
            .btnStyle()
            .onClick(async () => {
              if (ScanUtil.canIUseScan()) {
                let pixelMap = await ScanUtil.generateBarcode(this.txtStr);
                ImageUtil.savePixelMap(pixelMap, FileUtil.getFilesDirPath(""), this.fileName);
                Utils.showSheetImg(pixelMap);
              } else {
                ToastUtil.showToast("当前设备不支持码能力！");
              }
            })
          Button("decode()")
            .btnStyle()
            .onClick(() => {
              if (ScanUtil.canIUseScan()) {
                if (FileUtil.accessSync(this.filePath)) {
                  ScanUtil.decode(this.filePath).then((scanResult) => {
                    let scanStr3 = JSON.stringify(scanResult, null, 2);
                    Utils.showSheetText(scanStr3);
                  })
                } else {
                  ToastUtil.showToast("请先点击generateBarcode生成二维码图片");
                }
              } else {
                ToastUtil.showToast("当前设备不支持码能力！");
              }
            })
          Button("decodeImage()")
            .btnStyle()
            .onClick(async () => {
                let pixelMap = await ScanUtil.generateBarcode(this.txtStr);
                let arrayBuffer = await ImageUtil.packingFromPixelMap(pixelMap, { format: 'image/png', quality: 100 });
                let byteImg: detectBarcode.ByteImage = {
                  byteBuffer: arrayBuffer,
                  width: pixelMap.getImageInfoSync().size.width,
                  height: pixelMap.getImageInfoSync().size.height,
                  format: detectBarcode.ImageFormat.NV21
                };
                ScanUtil.decodeImage(byteImg).then((scanResult) => {
                  let scanStr3 = JSON.stringify(scanResult, null, 2);
                  Utils.showSheetText(scanStr3);
                });

            })
          Button("onPickerScanForResult()")
            .btnStyle()
            .onClick(() => {
              if (ScanUtil.canIUseScan()) {
                ScanUtil.onPickerScanForResult().then((scanResult) => {
                  let scanStr2 = JSON.stringify(scanResult, null, 2);
                  Utils.showSheetText(scanStr2);
                }).catch((err: BusinessError) => {
                  ToastUtil.showToast("扫码异常！");
                  LogUtil.error("扫码异常：code:" + err.code + " ~ msg:" + err.message);
                });
              } else {
                ToastUtil.showToast("当前设备不支持扫码能力！");
              }
            })
          Button("canIUseScan()")
            .btnStyle()
            .onClick(() => {
              let canIUseScan = ScanUtil.canIUseScan();
              ToastUtil.showToast(`当前设备是否支持码能力：${canIUseScan}`);
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
