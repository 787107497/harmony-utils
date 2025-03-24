import { webview } from '@kit.ArkWeb';
import { DialogAction, DialogHelper } from '@pura/harmony-dialog';
import { CacheUtil, DateUtil, FileUtil, LogUtil, NotificationUtil, ObjectUtil } from '@pura/harmony-utils';
import { Utils } from '../utils/Utils';
import { ArkJsObject } from './ArkJsObject';
import { ArkWebClient } from './ArkWebClient';
import { ArkWebOptions } from './ArkWebOptions';
import { BaseArkWebClient } from './BaseArkWebClient';


@ComponentV2
export struct ArkWeb {

  @Require @Param controller: webview.WebviewController;
  @Require @Param src: ResourceStr;
  @Param options: ArkWebOptions = new ArkWebOptions();
  @Param webClient: ArkWebClient = new BaseArkWebClient();
  @Param arkJsObject: ArkJsObject | ArkJsObject[] = new ArkJsObject();
  @Local arkJsObjects: ArkJsObject[] = []; //需要注册的接口对象
  // @Param renderMode?: RenderMode;
  // @Param incognitoMode?: boolean;
  // @Param sharedRenderProcessToken?: string;

  private beginTime: number = 0; //页面开始加载时间戳
  private downloadDelegate: webview.WebDownloadDelegate = new webview.WebDownloadDelegate(); //下载任务的状态会通过该类的回调接口通知给用户。



  aboutToAppear(): void {
    if (Array.isArray(this.arkJsObject)) {
      if (this.arkJsObject.length > 0) {
        this.arkJsObjects = this.arkJsObject;
      }
    } else {
      this.arkJsObjects = [this.arkJsObject];
    }
  }

  build() {
    Column() {
      Web({ src: this.src, controller: this.controller })
        .width('100%')
        .height('100%')
        .domStorageAccess(this.options.domStorageAccess)
        .javaScriptAccess(this.options.javaScriptAccess)
        .fileAccess(this.options.fileAccess)
        .imageAccess(this.options.imageAccess)
        .onlineImageAccess(this.options.onlineImageAccess)
        .overScrollMode(this.options.overScrollMode)
        .mixedMode(this.options.mixedMode)
        .zoomAccess(this.options.zoomAccess)
        .overviewModeAccess(this.options.overviewModeAccess)
        .databaseAccess(this.options.databaseAccess)
        .geolocationAccess(this.options.geolocationAccess)
        .mediaPlayGestureAccess(this.options.mediaPlayGestureAccess)
        .multiWindowAccess(this.options.multiWindowAccess)
        .horizontalScrollBarAccess(this.options.horizontalScrollBarAccess)
        .verticalScrollBarAccess(this.options.verticalScrollBarAccess)
        .cacheMode(this.options.cacheMode)
        .copyOptions(this.options.copyOptions)
        .textZoomRatio(this.options.textZoomRatio)
        .initialScale(this.options.initialScale)
        .blockNetwork(this.options.blockNetwork)
        .defaultFixedFontSize(this.options.defaultFixedFontSize)
        .defaultFontSize(this.options.defaultFontSize)
        .minFontSize(this.options.minFontSize)
        .minLogicalFontSize(this.options.minLogicalFontSize)
        .webFixedFont(this.options.webFixedFont)
        .webSansSerifFont(this.options.webSansSerifFont)
        .webSerifFont(this.options.webSerifFont)
        .webStandardFont(this.options.webStandardFont)
        .webFantasyFont(this.options.webFantasyFont)
        .webCursiveFont(this.options.webCursiveFont)
        .darkMode(this.options.darkMode)
        .forceDarkAccess(this.options.forceDarkAccess)
        .pinchSmooth(this.options.pinchSmooth)
        .allowWindowOpenMethod(this.options.allowWindowOpenMethod)
        .mediaOptions(this.options.mediaOptions)
        .javaScriptOnDocumentStart(this.options.javaScriptOnDocumentStart)
        .javaScriptOnDocumentEnd(this.options.javaScriptOnDocumentEnd)
        .layoutMode(this.options.layoutMode)
        .nestedScroll(this.options.nestedScroll)
        .enableNativeEmbedMode(this.options.enableNativeEmbedMode)
        .defaultTextEncodingFormat(this.options.defaultTextEncodingFormat)
        .metaViewport(this.options.metaViewport)
        .textAutosizing(this.options.textAutosizing)
        .enableNativeMediaPlayer(this.options.enableNativeMediaPlayer)
        .selectionMenuOptions(this.options.selectionMenuOptions)
        .keyboardAvoidMode(this.options.keyboardAvoidMode)
        .onControllerAttached(() => {
          this.webClient.setWebviewController?.(this.controller);
          this.initDownloadDelegate();
          this.arkJsObjects.forEach((jsObject) => {
            jsObject?.setWebviewController(this.controller)
            this.controller.registerJavaScriptProxy(jsObject, jsObject.getName(), ObjectUtil.getMethodsNames(jsObject));
          })
          this.webClient.onControllerAttached?.();
          LogUtil.info(`onControllerAttached => 事件回调`);
        })
        .onPageBegin((event) => {
          this.webClient.onPageBegin?.(event);
          this.beginTime = DateUtil.getTodayTime();
          LogUtil.info(`onPageBegin => ${event.url}`);
        })
        .onPageEnd((event) => {
          this.webClient.onPageEnd?.(event);
          LogUtil.info(`onPageEnd => 耗时：${DateUtil.getTodayTime() - this.beginTime}，${event.url}`);
        })
        .onProgressChange((event) => {
          this.webClient.onProgressChange?.(event);
          LogUtil.info(`onProgressChange => ${event.newProgress}`);
        })
        .onPageVisible((event) => {
          this.webClient.onPageVisible?.(event);
          LogUtil.info(`onPageVisible => ${event.url}`);
        })
        .onLoadIntercept((event) => {
          LogUtil.info(`onLoadIntercept => 事件回调`);
          return this.webClient.onLoadIntercept?.(event) ?? false;
        })
        .onOverrideUrlLoading((request) => {
          LogUtil.info(`onOverrideUrlLoading => 事件回调`);
          if (request && request.getRequestUrl() == "about:blank") {
            return true; //不加载空白页
          }
          return this.webClient.onOverrideUrlLoading?.(request) ?? false;
        })
        .onInterceptRequest((event) => {
          LogUtil.info(`onInterceptRequest => 事件回调`);
          return this.webClient?.onInterceptRequest?.(event) ?? null;
        })
        .onTitleReceive((event) => {
          this.webClient.onTitleReceive?.(event);
          LogUtil.info(`onTitleReceive => ${event.title}`);
        })
        .onErrorReceive((event) => {
          this.webClient.onErrorReceive?.(event);
          LogUtil.info(`onErrorReceive => errorCode：${event.error.getErrorCode()} - errorMsg：${event.error.getErrorInfo()}`);
        })
        .onHttpErrorReceive((event) => {
          this.webClient.onHttpErrorReceive?.(event);
          LogUtil.info(`onHttpErrorReceive => responseCode：${event.response.getResponseCode()}`);
        })
        .onSslErrorEventReceive((event) => {
          this.webClient.onSslErrorEventReceive?.(event);
          LogUtil.info(`onSslErrorEventReceive => 事件回调`);
        })
        .onSslErrorEvent((event) => {
          this.webClient.onSslErrorEvent?.(event);
          LogUtil.info(`onSslErrorEvent => isMainFrame：${event.isMainFrame}`);
        })
        .onHttpAuthRequest((event) => {
          LogUtil.info(`onHttpAuthRequest => 事件回调`);
          return this.webClient?.onHttpAuthRequest?.(event) ?? true;
        })
        .onClientAuthenticationRequest((event) => {
          this.webClient.onClientAuthenticationRequest?.(event);
          LogUtil.info(`onClientAuthenticationRequest => 事件回调`);
        })
        .onRenderExited((event) => {
          this.webClient.onRenderExited?.(event);
          LogUtil.info(`onRenderExited => 事件回调`);
        })
        .onDownloadStart((event) => {
          if (this.webClient.onDownloadStart) {
            this.webClient.onDownloadStart(event);
          }
          LogUtil.info(`onDownloadStart => 事件回调`);
        })
        .onShowFileSelector((event) => {
          LogUtil.info(`onShowFileSelector => 事件回调`);
          if (this.webClient.onShowFileSelector) {
            return this.webClient.onShowFileSelector(event);
          }
          return false;
        })
        .onPermissionRequest((event) => {
          if (this.webClient.onPermissionRequest) {
            this.webClient.onPermissionRequest(event);
          }
          LogUtil.info(`onPermissionRequest => 事件回调`);
        })
        .onGeolocationShow((event) => {
          if (this.webClient.onGeolocationShow) {
            this.webClient.onGeolocationShow(event);
          }
          LogUtil.info(`onGeolocationShow => 事件回调`);
        })
        .onGeolocationHide(() => {
          if (this.webClient.onGeolocationHide) {
            this.webClient.onGeolocationHide();
          }
          LogUtil.info(`onGeolocationHide => 事件回调`);
        })
        .onFullScreenEnter((event) => {
          if (this.webClient.onFullScreenEnter) {
            this.webClient.onFullScreenEnter(event);
          }
          LogUtil.info(`onFullScreenEnter => 事件回调`);
        })
        .onFullScreenExit(() => {
          if (this.webClient.onFullScreenExit) {
            this.webClient.onFullScreenExit();
          }
          LogUtil.info(`onFullScreenExit => 事件回调`);
        })
        .onContextMenuShow((event) => {
          LogUtil.info(`onContextMenuShow => 事件回调`);
          if (this.webClient.onContextMenuShow) {
            return this.webClient.onContextMenuShow(event);
          }
          return false;
        })
        .onContextMenuHide(() => {
          if (this.webClient.onContextMenuHide) {
            this.webClient.onContextMenuHide();
          }
          LogUtil.info(`onContextMenuHide => 事件回调`);
        })
        .onScaleChange((event) => {
          this.webClient.onScaleChange?.(event);
          LogUtil.info(`onScaleChange => changed from ${event.oldScale} to ${event.newScale}`);
        })
        .onScroll((event) => {
          this.webClient.onScroll?.(event);
          LogUtil.info(`onScroll => x=${event.xOffset}，y=${event.yOffset}`);
        })
        .onOverScroll((event) => {
          this.webClient.onOverScroll?.(event);
          LogUtil.info(`onOverScroll => x=${event.xOffset}，y=${event.yOffset}`);
        })
        .onRequestSelected(() => {
          this.webClient.onRequestSelected?.();
          LogUtil.info(`onRequestSelected => 事件回调`);
        })
        .onScreenCaptureRequest((event) => {
          this.webClient.onScreenCaptureRequest?.(event);
          LogUtil.info(`onScreenCaptureRequest => ${event.handler.getOrigin()}`);
        })
        .onWindowNew((event) => {
          this.webClient.onWindowNew?.(event);
          LogUtil.info(`onWindowNew => 事件回调`);
        })
        .onWindowExit(() => {
          this.webClient.onWindowExit?.();
          LogUtil.info(`onWindowExit => 事件回调`);
        })
        .onResourceLoad((event) => {
          this.webClient.onResourceLoad?.(event);
          LogUtil.info(`onResourceLoad => ${event.url}`);
        })
        .onRefreshAccessedHistory((event) => {
          this.webClient.onRefreshAccessedHistory?.(event);
          LogUtil.info(`onRefreshAccessedHistory => 事件回调`);
        })
        .onBeforeUnload((event) => {
          LogUtil.info(`onBeforeUnload => ${event.url}`);
          return this.webClient.onBeforeUnload?.(event) ?? false;
        })
        .onRenderProcessNotResponding((event) => {
          this.webClient.onRenderProcessNotResponding?.(event);
          LogUtil.info(`onRenderProcessNotResponding => 事件回调`);
        })
        .onRenderProcessResponding(() => {
          this.webClient.onRenderProcessResponding?.();
          LogUtil.info(`onRenderProcessResponding => 事件回调`);
        })
        .onSearchResultReceive((event) => {
          this.webClient.onSearchResultReceive?.(event);
          LogUtil.info(`onSearchResultReceive => 事件回调`);
        })
        .onDataResubmitted((event) => {
          this.webClient.onDataResubmitted?.(event);
          LogUtil.info(`onDataResubmitted => 事件回调`);
        })
        .onInterceptKeyEvent((event) => {
          LogUtil.info(`onInterceptKeyEvent => keyCode=${event.keyCode}`);
          return this.webClient.onInterceptKeyEvent?.(event) ?? false;
        })
        .onTouchIconUrlReceived((event) => {
          this.webClient.onTouchIconUrlReceived?.(event);
          LogUtil.info(`onTouchIconUrlReceived => 事件回调`);
        })
        .onFaviconReceived((event) => {
          this.webClient.onFaviconReceived?.(event);
          LogUtil.info(`onFaviconReceived => 事件回调`);
        })
        .onAudioStateChanged((event) => {
          this.webClient.onAudioStateChanged?.(event);
          LogUtil.info(`onAudioStateChanged => 事件回调`);
        })
        .onFirstContentfulPaint((event) => {
          this.webClient.onFirstContentfulPaint?.(event);
          LogUtil.info(`onFirstContentfulPaint => 事件回调`);
        })
        .onFirstMeaningfulPaint((paint) => {
          this.webClient.onFirstMeaningfulPaint?.(paint);
          LogUtil.info(`onFirstMeaningfulPaint => 事件回调`);
        })
        .onLargestContentfulPaint((paint) => {
          this.webClient.onLargestContentfulPaint?.(paint);
          LogUtil.info(`onLargestContentfulPaint => 事件回调`);
        })
        .onNavigationEntryCommitted((details) => {
          this.webClient.onNavigationEntryCommitted?.(details);
          LogUtil.info(`onNavigationEntryCommitted => 事件回调`);
        })
        .onNativeEmbedLifecycleChange((event) => {
          this.webClient.onNativeEmbedLifecycleChange?.(event);
          LogUtil.info(`onNativeEmbedLifecycleChange => 事件回调`);
        })
        .onNativeEmbedGestureEvent((event) => {
          this.webClient.onNativeEmbedGestureEvent?.(event);
          LogUtil.info(`onNativeEmbedGestureEvent => 事件回调`);
        })
        .onNativeEmbedVisibilityChange((info) => {
          this.webClient.onNativeEmbedVisibilityChange?.(info);
          LogUtil.info(`onNativeEmbedVisibilityChange => 事件回调`);
        })
        .onSafeBrowsingCheckResult((threatType) => {
          this.webClient.onSafeBrowsingCheckResult?.(threatType);
          LogUtil.info(`onSafeBrowsingCheckResult => 事件回调`);
        })
        .onIntelligentTrackingPreventionResult((details) => {
          this.webClient.onIntelligentTrackingPreventionResult?.(details);
          LogUtil.info(`onNativeEmbedVisibilityChange => 事件回调`);
        })
        .onViewportFitChanged((viewportFit) => {
          this.webClient.onViewportFitChanged?.(viewportFit);
          LogUtil.info(`onViewportFitChanged => 事件回调`);
        })
        .onInterceptKeyboardAttach((keyboardCallbackInfo) => {
          LogUtil.info(`onInterceptKeyboardAttach => 事件回调`);
          const option: WebKeyboardOptions = { useSystemKeyboard: true }; //option初始化，默认使用系统默认键盘
          return this.webClient.onInterceptKeyboardAttach?.(keyboardCallbackInfo) ?? option;
        })
        .onAdsBlocked((details) => {
          if (this.webClient.onAdsBlocked) {
            this.webClient.onAdsBlocked(details);
          }
          LogUtil.info(`onAdsBlocked => 事件回调`);
        })
        .onAlert((event) => {
          LogUtil.info(`onAlert => ${event.url}`);
          if (this.webClient.onAlert) {
            return this.webClient.onAlert(event);
          } else {
            DialogHelper.showAlertDialog({
              secondaryButton: "确定",
              backCancel: false,
              autoCancel: false,
              cornerRadius: 16,
              content: event.message,
              onAction: () => {
                event.result.handleConfirm();
              }
            })
            return true;
          }
        })
        .onConfirm((event) => {
          LogUtil.info(`onConfirm => ${event.url}`);
          if (this.webClient.onConfirm) {
            return this.webClient.onConfirm(event);
          } else {
            DialogHelper.showAlertDialog({
              primaryButton: "取消",
              secondaryButton: "确定",
              backCancel: false,
              autoCancel: false,
              cornerRadius: 16,
              content: event.message,
              onAction: (action) => {
                if (action == DialogAction.ONE) {
                  event.result.handleCancel();
                } else {
                  event.result.handleConfirm();
                }
              }
            })
            return true;
          }
        })
        .onPrompt((event) => {
          LogUtil.info(`onPrompt => ${event.url} - ${event.value}`);
          if (this.webClient.onPrompt) {
            return this.webClient.onPrompt(event);
          } else {
            DialogHelper.showTextInputDialog({
              buttons: ["取消", "确定"],
              backCancel: false,
              autoCancel: false,
              cornerRadius: 16,
              secondaryTitle: event.message,
              text: event.value,
              onAction: (action, dialogId, content) => {
                if (action == DialogAction.ONE) {
                  event.result.handleCancel();
                } else {
                  event.result.handlePromptConfirm(content);
                }
              }
            })
            return true;
          }
        })
        .onConsole((event) => {
          LogUtil.info(`onConsole => 事件回调`);
          return this.webClient.onConsole?.(event) ?? false;
        })
    }
    .width('100%')
    .height('100%')
  }


  /**
   * 初始化WebDownloadDelegate，下载任务的状态会通过该类的回调接口通知给用户。
   */
  private initDownloadDelegate() {
    Utils.setDownloadPath(this.options.downloadPath ?? FileUtil.getCacheDirPath()); //ArkWeb文件下载路径
    //下载开始前通知给用户，用户需要在此接口中调用WebDownloadItem.start("xxx")并提供下载路径，否则下载会一直处于PENDING状态。
    this.downloadDelegate.onBeforeDownload(async (item: webview.WebDownloadItem) => {
      CacheUtil.put<number>(item.getGuid(), NotificationUtil.generateNotificationId()); //缓存通知id
      const fileName = item.getSuggestedFileName();
      let savePath = `${Utils.getArkDownloadPath()}/${fileName}`; //下载文件路径
      try {
        item.start(savePath);
      } catch (error) {
        LogUtil.error(`下载文件 ${fileName} 时出错: `, error);
      }
    });
    //下载过程中的回调，通过该回调的参数可以了解下载进度等信息。
    this.downloadDelegate.onDownloadUpdated((item: webview.WebDownloadItem) => {
      const notificationKey = item.getGuid();
      const fileName = item.getSuggestedFileName();
      const percent = item.getPercentComplete();
      Utils.sendNotification(notificationKey, fileName, percent, 0);
    });
    //下载完成的通知。
    this.downloadDelegate.onDownloadFinish((item: webview.WebDownloadItem) => {
      const notificationKey = item.getGuid();
      const fileName = item.getSuggestedFileName();
      Utils.sendNotification(notificationKey, fileName, 100, 1);
    });
    //下载失败的通知。
    this.downloadDelegate.onDownloadFailed((item: webview.WebDownloadItem) => {
      const notificationKey = item.getGuid();
      const fileName = item.getSuggestedFileName();
      Utils.sendNotification(notificationKey, fileName, 0, -1);
    });
    this.controller?.setDownloadDelegate(this.downloadDelegate);
  }





}
