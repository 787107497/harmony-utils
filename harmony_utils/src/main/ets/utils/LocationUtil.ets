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
 *
 * https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 */

import geoLocationManager from '@ohos.geoLocationManager';
import { AsyncCallback, BusinessError, Callback } from '@ohos.base';
import { LogUtil } from './LogUtil';
import { PermissionUtil } from './PermissionUtil';


/**
 * TODO 定位工具类(WGS-84坐标系)
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class LocationUtil {

  private constructor() {}

  private static locationCallBack: Callback<geoLocationManager.Location> //开启位置变化订阅，监听回调


  /**
   * 判断位置服务是否已经使能(定位是否开启)。
   * @returns
   */
  static isLocationEnabled(): boolean {
    return geoLocationManager.isLocationEnabled();
  }


  /**
   * 申请定位权限
   * @returns
   */
  static async requestLocationPermissions(): Promise<boolean> {
    let grant = await PermissionUtil.requestPermissions(['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION']);
    if (!grant) {
      grant = await PermissionUtil.requestPermissionOnSetting(['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION']);
    }
    return grant;
  }


  /**
   * 获取当前位置，通过callback方式异步返回结果。
   * @param callBack
   * @returns 失败返回错误码，成功返回0。
   */
  static getCurrentLocationEasy(callBack: AsyncCallback<geoLocationManager.Location>): number {
    try {
      let request: geoLocationManager.CurrentLocationRequest = {
        // 'priority': geoLocationManager.LocationRequestPriority.FIRST_FIX, //表示快速获取位置优先，如果应用希望快速拿到一个位置，可以将优先级设置为该字段。
        'scenario': geoLocationManager.LocationRequestScenario.DAILY_LIFE_SERVICE, //表示日常服务使用场景。适用于不需要定位用户精确位置的使用场景。此场景默认以最小1秒间隔上报定位结果。
        'maxAccuracy': 0, //表示精度信息，单位是米。
        'timeoutMs': 1000 //表示超时时间，单位是毫秒，最小为1000毫秒。取值范围为大于等于1000。
      } //当前位置，默认Request参数
      geoLocationManager.getCurrentLocation(request, callBack);
      return 0; //成功返回-0
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`LocationUtil-getCurrentLocationEasy-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return error.code; //失败返回-错误码
    }
  }


  /**
   * 获取当前位置，使用Promise方式异步返回结果。
   * @param request
   */
  static async getCurrentLocation(request?: geoLocationManager.CurrentLocationRequest) :Promise<geoLocationManager.Location>{
    if (!request) {
      request = {
        // 'priority': geoLocationManager.LocationRequestPriority.FIRST_FIX, //表示快速获取位置优先，如果应用希望快速拿到一个位置，可以将优先级设置为该字段。
        'scenario': geoLocationManager.LocationRequestScenario.DAILY_LIFE_SERVICE, //表示日常服务使用场景。适用于不需要定位用户精确位置的使用场景。此场景默认以最小1秒间隔上报定位结果。
        'maxAccuracy': 0, //表示精度信息，单位是米。
        'timeoutMs': 1000 //表示超时时间，单位是毫秒，最小为1000毫秒。取值范围为大于等于1000。
      } //当前位置，默认Request参数
    }
   return await geoLocationManager.getCurrentLocation(request);
  }


  /**
   * 开启位置变化订阅，并发起定位请求。
   * @param callBack
   * @returns 失败返回错误码，成功返回0。
   */
  static onLocationChangeEasy(callBack: Callback<geoLocationManager.Location>): number {
    try {
      let locationRequest: geoLocationManager.LocationRequest = {
        'priority': geoLocationManager.LocationRequestPriority.FIRST_FIX, //表示快速获取位置优先，如果应用希望快速拿到一个位置，可以将优先级设置为该字段。
        'scenario': geoLocationManager.LocationRequestScenario.UNSET, //表示未设置优先级，表示LocationRequestPriority无效。
        'timeInterval': 10, //表示上报位置信息的时间间隔，单位是秒。默认值为1，取值范围为大于等于0。10秒钟获取一下位置
        'distanceInterval': 0, //表示上报位置信息的距离间隔。单位是米，默认值为0，取值范围为大于等于0。
        'maxAccuracy': 0 //表示精度信息，单位是米。
      }; //开启位置变化订阅，默认Request参数
      LocationUtil.locationCallBack = callBack;
      geoLocationManager.on('locationChange', locationRequest, callBack);
      return 0; //成功返回-0
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`LocationUtil-onLocationChangeEasy-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return error.code; //失败返回-错误码
    }
  }


  /**
   * 开启位置变化订阅，并发起定位请求。
   * @param request
   * @param callBack
   * @returns 失败返回错误码，成功返回0。
   */
  static onLocationChange(request: geoLocationManager.LocationRequest, callBack: Callback<geoLocationManager.Location>): number {
    try {
      LocationUtil.locationCallBack = callBack;
      geoLocationManager.on('locationChange', request, callBack);
      return 0; //成功返回-0
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`LocationUtil-onLocationChange-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return error.code; //失败返回-错误码
    }
  }


  /**
   *  关闭位置变化订阅，并删除对应的定位请求。
   * @param all 取消当前类型的所有订阅。
   * @returns 失败返回错误码，成功返回0。
   */
  static offLocationChange(all: boolean = false): number {
    try {
      if (all) {
        geoLocationManager.off('locationChange');
      } else {
        if (LocationUtil.locationCallBack) {
          geoLocationManager.off('locationChange', LocationUtil.locationCallBack);
        } else {
          geoLocationManager.off('locationChange'); //callback:需要取消订阅的回调函数。若无此参数，则取消当前类型的所有订阅。
        }
      }
      return 0; //成功返回-0
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`LocationUtil-offLocationChange-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return error.code; //失败返回-错误码
    }
  }


  /**
   * 判断地理编码与逆地理编码服务是否可用
   * @returns
   */
  static isGeocoderAvailable() {
    return geoLocationManager.isGeocoderAvailable();
  }


  /**
   * 地理编码,将地理描述转换为具体坐标集合（无需申请定位权限）
   * @param locationName  地理位置中文描述
   * @param maxItems 表示返回位置信息的最大个数。
   * @returns
   * @returns 编码后集合
   */
  static async getGeoAddressFromLocationName(locationName: string, maxItems: number = 1): Promise<Array<geoLocationManager.GeoAddress>> {
    let geocodeRequest: geoLocationManager.GeoCodeRequest = {
      description: locationName, //表示位置描述信息的语言，“zh”代表中文，“en”代表英文。
      maxItems: maxItems, //表示返回位置信息的最大个数。取值范围为大于等于0，推荐该值小于10。
      locale: 'zh' //表示位置信息描述，如“上海市浦东新区xx路xx号”。
    };
    let result = await geoLocationManager.getAddressesFromLocationName(geocodeRequest);
    if (result && result.length > 0) {
      return result;
    } else {
      return [];
    }
  }

  /**
   * 地理编码,将地理描述转换为具体坐标（无需申请定位权限）
   * @param locationName  地理位置中文描述
   * @returns 编码后location对象
   */
  static async getAddressFromLocationName(locationName: string): Promise<geoLocationManager.GeoAddress> {
    let geoAddress = await LocationUtil.getGeoAddressFromLocationName(locationName, 1);
    if (geoAddress != null && geoAddress.length >= 1) {
      return geoAddress[0];
    }
    return {};
  }


  /**
   * 逆地理编码,将坐标转换为地理描述集合（无需申请定位权限）
   * @param latitude 纬度
   * @param longitude 经度
   * @returns 逆编码后集合
   */
  static async getGeoAddressFromLocation(latitude: number, longitude: number, maxItems: number = 1): Promise<Array<geoLocationManager.GeoAddress>> {
    let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest = {
      latitude: latitude,
      longitude: longitude,
      maxItems: maxItems,
      locale: 'zh'
    };
    let result = await geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest);
    if (result && result.length > 0) {
      return result;
    } else {
      return [];
    }
  }

  /**
   * 逆地理编码,将坐标转换为地理描述（无需申请定位权限）
   * @param latitude 纬度
   * @param longitude 经度
   * @returns 逆编码后对象
   */
  static async getAddressFromLocation(latitude: number, longitude: number): Promise<geoLocationManager.GeoAddress> {
    let geoAddress = await LocationUtil.getGeoAddressFromLocation(latitude, longitude, 1);
    if (geoAddress != null && geoAddress.length >= 1) {
      return geoAddress[0];
    }
    return {};
  }


  /**
   * 获取当前的国家码（无需申请定位权限）
   * @returns 返回当前位置中文描述
   */
  static async getCountryCode(): Promise<string> {
    let result = await geoLocationManager.getCountryCode(); //获取当前的国家码
    if (result.country) {
      return result.country;
    }
    return "";
  }


  /**
   * 获取错误msg
   * @param code
   * @param defaultMsg
   */
  static getErrorMsg(code: number, defaultMsg: string) {
    if (201 == code) {
      return '权限校验失败！'
    } else if (202 == code) {
      return '系统API权限校验失败！'
    } else if (401 == code) {
      return '参数检查失败！'
    } else if (801 == code) {
      return '该设备不支持此API！'
    } else if (3301000 == code) {
      return '位置服务不可用！'
    } else if (3301100 == code) {
      return '请开启位置功能开关！'
    } else if (3301200 == code) {
      return '定位失败，未获取到定位结果！'
    } else if (3301300 == code) {
      return '逆地理编码查询失败！'
    } else if (3301400 == code) {
      return '地理编码查询失败！'
    } else if (3301500 == code) {
      return '区域信息（包含国家码）查询失败！'
    } else if (3301600 == code) {
      return '地理围栏操作失败！'
    } else {
      return defaultMsg
    }
  }


}