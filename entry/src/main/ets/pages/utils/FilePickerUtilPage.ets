import { ComposeTitleBar, router } from '@kit.ArkUI';
import { FilePickerUtil, LogUtil, PermissionUtil, StrUtil, ToastUtil } from 'harmony_utils';
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

  aboutToAppear(): void {

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
            .onClick(() => {
              let p: Permissions = 'ohos.permission.CAMERA';
              PermissionUtil.checkRequestPermissions(p).then((grant) => {
                if (grant) {
                  FilePickerUtil.camera().then((uri) => {
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
                  FilePickerUtil.selectPhoto().then((uris) => {
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
                  FilePickerUtil.savePhoto().then((uris) => {
                    this.uriStr = `调用保存图片，返回uris：\n${uris.join('\n')}`
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
              FilePickerUtil.selectDocument().then((uris) => {
                this.uriStr = `调用文件管理，返回uris：\n${uris.join('\n')}`
              }).catch((err: BusinessError) => {
                this.uriStr = `调用文件管理，异常：\n${JSON.stringify(err)}`
              })
            })
          Button("saveDocument()")
            .btnStyle()
            .onClick(() => {
              FilePickerUtil.saveDocument().then((uris) => {
                this.uriStr = `调用保存文件，返回uris：\n${uris.join('\n')}`
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
                  FilePickerUtil.selectPhoto().then(async (uris) => {
                    if (uris && uris.length > 0) {
                      let photoAsset = await FilePickerUtil.getPhotoAsset(uris[0]);
                      let name = photoAsset?.get(photoAccessHelper.PhotoKeys.DISPLAY_NAME);
                      let type = photoAsset?.get(photoAccessHelper.PhotoKeys.PHOTO_TYPE);
                      let size = photoAsset?.get(photoAccessHelper.PhotoKeys.SIZE);
                      let date = photoAsset?.get(photoAccessHelper.PhotoKeys.DATE_TAKEN);
                      let with1 = photoAsset?.get(photoAccessHelper.PhotoKeys.WIDTH);
                      let height = photoAsset?.get(photoAccessHelper.PhotoKeys.HEIGHT);
                      let title = photoAsset?.get(photoAccessHelper.PhotoKeys.TITLE);
                      this.uriStr = `图片信息：\n${name}\n${type}\n${size}\n${date}\n${with1}\n${height}\n${title}`
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