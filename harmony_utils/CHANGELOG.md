# 版本记录

## 1.2.5（API12 - 5.0.3.906）
1. 新增LRUCacheUtil工具类。
2. 优化CacheUtil工具类 和 GlobalContext工具类。
3. DateUtil：getFormatDate方法格式化时间可能异常的Bug修复。
4. 代码优化。

## 1.2.4（API12 - 5.0.3.906）
1. RandomUtil：新增getRandomDataBlob() 和 getRandomColor()的Bug修复。
2. ObjectUtil：新增shallowCopy()、assign() 和 优化deepCopy()。

## 1.2.3（API12 - 5.0.3.906）
1. DES，代码优化。   

## 1.2.2（API12 - 5.0.3.906）
1. PreferencesUtil，getString、getNumber、getBoolean方法添加defValue默认参数。    
2. EmitterUtil，适配新的API，优化代码。    
3. ImageUtil，优化代码；新增compressPhoto方法，图片压缩，返回压缩后的图片文件路径。    

## 1.2.1（API12 - 5.0.3.900）
1. 优化代码。
2. 导出KvUtil。
3. 修改useNormalizedOHMUrl为false。

## 1.2.0（API12 - 5.0.3.900）（慎用，请使用1.2.1）
1. DateUtil，修复1.1.0版本中的日期格式化异常的Bug。
2. NotificationUtil：       
   1、修复boolean默认参数可能异常的Bug。       
   2、新增getCompressedPicture方法，压缩通知的图片（图像像素的总字节数不能超过2MB）。       
   3、新增getCompressedIcon方法，获取压缩通知图标（图标像素的总字节数不超过192KB）。
3. SnapshotUtil，添加同步方法getSync，适配新的API；以及添加系统截图监听。
4. PreferencesUtil，适配新的API，添加订阅数据变更。
5. ImageUtil，添加图片压缩方法。
6. ArrayUtil，添加chunk方法。
7. KeyboardUtil，添加show方法 主动拉起键盘；适配新的API，重构其他方法；废弃部分方法。
8. DialogUtil，优化代码，适配新的API，重构方法；废弃部分方法。
9. AppUtil:       
   1、优化init方法，1.1.0版本后，在UIAbility的onCreate方法中初始化该方法。    
   2、新增setGrayScale方法，设置灰阶，APP一键置灰。       
   3、新增getWindowStage方法。    
   4、toAppSetting、toNetworkSetting、toNotificationSetting、toBluetoothSetting、toNfcSetting、toWebBrowser、toAppGalleryDetail、toFileManagement、等方法迁移到WantUtil。
10. FileUtil，getRawFileContent、getRawFileContentSync、getRawFileContentStr、getRawFileContentStrSync、等方法迁移到ResUtil。
11. StrUtil：    
    1、isMatch、isEmail、isEmoji、等方法迁移到RegexUtil。    
    2、isPhone、getPhoneFormat、getPhoneLocationName、等方法迁移到FormatUtil。
12. 新增KvUtil，键值型数据库工具类。
13. 新增WantUtil，Want相关工具类。
14. 新增ResUtil，资源相关工具类。
15. 新增RegexUtil，正则相关工具类。
16. 新增FormatUtil，格式化相关工具类。    

## 1.1.0（API12 - 5.0.3.800）
1. DateUtil，代码优化，兼容支持字符串时间戳。
2. EmitterUtil，新增参数，支持事件被发送的优先级。
3. LocationUtil，定位代码优化，添加错误code返回，用于判断错误类型。

## 1.0.9（API12 - Beta5 - 5.0.3.700）    
1.  规避代码风险:    
    1、重构CacheUtil        
    2、重构RandomUtil    
    3、优化部分方法    
2. 优化文档。    

## 1.0.8（API12 - Beta5 - 5.0.3.700）
1.  PermissionUtil:    
    1、新增requestPermissionsEasy，申请授权，拒绝后并二次向用户申请授权（申请权限，建议使用该方法）。    
    2、新增requestPermissionOnSetting，二次向用户申请授权（单个权限 或 读写权限组，建议使用该方法）。    
    3、新增requestPermissionOnSettingEasy，二次向用户申请授权（多个权限建议使用该方法）。    
    4、废弃requestPermissionsList。   
    5、温馨提示，废弃requestPermissionsList方法，使用新增的requestPermissionsEasy方法替代。
2. NotificationUtil:    
   1、新增setDefaultConfig，设置通知的默认统一配置。    
   2、新增isNotificationEnabled，查询通知是否授权。    
   3、新增isSupportTemplate，查询模板是否存在，目前仅支持进度条模板。    
   4、新增isDistributedEnabled，查询设备是否支持分布式通知。    
   5、新增publishTemplate，发布模板通知。    
   6、新增cancelGroup，取消本应用指定组下的通知。    
   7、新增addSlot，创建指定类型的通知渠道。    
   8、新增getSlot，获取一个指定类型的通知渠道。    
   9、新增getSlots，获取此应用程序的所有通知渠道。        
   10、新增removeSlot，删除此应用程序指定类型的通知渠道。    
   11、新增removeAllSlots，删除此应用程序所有通知渠道。        
   12、新增generateNotificationId，生成通知id（用时间戳当id）。    
   13、新增getDefaultWantAgent，创建一个可拉起Ability的Want。
3. ObjectUtil新增objToClass（obj转class，解决obj as class后丢失方法的问题）。

## 1.0.7 （API12 - Dev: 5.0.3.500）
1. 新增加解密，SM2、SM3、SM4、AES、DES、RSA、MD5、SHA、ECDSA、CryptoUtil、CryptoHelper。   
2. 新增EmitterUtil工具类。
3. DialogUtil，适配API12新增支持拦截系统返回键和新增setDefaultConfig设置默认统一样式。     
4. ToastUtil，新增setDefaultConfig设置默认统一样式。   
5. DateUtil，Bug修复。 
6. ClickUtil，优化代码。
7. PreferencesUtil，优化代码。
8. 废弃模块（给大家带来不便，非常抱歉；后面弹框这块将单独成库）：   
    1、WindowUtil。   
    2、ActionUtil。   
    3、自定义弹框,AlertControlDialog、ConfirmControlDialog、LoadingControlDialog、SelectControlDialog、TipControlDialog。   

## 1.0.6 （API12 - Dev: 5.0.3.500）
1. ToastUtil，调整Toast居中显示 和 修复Toast不显示Bug。

## 1.0.5 （API12 - Dev: 5.0.3.500）
1. 升级和适配API12，Dev版本5.0.3.500。      
2. 新增AssetUtil工具类。   
3. PreferencesUtil新增同步方法。   
4. DeviceUtil：    
   1、getDeviceId，改为同步方法。        
   2、deleteDeviceId，改为同步方法。   
5. FileUtil：   
   1、新增方法，getFileDirSize（获取文件和文件夹的大小）。        
   2、getFilesDirPath、getCacheDirPath、getTempDirPath工具方法，新增blHap参数（true：HAP级别文件路径、 false：App级别文件路径）。   

## 1.0.4
1. AppUtil：   
   1、优化代码与Bug修复，尽可能处理预览问题。     
   2、新增方法，getBundleName()、getVersionCode()、getVersionName()、getTargetVersion()、toWebBrowser()、toAppGalleryDetail()、toFileManagement()、exit()。
2. DeviceUtil：      
   1、新增方法，getBrand()、getProductModel()、getOsReleaseType()、getOsFullName()、getDisplayVersion()、getSdkApiVersion()、getBuildVersion()、getODID()。
3. DisplayUtil：    
   1、优化代码与Bug修复。
4. ObjectUtil：   
   1、新增方法，getHash()。
5. StrUtil：     
   1、新增方法，replaceAll()、isPhone()、getPhoneFormat()、getPhoneLocationName()、isMatch()、isEmail()、getErrnoToString()。
6. DateUtil：   
   1、新增若干方法。
7. 弹框Dialog调整为默认居中显示。
8. 添加字符工具类，CharUtil。

## 1.0.3
1. DeviceUtil：   
   1、getDeviceId()，修复该方法Bug,并调整入参。   
   2、添加删除设备ID方法，deleteDeviceId()。
2. CrashUtil：   
   1、onExportErrorLog(),修复该方法，文件导出Bug。
3. PickerUtil：   
   1、Bug修复。  
   2、拆分相册功能方法到PhotoHelper。
4. 新增PhotoHelper，后续会增加相册相关方法。
5. 优化代码，导出模块类。

## 1.0.2
1. 添加NetworkUtil工具类。   
2. 添加PreviewUtil工具类。   
3. 在AppUtil添加跳转常用设置页面方法。   
4. 优化代码。     

## 1.0.1
1. 修复‘PickerUtil’的Bug。   
2. 修复‘PreferencesUtil’的Bug。   
3. 优化代码。   

## 1.0.0 初版
1. 发布1.0.0初版。    