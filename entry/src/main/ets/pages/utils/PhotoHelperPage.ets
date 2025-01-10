import { router } from '@kit.ArkUI';
import {
  DateUtil,
  FileUtil,
  ImageUtil,
  LogUtil,
  PermissionUtil,
  PhotoHelper,
  PickerUtil,
  StrUtil,
  ToastUtil,
  WantUtil
} from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { Permissions } from '@kit.AbilityKit';
import { image } from '@kit.ImageKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';
import { DialogHelper } from '@pura/harmony-dialog';


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
  @State filePath2: string = ''; //本地图片path
  private saveButtonOptions: SaveButtonOptions = { icon: SaveIconStyle.FULL_FILLED, text: SaveDescription.SAVE_IMAGE, buttonType: ButtonType.Capsule } //设置安全控件按钮属性

  @MockSetup
  mock() {
    this.describe = new DescribeBean("PhotoHelper", "相册选择和保存,工具类");
  }

  async aboutToAppear(): Promise<void> {
    let pixelMap = await ImageUtil.getPixelMapFromMedia($r("app.media.test_as4"));
    this.filePath = await ImageUtil.savePixelMap(pixelMap, FileUtil.getFilesDirPath(""), "漂亮小姐姐.png");
    LogUtil.error("filePath: " + this.filePath);
    let pixelMap2 = await ImageUtil.getPixelMapFromMedia($r("app.media.test_as2"));
    this.filePath2 = await ImageUtil.savePixelMap(pixelMap2, FileUtil.getFilesDirPath(""), "为梦想窒息.png");
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
          Button("select()-默认使用")
            .btnStyle()
            .onClick(() => this.selectDefault())
          Button("select()-多选")
            .btnStyle()
            .onClick(() => this.selectMore())
          Button("select()-单选")
            .btnStyle()
            .onClick(() => this.selectSingle())
          Button("save()")
            .btnStyle()
            .onClick(() => this.save())
          Button("showAssetsCreationDialogEasy()")
            .btnStyle()
            .onClick(() => this.showAssetsCreationDialog())
          SaveButton(this.saveButtonOptions)
            .onClick(() => this.saveButton())
          Button("getPhotoAsset()")
            .btnStyle()
            .onClick(() => this.getPhotoAsset())

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


  //相册选择图片/视频
  selectDefault(){
    PhotoHelper.select().then((uris) => {
      this.uriStr = `调用相册，返回uris：\n${uris.join('\n')}`;
    }).catch((err: BusinessError) => {
      this.uriStr = `调用相册，异常：\n${JSON.stringify(err)}`;
    });
  }

  //相册选择图片/视频（多选）
  selectMore(){
    let options: photoAccessHelper.PhotoSelectOptions = {
      MIMEType: photoAccessHelper.PhotoViewMIMETypes.IMAGE_VIDEO_TYPE,
      maxSelectNumber: 12,
      isPhotoTakingSupported: false,
      isSearchSupported: false,
      isEditSupported: false,
      isOriginalSupported: true
    }
    PhotoHelper.select(options).then((uris) => {
      this.uriStr = `调用相册，返回uris：\n${uris.join('\n')}`;
    }).catch((err: BusinessError) => {
      this.uriStr = `调用相册，异常：\n${JSON.stringify(err)}`;
    });
  }

  //相册选择图片/视频（单选）
  selectSingle(){
    let options: photoAccessHelper.PhotoSelectOptions = {
      MIMEType: photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE,
      maxSelectNumber: 1,
      isOriginalSupported: true,
      isPreviewForSingleSelectionSupported: true //单选模式下是否需要进大图预览
    }
    PhotoHelper.select(options).then((uris) => {
      this.uriStr = `调用相册，返回uris：\n${uris.join('\n')}`;
    }).catch((err: BusinessError) => {
      this.uriStr = `调用相册，异常：\n${JSON.stringify(err)}`;
    });
  }


  //图片保存进相册（已申请权限使用该方法）
  save(){
    let ps: Permissions[] = ['ohos.permission.WRITE_IMAGEVIDEO'];
    PermissionUtil.requestPermissions(ps).then((result) => {
      if (result) {
        let imgName = `漂亮小姐姐_${DateUtil.getTodayTime()}`;
        PhotoHelper.save(photoAccessHelper.PhotoType.IMAGE, 'jpg', { title: imgName }).then(async (uri) => {
          if (uri) {
            this.uriStr = `保存图片成功，返回uris：\n${uri}`
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
        WantUtil.toAppSetting()
      }
    })
  }


  //弹窗授权保存，图片保存进相册。
  showAssetsCreationDialog(){
    let uri = FileUtil.getUriFromPath(this.filePath);
    let uri2 = FileUtil.getUriFromPath(this.filePath2);
    PhotoHelper.showAssetsCreationDialogEasy([uri, uri2]).then((result) => {
      this.uriStr = `图片保存成功，返回uris：\n${JSON.stringify(result, null, 2)}`;
      DialogHelper.showToast("图片保存成功！")
    }).catch((error: BusinessError) => {
      this.uriStr = `保存图片失败 ~ code: ${error.code} -·- message: ${error.message}`;
      DialogHelper.showToast("图片保存失败！")
    })
  }


  //安全控件保存，图片保存进相册。。
  saveButton() {
    let uri = FileUtil.getUriFromPath(this.filePath);
    PhotoHelper.applyChanges(uri).then((result) => {
      this.uriStr = `保存图片成功：${result.uri}`;
    }).catch((err: BusinessError) => {
      this.uriStr = `保存图片失败：${JSON.stringify(err)}`;
    })
  }


  //读取图片/视频的信息
  getPhotoAsset(){
    PickerUtil.selectPhoto().then(async (uris) => {
      if (uris && uris.length > 0) {
        PhotoHelper.getPhotoAsset(uris[0]).then((photoAsset) => {
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
          photoAsset?.getThumbnail((err, pixelMap) => {
            if (err) {
              LogUtil.error("缩略图-异常：" + JSON.stringify(err));
            }
            this.pixelMap = pixelMap;
          })
        }).catch((err: BusinessError) => {
          this.uriStr = `读取图片异常：\n${JSON.stringify(err)}`
        });
      } else {
        ToastUtil.showToast("请选择图片")
      }
    }).catch((err: BusinessError) => {
      this.uriStr = `异常：\n${JSON.stringify(err)}`
    })
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