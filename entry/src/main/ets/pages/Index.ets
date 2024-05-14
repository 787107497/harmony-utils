import { FileUtil, LogUtil, StrUtil, ToastUtil } from 'harmony_utils';
import { image } from '@kit.ImageKit';
import { ImageUtil } from '../../../../../harmony_utils/src/main/ets/utils/ImageUtil';


@Entry
@Component
struct Index {
  readonly img: string = 'data:image/png;base64,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';
  @State message: string = '这是一个消息';
  @State array: string[] = ["黑龙江省", "A", "哈尔滨市", "道里区", "a", "哈尔滨市", ''];
  @State url: string = 'https://ai.bdstatic.com/file/1E862211BBC64890A993557E222A4A57';
  @State pixelMap?: image.PixelMap = undefined
  @State pixelMap1?: image.PixelMap = undefined
  @State path: string = ''
  buf?: ArrayBuffer | image.PixelMap = undefined;


  aboutToAppear(): void {
    // CrashUtil.onError()
  }

  onBackPress(): boolean {
    ToastUtil.showToast("返回键")
    return false;
  }

  build() {
    Row() {
      Scroll(){
        Column() {
          Text('获取正文内容')
            .fontSize(30)
            .margin({ top: 15 })
            .fontWeight(FontWeight.Bold)
            .onClick(async () => {
              let filePath = FileUtil.getFilesDirOrPath("code.png")

              let pixelMap = await ImageUtil.base64ToPixelMap(this.img)
              this.pixelMap = pixelMap;
              let path = await ImageUtil.savePixelMap(pixelMap, FileUtil.getFilesDirOrPath("download/pic"), "code.png")
              if (path) {
                let imageSource=ImageUtil.createImageSource(path);
                let buf = StrUtil.strToBuffer("东风浩荡万里长——习近平主席欧洲三国之行引发热烈反响");
               await imageSource.updateData(buf, true, 0, buf.byteLength);
                this.pixelMap1 = await imageSource.createPixelMap();

              }



              let files = FileUtil.listFileSync(FileUtil.getFilesDirOrPath(), { recursion: true })
              LogUtil.error("files: " + files.join(' , '))
            })

          Image(this.pixelMap)
            .margin(15)
            .width('80%')
          Image(this.pixelMap1)
            .margin(15)
            .width('80%')

          Text(this.message)
            .fontSize(10)
            .margin({ top: 15 })
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFEFED')
      } .width('100%')
      .height('100%')
    }
    .backgroundColor('#7733FF')
    .width('100%')
    .height('100%')
  }
}


interface User {
  id: string;
  name: string;
  age: number;
  remark: string;
}