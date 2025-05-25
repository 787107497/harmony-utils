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

import { userAuth } from '@kit.UserAuthenticationKit';
import { BusinessError, Callback } from '@kit.BasicServicesKit';
import { LogUtil } from './LogUtil';
import { ToastUtil } from '../action/ToastUtil';
import { AuthOptions, StatusResult } from '../entity/AuthOptions';
import { StrUtil } from './StrUtil';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';

/**
 * TODO 手机的生物认证（指纹、人脸、密码）工具类
 * 需要权限 ohos.permission.ACCESS_BIOMETRIC
 *
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class AuthUtil {

  private static userAuthInstance: userAuth.UserAuthInstance; //认证对象

  /**
   * 查询指定类型和等级的认证能力是否支持。
   * @param authType
   * @param authTrustLevel
   * @returns
   */
  static getAvailableStatus(authType: userAuth.UserAuthType, authTrustLevel: userAuth.AuthTrustLevel): StatusResult {
    try {
      userAuth.getAvailableStatus(authType, authTrustLevel);
      return { status: true };
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AuthUtil-getAvailableStatus-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return { status: false, errorCode: error.code, errorMsg: AuthUtil.getErrorMsg(error.code) };
    }
  }


  /**
   * 开始认证,使用指纹和密码认证
   * @param showTip 是否显示提示语
   * @param callBack
   */
  static onStartEasy(showTip: boolean = false, callBack: Callback<userAuth.UserAuthResult>) {
    const options: AuthOptions = new AuthOptions();
    LogUtil.error(JSON.stringify(options, null, 2));
    options.showTip = showTip;
    AuthUtil.onStart(options, callBack);
  }


  /**
   * 开始认证，用户指定类型认证
   * @param options
   * @param callBack
   */
  static onStart(options: AuthOptions, callBack: Callback<userAuth.UserAuthResult>) {
    try {
      if (options.challenge === undefined) {
        options.challenge = AuthUtil.generateChallenge(); //挑战值，用来防重放攻击。最大长度为32字节，可传Uint8Array([])
      }
      if (options.authType === undefined || options.authType.length <= 0) {
        options.authType = [userAuth.UserAuthType.FINGERPRINT, userAuth.UserAuthType.FACE, userAuth.UserAuthType.PIN]; //认证类型列表，用来指定用户认证界面提供的认证方法。
      }
      if (options.authTrustLevel === undefined) {
        options.authTrustLevel = userAuth.AuthTrustLevel.ATL3; //认证信任等级。
      }
      if (options.title === undefined) {
        options.title = '请验证身份'; //用户认证界面的标题，最大长度为500字符。
      }
      if (options.showTip === undefined) {
        options.showTip = false; //默认不显示提示语
      }
      const authParam: userAuth.AuthParam = {
        challenge: options.challenge,
        authType: options.authType,
        authTrustLevel: options.authTrustLevel,
      };
      if (options.navigationButtonText) {
        AuthUtil.userAuthInstance = userAuth.getUserAuthInstance(authParam, {
          title: options.title, navigationButtonText: options.navigationButtonText });
      } else {
        AuthUtil.userAuthInstance = userAuth.getUserAuthInstance(authParam, { title: options.title });
      }
      AuthUtil.userAuthInstance.on('result', {
        onResult(result) {
          callBack?.(result);
          if (userAuth.UserAuthResultCode.SUCCESS === result.result && options.showTip) {
            const errorTip = AuthUtil.getErrorMsg(result.result, '');
            if (StrUtil.isNotEmpty(errorTip)) {
              ToastUtil.showToast(errorTip);
            }
          }
        }
      });
      AuthUtil.userAuthInstance.start(); //开始认证
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AuthUtil-onStart-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      if (options.showTip) {
        ToastUtil.showToast(AuthUtil.getErrorMsg(error.code, '认证失败：' + error.message));
      }
    }
  }


  /**
   * 取消认证
   */
  static cancel() {
    try {
      if (AuthUtil.userAuthInstance) {
        AuthUtil.userAuthInstance.cancel(); //取消认证
        AuthUtil.userAuthInstance.off('result'); //取消订阅用户身份认证结果
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`AuthUtil-cancel-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }


  /**
   * 生成挑战值,用来防重放攻击。
   * @param len  最大长度为32
   * @returns
   */
  static generateChallenge(len: number = 16) {
    const rand = cryptoFramework.createRandom();
    const randData: Uint8Array = rand.generateRandomSync((len > 0 && len <= 32) ? len : 16).data;
    return randData;
  }


  /**
   * 获取错误msg
   * @param code
   * @param defaultMsg
   */
  static getErrorMsg(code: number, defaultMsg: string = ''): string {
    if (201 == code) {
      return '权限校验失败！'
    } else if (202 == code) {
      return '系统API权限校验失败！'
    } else if (401 == code) {
      return '参数检查失败！'
    } else if (801 == code) {
      return '该设备不支持此API！'
    } else if (12500001 == code) {
      return '认证失败！'
    } else if (12500002 == code) {
      return '一般的操作错误！'
    } else if (12500003 == code) {
      return '认证被取消！'
    } else if (12500004 == code) {
      return '认证操作超时！'
    } else if (12500005 == code) {
      return '认证类型不支持！'
    } else if (12500006 == code) {
      return '认证信任等级不支持！'
    } else if (12500007 == code) {
      return '认证服务已经繁忙！'
    } else if (12500009 == code) {
      return '认证被锁定！'
    } else if (12500010 == code) {
      return '该类型的凭据没有录入！'
    } else if (12500011 == code) {
      return '认证被控件取消！'
    } else if (12700001 == code) {
      return '人脸录入过程中的操作失败！'
    } else {
      return defaultMsg
    }
  }


}