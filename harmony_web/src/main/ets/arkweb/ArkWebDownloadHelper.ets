import { webview } from '@kit.ArkWeb';
import { Callback } from '@ohos.base';


/**
 * 下载任务的状态会通过该类的回调接口通知给用户。
 */
class ArkWebDownloadHelper extends webview.WebDownloadDelegate {
  private downloadPath: string = ""; //下载文件Path。

  constructor(downloadPath: string) {
    super();
    this.downloadPath = downloadPath;
  }


  /**
   * 下载开始前通知给用户，用户需要在此接口中调用WebDownloadItem.start("xxx")并提供下载路径，否则下载会一直处于PENDING状态。
   * @param callback
   */
  onBeforeDownload(downloadItem: Callback<webview.WebDownloadItem>): void {

    downloadItem(null)

  }


  /**
   * 下载过程中的回调，通过该回调的参数可以了解下载进度等信息。
   * @param callback
   */
  onDownloadUpdated(callback: Callback<webview.WebDownloadItem>): void {

  }


  /**
   * 下载完成的通知。
   * @param callback
   */
  onDownloadFinish(callback: Callback<webview.WebDownloadItem>): void {

  }


  /**
   * 下载失败的通知。
   * @param callback
   */
  onDownloadFailed(callback: Callback<webview.WebDownloadItem>): void {

  }



}