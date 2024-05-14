
# <center>harmony-utils</center>
# <center>V1.0.0(API11)</center>

--------------------------------------------------------------------------------


## 📚简介
harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。


## 📚下载安装
`ohpm install @pura/harmony-utils`

OpenHarmony ohpm 环境配置等更多内容，请参考[如何安装 OpenHarmony ohpm 包](https://gitee.com/openharmony-tpc/docs/blob/master/OpenHarmony_har_usage.md)


## 📚模块介绍
| 模块                   | 介绍                          |
|:---------------------|:----------------------------|
| ActionUtil           | 弹窗工具类（promptAction）         |
| DialogUtil           | 弹窗工具类（AlertDialog）          |
| ToastUtil            | 土司工具类（promptAction）         |
| AppUtil              | 设备相关工具类                     |
| PreferencesUtil      | Preferences（用户首选项）工具类       |
| PermissionUtil       | 申请授权工具类                     |
| NotificationUtil     | 通知工具类                       |
| AuthUtil             | 手机的生物认证（指纹、人脸、密码）工具类        |
| LocationUtil         | 定位工具类(WGS-84坐标系)            |
| FilePickerUtil       | 拍照、文件(文件、图片、视频、音频)选择和保存,工具类 |
| FileUtil             | 文件操作相关工具类                   |
| PasteboardUtil       | 剪贴板工具类                      |
| DisplayUtil          | 屏幕相关工具类                     |
| SnapshotUtil         | 组件截图和窗口截图工具类                |
| ScanUtil             | 码工具类（扫码、码图生成、图片识码）          |
| ImageUtil            | 图片相关工具类                     |
| KeyboardUtil         | 键盘工具类                       |
| LogUtil              | 日志工具类                       |
| CrashUtil            | 全局异常捕获，崩溃日志收集               |
| StrUtil              | 字符串工具类                      |
| Base64Util           | Base64工具类                   |
| NumberUtil           | number工具类                   |
| DateUtil             | 日期工具类                       |
| ArrayUtil            | 数组工具类                       |
| RandomUtil           | 随机工具类                       |
| CacheUtil            | 缓存工具类                       |
| ClickUtil            | 节流、防抖 工具类（用于点击事件，防止按钮被重复点击） |
| TempUtil             | 温度转换工具类，华氏度与摄氏度相互转换         |
| WindowUtil           | 窗口工具类                       |
| AlertControlDialog   | 操作确认类弹出框                    |
| ConfirmControlDialog | 信息确认类弹出框                    |
| LoadingControlDialog | 进度加载类弹出框                    |
| SelectControlDialog  | 选择类弹出框                      |
| TipControlDialog     | 提示弹出框                       |


## 📚API详解

### ActionUtil
| 方法                 | 介绍           |
|:-------------------|:-------------|
| showConfirmDialog  | 显示弹窗（一个按钮）   |
| showPrimaryDialog  | 显示弹窗（两个按钮）   |
| showDialog         | 显示弹窗（多个按钮）   |
| showActionMenuEasy | 显示操作菜单（简单易用） |
| showActionMenu     | 显示操作菜单       |


### DialogUtil
| 方法                  | 介绍               |
|:--------------------|:-----------------|
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
| showCalendarPicker  | 日历选择器弹窗          |


### ToastUtil
| 方法        | 介绍               |
|:----------|:-----------------|
| showToast | 弹出土司，默认时长为2s     |
| showShort | 弹出短土司，默认时长为:1.5s |
| showLong  | 弹出长土司，默认时长为:10s  |


### AppUtil
| 方法                           | 介绍                                                                |
|:-----------------------------|:------------------------------------------------------------------|
| cacheWindowStage             | 缓存窗口管理器，在UIAbility的onWindowStageCreate方法中初始化该方法                   |
| getMainWindow                | 获取主窗口                                                             |
| getUIContext                 | 获取UIContext                                                       |
| getWindowProperties          | 获取当前窗口的属性                                                         |
| getKeyboardAvoidMode         | 获取虚拟键盘抬起时的页面避让模式（OFFSET-上抬模式、RESIZE-压缩模式）                         |
| setKeyboardAvoidMode         | 设置虚拟键盘弹出时，页面的避让模式                                                 |
| isPortrait                   | 设备当前是否以竖屏方式显示（竖屏、反向竖屏）                                            |
| isLandscape                  | 设备当前是否以横屏方式显示（横屏、反向横屏）                                            |
| setPreferredOrientation      | 设置窗口的显示方向属性                                                       |
| setWindowBrightness          | 设置屏幕亮度值                                                           |
| setWindowKeepScreenOn        | 设置屏幕是否为常亮状态                                                       |
| setWindowPrivacyMode         | 设置窗口是否为隐私模式。设置为隐私模式的窗口，窗口内容将无法被截屏或录屏                              |
| setWindowBackgroundColor     | 设置窗口的背景色。Stage模型下，该接口需要在loadContent()或setUIContent()调用生效后使用       |
| setWindowFocusable           | 设置点击时是否支持切换焦点窗口                                                   |
| setWindowTouchable           | 设置窗口是否为可触状态                                                       |
| getCutoutHeight              | 获取挖孔屏、刘海屏等不可用屏幕的状态栏的高度，单位为px                                      |
| getNavigationIndicatorHeight | 获取底部导航条的高度，单位为px。                                                 |
| setStatusBar                 | 设置沉浸式状态栏                                                          |
| enableAppRecovery            | 启用应用恢复功能，参数按顺序填入。该接口调用后，应用从启动器启动时第一个Ability支持恢复。                  |
| restartApp                   | 重启APP，并拉起应用启动时第一个Ability，可以配合errorManager相关接口使用                   |
| saveAppState                 | 保存当前App状态 或 主动保存Ability的状态，这个状态将在下次恢复启动时使用。可以配合errorManager相关接口使用 |
| setRestartWant               | 设置下次恢复主动拉起场景下的Ability。该Ability必须为当前包下的UIAbility                   |
| startVibration               | 开启振动                                                              |
| stopVibration                | 停止振动（按照VIBRATOR_STOP_MODE_TIME模式）                                 |
| getBundleInfo                | 获取当前应用的BundleInfo                                                 |
| getAppInfo                   | 获取应用程序的配置信息                                                       |


### PreferencesUtil
| 方法         | 介绍                     |
|:-----------|:-----------------------|
| put        | 将数据缓存                  |
| get        | 获取缓存值                  |
| getString  | 获取string类型的缓存值         |
| getNumber  | 获取number类型的缓存值         |
| getBoolean | 获取boolean类型的缓存值        |
| has        | 检查缓存实例中是否包含给定Key的存储键值对 |
| delete     | 删除缓存值                  |
| clear      | 清空缓存                   |


### PermissionUtil
| 方法                      | 介绍           |
|:------------------------|:-------------|
| checkPermissions        | 校验当前是否已经授权   |
| checkRequestPermissions | 校验是否授权后并申请授权 |
| requestPermissions      | 申请授权         |
| requestPermissionsList  | 申请组合授权       |
| toAppSetting            | 跳转应用设置页面     |


### NotificationUtil
| 方法                            | 介绍                                             |
|:------------------------------|:-----------------------------------------------|
| authorizeNotification         | 校验是否已授权通知服务                                    |
| publishBasic                  | 发布普通文本通知                                       |
| publishMultiLine              | 发布多文本通知（该方法为OpenHarmony的API,目前暂不支持HarmonyOS）   |
| publishLongText               | 发布长文本通知（该方法为OpenHarmony的API,目前暂不支持HarmonyOS）   |
| publishPicture                | 发布带有图片的通知（该方法为OpenHarmony的API,目前暂不支持HarmonyOS） |
| cancel                        | 取消通知                                           |
| cancelAll                     | 取消所有通知                                         |
| setBadge                      | 设置桌面角标个数                                       |
| clearBadge                    | 清空桌面角标                                         |
| setBadgeFromNotificationCount | 设置桌面角标数量，来自于通知数量                               |
| getActiveNotificationCount    | 获取当前应用未删除的通知数量                                 |
| getActiveNotifications        | 获取当前应用未删除的通知列表                                 |


### AuthUtil
| 方法                 | 介绍                 |
|:-------------------|:-------------------|
| getAvailableStatus | 查询指定类型和等级的认证能力是否支持 |
| onStartEasy        | 开始认证,使用指纹和密码认证     |
| onStart            | 开始认证，用户指定类型认证      |
| cancel             | 取消认证               |


### LocationUtil
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


### FilePickerUtil
| 方法             | 介绍                                                  |
|:---------------|:----------------------------------------------------|
| camera         | 调用系统相机，拍照、录视频                                       |
| selectPhoto    | 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频              |
| savePhoto      | 通过保存模式拉起photoPicker进行保存图片或视频资源的文件名，若无参数，则默认需要用户自行输入 |
| selectDocument | 通过选择模式拉起documentPicker界面，用户可以选择一个或多个文件              |
| saveDocument   | 通过保存模式拉起documentPicker界面，用户可以保存一个或多个文件。             |
| selectAudio    | 通过选择模式拉起audioPicker界面，用户可以选择一个或多个音频文件               |
| saveAudio      | 通过保存模式拉起audioPicker界面，用户可以保存一个或多个音频文件。              |
| getPhotoAsset  | 获取对应uri的PhotoAsset对象,用于读取文件信息                       |


### FileUtil
| 方法                | 介绍                                     |
|:------------------|:---------------------------------------|
| getFilesDirOrPath | 获取文件目录下的文件夹路径或文件路径                     |
| getCacheDirOrPath | 获取缓存目录下的文件夹路径或文件路径                     |
| getTempDirOrPath  | 获取临时目录下的文件夹路径或文件路径                     |
| getFileUri        | 通过URI或路径，获取FileUri                     |
| getFileName       | 通过URI或路径，获取文件名                         |
| getFilePath       | 通过URI或路径，获取文件路径                        |
| getParentUri      | 通过URI或路径，获取对应文件父目录的URI                 |
| getParentPath     | 通过URI或路径，获取对应文件父目录的路径名                 |
| getUriFromPath    | 以同步方法获取文件URI                           |
| isFile            | 判断文件是否是普通文件                            |
| isDirectory       | 判断文件是否是目录                              |
| rename            | 重命名文件或文件夹，使用Promise异步回调                |
| renameSync        | 重命名文件或文件夹，以同步方法                        |
| mkdir             | 创建目录，当recursion指定为true，可多层级创建目录        |
| mkdirSync         | 创建目录以同步方法，当recursion指定为true，可多层级创建目录   |
| rmdir             | 删除整个目录，使用Promise异步回调                   |
| rmdirSync         | 删除整个目录，以同步方法                           |
| unlink            | 删除单个文件，使用Promise异步回调                   |
| unlinkSync        | 删除单个文件，以同步方法                           |
| access            | 检查文件是否存在，使用Promise异步回调                 |
| accessSync        | 检查文件是否存在，以同步方法                         |
| open              | 打开文件，支持使用URI打开文件                       |
| openSync          | 打开文件，支持使用URI打开文件                       |
| read              | 从文件读取数据                                |
| readSync          | 从文件读取数据                                |
| readText          | 基于文本方式读取文件（即直接读取文件的文本内容）               |
| readTextSync      | 基于文本方式读取文件（即直接读取文件的文本内容）               |
| write             | 将数据写入文件                                |
| writeSync         | 将数据写入文件                                |
| writeEasy         | 将数据写入文件，并关闭文件                          |
| close             | 关闭文件                                   |
| closeSync         | 关闭文件                                   |
| listFile          | 列出文件夹下所有文件名，支持递归列出所有文件名（包含子目录下），支持文件过滤 |
| listFileSync      | 列出文件夹下所有文件名，支持递归列出所有文件名（包含子目录下），支持文件过滤 |
| stat              | 获取文件详细属性信息                             |
| statSync          | 获取文件详细属性信息                             |
| copy              | 拷贝文件或者目录，支持拷贝进度监听                      |
| copyFile          | 复制文件                                   |
| copyFileSync      | 以同步方法复制文件                              |
| moveFile          | 移动文件                                   |
| moveFileSync      | 移动文件，以同步方法                             |
| moveDir           | 移动源文件夹至目标路径下                           |
| moveDirSync       | 以同步方法移动源文件夹至目标路径下                      |
| truncate          | 截断文件                                   |
| truncateSync      | 截断文件，以同步方法                             |
| lstat             | 获取链接文件信息                               |
| lstatSync         | 获取链接文件信息，以同步方法                         |
| fsync             | 同步文件数据                                 |
| fsyncSync         | 同步文件数据，以同步方法                           |
| fdatasync         | 实现文件内容数据同步                             |
| fdatasyncSync     | 实现文件内容数据同步，以同步方法                       |
| createStream      | 基于文件路径打开文件流                            |
| createStreamSync  | 基于文件路径打开文件流，以同步方法                      |
| fdopenStream      | 基于文件描述符打开文件流                           |
| fdopenStreamSync  | 基于文件描述符打开文件流，以同步方法                     |
| mkdtemp           | 创建临时目录                                 |
| mkdtempSync       | 创建临时目录，以同步的方法                          |
| dup               | 将文件描述符转化为File                          |
| utimes            | 修改文件最近访问时间属性                           |
| getFormatFileSize | 格式化文件大小                                |


### PasteboardUtil
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


### DisplayUtil
| 方法                    | 介绍                                                  |
|:----------------------|:----------------------------------------------------|
| getDefaultDisplaySync | 获取当前默认的display对象                                    |
| getWidth              | 获取设备的屏幕宽度，单位为px                                     |
| getHeight             | 获取设备的屏幕高度，单位为px                                     |
| getOrientation        | 获取设备当前显示的方向                                         |
| getDisplayState       | 获取设备的状态                                             |
| getCutoutInfo         | 获取取挖孔屏、刘海屏、瀑布屏等不可用屏幕区域信息。使用Promise异步回调。建议应用布局规避该区域。 |
| getCutoutHeight       | 获取挖孔屏、刘海屏等不可用屏幕区域的高度。                               |
| isFoldable            | 检查设备是否可折叠                                           |
| getFoldStatus         | 获取可折叠设备的当前折叠状态                                      |
| getFoldDisplayMode    | 获取可折叠设备的显示模式                                        |
| onFoldStatusChange    | 开启折叠设备折叠状态变化的监听                                     |
| offFoldStatusChange   | 关闭折叠设备折叠状态变化的监听                                     |


### SnapshotUtil
| 方法                | 介绍                                             |
|:------------------|:-----------------------------------------------|
| get               | 获取已加载的组件的截图，传入组件的组件id，找到对应组件进行截图。通过Promise返回结果 |
| createFromBuilder | 在应用后台渲染CustomBuilder自定义组件，并输出其截图               |
| snapshot          | 获取窗口截图，使用Promise异步回调                           |


### ScanUtil
| 方法                    | 介绍                           |
|:----------------------|:-----------------------------|
| startScanForResult    | 调用默认界面扫码，使用Promise方式异步返回解码结果 |
| generateBarcode       | 码图生成，使用Promise异步返回生成的码图      |
| onPickerDetectBarCode | 通过picker拉起图库并选择图片,并调用图片识码    |
| onDetectBarCode       | 调用图片识码，使用Promise方式异步返回识码结果   |


### ImageUtil
| 方法                        | 介绍                        |
|:--------------------------|:--------------------------|
| base64ToPixelMap          | 图片base64字符串转PixelMap      |
| pixelMapToBase64Str       | PixelMap转图片base64字符串      |
| savePixelMap              | 保存pixelMap到本地             |
| saveImageSource           | 保存ImageSource到本地          |
| createImageSource         | 创建图片源实例                   |
| createIncrementalSource   | 以增量的方式创建图片源实例             |
| packingFromPixelMap       | 图片压缩或重新打包，使用Promise形式返回结果 |
| packingFromPixelMap       | 图片压缩或重新打包，使用Promise形式返回结果 |
| packToFileFromPixelMap    | 将PixelMap图片源编码后直接打包进文件    |
| packToFileFromImageSource | 将ImageSource图片源编码后直接打包进文件 |


### KeyboardUtil
| 方法                     | 介绍                |
|:-----------------------|:------------------|
| hide                   | 隐藏键盘              |
| onKeyboardListener     | 订阅输入法软键盘显示和隐藏事件   |
| removeKeyboardListener | 取消订阅输入法软键盘显示或隐藏事件 |
| onInputTextChanged     | 订阅文本内容变化          |
| removeInputTextChanged | 取消订阅文本内容变化        |


### LogUtil
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


### CrashUtil
| 方法               | 介绍                                                    |
|:-----------------|:------------------------------------------------------|
| onError          | 注册错误观测器。注册后可以捕获到应用产生的js crash，应用崩溃时进程不会退出。将异常信息写入本地文件 |
| offError         | 注销错误观测器                                               |
| onExportErrorLog | 导出错误日志文件                                              |


### StrUtil
| 方法                 | 介绍                                    |
|:-------------------|:--------------------------------------|
| isNull             | 字符串是否为空(undefined、null)               |
| isNotNull          | 判断字符串是否为非空                            |
| isEmpty            | 字符串是否为空(undefined、null、字符串长度为0)       |
| isNotEmpty         | 判断字符串是否为非空                            |
| isBlank            | 判断字符串是否为空和空白符(空白符包括空格、制表符、全角空格和不间断空格) |
| isNotBlank         | 判断字符串是否为非空                            |
| replace            | 替换字符串中匹配的正则为给定的字符串                    |
| startsWith         | 检查字符串是否以给定的字符串开头                      |
| endsWith           | 检查字符串是否以给定的字符串结尾                      |
| repeat             | 将字符串重复指定次数                            |
| toLower            | 转换整个字符串的字符为小写                         |
| toUpper            | 转换整个字符串的字符为大写                         |
| capitalize         | 转换字符串首字母为大写，剩下为小写                     |
| trim               | 去除传入集合的每个值的前后空格                       |
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


### Base64Util
| 方法              | 介绍                           |
|:----------------|:-----------------------------|
| encodeSync      | 编码，通过输入参数编码后输出Uint8Array对象   |
| encodeToStrSync | 编码，通过输入参数编码后输出对应文本           |
| decodeSync      | 解码，通过输入参数解码后输出对应Uint8Array对象 |
| encode          | 编码，通过输入参数编码后输出Uint8Array对象   |
| encodeToStr     | 编码，通过输入参数编码后输出对应文本           |
| decode          | 解码，通过输入参数解码后输出对应Uint8Array对象 |


### NumberUtil
| 方法       | 介绍         |
|:---------|:-----------|
| isNumber | 判断是否是数值    |
| toInt    | 将字符串转换为整数  |
| toFloat  | 将字符串转换为浮点数 |


### DateUtil
| 方法               | 介绍                         |
|:-----------------|:---------------------------|
| getToday         | 获取今天的日期                    |
| getTodayTime     | 获取今天的时间戳                   |
| getTodayStr      | 获取今天的时间，字符串类型              |
| getFormatDate    | 获取格式化日期，将传入的日期格式化为Date     |
| getFormatDateStr | 获取格式化日期，将传入的日期格式化为指定格式的字符串 |
| getTipDateStr    | 格式化时间戳，获取提示性时间字符串          |
| getDateDiff      | 获取两个Date的日期差单位为天           |


### ArrayUtil
| 方法          | 介绍                                 |
|:------------|:-----------------------------------|
| isNotEmpty  | 集合是否为非空集合                          |
| isEmpty     | 集合是否为空集合                           |
| removeEmpty | 去除集合中的空值                           |
| distinct    | 数组去重，去重后生成新的数组，原数组不变               |
| reverse     | 反转数组，会修改原始数组                       |
| filter      | 通过传入的filter实现来过滤返回需要的元素            |
| append      | 将新元素添加到已有数组中 添加新元素会生成一个新的数组，不影响原数组 |
| setOrAppend | 将元素值设置为数组的某个位置，当给定的index大于数组长度，则追加 |
| min         | 获取数组（数值、字符串、日期）最小值                 |
| max         | 获取数组（数值、字符串、日期）最大值                 |
| flatten     | 平铺二维数组                             |
| union       | 平铺二维数组，并去重                         |


### RandomUtil
| 方法             | 介绍                    |
|:---------------|:----------------------|
| randomInt      | 生成随机数number值          |
| randomLimit    | 生成指定范围内的随机数 [0,limit) |
| randomNumber   | 生成指定范围内的随机数           |
| randomBoolean  | 生成随机Boolean值          |
| randomStr      | 根据指定字符串，随机生成指定长度的字符串  |
| randomChinese  | 生成随机汉字                |
| randomColor    | 生成随机颜色，十六进制           |
| generateUUID36 | 生成36位UUID，带-          |
| generateUUID32 | 生成32位UUID，带-          |


### CacheUtil
| 方法     | 介绍    |
|:-------|:------|
| save   | 存值    |
| get    | 取值    |


### ClickUtil
| 方法       | 介绍                               |
|:---------|:---------------------------------|
| throttle | 节流：在一定时间内，只触发一次                  |
| debounce | 防抖：一定时间内，只有最后一次操作，再过wait毫秒后才执行函数 |


### TempUtil
| 方法  | 介绍      |
|:----|:--------|
| F2C | 华氏度转摄氏度 |
| C2F | 摄氏度转华氏度 |


## 📚示例代码
 ```
 new HttpUtils().download('https://count.liqucn.com/d.php?id=725672&urlos=android&from_type=web',
            'xUtils/hsh.apk', null)
            
            
 ```

## 📚仓库地址
`https://gitee.com/tongyuyan/harmony-utils`


## 💖后续计划
1、持续优化和添加更多的实用方法与功能（网络相关、语音、文字识别、router、图片相关、扫码）。
2、添加新的模块（悬浮窗、加载动画、JSBridge）。


## 💖技术交流
![QQ群：569512366](Picture/group_qrcode.jpg)


## 🙏贡献代码
使用过程中发现任何问题都可以提 [Issue](https://gitee.com/tongyuyan/harmony-utils/issues) 给我们，当然，我们也非常欢迎你给我们发 [PR](https://gitee.com/tongyuyan/harmony-utils/pulls) 。


## 📚开源协议
本项目基于 [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.html) ，请自由地享受和参与开源。

