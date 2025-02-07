/**
 * ArkWeb参数
 */
export class ArkWebOptions {
  /**
   * 设置是否开启文档对象模型存储接口（DOM Storage API）权限，默认开启。
   */
  domStorageAccess: boolean = true;
  /**
   * 设置是否允许执行JavaScript脚本，默认允许执行。
   */
  javaScriptAccess: boolean = true;
  /**
   * 设置是否开启应用中文件系统的访问。$rawfile(filepath/filename)中rawfile路径的文件不受该属性影响而限制访问。
   * 从API version 12开始，fileAccess默认不启用。同时，当fileAccess为false的时候，仅只读资源目录/data/storage/el1/bundle/entry/resources/resfile里面的file协议资源依然可以访问，不受fileAccess管控。
   */
  fileAccess: boolean = false;
  /**
   * 设置是否允许自动加载图片资源，默认允许。
   */
  imageAccess: boolean = true;
  /**
   * 设置是否允许从网络加载图片资源（通过HTTP和HTTPS访问的资源），默认允许访问。
   * 设置是否允许从网络加载图片资源。默认值：true。
   */
  onlineImageAccess: boolean = true;
  /**
   * 设置Web过滚动模式，默认关闭。当过滚动模式开启时，当用户在Web根页面上滑动到边缘时，Web会通过弹性动画弹回界面，根页面上的内部页面不会触发回弹。
   * 设置Web的过滚动模式为关闭或开启。默认值：OverScrollMode.NEVER。
   */
  overScrollMode: OverScrollMode = OverScrollMode.NEVER;
  /**
   * 设置是否允许加载超文本传输协议（HTTP）和超文本传输安全协议（HTTPS）混合内容，默认不允许加载HTTP和HTTPS混合内容。
   * 要设置的混合内容。默认值：MixedMode.None。
   */
  mixedMode: MixedMode = MixedMode.None
  /**
   * 设置是否支持手势进行缩放，默认允许执行缩放。
   */
  zoomAccess: boolean = true;
  /**
   * 设置是否使用概览模式加载网页，默认使用该方式。当前仅支持移动设备。
   */
  overviewModeAccess: boolean = true;
  /**
   * 设置是否开启数据库存储API权限，默认不开启。
   */
  databaseAccess: boolean = false;
  /**
   * 设置是否开启获取地理位置权限，默认开启。具体使用方式参考管理位置权限。
   */
  geolocationAccess: boolean = true;
  /**
   * 设置有声视频播放是否需要用户手动点击，静音视频播放不受该接口管控，默认需要。
   */
  mediaPlayGestureAccess: boolean = true;
  /**
   * 设置是否开启多窗口权限，默认不开启。使能多窗口权限时，需要实现onWindowNew事件，示例代码参考onWindowNew事件。
   */
  multiWindowAccess: boolean = false;
  /**
   * 设置是否显示横向滚动条，包括系统默认滚动条和用户自定义滚动条。默认显示。
   */
  horizontalScrollBarAccess: boolean = true;
  /**
   * 设置是否显示纵向滚动条，包括系统默认滚动条和用户自定义滚动条。默认显示。
   */
  verticalScrollBarAccess: boolean = true;
  /**
   * 设置缓存模式。默认值：CacheMode.Default。
   */
  cacheMode: CacheMode = CacheMode.Default;
  /**
   * 设置剪贴板复制范围选项。默认值：CopyOptions.LocalDevice。
   */
  copyOptions: CopyOptions = CopyOptions.LocalDevice;
  /**
   * 设置页面的文本缩放百分比。取值为整数，范围为(0, +∞)。默认值：100。
   */
  textZoomRatio: number = 100;
  /**
   * 设置整体页面的缩放百分比，默认为100。
   */

  initialScale: number = 100;
  /**
   * 设置Web组件是否阻止从网络加载资源。默认值：false。
   */
  blockNetwork: boolean = false;
  /**
   * 设置网页的默认等宽字体大小。单位px。输入值的范围为-2^31到2^31-1，实际渲染时超过72的值按照72进行渲染，低于1的值按照1进行渲染。默认值：13。
   */
  defaultFixedFontSize: number = 13;
  /**
   * 设置网页的默认字体大小，单位px。输入值的范围为-2^31到2^31-1，实际渲染时超过72的值按照72进行渲染，低于1的值按照1进行渲染。默认值：16。
   */
  defaultFontSize: number = 13;
  /**
   * 设置网页字体大小最小值，单位px。输入值的范围为-2^31到2^31-1，实际渲染时超过72的值按照72进行渲染，低于1的值按照1进行渲染。默认值：8。
   */
  minFontSize: number = 8;
  /**
   * 设置网页逻辑字体大小最小值，单位px。输入值的范围为-2^31到2^31-1，实际渲染时超过72的值按照72进行渲染，低于1的值按照1进行渲染。默认值：8。
   */
  minLogicalFontSize: number = 8;
  /**
   * 设置网页的fixed font字体库。默认值：monospace。
   */
  webFixedFont: string = "monospace";
  /**
   * 设置网页的sans serif font字体库。默认值：sans-serif。
   */
  webSansSerifFont: string = "sans-serif";
  /**
   * 设置网页的serif font字体库。默认值：serif。
   */
  webSerifFont: string = "serif";
  /**
   * 设置网页的standard font字体库。默认值：sans serif。
   */
  webStandardFont: string = "sans serif";
  /**
   * 设置网页的fantasy font字体库。默认值：fantasy。
   */
  webFantasyFont: string = "fantasy";
  /**
   * 设置网页的cursive font字体库。默认值：cursive。
   */
  webCursiveFont: string = "cursive";
  /**
   * 设置Web深色模式，默认关闭。当深色模式开启时，Web将启用媒体查询prefers-color-scheme中网页所定义的深色样式，若网页未定义深色样式，则保持原状。如需开启强制深色模式，建议配合forceDarkAccess使用。
   */
  darkMode: WebDarkMode = WebDarkMode.Off;
  /**
   * 设置网页是否开启强制深色模式。默认关闭。该属性仅在darkMode开启深色模式时生效。
   */
  forceDarkAccess: boolean = false;
  /**
   * 设置网页是否开启捏合流畅模式，默认不开启。
   */
  pinchSmooth: boolean = false;
  /**
   * 设置网页是否可以通过JavaScript自动打开新窗口。
   * 该属性为true时，可通过JavaScript自动打开新窗口。该属性为false时，用户行为仍可通过JavaScript自动打开新窗口，但非用户行为不能通过JavaScript自动打开新窗口。此处的用户行为是指，在用户对Web组件进行点击等操作后，同时在5秒内请求打开新窗口（window.open）的行为。
   * 该属性仅在javaScriptAccess开启时生效。
   * 该属性在multiWindowAccess开启时打开新窗口，关闭时打开本地窗口。
   * 该属性的默认值与系统属性persist.web.allowWindowOpenMethod.enabled 保持一致，如果未设置系统属性则默认值为false。
   */
  allowWindowOpenMethod: boolean = false;
  /**
   * 设置Web媒体播放的策略，其中包括：Web中的音频在重新获焦后能够自动续播的有效期、应用内多个Web实例的音频是否独占。
   */
  mediaOptions: WebMediaOptions = { resumeInterval: 0, audioExclusive: true };
  /**
   * 将JavaScript脚本注入到Web组件中，当指定页面或者文档开始加载时，该脚本将在其来源与scriptRules匹配的任何页面中执行。
   * 该脚本将在页面的任何JavaScript代码之前运行，并且DOM树此时可能尚未加载、渲染完毕。
   */
  javaScriptOnDocumentStart: Array<ScriptItem> = [];
  /**
   * 将JavaScript脚本注入到Web组件中，当指定页面或者文档加载完成时，该脚本将在其来源与scriptRules匹配的任何页面中执行。
   * 该脚本将在页面的任何JavaScript代码之后运行，并且DOM树此时已经加载、渲染完毕。
   */
  javaScriptOnDocumentEnd: Array<ScriptItem> = [];
  /**
   * 设置web布局模式，跟随系统或自适应布局。默认值：WebLayoutMode.NONE。
   */
  layoutMode: WebLayoutMode = WebLayoutMode.NONE;
  /**
   * 调用以设置嵌套滚动选项。默认scrollForward和scrollBackward模式为NestedScrollMode.SELF_FIRST。
   */
  nestedScroll: NestedScrollOptions = { scrollForward: NestedScrollMode.SELF_FIRST, scrollBackward: NestedScrollMode.SELF_FIRST };
  /**
   * 设置是否开启同层渲染功能，默认不开启。
   */
  enableNativeEmbedMode: boolean = false;
  /**
   * 设置网页的默认字符编码。默认值："UTF-8"。
   */
  defaultTextEncodingFormat: string = "UTF-8";
  /**
   * 设置meta标签的viewport属性是否可用。默认值：true。
   */
  metaViewport: boolean = true;
  /**
   * 设置使能文本自动调整大小。默认值：true。
   */
  textAutosizing: boolean = true;
  /**
   * 开启应用接管网页媒体播放功能。默认值：{enable: false, shouldOverlay: false}。
   *  enable: 是否开启该功能。
   *  shouldOverlay: 该功能开启后， 应用接管网页视频的播放器画面是否覆盖网页内容。
   */
  enableNativeMediaPlayer: NativeMediaPlayerConfig = { enable: false, shouldOverlay: false };
  /**
   * Web组件自定义菜单扩展项接口，允许用户设置扩展项的文本内容、图标、回调方法。
   * 该接口只支持选中纯文本，当选中内容包含图片及其他非文本内容时，action信息中会显示乱码。
   */
  selectionMenuOptions: Array<ExpandedMenuItemOptions> = [];
  /**
   * Web组件自定义软件键盘避让模式。默认是WebKeyboardAvoidMode.RESIZE_CONTENT避让行为。
   * 当UIContext设置的键盘避让模式为KeyboardAvoidMode.RESIZE模式时，该接口功能不生效。
   */
  keyboardAvoidMode: WebKeyboardAvoidMode = WebKeyboardAvoidMode.RESIZE_CONTENT;

}