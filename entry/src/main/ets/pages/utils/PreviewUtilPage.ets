import { router } from '@kit.ArkUI';
import { FileUtil, ImageUtil, LogUtil, PreviewUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';
import { Utils } from '../../utils/Utils';

/**
 * 对象工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State textPath: string = '' //文件路径
  @State docPath: string = '' //文件路径
  @State imgPath: string = '' //文件路径

  @MockSetup
  mock() {
    this.describe = new DescribeBean("PreviewUtil", "文件预览工具类");
  }


  async aboutToAppear(): Promise<void> {
    this.textPath = FileUtil.getFilesDirPath('download/wps/txt', '文本文档.txt');
    FileUtil.writeEasy(this.textPath, "harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包。帮助开发者快速构建鸿蒙应用。");
    this.docPath = FileUtil.getFilesDirPath('download/wps/doc', '测试DOC文件.doc');
    FileUtil.writeEasy(this.docPath, "harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包。帮助开发者快速构建鸿蒙应用。");
    let pixelMap = await ImageUtil.getPixelMapFromMedia($r("app.media.test_as4"));
    this.imgPath = await ImageUtil.savePixelMap(pixelMap, FileUtil.getFilesDirPath(""), "漂亮小妹纸.png");
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
          Button("canIUsePreview()")
            .btnStyle()
            .onClick(() => {
              let bl = PreviewUtil.canIUsePreview();
              ToastUtil.showToast(`当前设备是否支持文件预览能力:${bl}`);
            })
          Button("generatePreviewInfo()")
            .btnStyle()
            .onClick(() => {
              let uri = FileUtil.getUriFromPath(this.textPath);
              let info = PreviewUtil.generatePreviewInfo(uri);
              let infoStr = JSON.stringify(info, null, 2);
              Utils.showSheetText(infoStr);
            })
          Button("openPreview()")
            .btnStyle()
            .onClick(() => {
              let uri = FileUtil.getUriFromPath(this.textPath);
              let info = PreviewUtil.generatePreviewInfo(uri);
              PreviewUtil.openPreview(info).catch((error: BusinessError) => {
                LogUtil.error(`onSharePreview-异常 ~ code: ${error.code} -·- message: ${error.message}`);
              });
            })
          Button("openPreviewEasy()")
            .btnStyle()
            .onClick(() => {
              let uri = FileUtil.getUriFromPath(this.imgPath);
              PreviewUtil.openPreviewEasy(uri);
            })
          Button("canPreview()")
            .btnStyle()
            .onClick(async () => {
              let uri = FileUtil.getUriFromPath(this.textPath);
              let canPreview = await PreviewUtil.canPreview(uri);
              ToastUtil.showToast(`canPreview: ${canPreview}`);
            })
          Button("hasDisplayed()")
            .btnStyle()
            .onClick(async () => {
              let hasDisplayed = await PreviewUtil.hasDisplayed();
              ToastUtil.showToast(`hasDisplayed: ${hasDisplayed}`);
            })
          Button("closePreview()")
            .btnStyle()
            .onClick(() => {
              PreviewUtil.closePreview().then(() => {
                ToastUtil.showToast("已关闭预览");
              })
            })
          Button("loadData()")
            .btnStyle()
            .onClick(async () => {
              let uri = FileUtil.getUriFromPath(this.textPath);
              let info = PreviewUtil.generatePreviewInfo(uri);
              let hasDisplayed = await PreviewUtil.hasDisplayed();
              if (hasDisplayed) {
                PreviewUtil.loadData(info);
              } else {
                PreviewUtil.openPreview(info);
              }
            })
          Button("loadDataEasy()")
            .btnStyle()
            .onClick(async () => {
              let uri = FileUtil.getUriFromPath(this.textPath);
              let hasDisplayed = await PreviewUtil.hasDisplayed();
              if (hasDisplayed) {
                PreviewUtil.loadDataEasy(uri);
              } else {
                PreviewUtil.openPreviewEasy(uri);
              }
            })
          Button("onSharePreview()")
            .btnStyle()
            .onClick(() => {
              let uri = FileUtil.getUriFromPath(this.docPath);
              LogUtil.error("uri: "+ uri)
              PreviewUtil.onSharePreview(uri).catch((error: BusinessError) => {
                ToastUtil.showToast("打开文件失败，" + error.message);
                LogUtil.error(`onSharePreview-异常 ~ code: ${error.code} -·- message: ${error.message}`);
              });
            })
          Button("getTypeDescriptor()")
            .btnStyle()
            .onClick(() => {
              let typeDescriptor = PreviewUtil.getTypeDescriptor("png");
              ToastUtil.showToast(`${typeDescriptor.mimeTypes}`);
            })
          Button("getMimeType()")
            .btnStyle()
            .onClick(() => {
              let mimeType = PreviewUtil.getMimeType("png");
              let mimeType2 = PreviewUtil.getMimeType("txt");
              ToastUtil.showToast(`${mimeType} --- ${mimeType2}`);
            })
          Button("getIconFileStr()")
            .btnStyle()
            .onClick(() => {
              let iconFileStr = PreviewUtil.getIconFileStr("doc");
              ToastUtil.showToast(`${iconFileStr}`);
              Utils.showSheetImg($r(iconFileStr));
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
  .width('90%')
  .padding(10)
  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  .margin(15)
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}