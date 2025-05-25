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

import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import { bundleManager, common, PermissionRequestResult } from '@kit.AbilityKit';
import { BusinessError } from '@ohos.base';
import { ToastUtil } from '../action/ToastUtil';


/**
 * TODO 申请授权工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class PermissionUtil {


  /**
   * 校验当前是否已经授权
   * @param permissions  待判断的权限
   * @returns 已授权true,未授权false
   */
  static async checkPermissions(permissions: Permissions): Promise<boolean> {
    let grantStatus: abilityAccessCtrl.GrantStatus = await PermissionUtil.checkAccessToken(permissions);
    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) { //判断是否授权
      return true; //已经授权
    } else {
      return false; //未授权
    }
  }


  /**
   * 校验是否授权后并申请授权。
   * @param permissions 需要授权的权限
   * @returns true表示授权成功继续业务操作,false表示用户拒绝授权
   */
  static async checkRequestPermissions(permissions: Permissions): Promise<boolean> {
    let checkStatus = await PermissionUtil.checkPermissions(permissions);
    if (checkStatus) {
      return checkStatus;
    } else {
      return PermissionUtil.requestPermissions(permissions);
    }
  }


  /**
   * 申请授权（支持权限组合）
   * @param permissions 需要授权的权限
   * @returns true表示授权成功继续业务操作,false表示用户拒绝授权
   */
  static async requestPermissions(permissions: Permissions | Array<Permissions>): Promise<boolean> {
    const atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    const context: Context = getContext() as common.UIAbilityContext;
    //requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    let request = await atManager.requestPermissionsFromUser(context,
      Array.isArray(permissions) ? [...permissions] : [permissions]);
    let requestGrant: boolean = PermissionUtil.getGrantSuccess(request); //鉴权结果
    return requestGrant;
  }


  /**
   * 申请授权,拒绝后并二次向用户申请授权（申请权限，建议使用该方法）。
   * @param permissions
   * @returns
   */
  static async requestPermissionsEasy(permissions: Permissions | Array<Permissions>): Promise<boolean> {
    const atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    const context: Context = getContext() as common.UIAbilityContext;
    const ps: Array<Permissions> = Array.isArray(permissions) ? [...permissions] : [permissions];
    //requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    let request = await atManager.requestPermissionsFromUser(context, ps);
    let requestGrant: boolean = PermissionUtil.getGrantSuccess(request); //鉴权结果
    if (requestGrant) {
      return requestGrant;
    } else {
      return PermissionUtil.requestPermissionOnSettingEasy(ps); //二次向用户申请授权
    }
  }


  /**
   * 二次向用户申请授权（单个权限 或 读写权限组，建议使用该方法）。
   * @param permissions 需要授权的权限集合
   * @returns true表示授权成功继续业务操作,false表示用户拒绝授权
   */
  static async requestPermissionOnSetting(permissions: Permissions | Array<Permissions>): Promise<boolean> {
    const atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    const context: Context = getContext() as common.UIAbilityContext;
    //requestPermissionOnSetting会判断权限的授权状态来决定是否唤起弹窗
    let grantStatus = await atManager.requestPermissionOnSetting(context,
      Array.isArray(permissions) ? [...permissions] : [permissions]);
    let result: boolean = PermissionUtil.getGrantSuccess(grantStatus); //鉴权结果
    return result;
  }


  /**
   * 二次向用户申请授权（多个权限建议使用该方法）。
   * @param permissions 需要授权的权限集合
   */
  static async requestPermissionOnSettingEasy(permissions: Array<Permissions>): Promise<boolean> {
    for (let i = 0; i < permissions.length; i++) {
      let check = await PermissionUtil.checkPermissions(permissions[i]); //判断是否授权。
      if (!check) { //未授权，二次向用户申请授权。
        let grant = await PermissionUtil.requestPermissionOnSetting(permissions[i]);
        if (!grant) { //二次向用户申请授权，拒绝后，直接返回false。
          return false;
        }
      }
    }
    return true;
  }


  /**
   * 用于UIAbility/UIExtensionAbility拉起全局开关设置弹框。部分情况下，录音、拍照等功能禁用，应用可拉起此弹框请求用户同意开启对应功能。如果当前全局开关的状态为开启，则不拉起弹框
   * @param type 全局开关类型。
   * @returns
   */
  static async requestGlobalSwitch(type: abilityAccessCtrl.SwitchType): Promise<boolean> {
    const atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    const context: Context = getContext() as common.UIAbilityContext;
    return await atManager.requestGlobalSwitch(context, type);
  }


  /**
   * 判断是否授权成功
   */
  private static getGrantSuccess(data: PermissionRequestResult | Array<abilityAccessCtrl.GrantStatus>): boolean {
    let result: boolean = true; //鉴权结果
    let grantStatus: Array<number> = Array.isArray(data) ? data : data.authResults;
    for (let i = 0; i < grantStatus.length; i++) {
      if (grantStatus[i] !== abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        result = false; //用户未授权授权 或 拒绝授权。
      }
    }
    return result;
  }


  /**
   * 检查是否授权
   * @param permission 待检查权限
   * @returns 授权状态
   */
  private static async checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    const atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;
    let tokenId: number = 0; //获取应用程序的accessTokenID
    try {
      let bundleInfo: bundleManager.BundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId;
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      ToastUtil.showToast('获取应用信息失败:' + err.message);
    }
    //校验应用是否被授予权限
    try {
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      ToastUtil.showToast('校验授权信息失败:' + err.message);
    }
    return grantStatus;
  }


}