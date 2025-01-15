# harmony-utils (API12 - 5.0.3.906)

## 🏆简介与推荐

[harmony-utils](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils)
一款功能丰富且极易上手的HarmonyOS工具库，借助众多实用工具类，致力于助力开发者迅速构建鸿蒙应用。其封装的工具涵盖了APP、设备、屏幕、授权、通知、线程间通信、弹框、吐司、生物认证、用户首选项、拍照、相册、扫码、文件、日志，异常捕获、字符、字符串、数字、集合、日期、随机、base64、加密、解密、JSON等一系列的功能和操作，能够满足各种不同的开发需求。

[harmony-dialog](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog)
一款极为简单易用的零侵入弹窗，仅需一行代码即可轻松实现，无论在何处都能够轻松弹出。

[SpinKit](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fspinkit) 是一个适用于OpenHarmony/HarmonyOS的加载动画库。

## 🌞下载安装与使用说明🙏

`ohpm i @pura/harmony-utils`
OpenHarmony ohpm
环境配置等更多内容，请参考[如何安装 OpenHarmony ohpm 包](https://ohpm.openharmony.cn/#/cn/help/downloadandinstall)

#### 在更新记录里，每个版本号，都有对应的最低开发工具版本，如：“1.2.2（API12 - 5.0.3.906）”；如遇到API不存在和项目报错，请升级开发工具DevEco Studio。

 ```
全局初始化方法，从1.2.0版本开始，在UIAbility的onCreate方法中初始化 AppUtil.init()
    
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    AppUtil.init(this.context);
  }
 ```

<br>

## 📂模块介绍

| 模块                                                                                | 介绍                                                                       |
|:----------------------------------------------------------------------------------|:-------------------------------------------------------------------------|
| AppUtil                                                                           | APP相关工具类                                                                 |
| DeviceUtil                                                                        | 设备相关工具类                                                                  |
| DisplayUtil                                                                       | 屏幕相关工具类                                                                  |
| PermissionUtil                                                                    | 申请授权工具类                                                                  |
| NotificationUtil                                                                  | 通知工具类                                                                    |
| EmitterUtil                                                                       | Emitter工具类（进行线程间通信）                                                      |
| WantUtil                                                                          | Want工具类                                                                  |
| AuthUtil                                                                          | 手机的生物认证（指纹、人脸、密码）工具类                                                     |
| PreferencesUtil                                                                   | Preferences（用户首选项）工具类                                                    |
| KvUtil                                                                            | 键值型数据库工具类                                                                |
| CacheUtil                                                                         | 缓存工具类                                                                    |
| LRUCacheUtil                                                                      | LRUCache缓存工具类                                                            |
| FileUtil                                                                          | 文件操作相关工具类                                                                |
| PickerUtil                                                                        | 拍照、文件(文件、图片、视频、音频)选择和保存,工具类                                              |
| PhotoHelper                                                                       | 相册相关工具类                                                                  |
| ImageUtil                                                                         | 图片相关工具类                                                                  |
| SnapshotUtil                                                                      | 组件截图和窗口截图工具类                                                             |
| PreviewUtil                                                                       | 文件预览工具类                                                                  |
| ScanUtil                                                                          | 码工具类（扫码、码图生成、图片识码）                                                       |
| LocationUtil                                                                      | 定位工具类(WGS-84坐标系)                                                         |
| LogUtil                                                                           | 日志工具类                                                                    |
| ResUtil                                                                           | 资源工具类                                                                    |
| DateUtil                                                                          | 日期工具类                                                                    |
| StrUtil                                                                           | 字符串工具类                                                                   |
| RegexUtil                                                                         | 正则工具类                                                                    |
| FormatUtil                                                                        | 格式化工具类                                                                   |
| CharUtil                                                                          | 字符工具类                                                                    |
| Base64Util                                                                        | Base64工具类                                                                |
| NumberUtil                                                                        | number工具类                                                                |
| ArrayUtil                                                                         | 集合工具类                                                                    |
| RandomUtil                                                                        | 随机工具类                                                                    |
| ObjectUtil                                                                        | 对象工具类                                                                    |
| JSONUtil                                                                          | JSON工具类                                                                  |
| ClickUtil                                                                         | 节流、防抖 工具类（用于点击事件，防止按钮被重复点击）                                              |
| CrashUtil                                                                         | 全局异常捕获，崩溃日志收集                                                            |
| KeyboardUtil                                                                      | 键盘工具类                                                                    |
| PasteboardUtil                                                                    | 剪贴板工具类                                                                   |
| NetworkUtil                                                                       | 网络相关工具类                                                                  |
| AssetUtil                                                                         | 关键资产存储服务工具类                                                              |
| TempUtil                                                                          | 温度转换工具类，华氏度与摄氏度相互转换                                                      |
| DialogUtil                                                                        | 弹窗工具类（AlertDialog）                                                       |
| ToastUtil                                                                         | 吐司工具类（promptAction）                                                      |
| SM2、SM3、SM4、<br/>AES、DES、RSA、<br/>MD5、SHA、ECDSA、<br/>CryptoUtil、<br/>CryptoHelper | 加解密算法工具类<br/>CryptoUtil：加解密公用工具类，配合各个加密模块使用。<br/>CryptoHelper：加解密数据类型转换。 |

<br>

## AppUtil（APP相关工具类） [使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/AppUtilPage.ets)

| 方法                           | 介绍                                                                       |
|:-----------------------------|:-------------------------------------------------------------------------|
| init                         | 初始化方法,缓存全局变量，在UIAbility的onCreate方法中初始化该方法                                |
| getContext                   | 获取上下文，common.UIAbilityContext                                            |
| getWindowStage               | 获取WindowStage                                                            |
| getMainWindow                | 获取主窗口                                                                    |
| getUIContext                 | 获取UIContext                                                              |
| setGrayScale                 | 设置灰阶，APP一键置灰                                                             |
| setStatusBar                 | 设置沉浸式状态栏（需要配合getStatusBarHeight和getNavigationIndicatorHeight一起使用）        |
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
| getBundleInfo                | 获取当前应用的BundleInfo                                                        |
| getBundleName                | 获取应用包的名称                                                                 |
| getVersionCode               | 获取应用版本号                                                                  |
| getVersionName               | 获取应用版本名                                                                  |
| getTargetVersion             | 获取运行应用包所需要最高SDK版本号                                                       |
| getAppInfo                   | 获取应用程序的配置信息                                                              |
| exit                         | 主动退出整个应用；调用该方法后，任务中心的任务默认不会清理，如需清理，需要配置removeMissionAfterTerminate为true。 |

## DeviceUtil（设备相关工具类） [使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/DeviceUtilPage.ets)

| 方法                                              | 介绍                                  |
|:------------------------------------------------|:------------------------------------|
| getDeviceId                                     | 获取设备ID（卸载APP后依旧不变）                  |
| deleteDeviceId                                  | 移除设备ID                              |
| getBrand                                        | 获取设备品牌名称                            |
| getProductModel                                 | 获取认证型号                              |
| getOsReleaseType                                | 获取系统的发布类型，取值为：Canary、Beta、Release   |
| getOsFullName                                   | 获取系统版本                              |
| getDisplayVersion                               | 获取产品版本                              |
| getSdkApiVersion                                | 获取系统软件API版本                         |
| getBuildVersion                                 | 获取Build版本号，标识编译构建的版本号               |
| getODID                                         | 获取开发者匿名设备标识符                        |
| getConfiguration<br/>getConfigurationSync       | 获取设备的Configuration                  |
| getDirection                                    | 获取当前设备屏幕方向                          |
| getDeviceCapability<br/>getDeviceCapabilitySync | 获取设备的DeviceCapability               |
| getDeviceType                                   | 获取当前设备类型                            |
| getDeviceTypeStr                                | 获取当前设备类型，返回字符串                      |
| getScreenDensity                                | 获取当前设备屏幕密度                          |
| startVibration                                  | 开启设备振动                              |
| stopVibration                                   | 停止设备振动（按照VIBRATOR_STOP_MODE_TIME模式） |

## DisplayUtil（屏幕相关工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/DisplayUtilPage.ets)

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

## PermissionUtil（申请授权工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PermissionUtilPage.ets)

| 方法                             | 介绍                                |
|:-------------------------------|:----------------------------------|
| checkPermissions               | 校验当前是否已经授权                        |
| checkRequestPermissions        | 校验是否授权后并申请授权                      |
| requestPermissions             | 申请授权                              |
| requestPermissionsEasy         | 申请授权，拒绝后并二次向用户申请授权（申请权限，建议使用该方法）。 |
| requestPermissionOnSetting     | 二次向用户申请授权（单个权限 或 读写权限组，建议使用该方法）。  |
| requestPermissionOnSettingEasy | 二次向用户申请授权（多个权限建议使用该方法）。           |

## NotificationUtil（通知工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/NotificationUtilPage.ets)

| 方法                                                  | 介绍                          |
|:----------------------------------------------------|:----------------------------|
| setDefaultConfig                                    | 设置通知的默认统一配置                 |
| isNotificationEnabled<br/>isNotificationEnabledSync | 查询通知是否授权                    |
| authorizeNotification                               | 请求通知授权，第一次调用会弹窗让用户选择。       |
| isSupportTemplate                                   | 查询模板是否存在，目前仅支持进度条模板。        |
| isDistributedEnabled                                | 查询设备是否支持分布式通知               |
| publishBasic                                        | 发布普通文本通知                    |
| publishMultiLine                                    | 发布多文本通知                     |
| publishLongText                                     | 发布长文本通知                     |
| publishPicture                                      | 发布带有图片的通知                   |
| publishTemplate                                     | 发布模板通知                      |
| cancel                                              | 取消通知                        |
| cancelGroup                                         | 取消本应用指定组下的通知                |
| cancelAll                                           | 取消所有通知                      |
| setBadge                                            | 设置桌面角标个数                    |
| clearBadge                                          | 清空桌面角标                      |
| setBadgeFromNotificationCount                       | 设置桌面角标数量，来自于通知数量            |
| getActiveNotificationCount                          | 获取当前应用未删除的通知数量              |
| getActiveNotifications                              | 获取当前应用未删除的通知列表              |
| addSlot                                             | 创建指定类型的通知渠道                 |
| getSlot                                             | 获取一个指定类型的通知渠道               |
| getSlots                                            | 获取此应用程序的所有通知渠道              |
| removeSlot                                          | 删除此应用程序指定类型的通知渠道            |
| removeAllSlots                                      | 删除此应用程序所有通知渠道               |
| generateNotificationId                              | 生成通知id（用时间戳当id）             |
| getDefaultWantAgent                                 | 创建一个可拉起Ability的Want         |
| getCompressedPicture                                | 获取压缩通知的图片（图像像素的总字节数不能超过2MB） |
| getCompressedIcon                                   | 获取压缩通知图标（图标像素的总字节数不超过192KB） |

## EmitterUtil（Emitter工具类（进行线程间通信））[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/EmitterUtilPage.ets)

| 方法               | 介绍                  |
|:-----------------|:--------------------|
| post             | 发送事件                |
| onSubscribe      | 订阅事件                |
| onceSubscribe    | 单次订阅指定事件            |
| unSubscribe      | 取消事件订阅              |
| getListenerCount | 获取指定事件的订阅数          |
| on               | 订阅事件，支持Callback     |
| once             | 单次订阅指定事件，支持Callback |
| off              | 取消事件订阅，支持Callback   |

## WantUtil（Want工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/WantUtilPage.ets)

| 方法                    | 介绍                                         |
|:----------------------|:-------------------------------------------|
| toSetting             | 跳转系统设置页面（配合WantUtil里的URI常量一起使用，可跳转更多的设置页面） |
| toAppSetting          | 跳转应用设置页面                                   |
| toNotificationSetting | 跳转通知设置页面                                   |
| toNetworkSetting      | 跳转移动网络设置页面                                 |
| toWifiSetting         | 跳转WLAN设置页面                                 |
| toBluetoothSetting    | 跳转蓝牙设置页面                                   |
| toNfcSetting          | 跳转NFC设置页面                                  |
| toVolumeSetting       | 跳转声音和振动设置页面                                |
| toStorageSetting      | 跳转存储设置页面                                   |
| toBatterySetting      | 跳转电池设置页面                                   |
| toWebBrowser          | 拉起系统浏览器                                    |
| toAppGalleryDetail    | 拉起应用市场对应的应用详情界面                            |
| toFileManagement      | 拉起系统文件管理器                                  |
| startMMS              | 拉起短信界面并指定联系人                               |
| openFile              | 调用三方软件打开文件                                 |

## AuthUtil（手机的生物认证(指纹、人脸、密码)工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/AuthUtilPage.ets)

| 方法                 | 介绍                 |
|:-------------------|:-------------------|
| getAvailableStatus | 查询指定类型和等级的认证能力是否支持 |
| onStartEasy        | 开始认证,使用指纹和密码认证     |
| onStart            | 开始认证，用户指定类型认证      |
| cancel             | 取消认证               |

## KvUtil（键值型数据库工具类 ）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/KvUtilPage.ets)

| 方法                                                               | 介绍                        |
|:-----------------------------------------------------------------|:--------------------------|
| put                                                              | 添加指定类型的键值对到数据库            |
| get<br/>getString<br/>getNumber<br/>getBoolean<br/>getUint8Array | 获取指定键的值                   |
| delete                                                           | 从数据库中删除指定键值的数据            |
| putBatch                                                         | 批量插入键值对到SingleKVStore数据库中 |
| deleteBatch                                                      | 批量删除SingleKVStore数据库中的键值对 |
| getEntries                                                       | 获取匹配指定键前缀的所有键值对           |
| backup                                                           | 以指定名称备份数据库                |
| restore                                                          | 从指定的数据库文件恢复数据库            |
| deleteBackup                                                     | 根据指定名称删除备份文件              |
| onDataChange                                                     | 订阅指定类型的数据变更通知             |
| offDataChange                                                    | 取消订阅数据变更通知                |

## PreferencesUtil（Preferences工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PreferencesUtilPage.ets)

| 方法                            | 介绍                                                          |
|:------------------------------|:------------------------------------------------------------|
| init                          | 初始化                                                         |
| put<br/>putSync               | 将数据缓存                                                       |
| get<br/>getSync               | 获取缓存值                                                       |
| getString<br/>getStringSync   | 获取string类型的缓存值                                              |
| getNumber<br/>getNumberSync   | 获取number类型的缓存值                                              |
| getBoolean<br/>getBooleanSync | 获取boolean类型的缓存值                                             |
| has<br/>hasSync               | 检查缓存实例中是否包含给定Key的存储键值对                                      |
| getBoolean<br/>getBooleanSync | 获取boolean类型的缓存值                                             |
| delete<br/>deleteSync         | 删除缓存值                                                       |
| clear<br/>clearSync           | 清空缓存                                                        |
| deletePreferences             | 从缓存中移出指定的Preferences实例，若Preferences实例有对应的持久化文件，则同时删除其持久化文件。 |
| onChange                      | 订阅数据变更，订阅的Key的值发生变更后，在执行flush方法后，触发callback回调               |
| offChange                     | 取消订阅数据变更                                                    |
| onDataChange                  | 精确订阅数据变更，只有被订阅的key值发生变更后，在执行flush方法后，触发callback回调           |
| offDataChange                 | 取消精确订阅数据变更                                                  |

## CacheUtil（缓存工具类 ）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/CacheUtilPage.ets)

| 方法      | 介绍         |
|:--------|:-----------|
| put     | 将数据存入缓存中   |
| get     | 获取缓存中的数据   |
| has     | 缓存中的数据是否存在 |
| isEmpty | 判断缓存是否为空   |
| clear   | 清除缓存数据     |

## LRUCacheUtil（LRUCache缓存工具类 ）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/LRUCacheUtilPage.ets)

| 方法             | 介绍                    |
|:---------------|:----------------------|
| getInstance    | 获取LRUCacheUtil的单例     |
| put            | 添加缓存到lruCache中        |
| get            | 获取key对应的缓存            |
| has            | 判断是否包含key对应的缓存        |
| remove         | 删除key对应的缓存            |
| isEmpty        | 判断lruCache缓存是否为空      |
| getCapacity    | 获取当前缓冲区的容量            |
| updateCapacity | 重新设置lruCache的容量       |
| clear          | 清除缓存数据，并重置lruCache的大小 |

## FileUtil（文件操作相关工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/FileUtilPage.ets)

| 方法                                | 介绍                                     |
|:----------------------------------|:---------------------------------------|
| getFilesDirPath                   | 获取文件目录下的文件夹路径或文件路径                     |
| getCacheDirPath                   | 获取缓存目录下的文件夹路径或文件路径                     |
| getTempDirPath                    | 获取临时目录下的文件夹路径或文件路径                     |
| hasDirPath                        | 判断是否是完整路径                              |
| getFileUri                        | 通过URI或路径，获取FileUri                     |
| getFileName                       | 通过URI或路径，获取文件名                         |
| getFilePath                       | 通过URI或路径，获取文件路径                        |
| getParentUri                      | 通过URI或路径，获取对应文件父目录的URI                 |
| getParentPath                     | 通过URI或路径，获取对应文件父目录的路径名                 |
| getUriFromPath                    | 以同步方法获取文件URI                           |
| getFileExtention                  | 根据文件名获取文件后缀                            |
| getFileDirSize                    | 获取指定文件夹下所有文件的大小或指定文件大小                 |
| isFile                            | 判断文件是否是普通文件                            |
| isDirectory                       | 判断文件是否是目录                              |
| rename<br/>renameSync             | 重命名文件或文件夹，使用Promise异步回调                |
| mkdir<br/>mkdirSync               | 创建目录，当recursion指定为true，可多层级创建目录        |
| rmdir<br/>rmdirSync               | 删除整个目录，使用Promise异步回调                   |
| unlink<br/>unlinkSync             | 删除单个文件，使用Promise异步回调                   |
| access<br/>accessSync             | 检查文件是否存在，使用Promise异步回调                 |
| open<br/>openSync                 | 打开文件，支持使用URI打开文件                       |
| read<br/>readSync                 | 从文件读取数据                                |
| readText<br/>readTextSync         | 基于文本方式读取文件（即直接读取文件的文本内容）               |
| write<br/>writeSync               | 将数据写入文件                                |
| writeEasy                         | 将数据写入文件，并关闭文件                          |
| close<br/>closeSync               | 关闭文件                                   |
| listFile<br/>listFileSync         | 列出文件夹下所有文件名，支持递归列出所有文件名（包含子目录下），支持文件过滤 |
| stat<br/>statSync                 | 获取文件详细属性信息                             |
| copy                              | 拷贝文件或者目录，支持拷贝进度监听                      |
| copyFile<br/>copyFileSync         | 复制文件                                   |
| moveFile<br/>moveFileSync         | 移动文件                                   |
| moveDir<br/>moveDirSync           | 移动源文件夹至目标路径下                           |
| truncate<br/>truncateSync         | 截断文件                                   |
| lstat<br/>lstatSync               | 获取链接文件信息                               |
| fsync<br/>fsyncSync               | 同步文件数据                                 |
| fdatasync<br/>fdatasyncSync       | 实现文件内容数据同步                             |
| createStream<br/>createStreamSync | 基于文件路径打开文件流                            |
| fdopenStream<br/>fdopenStreamSync | 基于文件描述符打开文件流                           |
| mkdtemp<br/>mkdtempSync           | 创建临时目录                                 |
| dup                               | 将文件描述符转化为File                          |
| utimes                            | 修改文件最近访问时间属性                           |
| getFormatFileSize                 | 格式化文件大小                                |

## PickerUtil（拍照、文件选择和保存,工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PickerUtilPage.ets)

| 方法             | 介绍                                                  |
|:---------------|:----------------------------------------------------|
| camera         | 调用系统相机，拍照、录视频                                       |
| selectPhoto    | 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频              |
| savePhoto      | 通过保存模式拉起photoPicker进行保存图片或视频资源的文件名，若无参数，则默认需要用户自行输入 |
| selectDocument | 通过选择模式拉起documentPicker界面，用户可以选择一个或多个文件              |
| saveDocument   | 通过保存模式拉起documentPicker界面，用户可以保存一个或多个文件              |
| selectAudio    | 通过选择模式拉起audioPicker界面，用户可以选择一个或多个音频文件               |
| saveAudio      | 通过保存模式拉起audioPicker界面，用户可以保存一个或多个音频文件               |

## PhotoHelper（相册相关,工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PhotoHelperPage.ets)

| 方法                           | 介绍                                     |
|:-----------------------------|:---------------------------------------|
| select                       | 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频 |
| save                         | 申请权限保存，保存图片或视频到相册。                     |
| showAssetsCreationDialog     | 弹窗授权保存，调用接口拉起保存确认弹窗。                   |
| showAssetsCreationDialogEasy | 弹窗授权保存，调用接口拉起保存确认弹窗，并保存。               |
| applyChanges                 | 安全控件保存，提交媒体变更请求，插入图片/视频。               |
| getPhotoAsset                | 获取对应uri的PhotoAsset对象,用于读取文件信息          |

## ImageUtil（图片相关工具类 ）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ImageUtilPage.ets)

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
| compressedImage           | 图片压缩                              |
| compressPhoto             | 图片压缩，返回压缩后的图片文件路径                 |

## SnapshotUtil（组件截图和窗口截图工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/SnapshotUtilPage.ets)

| 方法                     | 介绍                               |
|:-----------------------|:---------------------------------|
| get<br/>getSync        | 获取已加载的组件的截图，传入组件的组件id，找到对应组件进行截图 |
| createFromBuilder      | 在应用后台渲染CustomBuilder自定义组件，并输出其截图 |
| snapshot               | 获取窗口截图，使用Promise异步回调             |
| onSnapshotListener     | 开启系统截屏事件的监听                      |
| removeSnapshotListener | 关闭系统截屏事件的监听                      |

## PreviewUtil（文件预览工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PreviewUtilPage.ets)

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
| getTypeDescriptor   | 根据文件后缀名获取TypeDescriptor（标准化数据类型的描述类） |
| getMimeType         | 根据文件后缀名获取文件mimeType                  |
| getIconFileStr      | 根据文件后缀名获取对应文件类型的图标                   |

## ScanUtil（码工具类(扫码、码图生成、图片识码)）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ScanUtilPage.ets)

| 方法                    | 介绍                           |
|:----------------------|:-----------------------------|
| startScanForResult    | 调用默认界面扫码，使用Promise方式异步返回解码结果 |
| generateBarcode       | 码图生成，使用Promise异步返回生成的码图      |
| onPickerScanForResult | 通过picker拉起图库并选择图片,并调用图片识码    |
| onDetectBarCode       | 调用图片识码，使用Promise方式异步返回识码结果   |
| canIUseScan           | 判断当前设备是否支持码能力                |

## LocationUtil（定位工具类(WGS-84坐标系)）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/LocationUtilPage.ets)

| 方法                            | 介绍                    |
|:------------------------------|:----------------------|
| isLocationEnabled             | 判断位置服务是否已经使能(定位是否开启)。 |
| requestLocationPermissions    | 申请定位权限                |
| getCurrentLocationEasy        | 获取当前位置                |
| getCurrentLocation            | 获取当前位置                |
| onLocationChangeEasy          | 开启位置变化订阅，并发起定位请求。     |
| onLocationChange              | 开启位置变化订阅，并发起定位请求      |
| offLocationChange             | 关闭位置变化订阅，并删除对应的定位请求   |
| isGeocoderAvailable           | 判断地理编码与逆地理编码服务是否可用    |
| getAddressFromLocationName    | 地理编码,将地理描述转换为具体坐标     |
| getGeoAddressFromLocationName | 地理编码,将地理描述转换为具体坐标集合   |
| getAddressFromLocation        | 逆地理编码,将坐标转换为地理描述      |
| getGeoAddressFromLocation     | 逆地理编码,将坐标转换为地理描述集合    |
| getCountryCode                | 获取当前的国家码              |

## LogUtil（日志工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/LogUtilPage.ets)

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

## ResUtil（资源工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ResUtilPage.ets)

| 方法                                                  | 介绍                                                                 |
|:----------------------------------------------------|:-------------------------------------------------------------------|
| getResourceManager                                  | 获取提供访问应用资源的能力                                                      |
| getBoolean                                          | 获取指定资源对应的布尔结果                                                      |
| getBooleanByName                                    | 获取指定资源名称对应的布尔结果                                                    |
| getNumber                                           | 获取指定资源对应的integer数值或者float数值                                        |
| getNumberByName                                     | 获取指定资源名称对应的integer数值或者float数值                                      |
| getStringValue<br/>getStringSync                    | 获取指定资源对应的字符串                                                       |
| getStringByName<br/>getStringByNameSync             | 获取指定资源名称对应的字符串                                                     |
| getStringArrayValue<br/>getStringArrayValueSync     | 获取指定资源对应的字符串数组                                                     |
| getStringArrayByName<br/>getStringArrayByNameSync   | 获取指定资源名称对应的字符串数组                                                   |
| getPluralStringValue<br/>getPluralStringValueSync   | 根据指定数量获取指定resource对象表示的单复数字符串                                      |
| getPluralStringByName<br/>getPluralStringByNameSync | 根据指定数量获取指定资源名称表示的单复数字符串                                            |
| getColor<br/>getColorSync                           | 获取指定资源对应的颜色值（十进制）                                                  |
| getColorByName<br/>getColorByNameSync               | 获取指定资源名称对应的颜色值（十进制）                                                |
| getMediaContent<br/>getMediaContentSync             | 获取指定资源对应的默认或指定的屏幕密度媒体文件内容                                          |
| getMediaByName<br/>getMediaByNameSync               | 获取指定资源名称对应的默认或指定的屏幕密度媒体文件内容                                        |
| getMediaContentBase64<br/>getMediaContentBase64Sync | 获取指定资源ID对应的默认或指定的屏幕密度图片资源Base64编码                                  |
| getMediaBase64ByName<br/>getMediaBase64ByNameSync   | 获取指定资源名称对应的默认或指定的屏幕密度图片资源Base64编码                                  |
| getRawFileContent<br/>getRawFileContentSync         | 获取resources/rawfile目录下对应的rawfile文件内容                               |
| getRawFileContentStr<br/>getRawFileContentStrSync   | 获取resources/rawfile目录下对应的rawfile文件内容（字符串）                          |
| getRawFileList<br/>getRawFileListSync               | 获取resources/rawfile目录下文件夹及文件列表（若文件夹中无文件，则不返回；若文件夹中有文件，则返回文件夹及文件列表） |
| getRawFd                                            | 用户获取resources/rawfile目录下对应rawfile文件所在hap的descriptor信息              |
| closeRawFd<br/>closeRawFdSync                       | 用户关闭resources/rawfile目录下rawfile文件所在hap的descriptor信息                |
| addResource                                         | 应用运行时，加载指定的资源路径，实现资源覆盖                                             |
| removeResource                                      | 用户运行时，移除指定的资源路径，还原被覆盖前的资源                                          |
| isRawDir                                            | 用户判断指定路径是否是rawfile下的目录（true：表示是rawfile下的目录，false：表示不是rawfile下的目录）  |
| getConfiguration<br/>getConfigurationSync           | 获取设备的Configuration                                                 |
| getDeviceCapability<br/>getDeviceCapabilitySync     | 获取设备的DeviceCapability                                              |

## DateUtil（日期工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/DateUtilPage.ets)

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

## StrUtil（字符串工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/StrUtilPage.ets)

| 方法                 | 介绍                                    |
|:-------------------|:--------------------------------------|
| isNull             | 判断字符串是否为空(undefined、null)             |
| isNotNull          | 判断字符串是否为非空                            |
| isEmpty            | 判断字符串是否为空(undefined、null、字符串长度为0)     |
| isNotEmpty         | 判断字符串是否为非空                            |
| isBlank            | 判断字符串是否为空和空白符(空白符包括空格、制表符、全角空格和不间断空格) |
| isNotBlank         | 判断字符串是否为非空                            |
| replace            | 替换字符串中匹配的正则为给定的字符串                    |
| replaceAll         | 替换字符串中所有匹配的正则为给定的字符串                  |
| startsWith         | 判断字符串是否以给定的字符串开头                      |
| endsWith           | 判断字符串是否以给定的字符串结尾                      |
| repeat             | 将字符串重复指定次数                            |
| toLower            | 将整个字符串转换为小写                           |
| toUpper            | 将整个字符串转换为大写                           |
| capitalize         | 将字符串首字母转换为大写，剩下为小写                    |
| equal              | 判断两个传入的数值或者是字符串是否相等                   |
| notEqual           | 判断两个传入的数值或者是字符串是否不相等                  |
| strToUint8Array    | 字符串转Uint8Array                        |
| unit8ArrayToStr    | Uint8Array转字符串                        |
| strToBase64        | 字符串转Base64字符串                         |
| base64ToStr        | Base64字符串转字符串                         |
| strToBuffer        | 字符串转ArrayBuffer                       |
| bufferToStr        | ArrayBuffer转字符串                       |
| bufferToUint8Array | ArrayBuffer转Uint8Array                |
| unit8ArrayToBuffer | Uint8Array转ArrayBuffer                |
| getErrnoToString   | 获取系统错误码对应的详细信息                        |

## RegexUtil（正则工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/RegexUtilPage.ets)

| 方法      | 介绍                                |
|:--------|:----------------------------------|
| isPhone | 判断传入的电话号码格式是否正确                   |
| isMatch | 给定内容是否匹配正则（配合RegexUtil里的正则常量一起使用） |
| isEmail | 判断传入的邮箱格式是否正确                     |
| isEmoji | 判断字符串是否包含表情                       |

## FormatUtil（格式化工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/FormatUtilPage.ets)

| 方法                   | 介绍                          |
|:---------------------|:----------------------------|
| isPhone              | 判断传入的电话号码格式是否正确             |
| getPhoneFormat       | 对电话号码进行格式化                  |
| getPhoneLocationName | 获取电话号码归属地                   |
| transliterator       | 将输入字符串从源格式转换为目标格式（中文汉字转为拼音） |
| getIconFont          | 解析iconFont字符                |

## CharUtil（字符工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/CharUtilPage.ets)

| 方法           | 介绍                             |
|:-------------|:-------------------------------|
| isDigit      | 判断字符串char是否是数字                 |
| isLetter     | 判断字符串char是否是字母                 |
| isLowerCase  | 判断字符串char是否是小写字母               |
| isUpperCase  | 判断字符串char是否是大写字母               |
| isSpaceChar  | 判断字符串char是否是空格符                |
| isWhitespace | 判断字符串char是否是空白符                |
| isRTL        | 判断字符串char是否是从右到左语言的字符          |
| isIdeograph  | 判断字符串char是否是表意文字               |
| isBlankChar  | 判断是否空白符 空白符包括空格、制表符、全角空格和不间断空格 |
| isAscii      | 判断字符是否位于ASCII范围内（0~127）        |

## Base64Util（Base64工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/Base64UtilPage.ets)

| 方法                              | 介绍                           |
|:--------------------------------|:-----------------------------|
| decode<br/>encodeSync           | 解码，通过输入参数解码后输出对应Uint8Array对象 |
| encodeToStr<br/>encodeToStrSync | 编码，通过输入参数编码后输出对应文本           |
| encode<br/>decodeSync           | 编码，通过输入参数编码后输出Uint8Array对象   |

## NumberUtil（number工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/NumberUtilPage.ets)

| 方法       | 介绍         |
|:---------|:-----------|
| isNumber | 判断是否是数值    |
| toInt    | 将字符串转换为整数  |
| toFloat  | 将字符串转换为浮点数 |

## ArrayUtil（集合工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ArrayUtilPage.ets)

| 方法          | 介绍                          |
|:------------|:----------------------------|
| isNotEmpty  | 判断集合是否为非空集合                 |
| isEmpty     | 判断集合是否为空集合                  |
| removeEmpty | 去除字符串数组中的空值                 |
| trim        | 去除字符串数组的每个值的前后空格            |
| distinct    | 将数组去重，去重后生成新的数组，原数组不变       |
| reverse     | 将数组反转，会修改原始数组               |
| filter      | 数组过滤，通过filter函数实现来过滤返回需要的元素 |
| append      | 拼接数据，使用扩展运算符，不影响原数组。        |
| min         | 获取数组最小值（数值、字符串、日期）          |
| max         | 获取数组最大值（数值、字符串、日期）          |
| flatten     | 平铺二维数组                      |
| union       | 平铺二维数组，并去重                  |
| chunk       | 数组分块                        |

## RandomUtil（随机工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/RandomUtilPage.ets)

| 方法                       | 介绍                                            |
|:-------------------------|:----------------------------------------------|
| getRandomBoolean         | 生成随机Boolean值                                  |
| getRandomInt             | 生成随机整数（可指定范围）                                 |
| getRandomNumber          | 生成指定范围内的随机数                                   |
| getRandomLimit           | 生成指定范围内的随机数 [0,limit)                         |
| getRandomChineseChar     | 生成一个随机汉字                                      |
| getRandomChinese         | 生成随机汉字                                        |
| getRandomStr             | 根据指定字符串，随机生成 指定长度的字符串                         |
| getRandomDataBlob        | 生成随机指定长度的DataBlob                             |
| getRandomUint8Array      | 生成随机指定长度的Uint8Array                           |
| getRandomColor           | 生成随机颜色，十六进制                                   |
| generateUUID36           | 生成36位UUID，带-                                  |
| generateUUID32           | 生成32位UUID，带-                                  |
| generateRandomUUID       | 使用加密安全随机数生成器生成随机的RFC 4122版本4的string类型UUID     |
| generateRandomBinaryUUID | 使用加密安全随机数生成器生成随机的RFC 4122版本4的Uint8Array类型UUID |

## ObjectUtil（对象工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ObjectUtilPage.ets)

| 方法          | 介绍                                |
|-------------|:----------------------------------|
| getHash     | 获取对象的Hash值                        |
| isString    | 判断是否是String                       |
| isNull      | 判断对象是否为空                          |
| isEmpty     | 判断属性内容是否为空                        |
| shallowCopy | 浅拷贝                               |
| deepCopy    | 深度拷贝对象                            |
| assign      | 合并两个或多个对象                         |
| objToClass  | obj转class，解决obj as class后丢失方法的问题  |

## JSONUtil（JSON工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/JSONUtilPage.ets)

| 方法            | 介绍              |
|:--------------|:----------------|
| jsonToBean    | JSON字符串转Class对象 |
| jsonToArray   | JSON字符串转Array   |
| jsonToMap     | JSON转Map        |
| beanToJsonStr | 对象转字符串          |
| isJSONStr     | 判断是否是字符串格式json  |

## ClickUtil（节流、防抖 工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ClickUtilPage.ets)

| 方法       | 介绍                               |
|:---------|:---------------------------------|
| throttle | 节流：在一定时间内，只触发一次                  |
| debounce | 防抖：一定时间内，只有最后一次操作，再过wait毫秒后才执行函数 |

## CrashUtil（全局异常捕获，崩溃日志收集）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/CrashUtilPage.ets)

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

## PasteboardUtil（剪贴板工具类 ）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PasteboardUtilPage.ets)

| 方法                            | 介绍            |
|:------------------------------|:--------------|
| setDataText                   | 将纯文本数据写入系统剪贴板 |
| setDataHtml                   | 将Htm数据写入系统剪贴板 |
| setDataUri                    | 将Uri数据写入系统剪贴板 |
| getData<br/>getDataSync       | 读取系统剪贴板内容     |
| getDataStr<br/>getDataSyncStr | 读取系统剪贴板里的字符串  |
| hasData<br/>hasDataSync       | 判断系统剪贴板中是否有内容 |
| clearData                     | 清空系统剪贴板内容     |

## KeyboardUtil（键盘工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/KeyboardUtilPage.ets)

| 方法                     | 介绍                |
|:-----------------------|:------------------|
| show                   | 拉起键盘              |
| hide                   | 隐藏键盘              |
| onKeyboardListener     | 订阅输入法软键盘显示和隐藏事件   |
| removeKeyboardListener | 取消订阅输入法软键盘显示或隐藏事件 |

## NetworkUtil（网络相关工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/NetworkUtilPage.ets)

| 方法                | 介绍                         |
|:------------------|:---------------------------|
| hasDefaultNet     | 检查默认数据网络是否被激活              |
| hasDefaultNetSync | 检查默认数据网络是否被激活              |
| hasNetWiFi        | 判断当前网络是否是Wi-Fi，否则是移动流量热点网络 |
| getNetBearType    | 获取网络类型                     |
| getIpAddress      | 获取当前设备的IP地址(设备连接Wi-Fi后)    |
| register          | 订阅指定网络状态变化的通知，支持多事件监听回调    |
| unregister        | 取消订阅默认网络状态变化的通知            |

## AssetUtil（关键资产存储服务工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/AssetUtilPage.ets)

| 方法                    | 介绍          |
|:----------------------|:------------|
| add<br/>addSync       | 新增一条关键资产    |
| get<br/>getSync       | 查询关键资产      |
| remove<br/>removeSync | 删除关键资产      |
| canIUse               | 当前设备是否支持该模块 |

## TempUtil(温度转换工具类)[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/TempUtilPage.ets)

| 方法  | 介绍      |
|:----|:--------|
| F2C | 华氏度转摄氏度 |
| C2F | 摄氏度转华氏度 |

## DialogUtil（弹窗工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/DialogUtilPage.ets)

| 方法                 | 介绍          |
|:-------------------|:------------|
| setDefaultConfig   | 设置默认统一样式    |
| showConfirmDialog  | 显示弹窗（一个按钮）  |
| showPrimaryDialog  | 显示弹窗（两个按钮）  |
| showDialog         | 显示弹窗（可多个按钮） |
| showActionSheet    | 列表选择弹窗      |
| showCalendarPicker | 日历选择器弹窗     |
| showDatePicker     | 日期滑动选择器弹窗   |
| showTimePicker     | 时间滑动选择器弹窗   |
| showTextPicker     | 文本滑动选择器弹窗   |

## ToastUtil（吐司工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ToastUtilPage.ets)

| 方法               | 介绍               |
|:-----------------|:-----------------|
| setDefaultConfig | 设置默认统一样式         |
| showToast        | 弹出吐司，默认时长为2s     |
| showShort        | 弹出短吐司，默认时长为:1.5s |
| showLong         | 弹出长吐司，默认时长为:10s  |

## SM2（SM2加解密）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/crypto/SM2Page.ets)

| 方法                                          | 介绍                                        |
|:--------------------------------------------|:------------------------------------------|
| encrypt<br/>encryptSync                     | 加密                                        |
| decrypt<br/>decryptSync                     | 解密                                        |
| generateKeyPair<br/>generateKeyPairSync     | 生成非对称密钥KeyPair                            |
| getConvertKeyPair<br/>getConvertKeyPairSync | 获取转换的非对称密钥KeyPair                         |
| getSM2PubKey                                | 获取转换SM2公钥, 将C1C2C3格式的SM2公钥转换为鸿蒙所需的ASN.1格式 |
| getSM2PubKey                                | 获取转换SM2私钥                                 |
| getCipherTextSpec                           | 获取转换SM2密文格式，ASN.1格式转换为C1C2C3或C1C3C2       |
| sign<br/>signSync                           | 对数据进行签名                                   |
| verify<br/>verifySync                       | 对数据进行验签                                   |
| signSegment<br/>signSegmentSync             | 对数据进行分段签名                                 |
| verifySegment<br/>verifySegmentSync         | 对数据进行分段验签                                 |

## SM3（SM3工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/crypto/SM3Page.ets)

| 方法                                  | 介绍            |
|:------------------------------------|:--------------|
| digest<br/>digestSync               | SM3摘要         |
| digestSegment<br/>digestSegmentSync | SM3分段摘要       |
| hmac<br/>hmacSync                   | SM3消息认证码计算    |
| hmacSegment<br/>hmacSegmentSync     | SM3消息认证码计算，分段 |

## SM4（SM4加解密）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/crypto/SM4Page.ets)

| 方法                                          | 介绍           |
|:--------------------------------------------|:-------------|
| encrypt<br/>encryptSync                     | 加密           |
| decrypt<br/>decryptSync                     | 解密           |
| encryptGCM<br/>encryptGCMSync               | 加密（GCM模式）    |
| decryptGCM<br/>decryptGCMSync               | 解密（GCM模式）    |
| encryptCBC<br/>encryptCBCSync               | 加密（CBC模式）    |
| decryptCBC<br/>decryptCBCSync               | 解密（CBC模式）    |
| encryptECB<br/>encryptECBSync               | 加密（ECB模式）    |
| decryptECB<br/>decryptECBSync               | 解密（ECB模式）    |
| encryptGCMSegment<br/>encryptGCMSegmentSync | 加密（GCM模式）分段  |
| decryptGCMSegment<br/>decryptGCMSegmentSync | 解密（GCM模式）分段  |
| generateSymKey<br/>generateSymKeySync       | 生成对称密钥SymKey |

## AES（AES加解密）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/crypto/AESPage.ets)

| 方法                                          | 介绍           |
|:--------------------------------------------|:-------------|
| encrypt<br/>encryptSync                     | 加密           |
| decrypt<br/>decryptSync                     | 解密           |
| encryptGCM<br/>encryptGCMSync               | 加密（GCM模式）    |
| decryptGCM<br/>decryptGCMSync               | 解密（GCM模式）    |
| encryptCBC<br/>encryptCBCSync               | 加密（CBC模式）    |
| decryptCBC<br/>decryptCBCSync               | 解密（CBC模式）    |
| encryptECB<br/>encryptECBSync               | 加密（ECB模式）    |
| decryptECB<br/>decryptECBSync               | 解密（ECB模式）    |
| encryptGCMSegment<br/>encryptGCMSegmentSync | 加密（GCM模式）分段  |
| decryptGCMSegment<br/>decryptGCMSegmentSync | 解密（GCM模式）分段  |
| generateSymKey<br/>generateSymKeySync       | 生成对称密钥SymKey |

## DES（DES加解密）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/crypto/DESPage.ets)

| 方法                                    | 介绍           |
|:--------------------------------------|:-------------|
| encrypt<br/>encryptSync               | 加密           |
| decrypt<br/>decryptSync               | 解密           |
| encryptECB<br/>encryptECBSync         | 加密（ECB模式）    |
| decryptECB<br/>decryptECBSync         | 解密（ECB模式）    |
| encryptCBC<br/>encryptCBCSync         | 加密（CBC模式）    |
| decryptCBC<br/>decryptCBCSync         | 解密（CBC模式）    |
| generateSymKey<br/>generateSymKeySync | 生成对称密钥SymKey |

## RSA（RSA加解密）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/crypto/RSAPage.ets)

| 方法                                          | 介绍                     |
|:--------------------------------------------|:-----------------------|
| encrypt<br/>encryptSync                     | 加密                     |
| decrypt<br/>decryptSync                     | 解密                     |
| encryptSegment<br/>encryptSegmentSync       | 加密,分段                  |
| decryptSegment<br/>decryptSegmentSync       | 解密,分段                  |
| generateKeyPair<br/>generateKeyPairSync     | 生成非对称密钥KeyPair         |
| getConvertKeyPair<br/>getConvertKeyPairSync | 获取转换的非对称密钥KeyPair      |
| sign<br/>signSync                           | 对数据进行签名                |
| verify<br/>verifySync                       | 对数据进行验签                |
| signSegment<br/>signSegmentSync             | 对数据进行分段签名              |
| verifySegment<br/>verifySegmentSync         | 对数据进行分段验签              |
| recover<br/>recoverSync                     | 对数据进行签名恢复原始数据，目前仅RSA支持 |

## MD5（MD5工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/crypto/MD5Page.ets)

| 方法                                  | 介绍         |
|:------------------------------------|:-----------|
| digest<br/>digestSync               | MD5摘要      |
| digestSegment<br/>digestSegmentSync | MD5摘要，分段   |
| hmac<br/>hmacSync                   | 消息认证码计算    |
| hmacSegment<br/>hmacSegmentSync     | 消息认证码计算，分段 |

## SHA（SHA工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/crypto/SHAPage.ets)

| 方法                                  | 介绍         |
|:------------------------------------|:-----------|
| digest<br/>digestSync               | SHA摘要      |
| digestSegment<br/>digestSegmentSync | SHA摘要，分段   |
| hmac<br/>hmacSync                   | 消息认证码计算    |
| hmacSegment<br/>hmacSegmentSync     | 消息认证码计算，分段 |

## ECDSA（ECDSA工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/crypto/ECDSAPage.ets)

| 方法                                  | 介绍        |
|:------------------------------------|:----------|
| sign<br/>signSync                   | 对数据进行签名   |
| verify<br/>verifySync               | 对数据进行验签   |
| signSegment<br/>signSegmentSync     | 对数据进行分段签名 |
| verifySegment<br/>verifySegmentSync | 对数据进行分段验签 |

## CryptoUtil（加解密公用工具类，配合各个加密模块使用）

| 方法                                          | 介绍                |
|:--------------------------------------------|:------------------|
| encrypt<br/>encryptSync                     | 加密                |
| decrypt<br/>decryptSync                     | 解密                |
| generateSymKey<br/>generateSymKeySync       | 生成对称密钥SymKey      |
| getConvertSymKey<br/>getConvertSymKeySync   | 获取转换的对称密钥SymKey   |
| generateKeyPair<br/>generateKeyPairSync     | 生成非对称密钥KeyPair    |
| getConvertKeyPair<br/>getConvertKeyPairSync | 获取转换的非对称密钥KeyPair |
| getPemKeyPair                               | 获取指定数据生成非对称密钥     |
| generateIvParamsSpec                        | 生成IvParamsSpec    |
| getIvParamsSpec                             | 获取转换IvParamsSpec  |
| generateGcmParamsSpec                       | 生成GcmParamsSpec   |
| getGcmParamsSpec                            | 获取转换GcmParamsSpec |
| sign<br/>signSync                           | 对数据进行签名           |
| verify<br/>verifySync                       | 对数据进行验签           |
| signSegment<br/>signSegmentSync             | 对数据进行分段签名         |
| verifySegment<br/>verifySegmentSync         | 对数据进行分段验签         |
| dynamicKey<br/>dynamicKeySync               | 密钥协商              |
| digest<br/>digestSync                       | 摘要                |
| digestSegment<br/>digestSegmentSync         | 摘要，分段             |
| hmac<br/>hmacSync                           | 消息认证码计算           |
| hmacSegment<br/>hmacSegmentSync             | 消息认证码计算，分段        |

## CryptoHelper（加解密数据类型转换，配合各个加密模块使用）

| 方法                       | 介绍                    |
|:-------------------------|:----------------------|
| strToDataBlob            | 字符串转DataBlob          |
| dataBlobToStr            | DataBlob转字符串          |
| strToUint8Array          | 字符串转Uint8Array        |
| uint8ArrayToStr          | Uint8Array转字符串        |
| getSymKeyDataBlob        | 获取DataBlob类型的密钥       |
| getKeyDataBlob           | 获取DataBlob类型的公钥或私钥    |
| getRandomUint8Array      | 根据传入的大小生成随机Uint8Array |
| getUint8ArrayPaddingZero | Uint8Array补零操作        |
| toHexWithPaddingZero     | 补零操作                  |
| stringToHex              | 字符串转Hex字符串            |
| uint8ArrayToString       | 字节流转成可理解的字符串          |

## 🍎贡献代码与技术交流

使用过程中发现任何问题都可以提 [Issue](https://gitee.com/tongyuyan/harmony-utils/issues)给我们；   
当然，我们也非常欢迎你给我们发 [PR](https://gitee.com/tongyuyan/harmony-utils/pulls) 。

[https://gitee.com/tongyuyan/harmony-utils](https://gitee.com/tongyuyan/harmony-utils)   
[https://github.com/787107497](https://github.com/787107497)

鸿蒙技术交流QQ群：569512366

## 🌞友情推荐

#### [《ArkUI实战》](https://www.arkui.club)深入浅出介绍鸿蒙应用开发，帮助数百万开发者学习鸿蒙与仓颉。

#### [CjCalendar](https://ohpm.openharmony.cn/#/cn/detail/cjcalendar) 是一款日常开发常用的日历组件，内部集成常规、单选、时间范围选择、多选、自定义日期每项显示等。

#### [鸿蒙NEXT实战教程](https://www.bilibili.com/cheese/play/ss25125) 鸿蒙next实战教学，不废话，手把手教你从零开始搭建获得next模拟器资格和查阅文档，学习当下最新的next技术；[鸿蒙next ArkUI 技术博客专栏](https://juejin.cn/column/7308434349426556979)旨在分享鸿蒙next最前沿的技术博客 ，希望广大群友能愉快的学习鸿蒙next开发。

## 🌏开源协议

本项目基于 [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.html) ，在拷贝和借鉴代码时，请大家务必注明出处。
