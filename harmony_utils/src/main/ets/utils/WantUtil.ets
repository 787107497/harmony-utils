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


import { AppUtil } from './AppUtil';
import { Want, wantConstant } from '@kit.AbilityKit';


/**
 * TODO Want工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class WantUtil {


  static readonly URI_NOTIFICATION: string = "systemui_notification_settings"; //通知设置页面
  static readonly URI_WIFI: string = "wifi_entry"; //WLAN设置页面
  static readonly URI_BLUETOOTH: string = "bluetooth_entry"; //蓝牙设置页面
  static readonly URI_NFC: string = "nfc_settings"; //NFC设置页面
  static readonly URI_VOLUME: string = "volume_settings"; //声音和振动
  static readonly URI_STORAGE: string = "storage_settings"; //存储界面
  static readonly URI_BATTERY: string = "battery"; //电池

  static readonly URI_NETWORK: string = "mobile_network_entry"; //移动网络设置页面
  static readonly URI_HOTSPOT_DATA: string = "hotspot_data_settings"; //移动网络-个人热点界面
  static readonly URI_PASSWORD_ENTRY: string = "password_entry"; //移动网络-个人热点-密码界面
  static readonly URI_CONNECTED_DEVICE: string = "connected_device_entry"; //移动网络-个人热点-已连接设备界面
  static readonly URI_MORE_SHARE: string = "more_share_entry"; //移动网络-个人热点-更多共享设置界面
  static readonly URI_MORE_CONNECTIONS: string = "more_connections_settings"; //更多连接

  static readonly URI_DISPLAY: string = "display_settings"; //显示和亮度
  static readonly URI_SCREEN_ZOOM: string = "screen_zoom"; //显示和亮度-显示大小三级页面
  static readonly URI_SCREEN_REFRESH_RATE: string = "screen_refresh_rate_entry"; //显示和亮度-屏幕刷新率三级页面（需看具体设备是否有刷新率选项）

  static readonly URI_ACCESSIBILITY_FEATURE: string = "accessibility_feature"; //辅助功能
  static readonly URI_ACCESSIBILITY_OPERATION: string = "accessibility_operation_entry"; //辅助功能-辅助功能快捷键三级页面
  static readonly URI_ACCESSIBILITY_MORE: string = "accessibility_more_settings_entry"; //辅助功能-已安装的服务-服务详情-更多设置五级页面

  static readonly URI_APPLICATION_AND_SERVICE: string = "application_and_service_settings"; //应用与元服务
  static readonly URI_APPLICATION_INFO: string = 'application_info_entry' //应用和元服务-某个具体应用的应用信息，需传递want.parameters.pushParams为具体应用的包名
  static readonly URI_APPLICATION_SETTINGS: string = "application_settings"; //应用与服务-应用管理三级页面

  static readonly URI_BIOMETRICS_AND_PASSWORD: string = "biometrics_and_password_settings"; //生物识别和密码
  static readonly URI_LOCK_SCREEN_PASSWORD: string = "lock_screen_password_title"; //生物识别和密码-设置数字锁屏密码
  static readonly URI_CHANGE_SIX_TO_NUMBER: string = "change_six_to_number_entry"; //生物识别和密码-锁屏密码（其他密码类型）-自定义数字密码（设置锁屏数字密码）四级页面
  static readonly URI_CHANGE_SIX_TO_MIXED: string = "change_six_to_mixed_entry"; //生物识别和密码-锁屏密码（其他密码类型）-混合密码（设置锁屏密码）四级页面
  static readonly URI_FINGERPRINT_SETTINGS: string = "fingerprint_settings_entry"; //生物识别与密码-指纹3级页面（需看具体设备是否支持指纹解锁能力）

  static readonly URI_PRIVACY: string = "privacy_settings"; //隐私与安全
  static readonly URI_LOCATION_HELP: string = "location_help_entry"; //隐私与安全-定位服务-帮助四级页面
  static readonly URI_USERS_ACCOUNTS: string = "users_accounts"; //用户和账户
  static readonly URI_CURRENT_USER: string = "current_user"; //用户和账户-当前登录（用户）三级页面
  static readonly URI_ABOUT_DEVICE: string = "about_device"; //关于本机界面
  static readonly URI_DEVICE_NAME: string = "device_name"; //关于本机-设备名称

  static readonly URI_SYSTEM_AND_UPDATES: string = "system_and_updates"; //系统和更新
  static readonly URI_TIME_ZONE: string = "time_zone_settings"; //系统和更新-日期时间-时区-时区选择列表
  static readonly URI_DATE_AND_TIME: string = "date_and_time"; //系统和更新-日期时间三级页面
  static readonly URI_SET_INPUT: string = "set_input"; //系统和更新-输入法页面
  static readonly URI_SET_LANGUAGE: string = "set_language"; //系统和更新-语言和输入法-语言和输入法四级页面
  static readonly URI_SET_LANGUAGE_REGION: string = "set_language_region"; //系统和更新-语言和输入法-语言和地区-语言和地区5级页面
  static readonly URI_RESET_SETTINGS: string = "reset_settings"; //系统和更新-重置三级页面
  static readonly URI_DEVELOPER_OPTIONS: string = "developer_options_settings"; //系统和更新-开发人员选项三级页面
  static readonly URI_EDIT_LANGUAGE: string = "edit_language_entry"; //系统和更新-语言和输入法-语言和地区-编辑（编译语言）五级页面
  static readonly URI_ADD_LANGUAGE: string = "add_language_entry"; //系统和更新-语言和输入法-语言和地区-添加语言五级页面
  static readonly URI_SELECT_REGION: string = "select_region_entry"; //系统和更新-语言和输入法-语言和地区-当前地区（选择地区）五级页面
  static readonly URI_RESET_FACTORY: string = "reset_factory_settings"; //系统和更新-重置-恢复出厂设置四级页面
  static readonly URI_RESET_NET: string = "reset_net_settings"; //系统和更新-重置-还原网络设置四级页面
  static readonly URI_RESET_CONFIRM: string = "reset_confirm_setting"; //系统和更新-重置-恢复出厂设置-重置手机五级页面
  static readonly URI_RESET_NET_CONFIRM: string = "reset_net_confirm_settings"; //系统和更新-重置-还原网络设置-还原网络设置确认五级页面




  /**
   * 跳转系统设置页面（配合WantUtil里的URI常量一起使用，可跳转更多的设置页面）
   * @param uri: 传入WantUtil的URI常量，不传默认为设置页面
   * @returns
   */
  static async toSetting(uri?: string): Promise<void> {
    let context = AppUtil.getContext();
    let want: Want = {
      bundleName: 'com.huawei.hmos.settings', //设置应用bundleName
      abilityName: 'com.huawei.hmos.settings.MainAbility', //设置应用abilityName
      uri: uri, //目标页面
      parameters: {
        bundleName: context.abilityInfo.bundleName, //拉起方应用包名
      }
    }
    return await context.startAbility(want);
  }


  /**
   * 跳转应用设置页面
   */
  static async toAppSetting(): Promise<void> {
    return WantUtil.toSetting(WantUtil.URI_APPLICATION_INFO);
  }

  /**
   * 跳转通知设置页面
   */
  static toNotificationSetting(): Promise<void> {
    return WantUtil.toSetting(WantUtil.URI_NOTIFICATION);
  }

  /**
   * 跳转移动网络设置页面
   */
  static toNetworkSetting(): Promise<void> {
    return WantUtil.toSetting(WantUtil.URI_NETWORK);
  }

  /**
   * 跳转WLAN设置页面
   */
  static toWifiSetting(): Promise<void> {
    return WantUtil.toSetting(WantUtil.URI_WIFI);
  }

  /**
   * 跳转蓝牙设置页面
   */
  static toBluetoothSetting(): Promise<void> {
    return WantUtil.toSetting(WantUtil.URI_BLUETOOTH);
  }

  /**
   * 跳转NFC设置页面
   */
  static toNfcSetting(): Promise<void> {
    return WantUtil.toSetting(WantUtil.URI_NFC);
  }

  /**
   * 跳转声音和振动设置页面
   */
  static toVolumeSetting(): Promise<void> {
    return WantUtil.toSetting(WantUtil.URI_VOLUME);
  }

  /**
   * 跳转存储设置页面
   */
  static toStorageSetting(): Promise<void> {
    return WantUtil.toSetting(WantUtil.URI_STORAGE);
  }

  /**
   * 跳转电池设置页面
   */
  static toBatterySetting(): Promise<void> {
    return WantUtil.toSetting(WantUtil.URI_BATTERY);
  }


  /**
   * 拉起系统浏览器
   */
  static async toWebBrowser(url: string): Promise<void> {
    let context = AppUtil.getContext();
    let want: Want = {
      action: 'ohos.want.action.viewData',
      entities: ['entity.system.browsable'],
      uri: url,
      parameters: {
        bundleName: context.abilityInfo.bundleName, //拉起方应用包名
      }
    }
    return await context.startAbility(want);
  }


  /**
   * 拉起应用市场对应的应用详情界面
   * @param bundleName 需要打开应用详情的应用的包名。
   * @returns
   */
  static async toAppGalleryDetail(bundleName: string): Promise<void> {
    let context = AppUtil.getContext();
    let want: Want = {
      action: 'ohos.want.action.appdetail',
      uri: 'store://appgallery.huawei.com/app/detail?id=' + bundleName,
    };
    return await context.startAbility(want);
  }


  /**
   * 拉起系统文件管理器
   */
  static async toFileManagement(): Promise<void> {
    let context = AppUtil.getContext();
    let want: Want = {
      bundleName: 'com.huawei.hmos.filemanager',
      abilityName: 'MainAbility'
    };
    return await context.startAbility(want);
  }


  /**
   * 拉起短信界面并指定联系人
   * @param contactsName
   * @param telephone
   * @returns
   */
  static async startMMS(contactsName: string, telephone: string): Promise<void> {
    let context = AppUtil.getContext();
    let want: Want = {
      bundleName: 'com.ohos.mms',
      abilityName: 'com.ohos.mms.MainAbility',
      parameters: {
        contactObjects: JSON.stringify({
          contactsName: contactsName,
          telephone: telephone
        }),
        pageFlag: 'conversation'
      }
    };
    return await context.startAbility(want);
  }


  /**
   * 分享文件给其他应用
   */
  static async openFile(uri: string) {
    let context = AppUtil.getContext();
    let want: Want = {
      flags: wantConstant.Flags.FLAG_AUTH_WRITE_URI_PERMISSION | wantConstant.Flags.FLAG_AUTH_READ_URI_PERMISSION, //配置被分享文件的读写权限，例如对被分享应用进行读写授权
      action: 'ohos.want.action.sendData', //配置分享应用的隐式拉起规则
      uri: uri,
      type: 'image/png'
    }
    return await context.startAbility(want);
  }

}