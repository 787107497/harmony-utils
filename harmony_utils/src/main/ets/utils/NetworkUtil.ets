/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-utils
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { connection } from '@kit.NetworkKit';
import { BusinessError, Callback } from '@kit.BasicServicesKit';
import { wifiManager } from '@kit.ConnectivityKit';
import { LogUtil } from './LogUtil';
import { radio } from '@kit.TelephonyKit';
import { NetworkType } from '../entity/constraint';

/**
 * TODO 网络相关工具类
 * 需要 ohos.permission.GET_NETWORK_INFO、ohos.permission.GET_WIFI_INFO 权限。
 * author: 桃花镇童长老
 * since: 2024/05/01
 */
export class NetworkUtil {

  private static netConnection: connection.NetConnection;


  /**
   * 检查默认数据网络是否被激活
   */
  static hasDefaultNet(): Promise<boolean> {
    return connection.hasDefaultNet();
  }

  /**
   * 检查默认数据网络是否被激活，是否有网络
   */
  static hasDefaultNetSync(): boolean {
    return connection.hasDefaultNetSync();
  }

  /**
   * 获取默认激活的数据网络
   * @returns
   */
  static getDefaultNet(): Promise<connection.NetHandle> {
    return connection.getDefaultNet();
  }

  /**
   * 获取默认激活的数据网络
   * @returns
   */
  static getDefaultNetSync(): connection.NetHandle {
    return connection.getDefaultNetSync();
  }

  /**
   * 获取所有处于连接状态的网络列表
   * @returns
   */
  static getAllNets(): Promise<Array<connection.NetHandle>> {
    return connection.getAllNets();
  }

  /**
   * 获取所有处于连接状态的网络列表
   * @returns
   */
  static getAllNetsSync(): Array<connection.NetHandle> {
    return connection.getAllNetsSync();
  }


  /**
   * 网络是否可用
   * @returns
   */
  static isNetworkAvailable(): Boolean {
    let allNets = connection.getAllNetsSync();
    if (allNets && allNets.length > 0) {
      return true;
    } else {
      return false;
    }
  }


  /**
   * 判断当前网络是否是蜂窝网络（移动网络）。
   */
  static hasNetMobile(): boolean {
    return NetworkUtil.hasNetBearType(connection.NetBearType.BEARER_CELLULAR);
  }

  /**
   * 判断当前网络是否是Wi-Fi网络。
   */
  static hasNetWiFi(): boolean {
    return NetworkUtil.hasNetBearType(connection.NetBearType.BEARER_WIFI);
  }

  /**
   * 判断当前网络是否是以太网网络。
   */
  static hasNetEthernet(): boolean {
    return NetworkUtil.hasNetBearType(connection.NetBearType.BEARER_ETHERNET);
  }

  /**
   * 判断当前网络是否是VPN网络。
   */
  static hasNetVPN(): boolean {
    return NetworkUtil.hasNetBearType(connection.NetBearType.BEARER_VPN);
  }

  /**
   * 是否存在指定的网络
   * @param netType 网络类型。
   * @returns
   */
  private static hasNetBearType(netType: connection.NetBearType): boolean {
    const netBearTypes = NetworkUtil.getNetBearTypes()
    for (let item of netBearTypes.values()) {
      if (item === netType) {
        return true;
      }
    }
    return false;
  }

  /**
   * 获取网络类型，数组里面只包含了一种具体的网络类型。
   */
  static getNetBearTypes(): Array<connection.NetBearType> {
    const netCapabilities = connection.getNetCapabilitiesSync(NetworkUtil.getDefaultNetSync());
    return netCapabilities.bearerTypes;
  }

  /**
   * 获取网络类型。
   */
  static getNetBearType(): connection.NetBearType {
    return NetworkUtil.getNetBearTypes()[0];
  }


  /**
   * 判断当前设备是否支持NR(New Radio)。也就是5G。
   * @param slotId 卡槽ID，不传默认主卡。
   */
  static isNRSupported(slotId?: number): boolean {
    if (slotId) {
      return radio.isNRSupported(slotId);
    }
    return radio.isNRSupported();
  }


  /**
   * 判断Radio是否打开。
   * @param slotId 卡槽ID，如果不指定slotId，默认主卡。
   * @returns
   */
  static async isRadioOn(slotId?: number): Promise<boolean> {
    if (slotId) {
      return radio.isRadioOn(slotId);
    }
    return radio.isRadioOn();
  }


  /**
   * 获取运营商名称
   * @param slotId 卡槽ID，如果不指定slotId，默认主卡。
   * @returns
   */
  static async getOperatorName(slotId?: number): Promise<string> {
    slotId = slotId ?? await radio.getPrimarySlotId(); //获取主卡所在卡槽的索引号
    return radio.getOperatorName(slotId);
  }

  /**
   * 获取网络状态
   * @param slotId 卡槽ID，如果不指定slotId，默认主卡。
   * @returns
   */
  static async getNetworkState(slotId?: number): Promise<radio.NetworkState> {
    slotId = slotId ?? await radio.getPrimarySlotId(); //获取主卡所在卡槽的索引号
    let networkState = await radio.getNetworkState(slotId)
    return networkState
  }


  /**
   * 获取指定SIM卡槽对应的注册网络信号强度信息列表。
   * @param slotId 卡槽ID，如果不指定slotId，默认主卡。
   * @returns
   */
  static async getSignalInformation(slotId?: number): Promise<Array<radio.SignalInformation>> {
    slotId = slotId ?? await radio.getPrimarySlotId(); //获取主卡所在卡槽的索引号。
    let signalInfo: Array<radio.SignalInformation> = await radio.getSignalInformation(slotId);
    return signalInfo;
  }


  /**
   * 获取网络类型。
   */
  static async getNetworkType(): Promise<NetworkType> {
    try {
      if (NetworkUtil.hasNetWiFi()) {
        return NetworkType.NETWORK_TYPE_WIFI
      }
      if (NetworkUtil.hasNetMobile()) {
        let signalInfo: Array<radio.SignalInformation> = await NetworkUtil.getSignalInformation();
        for (let item of signalInfo) {
          if (item.signalType === radio.NetworkType.NETWORK_TYPE_UNKNOWN) {
            return NetworkType.NETWORK_TYPE_UNKNOWN;
          } else if (item.signalType === radio.NetworkType.NETWORK_TYPE_GSM ||
            item.signalType === radio.NetworkType.NETWORK_TYPE_CDMA) {
            return NetworkType.NETWORK_TYPE_2G;
          } else if (item.signalType === radio.NetworkType.NETWORK_TYPE_WCDMA ||
            item.signalType === radio.NetworkType.NETWORK_TYPE_TDSCDMA) {
            return NetworkType.NETWORK_TYPE_3G;
          } else if (item.signalType === radio.NetworkType.NETWORK_TYPE_LTE) {
            return NetworkType.NETWORK_TYPE_4G;
          } else if (item.signalType === radio.NetworkType.NETWORK_TYPE_NR) {
            return NetworkType.NETWORK_TYPE_5G;
          }
        }
      }
    } catch (err) {
      console.error(err);
    }
    return NetworkType.NETWORK_TYPE_UNKNOWN;
  }


  /**
   * 获取网络类型 字符。
   */
  static async getNetworkTypeStr(): Promise<string> {
    const networkType = await NetworkUtil.getNetworkType();
    switch (networkType) {
      case NetworkType.NETWORK_TYPE_WIFI:
        return "Wi-Fi";
      case NetworkType.NETWORK_TYPE_2G:
        return "2G";
      case NetworkType.NETWORK_TYPE_3G:
        return "3G";
      case NetworkType.NETWORK_TYPE_4G:
        return "4G";
      case NetworkType.NETWORK_TYPE_5G:
        return "5G";
    }
    return "UNKNOWN";
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
    connection.getDefaultNet((error: BusinessError, netHandle: connection.NetHandle) => {
      if (error) {
        LogUtil.error(`NetworkUtil-getDefaultNet-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      }
      if (netHandle && netAvailableCallback) {
        netAvailableCallback(netHandle);
      }
    });
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