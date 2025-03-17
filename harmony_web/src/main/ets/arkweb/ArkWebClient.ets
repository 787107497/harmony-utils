import { webview } from '@kit.ArkWeb';

/**
 * ArkWeb事件分发 */
export interface ArkWebClient {


  /**
   * 设置webview.WebviewController给实现对象
   */
  setWebviewController(controller: webview.WebviewController): void;

  /**
   * 当Controller成功绑定到Web组件时触发该回调，且禁止在该事件回调前调用Web组件相关的接口，否则会抛出js-error异常。
   * 推荐在此事件中注入JS对象registerJavaScriptProxy、设置自定义用户代理setCustomUserAgent，可以在回调中使用loadUrl，getWebId等操作网页不相关的接口。
   * 但因该回调调用时网页还未加载，因此无法在回调中使用有关操作网页的接口，例如zoomIn、zoomOut等。
   */
  onControllerAttached?(): void;

  /**
   * 网页开始加载时触发该回调，且只在主frame触发，iframe或者frameset的内容加载时不会触发此回调。
   */
  onPageBegin?(event: OnPageBeginEvent): void;

  /**
   * 网页加载完成时触发该回调，且只在主frame触发。
   */
  onPageEnd?(event: OnPageEndEvent): void;

  /**
   * 网页加载进度变化时触发该回调。newProgress加载进度，取值范围为0到100的整数。
   */
  onProgressChange?(event: OnProgressChangeEvent): void;

  /**
   * Web回调事件。渲染流程中当HTTP响应的主体开始加载，新页面即将可见时触发该回调。此时文档加载还处于早期，因此链接的资源比如在线CSS、在线图片等可能尚不可用。
   */
  onPageVisible?(event: OnPageVisibleEvent): void;

  /**
   * 当Web组件加载url之前触发该回调，用于判断是否阻止此次访问。默认允许加载。
   * 返回值boolean。返回true表示阻止此次加载，否则允许此次加载。
   */
  onLoadIntercept?(event: OnLoadInterceptEvent): boolean;

  /**
   * 当URL将要加载到当前Web中时，让宿主应用程序有机会获得控制权，回调函数返回true将导致当前Web中止加载URL，而返回false则会导致Web继续照常加载URL。
   * onLoadIntercept接口和onOverrideUrlLoading接口行为不一致，触发时机也不同，所以在应用场景上存在一定区别。
   * 主要是在LoadUrl和iframe（HTML标签，表示HTML内联框架元素，用于将另一个页面嵌入到当前页面中）加载时，onLoadIntercept事件会正常回调到，
   * 但onOverrideUrlLoading事件在LoadUrl加载时不会触发，在iframe加载HTTP(s)协议或about:blank时也不会触发。
   * 详细介绍请见onLoadIntercept和onOverrideUrlLoading的说明。
   */
  onOverrideUrlLoading?(request: WebResourceRequest): boolean;

  /**
   * 当Web组件加载url之前触发该回调，用于拦截url并返回响应数据。
   * 返回值WebResourceResponse。返回响应数据则按照响应数据加载，无响应数据则返回null表示按照原来的方式加载。
   */
  onInterceptRequest?(event: OnInterceptRequestEvent): WebResourceResponse | null;

  /**
   * 网页document标题更改时触发该回调，当H5未设置<title>元素时会返回对应的URL。
   */
  onTitleReceive?(event: OnTitleReceiveEvent): void;

  /**
   * 网页加载遇到错误时触发该回调。主资源与子资源出错都会回调该接口，可以通过request.isMainFrame来判断是否是主资源报错。
   * 出于性能考虑，建议此回调中尽量执行简单逻辑。
   * 在无网络的情况下，触发此回调。
   */
  onErrorReceive?(event: OnErrorReceiveEvent): void;

  /**
   * 网页加载资源遇到的HTTP错误（响应码>=400)时触发该回调。
   */
  onHttpErrorReceive?(event: OnHttpErrorReceiveEvent): void;

  /**
   * 通知用户加载资源时发生SSL错误，只支持主资源。（如果需要支持子资源，请使用OnSslErrorEvent接口）
   */
  onSslErrorEventReceive?(event: OnSslErrorEventReceiveEvent): void;

  /**
   * 通知用户加载资源（主资源+子资源）时发生SSL错误，如果只想处理主资源的SSL错误，请用isMainFrame字段进行区分。
   */
  onSslErrorEvent?(event: SslErrorEvent): void;

  /**
   * 通知收到http auth认证请求。
   * 当浏览器需要用户的凭据时触发。返回值boolean。返回false表示此次认证失败，否则成功。
   */
  onHttpAuthRequest?(event: OnHttpAuthRequestEvent): boolean;

  /**
   * 通知用户收到SSL客户端证书请求事件。当需要用户提供的SSL客户端证书时触发的回调。
   */
  onClientAuthenticationRequest?(event: OnClientAuthenticationEvent): void;

  /**
   * 应用渲染进程异常退出时触发该回调，可以在此回调中进行系统资源的释放、数据的保存等操作。如果应用希望异常恢复，需要调用loadUrl接口重新加载页面。
   * 多个Web组件可能共享单个渲染进程，每个受影响的Web组件都会触发该回调。
   */
  onRenderExited?(event: OnRenderExitedEvent): void;

  /**
   * 通知主应用开始下载一个文件。
   */
  onDownloadStart?(event: OnDownloadStartEvent): void;

  /**
   * 调用此函数以处理具有“文件”输入类型的HTML表单。如果不调用此函数或返回false，Web组件会提供默认的“选择文件”处理界面。如果返回true，应用可以自定义“选择文件”的响应行为。
   */
  onShowFileSelector?(event: OnShowFileSelectorEvent): boolean;

  /**
   * 通知收到获取权限请求触发，需配置"ohos.permission.CAMERA"、"ohos.permission.MICROPHONE"权限。
   */
  onPermissionRequest?(event: OnPermissionRequestEvent): void;

  /**
   * 通知用户收到地理位置信息获取请求。请求显示地理位置权限时触发。
   */
  onGeolocationShow?(event: OnGeolocationShowEvent): void;

  /**
   * 通知用户先前被调用onGeolocationShow时收到地理位置信息获取请求已被取消。
   * 地理位置信息获取请求已被取消的回调函数。
   */
  onGeolocationHide?(): void;

  /**
   * 通知开发者Web组件进入全屏模式。
   */
  onFullScreenEnter?(event: FullScreenEnterEvent): void

  /**
   * 通知开发者Web组件退出全屏模式。
   */
  onFullScreenExit?(): void

  /**
   * 长按特定元素（例如图片，链接）或鼠标右键，跳出菜单。
   * 调用时触发的回调，以允许自定义显示上下文菜单。返回值boolean。自定义菜单返回true，触发的自定义菜单无效返回false。
   */
  onContextMenuShow?(event: OnContextMenuShowEvent): boolean;

  /**
   * 长按特定元素（例如图片，链接）或鼠标右键，隐藏菜单。
   */
  onContextMenuHide?(): void;

  /**
   * 当前页面显示比例的变化时触发该回调。
   */
  onScaleChange?(event: OnScaleChangeEvent): void;

  /**
   * 通知网页滚动条滚动位置。当滚动条滑动到指定位置时触发。
   */
  onScroll?(event: OnScrollEvent): void;

  /**
   * 该接口在网页过度滚动时触发，用于通知网页过度滚动的偏移量。
   */
  onOverScroll?(event: OnOverScrollEvent): void;

  /**
   * 当Web组件获得焦点时触发该回调。
   */
  onRequestSelected?(): void;

  /**
   * 通知收到屏幕捕获请求。
   */
  onScreenCaptureRequest?(event: OnScreenCaptureRequestEvent): void;

  /**
   * 使能multiWindowAccess情况下，通知用户新建窗口请求。
   * 若不调用event.handler.setWebController接口，会造成render进程阻塞。
   * 如果没有创建新窗口，调用event.handler.setWebController接口时设置成null，通知Web没有创建新窗口。
   */
  onWindowNew?(event: OnWindowNewEvent): void;

  /**
   * 通知用户窗口关闭请求。
   */
  onWindowExit?(): void;

  /**
   * 通知Web组件所加载的资源文件url信息。
   */
  onResourceLoad?(event: OnResourceLoadEvent): void;

  /**
   * 刷新或关闭场景下，在即将离开当前页面时触发此回调。刷新或关闭当前页面应先通过点击等方式获取焦点，才会触发此回调。
   * 返回值boolean。当回调返回true时，应用可以调用自定义弹窗能力（包括确认和取消），并且需要根据用户的确认或取消操作调用JsResult通知Web组件最终是否离开当前页面。当回调返回false时，函数中绘制的自定义弹窗无效。
   */
  onBeforeUnload?(event: OnBeforeUnloadEvent): boolean;

  /**
   * 加载网页页面完成时触发该回调，用于应用更新其访问的历史链接。
   */
  onRefreshAccessedHistory?(event: OnRefreshAccessedHistoryEvent): void;

  /**
   * 渲染进程无响应时触发该回调函数。
   */
  onRenderProcessNotResponding?(event: RenderProcessNotRespondingData): void;

  /**
   * 渲染进程由无响应状态变回正常运行状态时触发该回调函数,该回调表明该网页并非真正卡死。
   */
  onRenderProcessResponding?(): void;

  /**
   * 回调通知调用方网页页内查找的结果。
   */
  onSearchResultReceive?(event: OnSearchResultReceiveEvent): void;

  /**
   * 设置网页表单可以重新提交时触发的回调函数。
   */
  onDataResubmitted?(event: OnDataResubmittedEvent): void;

  /**
   * 设置键盘事件的回调函数，该回调在被Webview使用前触发。
   * 触发的KeyEvent事件。返回值：回调函数通过返回boolean类型值来决定是否继续将该KeyEvent传入Webview内核。
   */
  onInterceptKeyEvent?(event: KeyEvent): boolean;

  /**
   * 设置接收到apple-touch-icon url地址时的回调函数。
   */
  onTouchIconUrlReceived?(event: OnTouchIconUrlReceivedEvent): void;

  /**
   * 设置应用为当前页面接收到新的favicon时的回调函数。
   */
  onFaviconReceived?(event: OnFaviconReceivedEvent): void;

  /**
   * 设置网页上的音频播放状态发生改变时的回调函数。
   */
  onAudioStateChanged?(event: OnAudioStateChangedEvent): void;

  /**
   * 设置网页首次内容绘制回调函数。
   */
  onFirstContentfulPaint?(event: OnFirstContentfulPaintEvent): void;

  /**
   * 设置网页绘制页面主要内容回调函数。
   */
  onFirstMeaningfulPaint?(paint: FirstMeaningfulPaint): void;

  /**
   * 设置网页绘制页面最大内容回调函数。
   */
  onLargestContentfulPaint?(paint: LargestContentfulPaint): void;

  /**
   * 当网页跳转提交时触发该回调。
   */
  onNavigationEntryCommitted?(details: LoadCommittedDetails): void;

  /**
   * 当同层标签生命周期变化时触发该回调。
   */
  onNativeEmbedLifecycleChange?(event: NativeEmbedDataInfo): void;

  /**
   * 当手指触摸到同层标签时触发该回调
   */
  onNativeEmbedGestureEvent?(event: NativeEmbedTouchInfo): void;

  /**
   * 网页中同层标签（如Embed标签或Object标签）在视口内的可见性发生变化时会触发该回调。
   * 同层标签默认不可见，如果首次进入页面可见则会上报，不可见则不会上报，当同层标签大小由非0值变为0 *0时，不会上报不可见，由0 *0变为非0值时会上报可见。同层标签全部不可见才算不可见，部分可见或全部可见算作可见。
   */
  onNativeEmbedVisibilityChange?(info: NativeEmbedVisibilityInfo): void;

  /**
   * 收到网站安全风险检查结果时触发的回调。
   */
  onSafeBrowsingCheckResult?(threatType: ThreatType): void;

  /**
   * 智能防跟踪功能使能时，当追踪者cookie被拦截时触发该回调。
   * @param details
   */
  onIntelligentTrackingPreventionResult?(details: IntelligentTrackingPreventionDetails): void;

  /**
   * 网页meta中viewport-fit配置项更改时触发该回调，应用可在此回调中自适应布局视口。
   */
  onViewportFitChanged?(viewportFit: ViewportFit): void;

  /**
   * 网页中可编辑元素（如input标签）拉起软键盘之前会回调该接口。
   * 应用可以使用该接口拦截系统软键盘的弹出，配置应用定制的软键盘（应用根据该接口可以决定使用系统默认软键盘/定制enter键的系统软键盘/全部由应用自定义的软键盘）。
   */
  onInterceptKeyboardAttach?(keyboardCallbackInfo: WebKeyboardCallbackInfo): WebKeyboardOptions;

  /**
   * 一个页面发生广告过滤后，通过此回调接口通知过滤的详细信息。由于页面可能随时发生变化并不断产生网络请求，为了减少通知频次、降低对页面加载过程的影响，仅在页面加载完成时进行首次通知，此后发生的过滤将间隔1秒钟上报，无广告过滤则无通知。
   */
  onAdsBlocked?(details: AdsBlockedDetails): void;

  /**
   * 网页触发alert()告警弹窗时触发回调。
   * 返回值boolean。当回调返回true时，应用可以调用自定义弹窗能力（包括确认和取消），并且需要根据用户的确认或取消操作调用JsResult通知Web组件最终是否离开当前页面。当回调返回false时，函数中绘制的自定义弹窗无效。
   */
  onAlert?(event: OnAlertEvent): boolean;

  /**
   * 网页调用confirm()告警时触发此回调。
   * 返回值boolean。当回调返回true时，应用可以调用自定义弹窗能力（包括确认和取消），并且需要根据用户的确认或取消操作调用JsResult通知Web组件最终是否离开当前页面。当回调返回false时，函数中绘制的自定义弹窗无效。
   */
  onConfirm?(event: OnConfirmEvent): boolean;

  /**
   * 网页调用prompt()告警时触发此回调。
   * 返回值boolean。当回调返回true时，应用可以调用自定义弹窗能力（包括确认和取消），并且需要根据用户的确认或取消操作调用JsResult通知Web组件最终是否离开当前页面。当回调返回false时，函数中绘制的自定义弹窗无效。
   */
  onPrompt?(event: OnPromptEvent): boolean;

  /**
   * 通知宿主应用JavaScript console消息。
   * 返回值boolean。当返回true时，该条消息将不会再打印至控制台，反之仍会打印至控制台。
   */
  onConsole?(event: OnConsoleEvent): boolean;


}