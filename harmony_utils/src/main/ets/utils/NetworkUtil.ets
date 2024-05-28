import { connection } from '@kit.NetworkKit';
import { BusinessError, Callback } from '@kit.BasicServicesKit';
import { wifiManager } from '@kit.ConnectivityKit';
import { LogUtil } from './LogUtil';


/**
 * 网络相关工具类
 * 需要ohos.permission.GET_NETWORK_INFO权限。
 */
export class NetworkUtil {

  private constructor() {}

  private static netConnection: connection.NetConnection;


  /**
   * 检查默认数据网络是否被激活
   */
  static hasDefaultNet(): Promise<boolean> {
    return connection.hasDefaultNet();
  }

  /**
   * 检查默认数据网络是否被激活
   */
  static hasDefaultNetSync(): boolean {
    return connection.hasDefaultNetSync();
  }


  /**
   * 判断当前网络是否是Wi-Fi，否则是移动流量热点网络。
   */
  static async hasNetWiFi(): Promise<boolean> {
    let net = await connection.getDefaultNet();
    let netCapabilities = await connection.getNetCapabilities(net);
    let networkCap = netCapabilities.networkCap;
    if (networkCap) { //判断是否具有NET_CAPABILITY_NOT_METERED属性，如果具有NET_CAPABILITY_NOT_METERED，说明是普通Wi-Fi，否则是移动流量热点网络。
      return networkCap.indexOf(connection.NetCap.NET_CAPABILITY_NOT_METERED) >= 0
    }
    return false;
  }


  /**
   * 获取网络类型
   */
  static async getNetBearType(): Promise<connection.NetBearType> {
    let net = await connection.getDefaultNet();
    let netCapabilities = await connection.getNetCapabilities(net);
    let netBearType = netCapabilities.bearerTypes[0];
    return netBearType;
  }


  /**
   * 获取当前设备的IP地址(设备连接Wi-Fi后)
   */
  static getIpAddress() {
    let ipAddress = wifiManager.getIpInfo().ipAddress;
    let ip = (ipAddress >>> 24) + "." + (ipAddress >> 16 & 0xFF) + "." + (ipAddress >> 8 & 0xFF) + "." + (ipAddress & 0xFF);
    return ip;
  }


  /**
   * 订阅指定网络状态变化的通知，支持多事件监听回调。
   * @param netAvailableCallback  订阅网络可用事件回调。
   * @param netUnavailableCallback  订阅网络不可用事件回调。
   * @param netCapabilitiesChangeCallback  订阅网络能力变化事件回调。比如切换Wi-Fi、切换VPN、切换为手机流量。
   * @param netConnectionPropertiesChangeCallback  订阅网络连接信息变化事件回调。比如更改Wi-Fi、切换Wi-Fi、切换蜂窝网络。
   * @param netBlockStatusChangeCallback  订阅网络阻塞状态事件回调。
   * @param netLostCallback  订阅网络丢失事件回调。
   */
  static register(netAvailableCallback?: Callback<connection.NetHandle>,
                  netUnavailableCallback?: Callback<void>,
                  netCapabilitiesChangeCallback?: Callback<connection.NetCapabilityInfo>,
                  netConnectionPropertiesChangeCallback?: Callback<connection.NetConnectionPropertyInfo>,
                  netBlockStatusChangeCallback?: Callback<connection.NetBlockStatusInfo>,
                  netLostCallback?: Callback<connection.NetHandle>) {
    if (!NetworkUtil.netConnection) {
      NetworkUtil.netConnection = connection.createNetConnection(); //创建NetConnection对象
    }
    //先使用register接口注册订阅事件
    NetworkUtil.netConnection.register((error: BusinessError) => {
      if (error) {
        LogUtil.error(`NetworkUtil-register-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      }
    });
    if (netAvailableCallback) {
      NetworkUtil.netConnection.on('netAvailable', netAvailableCallback); //订阅网络可用事件。
    }
    if (netUnavailableCallback) {
      NetworkUtil.netConnection.on('netUnavailable', netUnavailableCallback); //订阅网络不可用事件。
    }
    if (netCapabilitiesChangeCallback) {
      NetworkUtil.netConnection.on('netCapabilitiesChange',netCapabilitiesChangeCallback); //订阅网络能力变化事件。比如切换Wi-Fi、切换VPN、切换为手机流量。
    }
    if (netConnectionPropertiesChangeCallback) {
      NetworkUtil.netConnection.on('netConnectionPropertiesChange',netConnectionPropertiesChangeCallback); //订阅网络连接信息变化事件。比如更改Wi-Fi、切换Wi-Fi、切换蜂窝网络。
    }
    if (netBlockStatusChangeCallback) {
      NetworkUtil.netConnection.on('netBlockStatusChange',netBlockStatusChangeCallback); //订阅网络阻塞状态事件。
    }
    if (netLostCallback) {
      NetworkUtil.netConnection.on('netLost',netLostCallback); //订阅网络丢失事件。
    }
  }


  /**
   * 取消订阅默认网络状态变化的通知。
   */
  static unregister() {
    if (NetworkUtil.netConnection) {
      NetworkUtil.netConnection.unregister((error: BusinessError) => {
        if (error) {
          LogUtil.error(`NetworkUtil-unregister-异常 ~ code: ${error.code} -·- message: ${error.message}`);
        }
      });
    }
  }



}