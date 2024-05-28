import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import { bundleManager } from '@kit.AbilityKit';
import { BusinessError } from '@ohos.base';
import { ToastUtil } from '../action/ToastUtil';
import { AppUtil } from './AppUtil';


/**
 * 申请授权工具类
 */
export class PermissionUtil{

  private constructor() {}


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
   * 校验是否授权后并申请授权,以Promise方式返回
   * @param permissions 需要授权的权限
   * @returns true表示授权成功继续业务操作,false表示用户拒绝授权
   */
  static async checkRequestPermissions(permissions: Permissions): Promise<boolean> {
    let checkStatus = await PermissionUtil.checkPermissions(permissions);
    if (checkStatus) {
      return checkStatus;
    } else {
      let grantStatus = await PermissionUtil.requestPermissions(permissions)
      return grantStatus;
    }
  }


  /**
   * 申请授权,以Promise方式返回
   * @param permissions 需要授权的权限
   * @returns true表示授权成功继续业务操作,false表示用户拒绝授权
   */
  static async requestPermissions(permissions: Permissions): Promise<boolean> {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    let context = AppUtil.getContext();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    let request = await atManager.requestPermissionsFromUser(context, [permissions]);
    let grantStatus: Array<number> = request.authResults;
    let result: boolean = true; //鉴权结果
    for (let i = 0; i < grantStatus.length; i++) {
      if (grantStatus[i] !== 0) {
        result = false; //用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
      }
    }
    return result;
  }


  /**
   * 申请组合授权,以Promise方式返回
   * @param permissions 需要授权的权限集合
   * @returns true表示授权成功继续业务操作,false表示用户拒绝授权
   */
  static async requestPermissionsList(permissions: Array<Permissions>): Promise<boolean> {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    let context = AppUtil.getContext();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    let request = await atManager.requestPermissionsFromUser(context, permissions);
    let grantStatus: Array<number> = request.authResults;
    let result: boolean = true; //鉴权结果
    for (let i = 0; i < grantStatus.length; i++) {
      if (grantStatus[i] !== 0) {
        result = false; //用户未授权授权
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
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
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