import { AbilityLifecycleCallback, common, UIAbility, WantAgent, wantAgent } from '@kit.AbilityKit';
import {
  CacheUtil,
  FileUtil,
  LogUtil,
  NotificationBasicOptions,
  NotificationUtil,
  PreviewUtil
} from '@pura/harmony-utils';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * ArkWeb内部工具类
 */
export class Utils {

  private static downloadPath: string = ""; //下载文件Path。


  /**
   * 设置下载文件夹路径，仅SDK内部使用
   */
  static setDownloadPath(path: string) {
    Utils.downloadPath = path;
  }

  /**
   * 获取ArkWeb文件夹下载路径，仅SDK内部使用
   */
  static getArkDownloadPath(): string {
    return Utils.downloadPath;
  }


  /**
   * 注册监听应用内生命周期。
   */
  static onAbilityLifecycle(context: common.UIAbilityContext) {
    try {
      const abilityLifecycleCallback: AbilityLifecycleCallback = {
        onAbilityCreate: (ability: UIAbility): void => {

        },
        onNewWant:(ability: UIAbility): void => {
          let parameters = ability.lastRequestWant.parameters;
          if (parameters) {
            let uri = parameters["uri"] as string;
            let filePreview = parameters["filePreview"];
            if ('filePreview' === filePreview && uri) {
              PreviewUtil.openPreviewEasy(uri)
            }
          }
        },
        onWindowStageCreate: (ability: UIAbility, windowStage: window.WindowStage): void => {
          let parameters = ability.lastRequestWant.parameters;
          if (parameters) {
            let uri = parameters["uri"] as string;
            let filePreview = parameters["filePreview"];
            if ('filePreview' === filePreview && uri) {
              PreviewUtil.openPreviewEasy(uri)
            }
          }
        },
        onWindowStageActive: (ability: UIAbility, windowStage: window.WindowStage): void => {

        },
        onWindowStageInactive: (ability: UIAbility, windowStage: window.WindowStage): void => {

        },
        onWindowStageDestroy: (ability: UIAbility, windowStage: window.WindowStage): void => {

        },
        onAbilityDestroy: (ability: UIAbility): void => {

        },
        onAbilityForeground: (ability: UIAbility): void => {

        },
        onAbilityBackground: (ability: UIAbility): void => {

        },
        onAbilityContinue: (ability: UIAbility): void => {

        }
      }
      context.getApplicationContext().on('abilityLifecycle', abilityLifecycleCallback);
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`abilityLifecycleCallback-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }


  /**
   * 下载文件，发送通知
   * @param notificationKey
   * @param fileName 文件名
   * @param percent 进度
   * @param state 0-下载中，-1-下载失败，1-下载成功，
   */
  static async sendNotification(notificationKey: string, fileName: string, percent: number, state: number) {
    let notificationId = CacheUtil.get<number>(notificationKey);
    let content = `正在下载：${percent}%`;
    if (state === 1) {
      content = `下载完成`;
    } else if (state === -1) {
      content = `下载失败`;
    }
    let savePath = `${Utils.getArkDownloadPath()}/${fileName}`; //下载文件路径
    let want = await Utils.getDownloadWantAgent(FileUtil.getUriFromPath(savePath));
    let basicOptions: NotificationBasicOptions = {
      id: notificationId,
      title: fileName,
      text: content,
      tapDismissed: state !== 0,
      isAlertOnce: true,
      badgeNumber: 0,
      wantAgent: state == 1 ? want : undefined,
    }
    NotificationUtil.publishBasic(basicOptions);
  }


  /**
   * 创建一个可拉起Ability的Want
   * @returns
   */
  static async getDownloadWantAgent(uri: string): Promise<WantAgent> {
    const context = getContext() as common.UIAbilityContext; //获取当前上下文对象
    const wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          bundleName: context.abilityInfo.bundleName,
          moduleName: context.abilityInfo.moduleName,
          abilityName: context.abilityInfo.name,
          action: 'action_notice',
          parameters: {
            "uri": uri,
            "filePreview": "filePreview"
          }
        }
      ],
      actionType: wantAgent.OperationType.START_ABILITY | wantAgent.OperationType.SEND_COMMON_EVENT,
      requestCode: 0,
      actionFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG]
    };
    return wantAgent.getWantAgent(wantAgentInfo);
  }


}