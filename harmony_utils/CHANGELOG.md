# 版本记录
## 1.0.7 （API12 - Dev: 5.0.3.500）
1. 11
2. 
2. DialogUtil，适配API12和新增setDefaultConfig设置默认统一样式。
2. ToastUtil,新增setDefaultConfig设置默认统一样式。
3. 废弃模块（给大家带来不便，非常抱歉；后面弹框这块将单独成库）：   
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