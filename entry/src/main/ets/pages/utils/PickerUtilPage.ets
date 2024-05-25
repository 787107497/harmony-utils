import { ComposeTitleBar, router } from '@kit.ArkUI';
import { DateUtil, FileUtil, ImageUtil, LogUtil, PermissionUtil, PickerUtil, StrUtil, ToastUtil } from 'harmony_utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { Permissions } from '@kit.AbilityKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { image } from '@kit.ImageKit';


/**
 * 拍照、文件(文件、图片、视频、音频)选择和保存,工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State uriStr: string = ''
  @State pixelMap?: image.PixelMap = undefined
  @State filePath: string = ''; //本地图片path

  async aboutToAppear(): Promise<void> {
    let pixelMap = await ImageUtil.getPixelMapFromMedia($r('app.media.as4'))
    this.filePath = await ImageUtil.savePixelMap(pixelMap, FileUtil.getFilesDirOrPath(), "漂亮小姐姐.png")
    LogUtil.error("filePath: " + this.filePath);
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
          Button("camera()")
            .btnStyle()
            .onClick(async () => {
              let p: Permissions = 'ohos.permission.CAMERA';
              PermissionUtil.checkRequestPermissions(p).then(async (grant) => {
                if (grant) {
                  PickerUtil.camera().then((uri) => {
                    this.uriStr = `调用相机，返回uri：\n${uri}`
                  }).catch((err: BusinessError) => {
                    this.uriStr = `调用相机，异常：\n${JSON.stringify(err)}`
                  })
                } else {
                  ToastUtil.showLong("请在设置中打开权限")
                  PermissionUtil.toAppSetting()
                }
              })
            })
          Button("selectPhoto()")
            .btnStyle()
            .onClick(() => {
              let ps: Permissions[] = ['ohos.permission.CAMERA', 'ohos.permission.READ_MEDIA', 'ohos.permission.WRITE_MEDIA'];
              PermissionUtil.requestPermissionsList(ps).then((result) => {
                if (result) {
                  PickerUtil.selectPhoto().then((uris) => {
                    this.uriStr = `调用相册，返回uris：\n${uris.join('\n')}`
                  }).catch((err: BusinessError) => {
                    this.uriStr = `调用相册，异常：\n${JSON.stringify(err)}`
                  })
                } else {
                  ToastUtil.showLong("请在设置中打开权限")
                  PermissionUtil.toAppSetting()
                }
              })
            })

          Button("savePhoto()")
            .btnStyle()
            .onClick(() => {
              let ps: Permissions[] = ['ohos.permission.READ_MEDIA', 'ohos.permission.WRITE_MEDIA'];
              PermissionUtil.requestPermissionsList(ps).then((result) => {
                if (result) {
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
                } else {
                  ToastUtil.showLong("请在设置中打开权限")
                  PermissionUtil.toAppSetting()
                }
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
              let fileName = `test_${DateUtil.getTodayTime()}.png`;
              PickerUtil.saveDocument([fileName]).then((uris) => {
                let uri = uris[0];
                this.uriStr = `调用保存文件，返回uris：\n${uri}`
                FileUtil.writeEasy(uri, `“党中央作出重大决策、制定重要文件，都深入调研，广泛听取各方面意见，这是我们党的一贯做法和优良传统。对大家提出的进一步全面深化改革的意见和建议，有关方面要认真研究吸纳。”企业和专家座谈会上，习近平总书记这样阐明此行深意。\n\n`)
                  .then(() => {
                    this.uriStr = `文件保存成功，返回uris：\n${uri}`
                    ToastUtil.showToast("文件保存成功");
                  })
              }).catch((err: BusinessError) => {
                this.uriStr = `调用保存文件，异常：\n${JSON.stringify(err)}`
              })
            })
          Button("getPhotoAsset()")
            .btnStyle()
            .onClick(() => {
              let ps: Permissions[] = ['ohos.permission.CAMERA', 'ohos.permission.READ_MEDIA', 'ohos.permission.WRITE_MEDIA'];
              PermissionUtil.requestPermissionsList(ps).then((result) => {
                if (result) {
                  PickerUtil.selectPhoto().then(async (uris) => {
                    if (uris && uris.length > 0) {
                      let photoAsset = await PickerUtil.getPhotoAsset(uris[0]);
                      try {
                        let name = photoAsset?.get(photoAccessHelper.PhotoKeys.DISPLAY_NAME);
                        let type = photoAsset?.get(photoAccessHelper.PhotoKeys.PHOTO_TYPE);
                        let size = photoAsset?.get(photoAccessHelper.PhotoKeys.SIZE);
                        let date = photoAsset?.get(photoAccessHelper.PhotoKeys.DATE_TAKEN);
                        let with1 = photoAsset?.get(photoAccessHelper.PhotoKeys.WIDTH);
                        let height = photoAsset?.get(photoAccessHelper.PhotoKeys.HEIGHT);
                        let title = photoAsset?.get(photoAccessHelper.PhotoKeys.TITLE);
                        this.uriStr = `图片信息：\n${name}\n${type}\n${size}\n${date}\n${with1}\n${height}\n${title}`
                      } catch (err) {
                        LogUtil.error("读取图片信息失败：" + JSON.stringify(err));
                      }
                      photoAsset?.getThumbnail((err, pixelMap,) => {
                        if (err) {
                          LogUtil.error("缩略图-异常：" + JSON.stringify(err))
                          result;
                        }
                        this.pixelMap = pixelMap;
                      })
                    } else {
                      ToastUtil.showToast("请选择图片")
                    }
                  }).catch((err: BusinessError) => {
                    this.uriStr = `异常：\n${JSON.stringify(err)}`
                  })
                } else {
                  ToastUtil.showLong("请在设置中打开权限")
                  PermissionUtil.toAppSetting()
                }
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