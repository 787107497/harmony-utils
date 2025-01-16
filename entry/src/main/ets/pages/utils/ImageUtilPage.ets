import { router } from '@kit.ArkUI';
import { DateUtil, FileUtil, ImageUtil, LogUtil, PhotoHelper, PickerUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { image } from '@kit.ImageKit';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';
import { BusinessError } from '@kit.BasicServicesKit';
import fs from '@ohos.file.fs';

/**
 * 图片相关工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State base64str: string = "data:image/png;base64,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";
  @State filePath: string = ''; //本地图片path
  @State fileUri: string = ''; //本地图片uri
  @State pixelMap1?: image.PixelMap = undefined;
  @State pixelMap2?: image.PixelMap = undefined;
  @State pixelMap3?: image.PixelMap = undefined;
  @State base64Str: string = '';
  @State imgPath: string = '';
  @State imgUri: string = '';
  @State resultStr: string = '';

  @MockSetup
  mock() {
    this.describe = new DescribeBean("FileUtil", "文件操作相关工具类");
  }


  async aboutToAppear(): Promise<void> {
    let pixelMap = await ImageUtil.getPixelMapFromMedia($r("app.media.test_as4"))
    this.filePath = await ImageUtil.savePixelMap(pixelMap, FileUtil.getFilesDirPath(""), "漂亮小姐姐.png")
    this.fileUri = FileUtil.getUriFromPath(this.filePath);
    LogUtil.error("filePath: " + this.filePath);
    LogUtil.error("fileUri: " + this.fileUri);
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("base64ToPixelMap()")
            .btnStyle()
            .onClick(async () => {
              this.pixelMap1 = await ImageUtil.base64ToPixelMap(this.base64str);
            })
          Image(this.pixelMap1)
            .visibility(this.pixelMap1 ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("savePixelMap()")
            .btnStyle()
            .onClick(async () => {
              let pixelMap = await ImageUtil.getPixelMapFromMedia($r("app.media.test_as3"))
              this.imgPath = await ImageUtil.savePixelMap(pixelMap, FileUtil.getFilesDirPath(""), "妹纸.png")
              this.imgUri = FileUtil.getUriFromPath(this.imgPath);
            })
          Image(this.imgUri)
            .visibility(this.imgUri ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("createImageSource()")
            .btnStyle()
            .onClick(async () => {
              let imageSource = await ImageUtil.createImageSource(this.filePath)
              this.pixelMap2 = await imageSource.createPixelMap()
            })
          Image(this.pixelMap2)
            .visibility(this.pixelMap2 ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("saveImageSource()")
            .btnStyle()
            .onClick(async () => {
              let imageSource = await ImageUtil.createImageSource(this.filePath);

              ImageUtil.saveImageSource(imageSource, FileUtil.getFilesDirPath(""), `MZ_${DateUtil.getTodayStr()}.png`)
                .then(() => {
                  ToastUtil.showToast("保存成功")
                })
            })
          Button("packingFromPixelMap()")
            .btnStyle()
            .onClick(async () => {
              let pixelMap = await ImageUtil.createImageSource(this.filePath).createPixelMap()

              let packOpts: image.PackingOption = { format: "image/png", quality: 98 }
              ImageUtil.packingFromPixelMap(pixelMap, packOpts).then((buff) => {
                LogUtil.error("buff: " + buff.byteLength)
                ToastUtil.showToast("打包成功了")
              })
            })
          Button("packingFromImageSource()")
            .btnStyle()
            .onClick(async () => {
              let imageSource = await ImageUtil.createImageSource(this.filePath)

              let packOpts: image.PackingOption = { format: "image/png", quality: 98 }
              ImageUtil.packingFromImageSource(imageSource, packOpts).then((buff) => {
                LogUtil.error("buff: " + buff.byteLength)
                ToastUtil.showToast("打包成功了")
              })
            })
          Button("packToFileFromPixelMap()")
            .btnStyle()
            .onClick(async () => {
              let pixelMap = await ImageUtil.createImageSource(this.filePath).createPixelMap()

              let filePath = FileUtil.getFilesDirPath("", `MeiZi_${DateUtil.getTodayTime()}.png`);
              let file = FileUtil.openSync(filePath)
              let packOpts: image.PackingOption = { format: "image/png", quality: 100 }
              ImageUtil.packToFileFromPixelMap(pixelMap, file.fd, packOpts).then(() => {
                FileUtil.closeSync(file.fd) //关闭文件
                ToastUtil.showToast("图片保存成功")
              })
            })
          Button("packToFileFromImageSource()")
            .btnStyle()
            .onClick(async () => {
              let imageSource = await ImageUtil.createImageSource(this.filePath)
              let filePath = FileUtil.getFilesDirPath("", `MeiZi_${DateUtil.getTodayTime()}.png`);
              let file = FileUtil.openSync(filePath)
              let packOpts: image.PackingOption = { format: "image/png", quality: 100 }
              ImageUtil.packToFileFromImageSource(imageSource, file.fd, packOpts).then(() => {
                FileUtil.closeSync(file.fd) //关闭文件
                ToastUtil.showToast("图片保存成功")
              })
            })
          Button("getPixelMapFromMedia()")
            .btnStyle()
            .onClick(async () => {
              this.pixelMap3 = await ImageUtil.getPixelMapFromMedia($r("app.media.test_as2"))
            })
          Image(this.pixelMap3)
            .visibility(this.pixelMap3 ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("pixelMapToBase64Str()")
            .btnStyle()
            .onClick(async () => {
              this.resultStr = ""
              let pixelMap = await ImageUtil.getPixelMapFromMedia($r("app.media.test_as3"))
              this.base64Str = await ImageUtil.pixelMapToBase64Str(pixelMap)
            })
          Button("compressedImage()")
            .btnStyle()
            .onClick(async () => {
              let pixelMap = await ImageUtil.getPixelMapFromMedia($r("app.media.test_as5")); //原大小3.78M
              let arrayBuffer = await ImageUtil.compressedImage(pixelMap, 150);
              LogUtil.error("压缩后的大小：" + arrayBuffer.byteLength);
              PickerUtil.savePhoto(['压缩后的图片.jpeg']).then(async (uris)=>{
                let uri = uris[0];
                await FileUtil.writeEasy(uri,arrayBuffer,false);
                ToastUtil.showToast("压缩文件保存成功")
              })
            })
          Button("compressPhoto()")
            .btnStyle()
            .onClick(async () => {
              this.base64Str = ""
              PhotoHelper.select({ maxSelectNumber: 1 }).then(async (uris) => {
                if (uris?.length > 0) {
                  let uri = uris[0];
                  let filePath = await ImageUtil.compressPhoto(uri, 100).catch((err: BusinessError) => {
                    LogUtil.error("图片压缩异常：" + err.message);
                    return "";
                  }); //压缩返回路径
                  let oldSize = FileUtil.statSync(FileUtil.openSync(uri, fs.OpenMode.READ_ONLY).fd).size; //压缩前大小
                  let compressSize = FileUtil.statSync(filePath).size; //压缩后大小
                  this.resultStr = `压缩路径: ${filePath}\n\n压缩前大小: ${FileUtil.getFormatFileSize(oldSize)}\n压缩后大小: ${FileUtil.getFormatFileSize(compressSize)}`
                  LogUtil.error(this.resultStr);
                }
              }).catch((err: BusinessError) => {
                LogUtil.error("异常信息：" + err.message);
              })
            })

          Text(this.base64Str)
            .visibility(this.base64Str ? Visibility.Visible : Visibility.None)
            .textStyle()
          Text(this.resultStr)
            .visibility(this.resultStr ? Visibility.Visible : Visibility.None)
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