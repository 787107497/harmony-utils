import { ComposeTitleBar, router } from '@kit.ArkUI';
import {AppUtil,DateUtil,FileUtil,ImageUtil,LogUtil,PermissionUtil,PickerUtil,StrUtil,ToastUtil} from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { Permissions } from '@kit.AbilityKit';
import { image } from '@kit.ImageKit';
import { MockSetup } from '@ohos/hamock';


/**
 * 拍照、文件(文件、图片、视频、音频)选择和保存,工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State uriStr: string = ''
  @State pixelMap?: image.PixelMap | string = undefined
  @State filePath: string = ''; //本地图片path

  @MockSetup
  mock() {
    this.describe = new DescribeBean("PickerUtil", "拍照、文件(文件、图片、视频、音频)选择和保存,工具类");
  }


  async aboutToAppear(): Promise<void> {
    let pixelMap = await ImageUtil.getPixelMapFromMedia($r('app.media.as4'))
    this.filePath = await ImageUtil.savePixelMap(pixelMap, FileUtil.getFilesDirPath(""), "漂亮小姐姐.png")
    LogUtil.error("filePath: " + this.filePath);
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
          Button("camera()")
            .btnStyle()
            .onClick(async () => {
              // let p: Permissions = 'ohos.permission.CAMERA';
              // PermissionUtil.checkRequestPermissions(p).then(async (grant) => {
              //   if (grant) {
              //
              //   } else {
              //     ToastUtil.showLong("请在设置中打开权限")
              //     AppUtil.toAppSetting()
              //   }
              // })
              PickerUtil.camera().then((uri) => {
                this.uriStr = `调用相机，返回uri：\n${uri}`
              }).catch((err: BusinessError) => {
                this.uriStr = `调用相机，异常：\n${JSON.stringify(err)}`
              })
            })
          Button("selectPhoto()")
            .btnStyle()
            .onClick(() => {
              // let ps: Permissions[] = ['ohos.permission.CAMERA', 'ohos.permission.READ_MEDIA', 'ohos.permission.WRITE_MEDIA', 'ohos.permission.READ_IMAGEVIDEO'];
              // PermissionUtil.requestPermissionsList(ps).then((result) => {
              //   if (result) {
              //
              //   } else {
              //     ToastUtil.showLong("请在设置中打开权限")
              //     AppUtil.toAppSetting()
              //   }
              // })
              PickerUtil.selectPhoto().then((uris) => {
                this.uriStr = `调用相册，返回uris：\n${uris.join('\n')}`
              }).catch((err: BusinessError) => {
                this.uriStr = `调用相册，异常：\n${JSON.stringify(err)}`
              })
            })

          Button("savePhoto()")
            .btnStyle()
            .onClick(() => {
              let imgName = `漂亮小姐姐_${DateUtil.getTodayTime()}.png`;
              let imgName1 = `漂亮小妹妹_${DateUtil.getTodayTime()}.png`;
              PickerUtil.savePhoto([imgName, imgName1]).then(async (uris) => {
                let uri = uris[0];
                this.uriStr = `调用保存图片，返回uris：\n${uri}`
                let file = FileUtil.openSync(uri);
                FileUtil.copyFile(this.filePath, file.fd).then(() => {
                  this.uriStr = `保存图片，返回uris：\n${uri}`
                  ToastUtil.showToast("图片保存成功");
                })

                let file1 = FileUtil.openSync(uris[1]);
                let pixelMap1 = await ImageUtil.getPixelMapFromMedia($r('app.media.as3'))
                let packOpts: image.PackingOption = { format: 'image/png', quality: 100 }
                ImageUtil.packToFileFromPixelMap(pixelMap1, file1.fd, packOpts).then(() => {
                  this.uriStr = `保存图片，返回uris：\n${uris[1]}`
                  ToastUtil.showToast("图片保存成功");
                })
              }).catch((err: BusinessError) => {
                this.uriStr = `调用保存图片，异常：\n${JSON.stringify(err)}`
              })
            })
          Button("selectDocument()")
            .btnStyle()
            .onClick(() => {
              PickerUtil.selectDocument().then((uris) => {
                this.uriStr = `调用文件管理，返回uris：\n${uris.join('\n')}`
              }).catch((err: BusinessError) => {
                this.uriStr = `调用文件管理，异常：\n${JSON.stringify(err)}`
              })
            })
          Button("saveDocument()")
            .btnStyle()
            .onClick(() => {
              let fileName = `test_${DateUtil.getTodayTime()}.txt`;
              PickerUtil.saveDocument([fileName]).then((uris) => {
                let uri = uris[0];
                this.uriStr = `调用保存文件，返回uris：\n${uri}`
                FileUtil.writeEasy(uri, `“harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。\n\n`)
                  .then(() => {
                    this.uriStr = `文件保存成功，返回uris：\n${uri}`
                    ToastUtil.showToast("文件保存成功");
                  })
              }).catch((err: BusinessError) => {
                this.uriStr = `调用保存文件，异常：\n${JSON.stringify(err)}`
              })
            })
          Button("selectPhoto()")
            .btnStyle()
            .onClick(() => {
              PickerUtil.selectPhoto({ maxSelectNumber: 1 }).then(async (uris) => {
                if (uris && uris.length > 0) {
                  this.pixelMap = uris[0];
                } else {
                  ToastUtil.showToast("请选择图片")
                }
              }).catch((err: BusinessError) => {
                this.uriStr = `异常：\n${JSON.stringify(err)}`
              })
            })
          Text(this.uriStr)
            .visibility(StrUtil.isNotEmpty(this.uriStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Image(this.pixelMap)
            .width('90%')
            .margin({ top: 10, bottom: 10 })

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