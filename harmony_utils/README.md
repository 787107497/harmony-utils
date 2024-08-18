# <center>harmony-utils (API12 - Dev: 5.0.3.500)</center>

## 📚简介

[harmony-utils](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils)
一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。   

***近期发现有三方库引用harmony-utils的源码但未注明出处，还请大家在引用时注明出处，万分感谢。***

## 📚下载安装

`ohpm i @pura/harmony-utils`

OpenHarmony ohpm
环境配置等更多内容，请参考[如何安装 OpenHarmony ohpm 包](https://ohpm.openharmony.cn/#/cn/help/downloadandinstall)
<br><br>

## 📚模块介绍

| 模块                                                                | 介绍                          |
|:------------------------------------------------------------------|:----------------------------|
| AppUtil                                                           | APP相关工具类                    |
| DeviceUtil                                                        | 设备相关工具类                     |
| DisplayUtil                                                       | 屏幕相关工具类                     |
| PermissionUtil                                                    | 申请授权工具类                     |
| AuthUtil                                                          | 手机的生物认证（指纹、人脸、密码）工具类        |
| NotificationUtil                                                  | 通知工具类                       |
| PreferencesUtil                                                   | Preferences（用户首选项）工具类       |
| FileUtil                                                          | 文件操作相关工具类                   |
| PickerUtil                                                        | 拍照、文件(文件、图片、视频、音频)选择和保存,工具类 |
| PhotoHelper                                                       | 相册相关工具类                     |
| PreviewUtil                                                       | 文件预览工具类                     |
| NetworkUtil                                                       | 网络相关工具类                     |
| LocationUtil                                                      | 定位工具类(WGS-84坐标系)            |
| PasteboardUtil                                                    | 剪贴板工具类                      |
| SnapshotUtil                                                      | 组件截图和窗口截图工具类                |
| ScanUtil                                                          | 码工具类（扫码、码图生成、图片识码）          |
| ImageUtil                                                         | 图片相关工具类                     |
| KeyboardUtil                                                      | 键盘工具类                       |
| LogUtil                                                           | 日志工具类                       |
| CrashUtil                                                         | 全局异常捕获，崩溃日志收集               |
| CharUtil                                                          | 字符工具类                       |
| StrUtil                                                           | 字符串工具类                      |
| Base64Util                                                        | Base64工具类                   |
| NumberUtil                                                        | number工具类                   |
| DateUtil                                                          | 日期工具类                       |
| ArrayUtil                                                         | 数组工具类                       |
| RandomUtil                                                        | 随机工具类                       |
| ObjectUtil                                                        | 对象工具类                       |
| JSONUtil                                                          | JSON工具类                     |
| CacheUtil                                                         | 缓存工具类                       |
| ClickUtil                                                         | 节流、防抖 工具类（用于点击事件，防止按钮被重复点击） |
| AssetUtil                                                         | 关键资产存储服务工具类                 |
| DialogUtil                                                        | 弹窗工具类（AlertDialog）          |
| ToastUtil                                                         | 土司工具类（promptAction）         |
| TempUtil                                                          | 温度转换工具类，华氏度与摄氏度相互转换         |
| SM2、SM3、SM4、<br>AES、DES、RSA、MD5、SHA、ECDSA、CryptoUtil、CryptoHelper | 操作确认类弹出框                    |

<br></br>

## 📚API详解

 ```
全局初始化方法，在UIAbility的onWindowStageCreate方法中初始化 AppUtil.init()
    
onWindowStageCreate(windowStage: window.WindowStage): void {
    AppUtil.init(this.context, windowStage);  
}
 ```

### AppUtil（APP相关工具类） [使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/AppUtilPage.ets)

| 方法                           | 介绍                                                                       |
|:-----------------------------|:-------------------------------------------------------------------------|
| init                         | 初始化方法,缓存全局变量，在UIAbility的onWindowStageCreate方法中初始化该方法                     |
| getContext                   | 获取上下文，common.UIAbilityContext                                            |
| getMainWindow                | 获取主窗口                                                                    |
| getUIContext                 | 获取UIContext                                                              |
| getWindowProperties          | 获取当前窗口的属性                                                                |
| getKeyboardAvoidMode         | 获取虚拟键盘抬起时的页面避让模式（OFFSET-上抬模式、RESIZE-压缩模式）                                |
| setKeyboardAvoidMode         | 设置虚拟键盘弹出时，页面的避让模式                                                        |
| isPortrait                   | 当前设备是否以竖屏方式显示                                                            |
| isLandscape                  | 当前设备是否以横屏方式显示                                                            |
| setPreferredOrientation      | 设置窗口的显示方向属性                                                              |
| setWindowBrightness          | 设置屏幕亮度值                                                                  |
| setWindowKeepScreenOn        | 设置屏幕是否为常亮状态                                                              |
| setWindowPrivacyMode         | 设置窗口是否为隐私模式。设置为隐私模式的窗口，窗口内容将无法被截屏或录屏                                     |
| setWindowBackgroundColor     | 设置窗口的背景色。Stage模型下，该接口需要在loadContent()或setUIContent()调用生效后使用              |
| setWindowFocusable           | 设置点击时是否支持切换焦点窗口                                                          |
| setWindowTouchable           | 设置窗口是否为可触状态                                                              |
| getStatusBarHeight           | 获取状态栏的高度，单位为px                                                           |
| getNavigationIndicatorHeight | 获取底部导航条的高度，单位为px。                                                        |
| setStatusBar                 | 设置沉浸式状态栏（需要配合getStatusBarHeight和getNavigationIndicatorHeight一起使用）        |
| getBundleInfo                | 获取当前应用的BundleInfo                                                        |
| getBundleName                | 获取应用包的名称                                                                 |
| getVersionCode               | 获取应用版本号                                                                  |
| getVersionName               | 获取应用版本名                                                                  |
| getTargetVersion             | 获取运行应用包所需要最高SDK版本号                                                       |
| getAppInfo                   | 获取应用程序的配置信息                                                              |
| toAppSetting                 | 跳转应用设置页面                                                                 |
| toNetworkSetting             | 跳转移动网络设置页面                                                               |
| toNotificationSetting        | 跳转通知设置页面                                                                 |
| toBluetoothSetting           | 跳转蓝牙设置页面                                                                 |
| toNfcSetting                 | 跳转NFC设置页面                                                                |
| toWebBrowser                 | 拉起系统浏览器                                                                  |
| toAppGalleryDetail           | 拉起应用市场对应的应用详情界面                                                          |
| toFileManagement             | 拉起系统文件管理器                                                                |
| exit                         | 主动退出整个应用；调用该方法后，任务中心的任务默认不会清理，如需清理，需要配置removeMissionAfterTerminate为true。 |

### DeviceUtil（设备相关工具类） [使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/DeviceUtilPage.ets)

| 方法                      | 介绍                                  |
|:------------------------|:------------------------------------|
| getDeviceId             | 获取设备ID（卸载APP后依旧不变）                  |
| deleteDeviceId          | 移除设备ID                              |
| getBrand                | 获取设备品牌名称                            |
| getProductModel         | 获取认证型号                              |
| getOsReleaseType        | 获取系统的发布类型，取值为：Canary、Beta、Release   |
| getOsFullName           | 获取系统版本                              |
| getDisplayVersion       | 获取产品版本                              |
| getSdkApiVersion        | 获取系统软件API版本                         |
| getBuildVersion         | 获取Build版本号，标识编译构建的版本号               |
| getODID                 | 获取开发者匿名设备标识符                        |
| getConfiguration        | 获取设备的Configuration                  |
| getConfigurationSync    | 获取设备的Configuration                  |
| getDirection            | 获取当前设备屏幕方向                          |
| getDeviceCapability     | 获取设备的DeviceCapability               |
| getDeviceCapabilitySync | 获取设备的DeviceCapability               |
| getDeviceType           | 获取当前设备类型                            |
| getDeviceTypeStr        | 获取当前设备类型，返回字符串                      |
| getScreenDensity        | 获取当前设备屏幕密度                          |
| startVibration          | 开启设备振动                              |
| stopVibration           | 停止设备振动（按照VIBRATOR_STOP_MODE_TIME模式） |

### DisplayUtil（屏幕相关工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/DisplayUtilPage.ets)

| 方法                    | 介绍                                   |
|:----------------------|:-------------------------------------|
| getDefaultDisplaySync | 获取当前默认的display对象                     |
| getWidth              | 获取设备的屏幕宽度，单位为px                      |
| getHeight             | 获取设备的屏幕高度，单位为px                      |
| getOrientation        | 获取设备当前显示的方向                          |
| getDisplayState       | 获取设备的状态                              |
| getCutoutRect         | 获取取挖孔屏、刘海屏、瀑布屏等不可用屏幕区域信息。建议应用布局规避该区域 |
| getCutoutHeight       | 获取挖孔屏、刘海屏等不可用屏幕区域的高度，单位为px           |
| isFoldable            | 检查设备是否可折叠                            |
| getFoldStatus         | 获取可折叠设备的当前折叠状态                       |
| getFoldDisplayMode    | 获取可折叠设备的显示模式                         |
| onFoldStatusChange    | 开启折叠设备折叠状态变化的监听                      |
| offFoldStatusChange   | 关闭折叠设备折叠状态变化的监听                      |

### PermissionUtil（申请授权工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PermissionUtilPage.ets)

| 方法                      | 介绍           |
|:------------------------|:-------------|
| checkPermissions        | 校验当前是否已经授权   |
| checkRequestPermissions | 校验是否授权后并申请授权 |
| requestPermissions      | 申请授权         |
| requestPermissionsList  | 申请组合授权       |

### AuthUtil（手机的生物认证(指纹、人脸、密码)工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/AuthUtilPage.ets)

| 方法                 | 介绍                 |
|:-------------------|:-------------------|
| getAvailableStatus | 查询指定类型和等级的认证能力是否支持 |
| onStartEasy        | 开始认证,使用指纹和密码认证     |
| onStart            | 开始认证，用户指定类型认证      |
| cancel             | 取消认证               |

### NotificationUtil（通知工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/NotificationUtilPage.ets)

| 方法                            | 介绍               |
|:------------------------------|:-----------------|
| authorizeNotification         | 校验是否已授权通知服务      |
| publishBasic                  | 发布普通文本通知         |
| publishMultiLine              | 发布多文本通知          |
| publishLongText               | 发布长文本通知          |
| publishPicture                | 发布带有图片的通知        |
| cancel                        | 取消通知             |
| cancelAll                     | 取消所有通知           |
| setBadge                      | 设置桌面角标个数         |
| clearBadge                    | 清空桌面角标           |
| setBadgeFromNotificationCount | 设置桌面角标数量，来自于通知数量 |
| getActiveNotificationCount    | 获取当前应用未删除的通知数量   |
| getActiveNotifications        | 获取当前应用未删除的通知列表   |

### PreferencesUtil（Preferences工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PreferencesUtilPage.ets)

| 方法                | 介绍                                                          |
|:------------------|:------------------------------------------------------------|
| init              | 初始化                                                         |
| put               | 将数据缓存                                                       |
| putSync           | 将数据缓存，同步                                                    |
| get               | 获取缓存值                                                       |
| getSync           | 获取缓存值，同步                                                    |
| getString         | 获取string类型的缓存值                                              |
| getStringSync     | 获取string类型的缓存值，同步                                           |
| getNumber         | 获取number类型的缓存值                                              |
| getNumberSync     | 获取number类型的缓存值，同步                                           |
| getBoolean        | 获取boolean类型的缓存值                                             |
| getBooleanSync    | 获取boolean类型的缓存值，同步                                          |
| has               | 检查缓存实例中是否包含给定Key的存储键值对                                      |
| hasSync           | 检查缓存实例中是否包含给定Key的存储键值对，同步                                   |
| getBoolean        | 获取boolean类型的缓存值                                             |
| getBooleanSync    | 获取boolean类型的缓存值，同步                                          |
| delete            | 删除缓存值                                                       |
| deleteSync        | 删除缓存值，同步                                                    |
| clear             | 清空缓存                                                        |
| clearSync         | 清空缓存 ，同步                                                    |
| deletePreferences | 从缓存中移出指定的Preferences实例，若Preferences实例有对应的持久化文件，则同时删除其持久化文件。 |

### FileUtil（文件操作相关工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/FileUtilPage.ets)

| 方法                       | 介绍                                     |
|:-------------------------|:---------------------------------------|
| getFilesDirPath          | 获取文件目录下的文件夹路径或文件路径                     |
| getCacheDirPath          | 获取缓存目录下的文件夹路径或文件路径                     |
| getTempDirPath           | 获取临时目录下的文件夹路径或文件路径                     |
| hasDirPath               | 判断是否是完整路径                              |
| getFileUri               | 通过URI或路径，获取FileUri                     |
| getFileName              | 通过URI或路径，获取文件名                         |
| getFilePath              | 通过URI或路径，获取文件路径                        |
| getParentUri             | 通过URI或路径，获取对应文件父目录的URI                 |
| getParentPath            | 通过URI或路径，获取对应文件父目录的路径名                 |
| getUriFromPath           | 以同步方法获取文件URI                           |
| getFileExtention         | 根据文件名获取文件后缀                            |
| getFileDirSize           | 获取指定文件夹下所有文件的大小或指定文件大小                 |
| isFile                   | 判断文件是否是普通文件                            |
| isDirectory              | 判断文件是否是目录                              |
| rename                   | 重命名文件或文件夹，使用Promise异步回调                |
| renameSync               | 重命名文件或文件夹，以同步方法                        |
| mkdir                    | 创建目录，当recursion指定为true，可多层级创建目录        |
| mkdirSync                | 创建目录以同步方法，当recursion指定为true，可多层级创建目录   |
| rmdir                    | 删除整个目录，使用Promise异步回调                   |
| rmdirSync                | 删除整个目录，以同步方法                           |
| unlink                   | 删除单个文件，使用Promise异步回调                   |
| unlinkSync               | 删除单个文件，以同步方法                           |
| access                   | 检查文件是否存在，使用Promise异步回调                 |
| accessSync               | 检查文件是否存在，以同步方法                         |
| open                     | 打开文件，支持使用URI打开文件                       |
| openSync                 | 打开文件，支持使用URI打开文件                       |
| read                     | 从文件读取数据                                |
| readSync                 | 从文件读取数据                                |
| readText                 | 基于文本方式读取文件（即直接读取文件的文本内容）               |
| readTextSync             | 基于文本方式读取文件（即直接读取文件的文本内容）               |
| write                    | 将数据写入文件                                |
| writeSync                | 将数据写入文件                                |
| writeEasy                | 将数据写入文件，并关闭文件                          |
| close                    | 关闭文件                                   |
| closeSync                | 关闭文件                                   |
| listFile                 | 列出文件夹下所有文件名，支持递归列出所有文件名（包含子目录下），支持文件过滤 |
| listFileSync             | 列出文件夹下所有文件名，支持递归列出所有文件名（包含子目录下），支持文件过滤 |
| stat                     | 获取文件详细属性信息                             |
| statSync                 | 获取文件详细属性信息                             |
| copy                     | 拷贝文件或者目录，支持拷贝进度监听                      |
| copyFile                 | 复制文件                                   |
| copyFileSync             | 以同步方法复制文件                              |
| moveFile                 | 移动文件                                   |
| moveFileSync             | 移动文件，以同步方法                             |
| moveDir                  | 移动源文件夹至目标路径下                           |
| moveDirSync              | 以同步方法移动源文件夹至目标路径下                      |
| truncate                 | 截断文件                                   |
| truncateSync             | 截断文件，以同步方法                             |
| lstat                    | 获取链接文件信息                               |
| lstatSync                | 获取链接文件信息，以同步方法                         |
| fsync                    | 同步文件数据                                 |
| fsyncSync                | 同步文件数据，以同步方法                           |
| fdatasync                | 实现文件内容数据同步                             |
| fdatasyncSync            | 实现文件内容数据同步，以同步方法                       |
| createStream             | 基于文件路径打开文件流                            |
| createStreamSync         | 基于文件路径打开文件流，以同步方法                      |
| fdopenStream             | 基于文件描述符打开文件流                           |
| fdopenStreamSync         | 基于文件描述符打开文件流，以同步方法                     |
| mkdtemp                  | 创建临时目录                                 |
| mkdtempSync              | 创建临时目录，以同步的方法                          |
| dup                      | 将文件描述符转化为File                          |
| utimes                   | 修改文件最近访问时间属性                           |
| getFormatFileSize        | 格式化文件大小                                |
| getRawFileContentSync    | 获取resources/rawfile目录下对应的rawfile文件内容   |
| getRawFileContent        | 获取resources/rawfile目录下对应的rawfile文件内容   |
| getRawFileContentStrSync | 获取resources/rawfile目录下对应的rawfile文件内容   |
| getRawFileContentStr     | 获取resources/rawfile目录下对应的rawfile文件内容   |

### PickerUtil（拍照、文件选择和保存,工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PickerUtilPage.ets)

| 方法             | 介绍                                                  |
|:---------------|:----------------------------------------------------|
| camera         | 调用系统相机，拍照、录视频                                       |
| selectPhoto    | 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频              |
| savePhoto      | 通过保存模式拉起photoPicker进行保存图片或视频资源的文件名，若无参数，则默认需要用户自行输入 |
| selectDocument | 通过选择模式拉起documentPicker界面，用户可以选择一个或多个文件              |
| saveDocument   | 通过保存模式拉起documentPicker界面，用户可以保存一个或多个文件              |
| selectAudio    | 通过选择模式拉起audioPicker界面，用户可以选择一个或多个音频文件               |
| saveAudio      | 通过保存模式拉起audioPicker界面，用户可以保存一个或多个音频文件               |

### PhotoHelper（相册相关,工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PhotoHelperPage.ets)

| 方法            | 介绍                                     |
|:--------------|:---------------------------------------|
| select        | 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频 |
| save          | 保存图片或视频到相册                             |
| getPhotoAsset | 获取对应uri的PhotoAsset对象,用于读取文件信息          |

### PreviewUtil（文件预览工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PreviewUtilPage.ets)

| 方法                  | 介绍                                   |
|:--------------------|:-------------------------------------|
| generatePreviewInfo | 根据文件uri构建PreviewInfo                 |
| openPreview         | 通过传入文件预览信息，打开预览窗口。1秒内重复调用无效          |
| openPreviewEasy     | 通过传入文件的uri，打开预览窗口。1秒内重复调用无效          |
| canPreview          | 根据文件的uri判断文件是否可预览                    |
| hasDisplayed        | 判断预览窗口是否已经存在                         |
| closePreview        | 关闭预览窗口，仅当预览窗口存在时起效                   |
| loadData            | 加载预览文件信息。仅当预览窗口存在时起效                 |
| loadDataEasy        | 加载预览文件信息。仅当预览窗口存在时起效                 |
| onSharePreview      | 调用其他应用预览文件                           |
| getMimeType         | 根据文件后缀名获取文件mimeType                  |
| getIconFileStr      | 根据文件后缀名获取对应文件类型的图标                   |
| getMimeTypeMap      | filePreview支持的预览文件类型                 |

### NetworkUtil（网络相关工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/NetworkUtilPage.ets)

| 方法                | 介绍                         |
|:------------------|:---------------------------|
| hasDefaultNet     | 检查默认数据网络是否被激活              |
| hasDefaultNetSync | 检查默认数据网络是否被激活              |
| hasNetWiFi        | 判断当前网络是否是Wi-Fi，否则是移动流量热点网络 |
| getNetBearType    | 获取网络类型                     |
| getIpAddress      | 获取当前设备的IP地址(设备连接Wi-Fi后)    |
| register          | 订阅指定网络状态变化的通知，支持多事件监听回调    |
| unregister        | 取消订阅默认网络状态变化的通知            |

### LocationUtil（定位工具类(WGS-84坐标系)）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/LocationUtilPage.ets)

| 方法                            | 介绍                    |
|:------------------------------|:----------------------|
| isLocationEnabled             | 判断位置服务是否已经使能(定位是否开启)。 |
| requestLocationPermissions    | 申请定位权限                |
| getCurrentLocationEasy        | 获取当前位置                |
| getCurrentLocation            | 获取当前位置                |
| onLocationChangeEasy          | 开启位置变化订阅，并发起定位请求。     |
| onLocationChange              | 开启位置变化订阅，并发起定位请求      |
| offLocationChange             | 关闭位置变化订阅，并删除对应的定位请求。  |
| getAddressFromLocationName    | 地理逆编码,将地理描述转换为具体坐标    |
| getGeoAddressFromLocationName | 地理逆编码,将地理描述转换为具体坐标    |
| getAddressFromLocation        | 地理逆编码,将坐标转换为地理描述      |
| getGeoAddressFromLocation     | 地理逆编码,将坐标转换为地理描述集合    |
| getCountryCode                | 获取当前的国家码              |

### PasteboardUtil（剪贴板工具类 ）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PasteboardUtilPage.ets)

| 方法             | 介绍            |
|:---------------|:--------------|
| setDataText    | 将纯文本数据写入系统剪贴板 |
| setDataHtml    | 将Htm数据写入系统剪贴板 |
| setDataUri     | 将Uri数据写入系统剪贴板 |
| getData        | 读取系统剪贴板内容     |
| getDataSync    | 读取系统剪贴板内容     |
| getDataStr     | 读取系统剪贴板里的字符串  |
| getDataSyncStr | 读取系统剪贴板里的字符串  |
| clearData      | 清空系统剪贴板内容     |
| hasData        | 判断系统剪贴板中是否有内容 |
| hasDataSync    | 判断系统剪贴板中是否有内容 |

### SnapshotUtil（组件截图和窗口截图工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/SnapshotUtilPage.ets)

| 方法                | 介绍                                             |
|:------------------|:-----------------------------------------------|
| get               | 获取已加载的组件的截图，传入组件的组件id，找到对应组件进行截图。通过Promise返回结果 |
| createFromBuilder | 在应用后台渲染CustomBuilder自定义组件，并输出其截图               |
| snapshot          | 获取窗口截图，使用Promise异步回调                           |

### ScanUtil（码工具类(扫码、码图生成、图片识码)）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ScanUtilPage.ets)

| 方法                    | 介绍                           |
|:----------------------|:-----------------------------|
| startScanForResult    | 调用默认界面扫码，使用Promise方式异步返回解码结果 |
| generateBarcode       | 码图生成，使用Promise异步返回生成的码图      |
| onPickerScanForResult | 通过picker拉起图库并选择图片,并调用图片识码    |
| onDetectBarCode       | 调用图片识码，使用Promise方式异步返回识码结果   |
| canIUseScan           | 判断当前设备是否支持码能力                |

### ImageUtil（图片相关工具类 ）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ImageUtilPage.ets)

| 方法                        | 介绍                                |
|:--------------------------|:----------------------------------|
| base64ToPixelMap          | 图片base64字符串转PixelMap              |
| pixelMapToBase64Str       | PixelMap转图片base64字符串              |
| savePixelMap              | 保存pixelMap到本地                     |
| saveImageSource           | 保存ImageSource到本地                  |
| createImageSource         | 创建图片源实例                           |
| createIncrementalSource   | 以增量的方式创建图片源实例                     |
| packingFromPixelMap       | 图片压缩或重新打包，使用Promise形式返回结果         |
| packingFromImageSource    | 图片压缩或重新打包，使用Promise形式返回结果         |
| packToFileFromPixelMap    | 将PixelMap图片源编码后直接打包进文件            |
| packToFileFromImageSource | 将ImageSource图片源编码后直接打包进文件         |
| getPixelMapFromMedia      | 用户获取resource目录下的media中的图片PixelMap |

### KeyboardUtil（键盘工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/KeyboardUtilPage.ets)

| 方法                     | 介绍                |
|:-----------------------|:------------------|
| hide                   | 隐藏键盘              |
| onKeyboardListener     | 订阅输入法软键盘显示和隐藏事件   |
| removeKeyboardListener | 取消订阅输入法软键盘显示或隐藏事件 |
| onInputTextChanged     | 订阅文本内容变化          |
| removeInputTextChanged | 取消订阅文本内容变化        |

### LogUtil（日志工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/LogUtilPage.ets)

| 方法         | 介绍                                           |
|:-----------|:---------------------------------------------|
| init       | 初始化日志参数（该方法建议在Ability里调用）                    |
| setDomain  | 设置日志对应的领域标识，范围是0x0~0xFFFF。（该方法建议在Ability里调用） |
| setTag     | 设置日志标识（该方法建议在Ability里调用）                     |
| setShowLog | 是否打印日志（该方法建议在Ability里调用）                     |
| debug      | 打印DEBUG级别日志                                  |
| info       | 打印INFO级别日志                                   |
| warn       | 打印WARN级别日志                                   |
| error      | 打印ERROR级别日志                                  |
| fatal      | 打印FATAL级别日志                                  |
| print      | 打印JSON对象和JSON字符串（日志过滤tag为：JSAPP）             |

### CrashUtil（全局异常捕获，崩溃日志收集）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/CrashUtilPage.ets)

| 方法                | 介绍                                                                |
|:------------------|:------------------------------------------------------------------|
| onError           | 注册错误观测器。注册后可以捕获到应用产生的js crash，应用崩溃时进程不会退出。将异常信息写入本地文件             |
| offError          | 注销错误观测器                                                           |
| readErrorText     | 读取错误日志文件                                                          |
| onExportErrorLog  | 导出错误日志文件                                                          |
| enableAppRecovery | 启用应用恢复功能，参数按顺序填入。该接口调用后，应用从启动器启动时第一个Ability支持恢复。                  |
| restartApp        | 重启APP，并拉起应用启动时第一个Ability，可以配合errorManager相关接口使用                   |
| saveAppState      | 保存当前App状态 或 主动保存Ability的状态，这个状态将在下次恢复启动时使用。可以配合errorManager相关接口使用 |
| setRestartWant    | 设置下次恢复主动拉起场景下的Ability。该Ability必须为当前包下的UIAbility                   |

### CharUtil（字符工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/CharUtilPage.ets)

| 方法           | 介绍                           |
|:-------------|:-----------------------------|
| isDigit      | 判断字符串char是否是数字               |
| isLetter     | 判断字符串char是否是字母               |
| isLowerCase  | 判断字符串char是否是小写字母             |
| isUpperCase  | 判断字符串char是否是大写字母             |
| isSpaceChar  | 判断字符串char是否是空格符              |
| isWhitespace | 判断字符串char是否是空白符              |
| isRTL        | 判断字符串char是否是从右到左语言的字符        |
| isIdeograph  | 判断字符串char是否是表意文字             |
| isBlankChar  | 是否空白符 空白符包括空格、制表符、全角空格和不间断空格 |
| isAscii      | 检查字符是否位于ASCII范围内（0~127）      |
| isEmoji      | 判断是否为emoji表情符                |

### StrUtil（字符串工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/StrUtilPage.ets)

| 方法                   | 介绍                                    |
|:---------------------|:--------------------------------------|
| isNull               | 字符串是否为空(undefined、null)               |
| isNotNull            | 判断字符串是否为非空                            |
| isEmpty              | 字符串是否为空(undefined、null、字符串长度为0)       |
| isNotEmpty           | 判断字符串是否为非空                            |
| isBlank              | 判断字符串是否为空和空白符(空白符包括空格、制表符、全角空格和不间断空格) |
| isNotBlank           | 判断字符串是否为非空                            |
| replace              | 替换字符串中匹配的正则为给定的字符串                    |
| replaceAll           | 替换字符串中所有匹配的正则为给定的字符串                  |
| startsWith           | 检查字符串是否以给定的字符串开头                      |
| endsWith             | 检查字符串是否以给定的字符串结尾                      |
| repeat               | 将字符串重复指定次数                            |
| toLower              | 转换整个字符串的字符为小写                         |
| toUpper              | 转换整个字符串的字符为大写                         |
| capitalize           | 转换字符串首字母为大写，剩下为小写                     |
| equal                | 判断两个传入的数值或者是字符串是否相等                   |
| notEqual             | 判断两个传入的数值或者是字符串是否不相等                  |
| strToUint8Array      | 字符串转Uint8Array                        |
| unit8ArrayToStr      | Uint8Array转字符串                        |
| strToBase64          | 字符串转Base64字符串                         |
| base64ToStr          | Base64字符串转字符串                         |
| strToBuffer          | 字符串转ArrayBuffer                       |
| bufferToStr          | ArrayBuffer转字符串                       |
| bufferToUint8Array   | ArrayBuffer转Uint8Array                |
| unit8ArrayToBuffer   | Uint8Array转ArrayBuffer                |
| isPhone              | 判断传入的电话号码格式是否正确                       |
| getPhoneFormat       | 对电话号码进行格式化                            |
| getPhoneLocationName | 获取电话号码归属地                             |
| isMatch              | 给定内容是否匹配正则                            |
| isEmail              | 判断传入的邮箱格式是否正确                         |
| getErrnoToString     | 获取系统错误码对应的详细信息                        |


### Base64Util（Base64工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/Base64UtilPage.ets)

| 方法              | 介绍                           |
|:----------------|:-----------------------------|
| encodeSync      | 编码，通过输入参数编码后输出Uint8Array对象   |
| encodeToStrSync | 编码，通过输入参数编码后输出对应文本           |
| decodeSync      | 解码，通过输入参数解码后输出对应Uint8Array对象 |
| encode          | 编码，通过输入参数编码后输出Uint8Array对象   |
| encodeToStr     | 编码，通过输入参数编码后输出对应文本           |
| decode          | 解码，通过输入参数解码后输出对应Uint8Array对象 |

### NumberUtil（number工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/NumberUtilPage.ets)

| 方法       | 介绍         |
|:---------|:-----------|
| isNumber | 判断是否是数值    |
| toInt    | 将字符串转换为整数  |
| toFloat  | 将字符串转换为浮点数 |

### DateUtil（日期工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/DateUtilPage.ets)

| 方法                    | 介绍                          |
|:----------------------|:----------------------------|
| getFormatDate         | 获取格式化日期，将传入的日期格式化为Date      |
| getFormatDateStr      | 获取格式化日期，将传入的日期格式化为指定格式的字符串  |
| getToday              | 获取今天的日期                     |
| getTodayTime          | 获取今天的时间戳                    |
| getTodayStr           | 获取今天的时间，字符串类型               |
| isToday               | 判断日期是否是今天                   |
| getNowYear            | 获取当前年                       |
| getNowMonth           | 获取当前月                       |
| getNowDay             | 获取当前日                       |
| isLeapYear            | 判断是否是闰年                     |
| getDaysByYear         | 获取指定年份的天数                   |
| getDaysByMonth        | 获取指定月份的天数                   |
| isSameYear            | 判断两个日期是否是同一年                |
| isSameMonth           | 判断两个日期是否是同一月                |
| isSameWeek            | 判断两个日期是否是同一周                |
| isSameDay             | 判断是否是同一天                    |
| getCalendar           | 获取日历对象,并设置日历对象内部的时间日期       |
| getCalendarField      | 获取日历对象中与field相关联的值。         |
| getCalendarAdd        | 在日历的给定字段进行加减操作              |
| isWeekend             | 判断指定的日期在日历中是否为周末            |
| compareDays           | 比较指定日期相差的天数                 |
| compareDate           | 比较指定日期相差的毫秒数                |
| getAmountDay          | 获取前几天日期或后几天日期               |
| getAmountDayStr       | 获取前几天日期或后几天日期,返回字符串         |
| getBeforeDay          | 获取前一天日期                     |
| getBeforeDayStr       | 获取前一天日期,返回字符串               |
| getAfterDay           | 获取后一天日期                     |
| getAfterDayStr        | 获取后一天日期,返回字符串               |
| getWeekOfMonth        | 获取给定日期是当月的第几周               |
| getWeekDay            | 获取给定的日期是星期几                 |
| getLastDayOfMonth     | 获取给定年份和月份的最后一天是几号           |
| getFormatTime         | 格式化时间日期字符串（DateTimeFormat）  |
| getFormatRange        | 格式化时间日期段字符串（DateTimeFormat） |
| getFormatRelativeTime | 格式化相对时间                     |
| getTipDateStr         | 格式化时间戳，获取提示性时间字符串           |

### ArrayUtil（数组工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ArrayUtilPage.ets)

| 方法          | 介绍                                 |
|:------------|:-----------------------------------|
| isNotEmpty  | 集合是否为非空集合                          |
| isEmpty     | 集合是否为空集合                           |
| removeEmpty | 去除集合中的空值                           |
| trim        | 去除传入集合的每个值的前后空格                    |
| distinct    | 数组去重，去重后生成新的数组，原数组不变               |
| reverse     | 反转数组，会修改原始数组                       |
| filter      | 通过传入的filter实现来过滤返回需要的元素            |
| append      | 将新元素添加到已有数组中 添加新元素会生成一个新的数组，不影响原数组 |
| setOrAppend | 将元素值设置为数组的某个位置，当给定的index大于数组长度，则追加 |
| min         | 获取数组（数值、字符串、日期）最小值                 |
| max         | 获取数组（数值、字符串、日期）最大值                 |
| flatten     | 平铺二维数组                             |
| union       | 平铺二维数组，并去重                         |

### RandomUtil（随机工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/RandomUtilPage.ets)

| 方法                       | 介绍                                            |
|:-------------------------|:----------------------------------------------|
| randomInt                | 生成随机数number值                                  |
| randomLimit              | 生成指定范围内的随机数 [0,limit)                         |
| randomNumber             | 生成指定范围内的随机数                                   |
| randomBoolean            | 生成随机Boolean值                                  |
| randomStr                | 根据指定字符串，随机生成指定长度的字符串                          |
| randomChinese            | 生成随机汉字                                        |
| randomColor              | 生成随机颜色，十六进制                                   |
| generateUUID36           | 生成36位UUID，带-                                  |
| generateUUID32           | 生成32位UUID，带-                                  |
| generateRandomUUID       | 使用加密安全随机数生成器生成随机的RFC 4122版本4的string类型UUID     |
| generateRandomBinaryUUID | 使用加密安全随机数生成器生成随机的RFC 4122版本4的Uint8Array类型UUID |

### ObjectUtil（对象工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ObjectUtilPage.ets)

| 方法       | 介绍          |
|----------|:------------|
| getHash  | 获取对象的Hash值  |
| isString | 判断是否是String |
| isNull   | 判断对象是否为空    |
| deepCopy | 深度拷贝对象      |

### JSONUtil（JSON工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/JSONUtilPage.ets)

| 方法            | 介绍              |
|:--------------|:----------------|
| jsonToBean    | JSON字符串转Class对象 |
| jsonToArray   | JSON字符串转Array   |
| jsonToMap     | JSON转Map        |
| beanToJsonStr | 对象转字符串          |
| isJSONStr     | 判断是否是字符串格式json  |

### CacheUtil（缓存工具类 ）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/CacheUtilPage.ets)

| 方法   | 介绍  |
|:-----|:----|
| save | 存值  |
| get  | 取值  |

### ClickUtil（节流、防抖 工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ClickUtilPage.ets)

| 方法       | 介绍                               |
|:---------|:---------------------------------|
| throttle | 节流：在一定时间内，只触发一次                  |
| debounce | 防抖：一定时间内，只有最后一次操作，再过wait毫秒后才执行函数 |

### TempUtil(温度转换工具类)[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/TempUtilPage.ets)

| 方法  | 介绍      |
|:----|:--------|
| F2C | 华氏度转摄氏度 |
| C2F | 摄氏度转华氏度 |

### AssetUtil(关键资产存储服务工具类)[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/AssetUtilPage.ets)

| 方法         | 介绍          |
|:-----------|:------------|
| add        | 新增一条关键资产    |
| addSync    | 新增一条关键资产,同步 |
| get        | 查询关键资产      |
| getSync    | 查询关键资产，同步   |
| remove     | 删除关键资产      |
| removeSync | 删除关键资产，同步   |
| canIUse    | 当前设备是否支持该模块 |

### DialogUtil（弹窗工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/DialogUtilPage.ets)

| 方法                  | 介绍               |
|:--------------------|:-----------------|
| setDefaultConfig    | 设置默认统一样式         |
| showConfirmDialog   | 显示弹窗（一个按钮）       |
| showPrimaryDialog   | 显示弹窗（两个按钮）       |
| showDialog          | 显示弹窗（可多个按钮）      |
| showDialogEasy      | 显示弹窗（可多个按钮,简单易用） |
| showActionSheet     | 列表选择弹窗           |
| showActionSheetEasy | 列表选择弹窗（简单易用）     |
| showCalendarPicker  | 日历选择器弹窗          |
| showDatePicker      | 日期滑动选择器弹窗        |
| showTimePicker      | 时间滑动选择器弹窗        |
| showTextPicker      | 文本滑动选择器弹窗        |

### ToastUtil（土司工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ToastUtilPage.ets)

| 方法               | 介绍               |
|:-----------------|:-----------------|
| setDefaultConfig | 设置默认统一样式         |
| showToast        | 弹出土司，默认时长为2s     |
| showShort        | 弹出短土司，默认时长为:1.5s |
| showLong         | 弹出长土司，默认时长为:10s  |

### ActionUtil（弹窗工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ActionUtilPage.ets)

| 方法                 | 介绍           |
|:-------------------|:-------------|
| showConfirmDialog  | 显示弹窗（一个按钮）   |
| showPrimaryDialog  | 显示弹窗（两个按钮）   |
| showDialog         | 显示弹窗（多个按钮）   |
| showActionMenuEasy | 显示操作菜单（简单易用） |
| showActionMenu     | 显示操作菜单       |


<br><br>
## 🙏贡献代码与技术交流

使用过程中发现任何问题都可以提 [Issue](https://gitee.com/tongyuyan/harmony-utils/issues)。   
给我们，当然，我们也非常欢迎你给我们发 [PR](https://gitee.com/tongyuyan/harmony-utils/pulls) 。   

[https://gitee.com/tongyuyan/harmony-utils](https://gitee.com/tongyuyan/harmony-utils)   
[https://github.com/787107497](https://github.com/787107497)   

鸿蒙技术交流QQ群：569512366

## 📚开源协议

本项目基于 [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.html) ，拷贝和借鉴代码请标注来源。

