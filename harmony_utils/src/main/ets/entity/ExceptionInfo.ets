import { FaultLogger } from "@kit.PerformanceAnalysisKit";

/**
 * 异常信息对象
 */
export class ExceptionInfo{
  deviceInfo?: string;
  buildInfo?: string;
  version?: string;
  versionCode?: string;
  pid?: number;
  uid?: number;
  timestamp?: number;
  module?: string;
  summary?: string;
  fullLog?: string;
  reason?: string;
  type?: FaultLogger.FaultType;
  nowTime?: string;


  name?: string;
  message?: string;
  stack?: string;



  // StringBuilder sb = new StringBuilder();
  // sb.append("\n软件App的Id:").append(BuildConfig.LIBRARY_PACKAGE_NAME);
  // sb.append("\n是否是DEBUG版本:").append(BuildConfig.BUILD_TYPE);
  // sb.append("\n崩溃的时间:").append(crashTime);
  // sb.append("\n是否root:").append(NetDeviceUtils.isDeviceRooted());
  // sb.append("\n系统硬件商:").append(NetDeviceUtils.getManufacturer());
  // sb.append("\n设备的品牌:").append(NetDeviceUtils.getBrand());
  // sb.append("\n手机的型号:").append(NetDeviceUtils.getModel());
  // sb.append("\n设备版本号:").append(NetDeviceUtils.getId());
  // sb.append("\nCPU的类型:").append(NetDeviceUtils.getCpuType());
  // sb.append("\n系统的版本:").append(NetDeviceUtils.getSDKVersionName());
  // sb.append("\n系统版本值:").append(NetDeviceUtils.getSDKVersionCode());
  // sb.append("\n当前的版本:").append(versionName).append("—").append(versionCode);


  // String now = dataFormat.format(new Date());
  // sb.append("TIME:").append(now);//崩溃时间
  // //程序信息
  // sb.append("\nAPPLICATION_ID:").append(BuildConfig.LIBRARY_PACKAGE_NAME);//软件APPLICATION_ID
  // sb.append("\nVERSION_CODE:").append(BuildConfig.VERSION_CODE);//软件版本号
  // sb.append("\nVERSION_NAME:").append(BuildConfig.VERSION_NAME);//VERSION_NAME
  // sb.append("\nBUILD_TYPE:").append(BuildConfig.BUILD_TYPE);//是否是DEBUG版本
  // //设备信息
  // sb.append("\nMODEL:").append(Build.MODEL);
  // sb.append("\nRELEASE:").append(Build.VERSION.RELEASE);
  // sb.append("\nSDK:").append(Build.VERSION.SDK_INT);
  // sb.append("\nEXCEPTION:").append(ex.getLocalizedMessage());
  // sb.append("\nSTACK_TRACE:").append(result);


}