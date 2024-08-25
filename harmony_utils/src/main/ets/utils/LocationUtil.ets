import geoLocationManager from '@ohos.geoLocationManager';
import { BusinessError, Callback } from '@ohos.base';
import { ToastUtil } from '../action/ToastUtil';
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


  private static locationRequest: geoLocationManager.LocationRequest = {
    'priority': geoLocationManager.LocationRequestPriority.FIRST_FIX, //表示快速获取位置优先，如果应用希望快速拿到一个位置，可以将优先级设置为该字段。
    'scenario': geoLocationManager.LocationRequestScenario.UNSET, //表示未设置优先级，表示LocationRequestPriority无效。
    'timeInterval': 10, //表示上报位置信息的时间间隔，单位是秒。默认值为1，取值范围为大于等于0。10秒钟获取一下位置
    'distanceInterval': 0, //表示上报位置信息的距离间隔。单位是米，默认值为0，取值范围为大于等于0。
    'maxAccuracy': 0 //表示精度信息，单位是米。
  }; //开启位置变化订阅，默认Request参数
  private static currentRequest: geoLocationManager.CurrentLocationRequest = {
    // 'priority': geoLocationManager.LocationRequestPriority.FIRST_FIX, //表示快速获取位置优先，如果应用希望快速拿到一个位置，可以将优先级设置为该字段。
    'scenario': geoLocationManager.LocationRequestScenario.DAILY_LIFE_SERVICE, //表示日常服务使用场景。适用于不需要定位用户精确位置的使用场景。此场景默认以最小1秒间隔上报定位结果。
    'maxAccuracy': 0, //表示精度信息，单位是米。
    'timeoutMs': 1000 //表示超时时间，单位是毫秒，最小为1000毫秒。取值范围为大于等于1000。
  } //当前位置，默认Request参数
  private static locationCallBack: Callback<geoLocationManager.Location> //开启位置变化订阅，监听回调



  /**
   * 判断位置服务是否已经使能(定位是否开启)。
   * @returns
   */
  static isLocationEnabled(): boolean {
    return geoLocationManager.isLocationEnabled()
  }


  /**
   * 申请定位权限
   * @returns
   */
  static async requestLocationPermissions(): Promise<boolean> {
    let isAuth = await PermissionUtil.checkPermissions('ohos.permission.APPROXIMATELY_LOCATION') && await PermissionUtil.checkPermissions('ohos.permission.LOCATION');
    if (!isAuth) {
      let grant = await PermissionUtil.requestPermissions(['ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.LOCATION']);
      return grant
    } else {
      return true;
    }
  }


  /**
   * 获取当前位置，通过callback方式异步返回结果。
   */
  static getCurrentLocationEasy(callBack: Callback<geoLocationManager.Location>) {
    geoLocationManager.getCurrentLocation(LocationUtil.currentRequest, (error: BusinessError, location: geoLocationManager.Location): void => {
      if (error) {
        LogUtil.error(`LocationUtil-getCurrentLocationEasy-异常 ~ code: ${error.code} -·- message: ${error.message}`);
        ToastUtil.showToast(LocationUtil.getErrorMsg(error.code, '获取当前位置失败：' + error.message));
      }
      if (location && callBack) {
        callBack(location)
      }
    });
  }


  /**
   * 获取当前位置，使用Promise方式异步返回结果。
   * @param request
   */
  static async getCurrentLocation(request?: geoLocationManager.CurrentLocationRequest) :Promise<geoLocationManager.Location>{
   return await geoLocationManager.getCurrentLocation(request);
  }


  /**
   * 开启位置变化订阅，并发起定位请求。
   * @param callBack
   */
  static onLocationChangeEasy(callBack: Callback<geoLocationManager.Location>) {
    try {
      LocationUtil.locationCallBack = callBack;
      geoLocationManager.on('locationChange', LocationUtil.locationRequest, callBack);
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`LocationUtil-onLocationChangeEasy-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      ToastUtil.showToast(LocationUtil.getErrorMsg(err.code, '开启位置变化订阅失败：' + error.message));
    }
  }


  /**
   * 开启位置变化订阅，并发起定位请求。
   * @param request
   * @param callBack
   */
  static onLocationChange(request: geoLocationManager.LocationRequest, callBack: Callback<geoLocationManager.Location>) {
    try {
      if (!request) {
        request = LocationUtil.locationRequest;
      }
      LocationUtil.locationCallBack = callBack;
      geoLocationManager.on('locationChange', request, callBack);
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`LocationUtil-onLocationChange-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      ToastUtil.showToast(LocationUtil.getErrorMsg(err.code, '开启位置变化订阅失败：' + error.message));
    }
  }


  /**
   * 关闭位置变化订阅，并删除对应的定位请求。
   * @param all 取消当前类型的所有订阅。
   */
  static offLocationChange(all: boolean = false) {
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
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`LocationUtil-offLocationChange-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      ToastUtil.showToast(LocationUtil.getErrorMsg(err.code, '关闭位置变化订阅失败：' + error.message));
    }
  }


  /**
   * 地理逆编码,将地理描述转换为具体坐标-无需申请定位权限
   * @param locationName  地理位置中文描述
   * @returns 编码后location对象
   */
  static async getAddressFromLocationName(locationName: string): Promise<geoLocationManager.GeoAddress> {
    try {
      let isAvailable = geoLocationManager.isGeocoderAvailable(); //（逆）地理编码服务是否可用
      if (isAvailable) {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          description: locationName, //表示位置描述信息的语言，“zh”代表中文，“en”代表英文。
          maxItems: 1, //表示返回位置信息的最大个数。取值范围为大于等于0，推荐该值小于10。
          locale: 'zh' //表示位置信息描述，如“上海市浦东新区xx路xx号”。
        };
        let result = await geoLocationManager.getAddressesFromLocationName(geocodeRequest);
        if (result && result.length > 0) {
          return result[0];
        } else {
          ToastUtil.showToast('地理编码失败!');
          return {};
        }
      } else {
        ToastUtil.showToast("（逆）地理编码服务不可用！")
        return {};
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`LocationUtil-getAddressFromLocationName-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      ToastUtil.showToast(LocationUtil.getErrorMsg(error.code, '地理编码失败：' + error.message));
      return {};
    }
  }


  /**
   * 地理逆编码,将地理描述转换为具体坐标-无需申请定位权限
   * @param locationName  地理位置中文描述
   * @param maxItems 表示返回位置信息的最大个数。
   * @returns
   * @returns 编码后集合
   */
  static async getGeoAddressFromLocationName(locationName: string, maxItems: number = 1): Promise<Array<geoLocationManager.GeoAddress>> {
    try {
      let isAvailable = geoLocationManager.isGeocoderAvailable(); //（逆）地理编码服务是否可用
      if (isAvailable) {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          description: locationName, //表示位置描述信息的语言，“zh”代表中文，“en”代表英文。
          maxItems: maxItems, //表示返回位置信息的最大个数。取值范围为大于等于0，推荐该值小于10。
          locale: 'zh' //表示位置信息描述，如“上海市浦东新区xx路xx号”。
        };
        let result = await geoLocationManager.getAddressesFromLocationName(geocodeRequest);
        if (result && result.length > 0) {
          return result;
        } else {
          ToastUtil.showToast('地理编码失败!');
          return [];
        }
      } else {
        ToastUtil.showToast("（逆）地理编码服务不可用！")
        return [];
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`LocationUtil-getGeoAddressFromLocationName-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      ToastUtil.showToast(LocationUtil.getErrorMsg(error.code, '地理编码失败：' + error.message));
      return [];
    }
  }


  /**
   * 地理逆编码,将坐标转换为地理描述-无需申请定位权限
   * @param latitude  维度
   * @param longitude 经度
   * @returns 逆编码后对象
   */
  static async getAddressFromLocation(latitude: number, longitude: number): Promise<geoLocationManager.GeoAddress> {
    try {
      let isAvailable = geoLocationManager.isGeocoderAvailable(); //校验是否逆编码可用
      if (isAvailable) {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest = {
          latitude: latitude,
          longitude: longitude,
          maxItems: 1,
          locale: 'zh'
        };
        let result = await geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest);
        if (result && result.length > 0) {
          return result[0];
        } else {
          ToastUtil.showToast('地理编码失败!');
          return {} as geoLocationManager.GeoAddress;
        }
      } else {
        ToastUtil.showToast("（逆）地理编码服务不可用！")
        return {} as geoLocationManager.GeoAddress;
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`LocationUtil-getAddressFromLocation-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      ToastUtil.showToast(LocationUtil.getErrorMsg(error.code, '地理编码失败：' + error.message));
      return {}
    }
  }


  /**
   * 地理逆编码,将坐标转换为地理描述集合-无需申请定位权限
   * @param latitude  维度
   * @param longitude 经度
   * @returns 逆编码后集合
   */
  static async getGeoAddressFromLocation(latitude: number, longitude: number, maxItems: number = 1): Promise<Array<geoLocationManager.GeoAddress>> {
    try {
      let isAvailable = geoLocationManager.isGeocoderAvailable(); //校验是否逆编码可用
      if (isAvailable) {
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
          ToastUtil.showToast('地理编码失败!');
          return [];
        }
      } else {
        ToastUtil.showToast("（逆）地理编码服务不可用！")
        return [];
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`LocationUtil-getGeoAddressFromLocation-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      ToastUtil.showToast(LocationUtil.getErrorMsg(error.code, '地理编码失败：' + error.message));
      return [];
    }
  }


  /**
   * 获取当前的国家码-无需申请定位权限
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
  private static getErrorMsg(code: number, defaultMsg: string) {
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