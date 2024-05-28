import { ComposeTitleBar, router } from '@kit.ArkUI';
import { FileUtil, ImageUtil, LogUtil, PreviewUtil, StrUtil, ToastUtil } from 'harmony_utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';

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
  @State infoStr: string = ''
  @State iconFileStr: string = ''
  @State resultStr: string = ''


  async aboutToAppear(): Promise<void> {
    this.textPath = FileUtil.getFilesDirPath('download/wps/txt', '文本文档.txt');
    FileUtil.writeEasy(this.textPath, "harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包。帮助开发者快速构建鸿蒙应用。")
    this.docPath = FileUtil.getFilesDirPath('download/wps/doc', '测试DOC文件.doc');
    FileUtil.writeEasy(this.docPath, "harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包。帮助开发者快速构建鸿蒙应用。")
    let pixelMap = await ImageUtil.getPixelMapFromMedia($r('app.media.as4'))
    this.imgPath = await ImageUtil.savePixelMap(pixelMap, FileUtil.getFilesDirPath(""), "漂亮小妹纸.png")
  }

  onBackPress(): boolean {
    return false;
  }

  build() {
    Column() {
      ComposeTitleBar({
        title: this.describe.name,
        subtitle: this.describe.desc,
      })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("generatePreviewInfo()")
            .btnStyle()
            .onClick(() => {
              let uri = FileUtil.getUriFromPath(this.textPath);
              let info = PreviewUtil.generatePreviewInfo(uri);
              this.infoStr = JSON.stringify(info, null, 2);
            })
          Text(this.infoStr)
            .visibility(StrUtil.isNotEmpty(this.infoStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("openPreview()")
            .btnStyle()
            .onClick(() => {
              let uri = FileUtil.getUriFromPath(this.textPath);
              let info = PreviewUtil.generatePreviewInfo(uri);
              PreviewUtil.openPreview(info).catch((error:BusinessError)=>{
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
              ToastUtil.showToast(`canPreview: ${canPreview}`)
            })
          Button("hasDisplayed()")
            .btnStyle()
            .onClick(async () => {
              let hasDisplayed = await PreviewUtil.hasDisplayed();
              ToastUtil.showToast(`hasDisplayed: ${hasDisplayed}`)
            })
          Button("closePreview()")
            .btnStyle()
            .onClick(() => {
              PreviewUtil.closePreview().then(() => {
                ToastUtil.showToast("已关闭预览")
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
              let uri = FileUtil.getUriFromPath(this.textPath);
              PreviewUtil.onSharePreview(uri).catch((error:BusinessError)=>{
                LogUtil.error(`onSharePreview-异常 ~ code: ${error.code} -·- message: ${error.message}`);
              });
            })
          Button("onPreview()")
            .btnStyle()
            .onClick(() => {
              let uri = FileUtil.getUriFromPath(this.textPath);
              PreviewUtil.onPreview(uri);
            })
          Button("getMimeType()")
            .btnStyle()
            .onClick(() => {
              let mimeType = PreviewUtil.getMimeType("png");
              let mimeType2 = PreviewUtil.getMimeType("txt");
              ToastUtil.showToast(`${mimeType} --- ${mimeType2}`)
            })
          Button("getIconFileStr()")
            .btnStyle()
            .onClick(() => {
              this.iconFileStr = PreviewUtil.getIconFileStr("doc");
              ToastUtil.showToast(`${this.iconFileStr}`)
            })
          Image($r(this.iconFileStr))
            .visibility(StrUtil.isNotEmpty(this.iconFileStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getMimeTypeMap()")
            .btnStyle()
            .onClick(() => {
              let map = PreviewUtil.getMimeTypeMap();
              this.resultStr = JSON.stringify(map, null, 2);
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