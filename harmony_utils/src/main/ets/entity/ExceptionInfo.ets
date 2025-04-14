import { AppUtil } from '../utils/AppUtil';
import { DeviceUtil } from '../utils/DeviceUtil';
import { systemDateTime } from '@kit.BasicServicesKit';

/**
 * 异常信息对象
 */
export class ExceptionInfo {

  constructor(name: string, message: string, stack: string) {
    this.brandModel = DeviceUtil.getBrandModel();
    this.marketName = DeviceUtil.getMarketName();
    this.osFullName = DeviceUtil.getOsFullName();
    this.displayVersion = DeviceUtil.getDisplayVersion();
    this.osVersion = DeviceUtil.getOsVersion();
    this.sdkApiVersion = DeviceUtil.getSdkApiVersion();
    this.bundleName = AppUtil.getBundleName();
    this.versionName = AppUtil.getVersionName();
    this.versionCode = AppUtil.getVersionCode();
    this.installTime = AppUtil.getInstallTime();
    this.updateTime = AppUtil.getUpdateTime();
    this.provisionType = AppUtil.getAppProvisionType();
    this.crashTime = systemDateTime.getTime(false);
    this.name = name;
    this.message = message;
    this.stack = stack;
  }


  brandModel?: string; //设备品牌及型号
  marketName?: string; //设备产品系列名称
  osFullName?: string; //系统版本
  displayVersion?: string; //产品版本。示例：ALN-AL00 5.0.0.1(XXX)
  osVersion?: string; //OS版本号，示例：5.0.4
  sdkApiVersion?: number; //系统软件API版本，示例：12

  bundleName?: string; //应用包的名称
  versionName?: string; //应用版本名
  versionCode?: number; //应用版本号
  installTime?: number; //应用包安装时间
  updateTime?: number; //应用包更新时间
  provisionType?: string; //应用程序签名证书文件的类型，分为debug和release两种类型。

  crashTime?: number; //崩溃的时间
  name?: string;
  message?: string;
  stack?: string;


}