import { ComposeTitleBar, router } from '@kit.ArkUI';
import {
  AppUtil,
  DateUtil,
  FileUtil,
  ImageUtil,
  LogUtil,
  PermissionUtil,
  PhotoHelper,
  PickerUtil,
  StrUtil,
  ToastUtil
} from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { Permissions } from '@kit.AbilityKit';
import { image } from '@kit.ImageKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';


/**
 * 相册选择和保存,工具类
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
    this.filePath = await ImageUtil.savePixelMap(pixelMap, FileUtil.getFilesDirPath(""), "漂亮小姐姐.png")
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
          Button("select()")
            .btnStyle()
            .onClick(() => {
              let ps: Permissions[] = ['ohos.permission.READ_IMAGEVIDEO'];
              PermissionUtil.requestPermissionsList(ps).then((result) => {
                if (result) {
                  PhotoHelper.select().then((uris) => {
                    this.uriStr = `调用相册，返回uris：\n${uris.join('\n')}`
                  }).catch((err: BusinessError) => {
                    this.uriStr = `调用相册，异常：\n${JSON.stringify(err)}`
                  })
                } else {
                  ToastUtil.showLong("请在设置中打开权限")
                  AppUtil.toAppSetting()
                }
              })
            })

          Button("save()")
            .btnStyle()
            .onClick(() => {
              let ps: Permissions[] = ['ohos.permission.WRITE_IMAGEVIDEO'];
              PermissionUtil.requestPermissionsList(ps).then((result) => {
                if (result) {
                  let imgName = `漂亮小姐姐_${DateUtil.getTodayTime()}`;
                  PhotoHelper.save(photoAccessHelper.PhotoType.IMAGE, 'jpg', { title: imgName }).then(async (uri) => {
                    if (uri) {
                      this.uriStr = `调用1保存图片，返回uris：\n${uri}`
                      let file = FileUtil.openSync(uri);
                      FileUtil.copyFile(this.filePath, file.fd).then(() => {
                        FileUtil.close(file.fd);
                        ToastUtil.showToast("图片保存成功");
                      })
                    }
                  }).catch((err: BusinessError) => {
                    this.uriStr = `调用保存图片，异常：\n${JSON.stringify(err)}`
                  })
                } else {
                  ToastUtil.showLong("请在设置中打开权限")
                  AppUtil.toAppSetting()
                }
              })
            })

          Button("save()")
            .btnStyle()
            .onClick(() => {
              let ps: Permissions[] = ['ohos.permission.WRITE_IMAGEVIDEO'];
              PermissionUtil.requestPermissionsList(ps).then((result) => {
                if (result) {
                  let imgName = `漂亮小姐姐_${DateUtil.getTodayTime()}`;
                  PhotoHelper.save(photoAccessHelper.PhotoType.IMAGE, 'png', { title: imgName }).then(async (uri) => {
                    if (uri) {
                      this.uriStr = `调用2保存图片，返回uris：\n${uri}`
                      let file = FileUtil.openSync(uri);
                      let pixelMap = await ImageUtil.getPixelMapFromMedia($r('app.media.as3'))
                      let packOpts: image.PackingOption = { format: 'image/png', quality: 100 }
                      ImageUtil.packToFileFromPixelMap(pixelMap, file.fd, packOpts).then(() => {
                        FileUtil.close(file.fd);
                        ToastUtil.showToast("图片保存成功");
                      })
                    }
                  }).catch((err: BusinessError) => {
                    this.uriStr = `调用保存图片，异常：\n${JSON.stringify(err)}`
                  })
                } else {
                  ToastUtil.showLong("请在设置中打开权限")
                  AppUtil.toAppSetting()
                }
              })
            })

          Button("getPhotoAsset()")
            .btnStyle()
            .onClick(() => {
              let ps: Permissions[] = ['ohos.permission.READ_IMAGEVIDEO'];
              PermissionUtil.requestPermissionsList(ps).then((result) => {
                if (result) {
                  PickerUtil.selectPhoto().then(async (uris) => {
                    if (uris && uris.length > 0) {
                      let photoAsset = await PhotoHelper.getPhotoAsset(uris[0]);
                      try {
                        let name = photoAsset?.get(photoAccessHelper.PhotoKeys.DISPLAY_NAME);
                        let type = photoAsset?.get(photoAccessHelper.PhotoKeys.PHOTO_TYPE);
                        let title = photoAsset?.get(photoAccessHelper.PhotoKeys.TITLE.toString());
                        let size = photoAsset?.get(photoAccessHelper.PhotoKeys.SIZE.toString());
                        let with1 = photoAsset?.get(photoAccessHelper.PhotoKeys.WIDTH.toString());
                        let height = photoAsset?.get(photoAccessHelper.PhotoKeys.HEIGHT.toString());
                        let date = photoAsset?.get(photoAccessHelper.PhotoKeys.DATE_TAKEN.toString());
                        let orientation = photoAsset?.get(photoAccessHelper.PhotoKeys.ORIENTATION.toString());
                        this.uriStr = `图片信息：\n文件名：${name}\n文件类型：${type}\n文件大小：${size}\n图片宽度：${with1}\n图片高度：${height}\n拍摄日期：${date}\n文件标题：${title}\n图片文件的方向：${orientation}`
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
                  AppUtil.toAppSetting()
                }
              })
            })
          Text(this.uriStr)
            .visibility(StrUtil.isNotEmpty(this.uriStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Image(this.pixelMap)
            .objectFit(ImageFit.Fill)
            .autoResize(true)
            .textStyle()

          Blank().layoutWeight(1)
        }
        .margin({ top: 5, bottom: 5 })
        .width('100%')
      }
      .width('100%')
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