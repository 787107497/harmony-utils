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

import notificationManager from '@ohos.notificationManager';
import Base, { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';
import wantAgent from '@ohos.app.ability.wantAgent';
import { WantAgent } from '@ohos.wantAgent';
import { LogUtil } from './LogUtil';
import { DateUtil } from './DateUtil';
import {
    NotificationBasicOptions,
    NotificationLongTextOptions,
    NotificationMultiLineOptions,
    NotificationOptions,
    NotificationPictureOptions,
    NotificationTemplateOptions
} from '../entity/NotificationOptions';
import { NotificationConfig } from '../entity/NotificationConfig';


/**
 * TODO 通知工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class NotificationUtil {

  private constructor() {}

  private static defaultConfig: NotificationConfig = new NotificationConfig(); //默认配置


  /**
   * 设置通知的默认统一配置
   * @param configs
   */
  static setDefaultConfig(configs: (config: NotificationConfig) => void): void {
    configs(NotificationUtil.defaultConfig);
  }


  /**
   * 查询通知是否授权
   */
  static async isNotificationEnabled(): Promise<boolean> {
    return await notificationManager.isNotificationEnabled(); //查询通知是否授权。
  }

  /**
   * 查询通知是否授权
   */
  static isNotificationEnabledSync(): boolean {
    return notificationManager.isNotificationEnabledSync(); //查询通知是否授权。
  }


  /**
   * 请求通知授权，第一次调用会弹窗让用户选择。
   * @returns
   */
  static async authorizeNotification(callBack?: (grant: boolean) => void): Promise<boolean> {
    let isEnabled = await NotificationUtil.isNotificationEnabled(); //查询通知是否授权
    if (!isEnabled) { //未授权，拉起授权
      try {
        let context = getContext() as common.UIAbilityContext;
        await notificationManager.requestEnableNotification(context);
        if (callBack) {
          callBack(true);
        }
        return true;
      } catch (e) {
        if (callBack) {
          callBack(false);
        }
        return false;
      }
    } else {
      if (callBack) {
        callBack(true);
      }
      return true;
    }
  }


  /**
   * 查询模板是否存在，目前仅支持进度条模板。
   * @param templateName 模板名称。当前仅支持'downloadTemplate'。
   * @returns
   */
  static async isSupportTemplate(templateName: string = 'downloadTemplate'): Promise<boolean> {
    return await notificationManager.isSupportTemplate(templateName);
  }


  /**
   * 查询设备是否支持分布式通知
   * @returns
   */
  static async isDistributedEnabled(): Promise<boolean> {
    return await notificationManager.isDistributedEnabled()
  }


  /**
   * 发布普通文本通知
   * @param options  通知实体
   * @returns
   */
  static publishBasic(options: NotificationBasicOptions) {
    try {
      let notificationId: number = options.id ?? NotificationUtil.generateNotificationId(); //通知ID。
      let basicContent: notificationManager.NotificationBasicContent = {
        title: options.title,
        text: options.text
      }
      if (options.additionalText || NotificationUtil.defaultConfig.additionalText) {
        basicContent.additionalText = options.additionalText ?? NotificationUtil.defaultConfig.additionalText;
      }
      if (options.lockscreenPicture || NotificationUtil.defaultConfig.lockscreenPicture) {
        basicContent.lockscreenPicture = options.lockscreenPicture ?? NotificationUtil.defaultConfig.lockscreenPicture;
      }
      let notificationContent: notificationManager.NotificationContent = {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: basicContent
      }
      //通知Request对象
      let notificationRequest = NotificationUtil.getNotificationRequest(notificationId, options, notificationContent);
      //发送通知
      notificationManager.publish(notificationRequest, (err: BusinessError) => {
        if (!err && options.callBack && options.id) {
          options.callBack(options.id); //执行回调
        }
        if (err) {
          LogUtil.error(`发送通知异常：${NotificationUtil.getErrorMsg(err.code, err.code + " - " + err.message)}`);
        }
      });
    } catch (error) {
      let err = error as BusinessError;
      LogUtil.error(`发送通知异常：${NotificationUtil.getErrorMsg(err.code, err.code + " - " + err.message)}`);
    }
  }


  /**
   * 发布长文本通知
   * @param options  通知实体
   * @returns
   */
  static publishLongText(options: NotificationLongTextOptions) {
    try {
      let notificationId: number = options.id ?? NotificationUtil.generateNotificationId(); //通知ID。
      let longTextContent: notificationManager.NotificationLongTextContent = {
        title: options.title,
        text: options.text,
        briefText: options.briefText,
        longText: options.longText,
        expandedTitle: options.expandedTitle
      }
      if (options.additionalText || NotificationUtil.defaultConfig.additionalText) {
        longTextContent.additionalText = options.additionalText ?? NotificationUtil.defaultConfig.additionalText;
      }
      if (options.lockscreenPicture || NotificationUtil.defaultConfig.lockscreenPicture) {
        longTextContent.lockscreenPicture = options.lockscreenPicture ?? NotificationUtil.defaultConfig.lockscreenPicture;
      }
      let notificationContent: notificationManager.NotificationContent = {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
        longText: longTextContent
      }
      //通知Request对象
      let notificationRequest = NotificationUtil.getNotificationRequest(notificationId, options, notificationContent);
      //发送通知
      notificationManager.publish(notificationRequest, (err: Base.BusinessError) => {
        if (!err && options.callBack && options.id) {
          options.callBack(options.id); //执行回调
        }
        if (err) {
          LogUtil.error(`发送通知异常：${NotificationUtil.getErrorMsg(err.code, err.code + " - " + err.message)}`);
        }
      });
    } catch (error) {
      let err = error as BusinessError;
      LogUtil.error(`发送通知异常：${NotificationUtil.getErrorMsg(err.code, err.code + " - " + err.message)}`);
    }
  }


  /**
   * 发布多文本通知
   * @param options  通知实体
   * @returns
   */
  static publishMultiLine(options: NotificationMultiLineOptions) {
    try {
      let notificationId: number = options.id ?? NotificationUtil.generateNotificationId(); //通知ID。
      let multiLineContent: notificationManager.NotificationMultiLineContent = {
        title: options.title,
        text: options.text,
        briefText: options.briefText,
        longTitle: options.longTitle,
        lines: options.lines
      }
      if (options.additionalText || NotificationUtil.defaultConfig.additionalText) {
        multiLineContent.additionalText = options.additionalText ?? NotificationUtil.defaultConfig.additionalText;
      }
      if (options.lockscreenPicture || NotificationUtil.defaultConfig.lockscreenPicture) {
        multiLineContent.lockscreenPicture = options.lockscreenPicture ?? NotificationUtil.defaultConfig.lockscreenPicture;
      }
      let notificationContent: notificationManager.NotificationContent = {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
        multiLine: multiLineContent
      }
      //通知Request对象
      let notificationRequest = NotificationUtil.getNotificationRequest(notificationId, options, notificationContent);
      //发送通知
      notificationManager.publish(notificationRequest, (err: Base.BusinessError) => {
        if (!err && options.callBack && options.id) {
          options.callBack(options.id); //执行回调
        }
        if (err) {
          LogUtil.error(`发送通知异常：${NotificationUtil.getErrorMsg(err.code, err.code + " - " + err.message)}`);
        }
      });
    } catch (error) {
      let err = error as BusinessError;
      LogUtil.error(`发送通知异常：${NotificationUtil.getErrorMsg(err.code, err.code + " - " + err.message)}`);
    }
  }


  /**
   * 发布带有图片的通知
   * @param options  通知实体
   * @returns
   */
  static publishPicture(options: NotificationPictureOptions) {
    try {
      let notificationId: number = options.id ?? NotificationUtil.generateNotificationId(); //通知ID。
      let pictureContent: notificationManager.NotificationPictureContent = {
        title: options.title,
        text: options.text,
        briefText: options.briefText,
        expandedTitle: options.expandedTitle,
        picture: options.picture
      }
      if (options.additionalText || NotificationUtil.defaultConfig.additionalText) {
        pictureContent.additionalText = options.additionalText ?? NotificationUtil.defaultConfig.additionalText;
      }
      if (options.lockscreenPicture || NotificationUtil.defaultConfig.lockscreenPicture) {
        pictureContent.lockscreenPicture = options.lockscreenPicture ?? NotificationUtil.defaultConfig.lockscreenPicture;
      }
      let notificationContent: notificationManager.NotificationContent = {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE,
        picture: pictureContent
      }
      //通知Request对象
      let notificationRequest = NotificationUtil.getNotificationRequest(notificationId, options, notificationContent);
      //发送通知
      notificationManager.publish(notificationRequest, (err: Base.BusinessError) => {
        if (!err && options.callBack && options.id) {
          options.callBack(options.id); //执行回调
        }
        if (err) {
          LogUtil.error(`发送通知异常：${NotificationUtil.getErrorMsg(err.code, err.code + " - " + err.message)}`);
        }
      });
    } catch (error) {
      let err = error as BusinessError;
      LogUtil.error(`发送通知异常：${NotificationUtil.getErrorMsg(err.code, err.code + " - " + err.message)}`);
    }
  }


  /**
   * 发布模板的通知
   * @param options
   */
  static publishTemplate(options: NotificationTemplateOptions){
    try {
      let notificationId: number = options.id ?? NotificationUtil.generateNotificationId(); //通知ID。
      let basicContent: notificationManager.NotificationBasicContent = {
        title: options.title,
        text: options.text
      }
      if (options.additionalText || NotificationUtil.defaultConfig.additionalText) {
        basicContent.additionalText = options.additionalText ?? NotificationUtil.defaultConfig.additionalText;
      }
      if (options.lockscreenPicture || NotificationUtil.defaultConfig.lockscreenPicture) {
        basicContent.lockscreenPicture = options.lockscreenPicture ?? NotificationUtil.defaultConfig.lockscreenPicture;
      }
      let notificationContent: notificationManager.NotificationContent = {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: basicContent
      }
      //模板对象
      let template: notificationManager.NotificationTemplate = {
        name: 'downloadTemplate',
        data: { title: options.title, fileName: options.fileName, progressValue: options.progressValue }
      }
      //通知Request对象
      let notificationRequest = NotificationUtil.getNotificationRequest(notificationId, options, notificationContent, template);
      //发送通知
      notificationManager.publish(notificationRequest, (err: BusinessError) => {
        if (!err && options.callBack && options.id) {
          options.callBack(options.id); //执行回调
        }
        if (err) {
          LogUtil.error(`发送通知异常：${NotificationUtil.getErrorMsg(err.code, err.code + " - " + err.message)}`);
        }
      });
    } catch (error) {
      let err = error as BusinessError;
      LogUtil.error(`发送通知异常：${NotificationUtil.getErrorMsg(err.code, err.code + " - " + err.message)}`);
    }
  }


  /**
   * 取消通知,通过通知ID和通知标签取消已发布的通知，若label为空表示取消与指定通知ID相匹配的已发布通知。
   * @param id 通知id
   * @param label 通知标签，默认为空。
   * @returns
   */
  static async cancel(id: number, label?: string): Promise<void> {
    return await notificationManager.cancel(id, label);
  }

  /**
   * 取消本应用指定组下的通知
   * @param groupName 通知组名称，此名称需要在发布通知时通过NotificationRequest对象指定。
   * @returns
   */
  static async cancelGroup(groupName: string): Promise<void> {
    return await notificationManager.cancelGroup(groupName);
  }

  /**
   * 取消所有通知,取消当前应用所有已发布的通知。
   * @returns
   */
  static async cancelAll(): Promise<void> {
    return await notificationManager.cancelAll()
  }


  /**
   * 设置桌面角标个数，在应用的桌面图标上呈现。
   */
  static async setBadge(badgeNumber: number): Promise<void> {
    return await notificationManager.setBadgeNumber(badgeNumber);
  }

  /**
   * 清空桌面角标，在应用的桌面图标上呈现。
   */
  static async clearBadge(): Promise<void> {
    return await notificationManager.setBadgeNumber(0);
  }


  /**
   * 获取当前应用未删除的通知数量。
   */
  static async getActiveNotificationCount(): Promise<number> {
    return await notificationManager.getActiveNotificationCount();
  }


  /**
   * 设置桌面角标数量，来自于通知数量。
   */
  static async setBadgeFromNotificationCount(): Promise<void> {
    try {
      let count = await NotificationUtil.getActiveNotificationCount();
      notificationManager.setBadgeNumber(count); //设置角标
    } catch (error) {
      const err = error as BusinessError;
      LogUtil.error(`NotificationUtil-setBadgeFromNotificationCount-异常：${NotificationUtil.getErrorMsg(err.code,
        err.code + " - " + err.message)}`);
    }
  }


  /**
   * 获取当前应用未删除的通知列表。
   */
  static async getActiveNotifications(): Promise<Array<notificationManager.NotificationRequest>> {
    return await notificationManager.getActiveNotifications();
  }


  /**
   * 创建指定类型的通知渠道。
   * @param type 要创建的通知渠道的类型
   */
  static async addSlot(type: notificationManager.SlotType) {
    return await notificationManager.addSlot(type);
  }

  /**
   * 获取一个指定类型的通知渠道。
   * @param type 要创建的通知渠道的类型
   */
  static async getSlot(type: notificationManager.SlotType): Promise<notificationManager.NotificationSlot> {
    return await notificationManager.getSlot(type);
  }

  /**
   * 获取此应用程序的所有通知渠道
   * @returns
   */
  static async getSlots(): Promise<Array<notificationManager.NotificationSlot>> {
    return await notificationManager.getSlots();
  }


  /**
   * 删除此应用程序指定类型的通知渠道
   * @param type 通知渠道类型，例如社交通信、服务提醒、内容咨询等类型。
   * @returns
   */
  static async removeSlot(type: notificationManager.SlotType) {
    return await notificationManager.removeSlot(type);
  }

  /**
   * 删除此应用程序所有通知渠道
   * @returns
   */
  static async removeAllSlots() {
    return await notificationManager.removeAllSlots();
  }


  /**
   * 生成通知id（用时间戳当id）
   * @returns
   */
  static generateNotificationId(): number {
    return DateUtil.getTodayTime();
  }


  /**
   * 创建一个可拉起Ability的Want
   * @returns
   */
  static async getDefaultWantAgent(): Promise<WantAgent> {
    let context = getContext() as common.UIAbilityContext; //获取当前上下文对象
    let wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          deviceId: '',
          bundleName: context.abilityInfo.bundleName,
          moduleName: context.abilityInfo.moduleName,
          abilityName: context.abilityInfo.name,
          action: 'action_notice',
          entities: [],
          uri: '',
          // parameters: {
          //   'params_notice': noticeId
          // }
        }
      ],
      actionType: wantAgent.OperationType.START_ABILITY | wantAgent.OperationType.SEND_COMMON_EVENT,
      requestCode: 0,
      actionFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG]
    };
    return await wantAgent.getWantAgent(wantAgentInfo);
  }


  /**
   * 构建NotificationRequest对象
   * @param notificationId 通知ID
   * @param options 描述通知的请求参数
   * @param content 通知内容
   * @param template 模板
   * @returns
   */
  private static getNotificationRequest(notificationId: number, options: NotificationOptions,
    content: notificationManager.NotificationContent, template?: notificationManager.NotificationTemplate): notificationManager.NotificationRequest {
    let request: notificationManager.NotificationRequest = { content: content };
    request.id = notificationId; //通知ID。
    if (template) {
      request.template = template; //模板
    }
    if (options.notificationSlotType || NotificationUtil.defaultConfig.notificationSlotType) {
      request.notificationSlotType = options.notificationSlotType ?? NotificationUtil.defaultConfig.notificationSlotType; //通道类型。
    }
    if (options.deliveryTime || NotificationUtil.defaultConfig.deliveryTime) {
      request.deliveryTime = options.deliveryTime ?? NotificationUtil.defaultConfig.deliveryTime; //通知发送时间。
    }
    request.showDeliveryTime = options.showDeliveryTime ?? NotificationUtil.defaultConfig.showDeliveryTime; //是否显示分发时间。
    request.tapDismissed = options.tapDismissed ?? NotificationUtil.defaultConfig.tapDismissed; //通知是否自动清除。
    if (options.autoDeletedTime || NotificationUtil.defaultConfig.autoDeletedTime) {
      request.autoDeletedTime = options.autoDeletedTime ?? NotificationUtil.defaultConfig.autoDeletedTime; //自动清除的时间。
    }
    request.isAlertOnce = options.isAlertOnce ?? NotificationUtil.defaultConfig.isAlertOnce; //设置是否仅有一次此通知提醒。
    request.isStopwatch = options.isStopwatch ?? NotificationUtil.defaultConfig.isStopwatch; //是否显示已用时间。
    request.isCountDown = options.isCountDown ?? NotificationUtil.defaultConfig.isCountDown; //是否显示倒计时时间。
    request.isFloatingIcon = options.isFloatingIcon ?? NotificationUtil.defaultConfig.isFloatingIcon; //是否显示状态栏图标。

    if (options.label || NotificationUtil.defaultConfig.label) {
      request.label = options.label ?? NotificationUtil.defaultConfig.label; //通知标签。
    }
    if (options.actionButtons || NotificationUtil.defaultConfig.actionButtons) {
      request.actionButtons = options.actionButtons ?? NotificationUtil.defaultConfig.actionButtons; //通知按钮，最多三个按钮。
    }
    if (options.smallIcon || NotificationUtil.defaultConfig.smallIcon) {
      request.smallIcon = options.smallIcon ?? NotificationUtil.defaultConfig.smallIcon; //通知小图标。可选字段，图像像素的总字节数不超过100KB。实际显示效果依赖于设备能力和通知中心UI样式。
    }
    if (options.largeIcon || NotificationUtil.defaultConfig.largeIcon) {
      request.largeIcon = options.largeIcon ?? NotificationUtil.defaultConfig.largeIcon; //通知大图标。可选字段，图像像素的总字节数不超过100KB。实际显示效果依赖于设备能力和通知中心UI样式。
    }
    if (options.groupName || NotificationUtil.defaultConfig.groupName) {
      request.groupName = options.groupName ?? NotificationUtil.defaultConfig.groupName; //组通知名称。
    }
    if (options.template || NotificationUtil.defaultConfig.template) {
      request.template = options.template ?? NotificationUtil.defaultConfig.template; //通知模板。
    }
    if (options.distributedOption || NotificationUtil.defaultConfig.distributedOption) {
      request.distributedOption = options.distributedOption ?? NotificationUtil.defaultConfig.distributedOption; //分布式通知的选项。
    }
    if (options.appMessageId || NotificationUtil.defaultConfig.appMessageId) {
      request.appMessageId = options.appMessageId ?? NotificationUtil.defaultConfig.appMessageId; //应用发送通知携带的唯一标识字段, 用于通知去重。如果同一应用通过本地和云端等不同途径发布携带相同appMessageId的通知，设备只展示一条消息，之后收到的重复通知会被静默去重，不展示、不提醒。去重标识仅在通知发布的24小时内有效，超过24小时或者设备重启失效。。
    }
    if (options.sound || NotificationUtil.defaultConfig.sound) {
      request.sound = options.sound ?? NotificationUtil.defaultConfig.sound; //应用通知自定义铃声，需要通过Push云侧获取自定义发送铃声权限后，该字段才会生效。
    }
    if (options.badgeNumber || NotificationUtil.defaultConfig.badgeNumber) {
      request.badgeNumber = options.badgeNumber ?? NotificationUtil.defaultConfig.badgeNumber; //应用程序图标上显示的通知数。
    }
    if (options.extraInfo || NotificationUtil.defaultConfig.extraInfo) {
      request.extraInfo = options.extraInfo ?? NotificationUtil.defaultConfig.extraInfo; //扩展参数。
    }
    if (options.wantAgent || NotificationUtil.defaultConfig.wantAgent) {
      request.wantAgent = options.wantAgent ?? NotificationUtil.defaultConfig.wantAgent; //WantAgent封装了应用的行为意图，点击通知时触发该行为。
    }
    if (options.removalWantAgent || NotificationUtil.defaultConfig.removalWantAgent) {
      request.removalWantAgent = options.removalWantAgent ?? NotificationUtil.defaultConfig.removalWantAgent; //当移除通知时，通知将被重定向到的WantAgent实例。
    }
    return request;
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
    } else if (1600001 == code) {
      return '应用通知，内部错误！'
    } else if (1600002 == code) {
      return '序列化或反序列化错误！'
    } else if (1600003 == code) {
      return '应用连接通知服务失败！'
    } else if (1600004 == code) {
      return '请开启应用通知开关！'
    } else if (1600005 == code) {
      return '通知渠道关闭！'
    } else if (1600006 == code) {
      return '通知删除失败！'
    } else if (1600007 == code) {
      return '通知不存在！'
    } else if (1600008 == code) {
      return '用户不存在！'
    } else if (1600009 == code) {
      return '通知发布频度超过限制！'
    } else if (1600010 == code) {
      return '分布式操作失败！'
    } else if (1600011 == code) {
      return '读模板配置文件错误！'
    } else if (1600012 == code) {
      return '内存空间不够！'
    } else if (17700001 == code) {
      return '包名不存在！'
    } else {
      return defaultMsg
    }
  }


}
