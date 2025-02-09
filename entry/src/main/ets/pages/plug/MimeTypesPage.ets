import { router } from '@kit.ArkUI';
import { StrUtil } from '@pura/harmony-utils';
import { Mime } from '@pura/mime-types';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * @nutpi/mime-types，使用案例
 */
@Entry
@ComponentV2
export struct MimeTypesPage {
  private scroller: Scroller = new Scroller();
  @Local describe: DescribeBean = router.getParams() as DescribeBean;
  @Local txtStr: string = "";
  @Local iconFile1: string = "";
  @Local iconFile2: string = "";


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("lookup()")
            .btnStyle()
            .onClick(() => {
              let mimeType1 = Mime.lookup("test.txt");
              let mimeType2 = Mime.lookup("测试文档.doc");
              let mimeType3 = Mime.lookup("应用.apk");
              let mimeType4 = Mime.lookup("一路向西.mp4");
              let mimeType5 = Mime.lookup("嗨歌.mp3");
              this.txtStr = `test.txt：${mimeType1}\n\n测试文档.doc：${mimeType2}\n\n应用.apk：${mimeType3}\n\n一路向西.mp4：${mimeType4}\n\n嗨歌.mp3：${mimeType5}`;
              this.iconFile1 = "";
              this.iconFile2 = "";
            })
          Button("contentType()")
            .btnStyle()
            .onClick(() => {
              let mimeType1 = Mime.contentType("html");
              let mimeType2 = Mime.contentType("jpeg");
              let mimeType3 = Mime.contentType(".ofd");
              let mimeType4 = Mime.contentType(".PDF");
              let mimeType5 = Mime.contentType(".png");
              this.txtStr = `html：${mimeType1}\n\njpeg：${mimeType2}\n\n.ofd：${mimeType3}\n\n.PDF：${mimeType4}\n\n.png：${mimeType5}`;
              this.iconFile1 = "";
              this.iconFile2 = "";
            })
          Button("extension()")
            .btnStyle()
            .onClick(() => {
              let mimeType1 = Mime.extension("image/jpeg");
              let mimeType2 = Mime.extension("image/gif");
              let mimeType3 = Mime.extension("audio/mp3");
              let mimeType4 = Mime.extension("application/pdf");
              let mimeType5 = Mime.extension("application/epub+zip");
              this.txtStr = `image/jpeg：${mimeType1}\n\nimage/gif：${mimeType2}\n\naudio/mp3：${mimeType3}\n\napplication/pdf：${mimeType4}\n\napplication/epub+zip：${mimeType5}`;
              this.iconFile1 = "";
              this.iconFile2 = "";
            })
          Button("getFileExtention()")
            .btnStyle()
            .onClick(() => {
              let mimeType1 = Mime.getFileExtention("test.txt");
              let mimeType2 = Mime.getFileExtention("/downnload/wps/测试文档.doc");
              let mimeType3 = Mime.getFileExtention("https://developer.demo/files/开发说明.PDF");
              this.txtStr = `${mimeType1}\n\n${mimeType2}\n\n${mimeType3}`;
              this.iconFile1 = "";
              this.iconFile2 = "";
            })
          Button("getIconFileByFileExtension()")
            .btnStyle()
            .onClick(() => {
              this.iconFile1 = Mime.getIconFileByFileExtension(".txt");
              this.iconFile2 = Mime.getIconFileByFileExtension("doc");
              this.txtStr = `${this.iconFile1}\n\n${this.iconFile2}`;
            })
          Button("getIconFileByMIMEType()")
            .btnStyle()
            .onClick(() => {
              this.iconFile1 = Mime.getIconFileByMIMEType("application/pdf");
              this.iconFile2 = Mime.getIconFileByMIMEType("image/gif");
              this.txtStr = `${this.iconFile1}\n\n${this.iconFile2}`;
            })

          Blank().layoutWeight(1)

          Image($r(this.iconFile1)).textStyle()
            .visibility(StrUtil.isNotEmpty(this.iconFile1) ? Visibility.Visible : Visibility.None)

          Image($r(this.iconFile2)).textStyle()
            .visibility(StrUtil.isNotEmpty(this.iconFile2) ? Visibility.Visible : Visibility.None)

          Text(this.txtStr)
            .visibility(StrUtil.isNotEmpty(this.txtStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
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