import { ImageUtil, LogUtil } from '@pura/harmony-utils';
import { ArkWebClient } from '@pura/harmony-web';
import { webview } from '@kit.ArkWeb';
import { Utils } from './Utils';
import { DialogHelper } from '@pura/harmony-dialog';
import { cameraPicker } from '@kit.CameraKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { CameraOptions, PickerUtil } from '@pura/picker_utils';


/**
 * Web事件 */
export class MyWebClient implements ArkWebClient {
  controller?: webview.WebviewController;

  private onPageBeginCallback?: Callback<OnPageBeginEvent>;

  setOnPageBegin(onPageBeginCallback: Callback<OnPageBeginEvent>) {
    this.onPageBeginCallback = onPageBeginCallback;
  }


  setWebviewController(controller: webview.WebviewController): void {
    this.controller = controller;
  }

  onControllerAttached(): void {
    //重新定义UserAgent，在原来的UserAgent的上拼接“Linux”，这样就能调用原来Android的JS方法
    this.controller?.setCustomUserAgent(`${this.controller?.getUserAgent()},Linux`)
  }

  onPageBegin(event: OnPageBeginEvent): void {
    this.onPageBeginCallback?.(event);
    LogUtil.info(`onPageBegin => ` + event.url);
  }


  //文件选择
  onShowFileSelector(event: OnShowFileSelectorEvent): boolean {
    const isCapture = event.fileSelector.isCapture(); //是否拍照/拍视频
    if (isCapture) { //拍照/拍视频
      PickerUtil.cameraEasy().then((result) => {
        event.result.handleFileList([result]);
      });
    } else {
      const types = event.fileSelector.getAcceptType() ?? [];
      const mode = event.fileSelector.getMode();
      const isPhoto = Utils.isPhoto(types);
      const isVideo = Utils.isVideo(types);
      if (isPhoto || isVideo) { //图片、视频
        let sheets = isPhoto ? ["拍照", "选择照片"] : ["拍视频", "选择视频"];
        DialogHelper.showActionSheetDialog({
          title: "请选择",
          sheets: sheets,
          onAction: (action) => {
            if (action === 0) {
              let options = new CameraOptions();
              options.mediaTypes = isPhoto ? [cameraPicker.PickerMediaType.PHOTO] : [cameraPicker.PickerMediaType.VIDEO];
              PickerUtil.cameraEasy(options).then((result) => {
                if (isPhoto) { //对拍照的图片进行压缩，压缩到3M以内
                  ImageUtil.compressPhoto(result, 1024 * 3).then((path) => {
                    event.result.handleFileList([path]);
                  }).catch((err: BusinessError) => {
                    event.result.handleFileList([result]); //图片压缩异常时，使用原图。
                    LogUtil.error(`拍照图片压缩异常：${err.code} - ${err.message}`);
                  });
                } else {
                  event.result.handleFileList([result]);
                }
              });
            } else {
              PickerUtil.selectDocument({
                maxSelectNumber: mode === FileSelectorMode.FileOpenMode ? 1 : 9,
                fileSuffixFilters: types
              }).then((result) => {
                event.result.handleFileList(result);
              })
            }
          }
        })
      } else { //文档
        PickerUtil.selectDocument({
          maxSelectNumber: mode === FileSelectorMode.FileOpenMode ? 1 : 9,
          fileSuffixFilters: types
        }).then((result) => {
          event.result.handleFileList(result);
        })
      }
    }
    return true;
  }


}