import { router } from '@kit.ArkUI';
import { DateUtil, FileUtil, ImageUtil, LogUtil, PreferencesUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { image } from '@kit.ImageKit';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';
import { camera, cameraPicker } from '@kit.CameraKit';
import { picker } from '@kit.CoreFileKit';
import { CameraOptions, PickerUtil } from '@pura/picker_utils';


/**
 * 拍照、文件(文件、图片、视频、音频)选择和保存,工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State uriStr: string = ''
  @State filePath: string = ''; //本地图片path
  @State cacheUri: string = ''; //缓存本地Uri，上次保存的Uri。


  @MockSetup
  mock() {
    this.describe = new DescribeBean("PickerUtil", "拍照、文件(文件、图片、视频、音频)选择和保存,工具类");
  }


  async aboutToAppear(): Promise<void> {
    this.cacheUri = PreferencesUtil.getStringSync("picker_cache_uri");
    let pixelMap = await ImageUtil.getPixelMapFromMedia($r("app.media.test_as4"))
    this.filePath = await ImageUtil.savePixelMap(pixelMap, FileUtil.getFilesDirPath(""), "漂亮小姐姐.png")
    LogUtil.error("filePath: " + this.filePath);
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("cameraEasy()")
            .btnStyle()
            .onClick(async () => {
              PickerUtil.cameraEasy().then((uri) => {
                this.uriStr = `调用相机，返回uri：\n${uri}`;
              }).catch((err: BusinessError) => {
                this.uriStr = `调用相机，异常：\n${JSON.stringify(err)}`;
              });
            })
          Button("camera()")
            .btnStyle()
            .onClick(async () => {
              let options: CameraOptions = {
                mediaTypes: [cameraPicker.PickerMediaType.PHOTO],
                cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK
              }
              PickerUtil.camera(options).then((result) => {
                this.uriStr = `调用相机，返回uri：\n${result.resultUri}`;
              }).catch((err: BusinessError) => {
                this.uriStr = `调用相机，异常：\n${JSON.stringify(err)}`;
              });
            })
          Button("selectPhoto()")
            .btnStyle()
            .onClick(() => {
              PickerUtil.selectPhoto().then((uris) => {
                this.uriStr = `调用相册，返回uris：\n${uris.join('\n')}`;
              }).catch((err: BusinessError) => {
                this.uriStr = `调用相册，异常：\n${JSON.stringify(err)}`;
              });
            })
          Button("savePhoto()")
            .btnStyle()
            .onClick(() => {
              let imgName = `大漂亮_${DateUtil.getTodayTime()}.png`;
              let imgName1 = `小漂亮_${DateUtil.getTodayTime()}.png`;
              PickerUtil.savePhoto([imgName, imgName1]).then(async (uris) => {
                let uri = uris[0];
                this.uriStr = `调用保存图片，返回uris：\n${uri}`
                let file = FileUtil.openSync(uri);
                FileUtil.copyFile(this.filePath, file.fd).then(() => {
                  this.uriStr = `保存图片，返回uris：\n${uri}`
                  ToastUtil.showToast("图片1保存成功");
                })

                let file1 = FileUtil.openSync(uris[1]);
                let pixelMap1 = await ImageUtil.getPixelMapFromMedia($r("app.media.test_as3"))
                let packOpts: image.PackingOption = { format: 'image/png', quality: 100 }
                ImageUtil.packToFileFromPixelMap(pixelMap1, file1.fd, packOpts).then(() => {
                  this.uriStr = `保存图片，返回uris：\n${uris[1]}`
                  ToastUtil.showToast("图片2保存成功");
                })
              }).catch((err: BusinessError) => {
                this.uriStr = `调用保存图片，异常：\n${JSON.stringify(err)}`
              })
            })
          Button("selectDocument()")
            .btnStyle()
            .onClick(() => {
              let options: picker.DocumentSelectOptions = {
                maxSelectNumber: 9, //选择媒体文件数量的最大值,默认9。
                selectMode: picker.DocumentSelectMode.FILE, //支持选择的资源类型,默认文件
                // fileSuffixFilters: ['图片(.png, .jpg)|.png,.jpg', '文档|.txt', '视频|.mp4', '.pdf'], //选择文件的后缀类型['后缀类型描述|后缀类型']（可选） 若选择项存在多个后缀名，则每一个后缀名之间用英文逗号进行分隔（可选），后缀类型名不能超过100,选择所有文件：'所有文件(*.*)|.*';
                // defaultFilePathUri: "file://docs/storage/Users/currentUser/Download/com.harmony.utils", //指定选择的文件或者目录路径（可选）
                // authMode: true //选择是否对指定文件或目录授权，true为授权，当为true时，defaultFilePathUri为必选参数。
              }
              PickerUtil.selectDocument(options).then((uris) => {
                this.uriStr = `调用文件管理，返回uris：\n${uris.join('\n')}`
              }).catch((err: BusinessError) => {
                this.uriStr = `调用文件管理，异常：\n${JSON.stringify(err)}`
              });
            })
          Button("saveDocumentEasy()")
            .btnStyle()
            .onClick(() => {
              let fileName = `test_easy_${DateUtil.getTodayTime()}.txt`;
              PickerUtil.saveDocumentEasy([fileName]).then((paths) => {
                let path = paths[0];
                this.cacheUri = FileUtil.getUriFromPath(path);
                PreferencesUtil.put("picker_cache_uri", this.cacheUri);
                let txtStr = `“harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。\n\n`;
                FileUtil.writeEasy(path, txtStr).then(() => {
                  this.uriStr = `文件保存成功，返回uris：\n${path}`;
                  ToastUtil.showToast("文件保存成功！");
                }).catch((err: BusinessError) => {
                  this.uriStr = `文件保存，异常：\n${JSON.stringify(err)}`;
                })
              }).catch((err: BusinessError) => {
                this.uriStr = `调用保存文件，异常：\n${JSON.stringify(err)}`;
              })
            })
          Button("saveDocument()")
            .btnStyle()
            .onClick(() => {
              let fileName = `test_${DateUtil.getTodayTime()}.txt`;
              PickerUtil.saveDocument({newFileNames:[fileName]}).then((uris) => {
                let uri = uris[0];
                this.cacheUri = uri
                PreferencesUtil.put("picker_cache_uri", this.cacheUri);
                let txtStr = `“harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。\n\n`;
                FileUtil.writeEasy(uri, txtStr).then(() => {
                  this.uriStr = `文件保存成功，返回uris：\n${uri}`;
                  ToastUtil.showToast("文件保存成功！");
                }).catch((err: BusinessError) => {
                  this.uriStr = `文件保存，异常：\n${JSON.stringify(err)}`;
                })
              }).catch((err: BusinessError) => {
                this.uriStr = `调用保存文件，异常：\n${JSON.stringify(err)}`;
              })
            })
          Button("selectAudio()")
            .btnStyle()
            .onClick(() => {
              PickerUtil.selectAudio().then((uris) => {
                this.uriStr = `调用文件管理，返回uris：\n${uris.join('\n')}`;
              }).catch((err: BusinessError) => {
                this.uriStr = `调用文件管理，异常：\n${JSON.stringify(err)}`;
              });
            })
          Button("saveAudio()")
            .btnStyle()
            .onClick(() => {
              let fileName = `AudioViewPicker001.mp3`;
              PickerUtil.saveAudio([fileName]).then((uris) => {
                let uri = uris[0];
                this.uriStr = `音频文件，返回uris：\n${uri}`;
              }).catch((err: BusinessError) => {
                this.uriStr = `调用保存文件，异常：\n${JSON.stringify(err)}`;
              })
            })

          Text(this.uriStr)
            .visibility(StrUtil.isNotEmpty(this.uriStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
            .margin(12)

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
  .width('95%')
  .padding(10)
  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  .margin({ top: 5, bottom: 10 })
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}