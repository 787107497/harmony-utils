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
import { data, radio, sim } from '@kit.TelephonyKit';
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
   * 检查当前网络上的数据流量使用是否被计量
   * @returns
   */
  static async isDefaultNetMetered(): Promise<boolean> {
    return connection.isDefaultNetMetered();
  }

  /**
   * 检查当前网络上的数据流量使用是否被计量
   * @returns
   */
  static isDefaultNetMeteredSync(): boolean {
    return connection.isDefaultNetMeteredSync();
  }


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
   * 获取App绑定的网络信息
   * @returns
   */
  static getAppNet(): Promise<connection.NetHandle> {
    return connection.getAppNet();
  }

  /**
   * 获取App绑定的网络信息
   * @returns
   */
  static getAppNetSync(): connection.NetHandle {
    return connection.getAppNetSync();
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
   * 判断当前设备网络是否可用
   * @returns
   */
  static isNetworkAvailable(): boolean {
    let allNets = NetworkUtil.getAllNetsSync();
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
  static hasNetBearType(netType: connection.NetBearType): boolean {
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
    const netCapabilities = NetworkUtil.getNetCapabilitiesSync(NetworkUtil.getDefaultNetSync());
    return netCapabilities.bearerTypes;
  }

  /**
   * 获取网络类型。
   */
  static getNetBearType(): connection.NetBearType {
    return NetworkUtil.getNetBearTypes()[0];
  }


  /**
   * 获取netHandle对应的网络的能力信息
   * @param netHandle 默认激活的数据网络
   * @returns
   */
  static async getNetCapabilities(netHandle: connection.NetHandle = NetworkUtil.getDefaultNetSync()): Promise<connection.NetCapabilities> {
    return connection.getNetCapabilities(netHandle);
  }

  /**
   * 获取netHandle对应的网络的能力信息
   * @param netHandle 默认激活的数据网络
   * @returns
   */
  static getNetCapabilitiesSync(netHandle: connection.NetHandle = NetworkUtil.getDefaultNetSync()): connection.NetCapabilities {
    return connection.getNetCapabilitiesSync(netHandle);
  }


  /**
   * 获取netHandle对应的网络的连接信息
   * @param netHandle 默认激活的数据网络
   * @returns
   */
  static async getConnectionProperties(netHandle: connection.NetHandle = NetworkUtil.getDefaultNetSync()): Promise<connection.ConnectionProperties> {
    return connection.getConnectionProperties(netHandle);
  }

  /**
   * 获取netHandle对应的网络的连接信息
   * @param netHandle 默认激活的数据网络
   * @returns
   */
  static getConnectionPropertiesSync(netHandle: connection.NetHandle = NetworkUtil.getDefaultNetSync()): connection.ConnectionProperties {
    return connection.getConnectionPropertiesSync(netHandle);
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
        LogUtil.error(error);
      }
      if (netHandle && netAvailableCallback) {
        netAvailableCallback(netHandle);
      }
    });
    //先使用register接口注册订阅事件
    NetworkUtil.netConnection.register((error: BusinessError) => {
      if (error) {
        LogUtil.error(error);
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
          LogUtil.error(error);
        }
      });
    }
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
   * 获取主卡所在卡槽的索引号。使用Promise异步回调。
   * @returns
   */
  static async getPrimarySlotId(): Promise<number> {
    return radio.getPrimarySlotId();
  }


  /**
   * 获取运营商名称
   * @param slotId 卡槽ID，如果不指定slotId，默认主卡。
   * @returns
   */
  static async getOperatorName(slotId?: number): Promise<string> {
    slotId = slotId ?? await NetworkUtil.getPrimarySlotId(); //获取主卡所在卡槽的索引号
    return radio.getOperatorName(slotId);
  }

  /**
   * 获取网络状态
   * @param slotId 卡槽ID，如果不指定slotId，默认主卡。
   * @returns
   */
  static async getNetworkState(slotId?: number): Promise<radio.NetworkState> {
    slotId = slotId ?? await NetworkUtil.getPrimarySlotId(); //获取主卡所在卡槽的索引号
    return radio.getNetworkState(slotId);
  }


  /**
   * 获取当前选网模式。使用Promise异步回调。
   * @param slotId 卡槽ID，如果不指定slotId，默认主卡。
   * @returns
   */
  static async getNetworkSelectionMode(slotId?: number): Promise<radio.NetworkSelectionMode> {
    slotId = slotId ?? await NetworkUtil.getPrimarySlotId(); //获取主卡所在卡槽的索引号
    return radio.getNetworkSelectionMode(slotId);
  }


  /**
   * 获取指定SIM卡槽对应的注册网络信号强度信息列表。
   * @param slotId 卡槽ID，如果不指定slotId，默认主卡。
   * @returns
   */
  static async getSignalInformation(slotId?: number): Promise<Array<radio.SignalInformation>> {
    slotId = slotId ?? await NetworkUtil.getPrimarySlotId(); //获取主卡所在卡槽的索引号。
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
      LogUtil.error(err);
    }
    return NetworkType.NETWORK_TYPE_UNKNOWN;
  }


  /**
   * 获取网络类型，返回字符类型。
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
   * 获取默认移动数据的SIM卡，使用Promise方式作为异步方法。
   * @returns
   */
  static async getDefaultCellularDataSlotId(): Promise<number> {
    return data.getDefaultCellularDataSlotId();
  }

  /**
   * 获取默认移动数据的SIM卡。
   * @returns
   */
  static getDefaultCellularDataSlotIdSync(): number {
    return data.getDefaultCellularDataSlotIdSync();
  }


  /**
   * 获取蜂窝数据业务的上下行状态，使用Promise方式作为异步方法。
   * @returns
   */
  static async getCellularDataFlowType(): Promise<data.DataFlowType> {
    return data.getCellularDataFlowType();
  }


  /**
   * 获取分组交换域(PS域)的连接状态，使用Promise方式作为异步方法。
   * @returns
   */
  static async getCellularDataState(): Promise<data.DataConnectState> {
    return data.getCellularDataState();
  }


  /**
   * 检查蜂窝数据业务是否启用，使用Promise方式作为异步方法。
   * @returns
   */
  static async isCellularDataEnabled(): Promise<boolean> {
    return data.isCellularDataEnabled();
  }

  /**
   * 检查蜂窝数据业务是否启用。
   * @returns
   */
  static isCellularDataEnabledSync(): boolean {
    return data.isCellularDataEnabledSync();
  }


  /**
   * 检查蜂窝数据业务是否启用漫游，使用Promise方式作为异步方法。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。 默认移动数据的SIM卡。
   * @returns
   */
  static async isCellularDataRoamingEnabled(slotId?: number): Promise<boolean> {
    slotId = slotId ?? await NetworkUtil.getDefaultCellularDataSlotId(); //默认移动数据的SIM卡
    return data.isCellularDataRoamingEnabled(slotId);
  }

  /**
   * 检查蜂窝数据业务是否启用漫游，使用Promise方式作为异步方法。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。 默认移动数据的SIM卡。
   * @returns
   */
  static isCellularDataRoamingEnabledSync(slotId?: number): boolean {
    slotId = slotId ?? NetworkUtil.getDefaultCellularDataSlotIdSync(); //默认移动数据的SIM卡
    return data.isCellularDataRoamingEnabledSync(slotId);
  }


  /**
   * 获取默认移动数据的SIM卡ID。与SIM卡绑定，从1开始递增。
   * @returns
   */
  static getDefaultCellularDataSimId(): number {
    return data.getDefaultCellularDataSimId();
  }



  /**
   * 获取指定卡槽SIM卡是否激活。使用Promise异步回调。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。
   * @returns
   */
  static async isSimActive(slotId: number): Promise<boolean> {
    return sim.isSimActive(slotId);
  }

  /**
   * 获取指定卡槽SIM卡是否激活
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。 默认移动数据的SIM卡。
   * @returns
   */
  static isSimActiveSync(slotId: number): boolean {
    return sim.isSimActiveSync(slotId);
  }


  /**
   * 获取指定卡槽SIM卡是否插卡。使用Promise异步回调。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。
   * @returns
   */
  static async hasSimCard(slotId: number): Promise<boolean> {
    return sim.hasSimCard(slotId);
  }

  /**
   * 获取指定卡槽SIM卡是否插卡。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。
   * @returns
   */
  static hasSimCardSync(slotId: number): boolean {
    return sim.hasSimCardSync(slotId);
  }


  /**
   * 获取卡槽数量。
   * @returns
   */
  static getMaxSimCount(): number {
    return sim.getMaxSimCount();
  }


  /**
   * 获取指定卡槽SIM卡的归属PLMN（Public Land Mobile Network）号。使用Promise异步回调。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。 默认移动数据的SIM卡。
   * @returns
   */
  static async getSimOperatorNumeric(slotId?: number): Promise<string> {
    slotId = slotId ?? await NetworkUtil.getDefaultCellularDataSlotId(); //默认移动数据的SIM卡
    return sim.getSimOperatorNumeric(slotId);
  }

  /**
   * 获取指定卡槽SIM卡的归属PLMN（Public Land Mobile Network）号。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。 默认移动数据的SIM卡。
   * @returns
   */
  static getSimOperatorNumericSync(slotId?: number): string {
    slotId = slotId ?? NetworkUtil.getDefaultCellularDataSlotIdSync(); //默认移动数据的SIM卡
    return sim.getSimOperatorNumericSync(slotId);
  }


  /**
   * 获取指定卡槽SIM卡的服务提供商名称（Service Provider Name，SPN）。使用Promise异步回调。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。 默认移动数据的SIM卡。
   * @returns
   */
  static async getSimSpn(slotId?: number): Promise<string> {
    slotId = slotId ?? await NetworkUtil.getDefaultCellularDataSlotId(); //默认移动数据的SIM卡
    return sim.getSimSpn(slotId);
  }

  /**
   * 获取指定卡槽SIM卡的服务提供商名称（Service Provider Name，SPN）。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。 默认移动数据的SIM卡。
   * @returns
   */
  static getSimSpnSync(slotId?: number): string {
    slotId = slotId ?? NetworkUtil.getDefaultCellularDataSlotIdSync(); //默认移动数据的SIM卡
    return sim.getSimSpnSync(slotId);
  }


  /**
   * 获取指定卡槽的SIM卡状态。使用Promise异步回调。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。 默认移动数据的SIM卡。
   * @returns
   */
  static async getSimState(slotId?: number): Promise<sim.SimState> {
    slotId = slotId ?? await NetworkUtil.getDefaultCellularDataSlotId(); //默认移动数据的SIM卡
    return sim.getSimState(slotId);
  }

  /**
   * 获取指定卡槽的SIM卡状态。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。 默认移动数据的SIM卡。
   * @returns
   */
  static getSimStateSync(slotId?: number): sim.SimState {
    slotId = slotId ?? NetworkUtil.getDefaultCellularDataSlotIdSync(); //默认移动数据的SIM卡
    return sim.getSimStateSync(slotId);
  }


  /**
   * 获取指定卡槽SIM卡的卡类型。使用Promise异步回调。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。 默认移动数据的SIM卡。
   * @returns
   */
  static async getCardType(slotId?: number): Promise<sim.CardType> {
    slotId = slotId ?? await NetworkUtil.getDefaultCellularDataSlotId(); //默认移动数据的SIM卡
    return sim.getCardType(slotId);
  }

  /**
   * 获取指定卡槽SIM卡的卡类型。
   * @param slotId 卡槽ID（0-卡槽1、1-卡槽2）。 默认移动数据的SIM卡。
   * @returns
   */
  static getCardTypeSync(slotId?: number): sim.CardType {
    slotId = slotId ?? NetworkUtil.getDefaultCellularDataSlotIdSync(); //默认移动数据的SIM卡
    return sim.getCardTypeSync(slotId);
  }



}