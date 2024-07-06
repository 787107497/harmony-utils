import notificationManager from '@ohos.notificationManager';
import Base, { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';
import wantAgent from '@ohos.app.ability.wantAgent';
import image from '@ohos.multimedia.image';
import { WantAgent } from '@ohos.wantAgent';
import { LogUtil } from './LogUtil';
import { DateUtil } from './DateUtil';


/**
 * 通知工具类
 */
export class NotificationUtil {

  private constructor() {}

  /**
   * 校验是否已授权通知服务
   * @param callBack  回调函数
   * @returns
   */
  static async authorizeNotification(callBack: (grant: boolean) => void): Promise<void> {
    let isAuth = await notificationManager.isNotificationEnabled(); //获取通知使能状态。
    let context = getContext() as common.UIAbilityContext
    if (!isAuth) {
      //未授权，拉起授权,应用请求通知使能模态弹窗。
      notificationManager.requestEnableNotification(context, (err: Base.BusinessError) => {
        if (err) {
          callBack(false);
        } else {
          callBack(true);
        }
      })
    } else {
      callBack(true);
    }
  }


  /**
   * 发布普通文本通知
   * @param options  通知实体
   * @returns
   */
  static async publishBasic(options: NotificationBasicOptions): Promise<void> {
    try {
      if (!options) {
        options = new NotificationBasicOptions();
      }
      if (!options.title) {
        options.title = NotificationUtil.getNotificationTitle(); //通知标题（不可为空字符串）。
      }
      if (!options.text) {
        options.text = options.title; //通知内容（不可为空字符串）。
      }
      if (!options.additionalText) {
        options.additionalText = ''; //通知附加内容，是对通知内容的补充。
      }

      if (!options.id) {
        options.id = NotificationUtil.getNotificationId(); //通知ID。
      }
      if (options.isOngoing == undefined) {
        options.isOngoing = true; //是否进行时通知。
      }
      if (options.isStopwatch == undefined) {
        options.isStopwatch = true; //是否显示已用时间。
      }
      if (options.isAlertOnce == undefined) {
        options.isAlertOnce = false; //设置是否仅有一次此通知提醒。
      }
      if (options.tapDismissed == undefined) {
        options.tapDismissed = true; //通知是否自动清除。
      }
      if (options.isCountDown == undefined) {
        options.isCountDown = false; //是否显示倒计时时间。
      }
      if (options.isFloatingIcon == undefined) {
        options.isFloatingIcon = true; //是否显示状态栏图标。
      }
      if (options.showDeliveryTime == undefined) {
        options.showDeliveryTime = false; //是否显示分发时间。
      }
      if (!options.badgeNumber) {
        options.badgeNumber = 1; //应用程序图标上显示的通知数。
      }
      if (!options.deliveryTime) {
        options.deliveryTime = 0; //通知发送时间。。
      }
      if (!options.autoDeletedTime) {
        options.autoDeletedTime = 1; //自动清除的时间(大于0，否者不显示角标)。
      }
      if (!options.label) {
        options.label = NotificationUtil.getNotificationLabel(); //通知标签。。
      }
      if (!options.creatorBundleName) {
        options.creatorBundleName = NotificationUtil.getCreatorBundleName(); //创建通知的包名。
      }
      if (!options.notificationSlotType) {
        options.notificationSlotType = notificationManager.SlotType.SERVICE_INFORMATION; //通道类型(服务提醒。)。
      }
      let actionButtons = new Array<notificationManager.NotificationActionButton>();
      if (options.actionButtons && options.actionButtons.length > 0) {
        actionButtons = options.actionButtons //通知按钮，最多三个按钮。
      }

      //创建wantAgent
      let wantAgentObj = await NotificationUtil.getWantAgent(options.id);
      //通知Request对象
      let notificationRequest: notificationManager.NotificationRequest = {
        id: options.id,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: options.title,
            text: options.text,
            additionalText: options.additionalText
          }
        },
        isOngoing: options.isOngoing, //是否进行时通知。
        isStopwatch: options.isStopwatch, //是否显示已用时间。
        isAlertOnce: options.isAlertOnce, //设置是否仅有一次此通知提醒。
        badgeNumber: options.badgeNumber, //应用程序图标上显示的通知数。
        label: options.label, //通知标签。
        notificationSlotType: options.notificationSlotType, //通道类型。
        deliveryTime: options.deliveryTime, //通知发送时间。
        tapDismissed: options.tapDismissed, //通知是否自动清除。
        autoDeletedTime: options.autoDeletedTime, //自动清除的时间。
        isCountDown: options.isCountDown, //是否显示倒计时时间。
        isFloatingIcon: options.isFloatingIcon, //是否显示状态栏图标。
        showDeliveryTime: options.showDeliveryTime, //是否显示分发时间。
        creatorBundleName: options.creatorBundleName, //创建通知的包名。
        wantAgent: wantAgentObj, //WantAgent封装了应用的行为意图，点击通知时触发该行为。
        removalWantAgent: wantAgentObj, //当移除通知时，通知将被重定向到的WantAgent实例。
        actionButtons: actionButtons //通知按钮，最多三个按钮。
      };
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
   * 发布多文本通知
   * @param options  通知实体
   * @returns
   */
  static async publishMultiLine(options: NotificationMultiLineOptions): Promise<void> {
    try {
      if (!options) {
        options = new NotificationMultiLineOptions();
      }
      if (!options.title) {
        options.title = NotificationUtil.getNotificationTitle(); //通知标题（不可为空字符串）。
      }
      if (!options.text) {
        options.text = options.title; //通知内容（不可为空字符串）。
      }
      if (!options.additionalText) {
        options.additionalText = ''; //通知附加内容，是对通知内容的补充。
      }
      if (!options.briefText) {
        options.briefText = options.title; //通知概要内容，是对通知内容的总结（不可为空字符串）。
      }
      if (!options.longTitle) {
        options.longTitle = options.title; //通知展开时的标题（不可为空字符串）。
      }
      if (!options.lines) {
        options.lines = [options.text]; //通知的多行文本。
      }

      if (!options.id) {
        options.id = NotificationUtil.getNotificationId(); //通知ID。
      }
      if (options.isOngoing == undefined) {
        options.isOngoing = true; //是否进行时通知。
      }
      if (options.isStopwatch == undefined) {
        options.isStopwatch = false; //是否显示已用时间。
      }
      if (options.isAlertOnce == undefined) {
        options.isAlertOnce = false; //设置是否仅有一次此通知提醒。
      }
      if (options.tapDismissed == undefined) {
        options.tapDismissed = true; //通知是否自动清除。
      }
      if (options.isCountDown == undefined) {
        options.isCountDown = false; //是否显示倒计时时间。
      }
      if (options.isFloatingIcon == undefined) {
        options.isFloatingIcon = true; //是否显示状态栏图标。
      }
      if (options.showDeliveryTime == undefined) {
        options.showDeliveryTime = false; //是否显示分发时间。
      }
      if (!options.badgeNumber) {
        options.badgeNumber = 1; //应用程序图标上显示的通知数。
      }
      if (!options.deliveryTime) {
        options.deliveryTime = 0; //通知发送时间。。
      }
      if (!options.autoDeletedTime) {
        options.autoDeletedTime = 1; //自动清除的时间(大于0，否者不显示角标)。
      }
      if (!options.label) {
        options.label = NotificationUtil.getNotificationLabel(); //通知标签。。
      }
      if (!options.creatorBundleName) {
        options.creatorBundleName = NotificationUtil.getCreatorBundleName(); //创建通知的包名。
      }
      if (!options.notificationSlotType) {
        options.notificationSlotType = notificationManager.SlotType.SERVICE_INFORMATION; //通道类型(服务提醒。)。
      }
      let actionButtons = new Array<notificationManager.NotificationActionButton>();
      if (options.actionButtons && options.actionButtons.length > 0) {
        actionButtons = options.actionButtons //通知按钮，最多三个按钮。
      }

      //创建wantAgent
      let wantAgentObj = await NotificationUtil.getWantAgent(options.id);
      //通知Request对象
      let notificationRequest: notificationManager.NotificationRequest = {
        id: options.id,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
          multiLine: {
            title: options.title,
            text: options.text,
            additionalText: options.additionalText,
            briefText: options.briefText,
            longTitle: options.longTitle,
            lines: options.lines
          }
        },
        isOngoing: options.isOngoing, //是否进行时通知。
        isStopwatch: options.isStopwatch, //是否显示已用时间。
        isAlertOnce: options.isAlertOnce, //设置是否仅有一次此通知提醒。
        badgeNumber: options.badgeNumber, //应用程序图标上显示的通知数。
        label: options.label, //通知标签。
        notificationSlotType: options.notificationSlotType, //通道类型。
        deliveryTime: options.deliveryTime, //通知发送时间。
        tapDismissed: options.tapDismissed, //通知是否自动清除。
        autoDeletedTime: options.autoDeletedTime, //自动清除的时间。
        isCountDown: options.isCountDown, //是否显示倒计时时间。
        isFloatingIcon: options.isFloatingIcon, //是否显示状态栏图标。
        showDeliveryTime: options.showDeliveryTime, //是否显示分发时间。
        creatorBundleName: options.creatorBundleName, //创建通知的包名。
        wantAgent: wantAgentObj, //WantAgent封装了应用的行为意图，点击通知时触发该行为。
        removalWantAgent: wantAgentObj, //当移除通知时，通知将被重定向到的WantAgent实例。
        actionButtons: actionButtons //通知按钮，最多三个按钮。
      };
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
   * 发布长文本通知
   * @param options  通知实体
   * @returns
   */
  static async publishLongText(options: NotificationLongTextOptions): Promise<void> {
    try {
      if (!options) {
        options = new NotificationLongTextOptions();
      }
      if (!options.title) {
        options.title = NotificationUtil.getNotificationTitle(); //通知标题（不可为空字符串）。
      }
      if (!options.text) {
        options.text = options.title; //通知内容（不可为空字符串）。
      }
      if (!options.additionalText) {
        options.additionalText = ''; //通知附加内容，是对通知内容的补充。
      }
      if (!options.briefText) {
        options.briefText = options.title; //通知概要内容，是对通知内容的总结（不可为空字符串）。
      }
      if (!options.expandedTitle) {
        options.expandedTitle = options.title; //通知展开时的标题（不可为空字符串）
      }
      if (!options.longText) {
        options.longText = options.text; //通知的长文本（不可为空字符串）。
      }

      if (!options.id) {
        options.id = NotificationUtil.getNotificationId(); //通知ID。
      }
      if (options.isOngoing == undefined) {
        options.isOngoing = true; //是否进行时通知。
      }
      if (options.isStopwatch == undefined) {
        options.isStopwatch = true; //是否显示已用时间。
      }
      if (options.isAlertOnce == undefined) {
        options.isAlertOnce = false; //设置是否仅有一次此通知提醒。
      }
      if (options.tapDismissed == undefined) {
        options.tapDismissed = true; //通知是否自动清除。
      }
      if (options.isCountDown == undefined) {
        options.isCountDown = false; //是否显示倒计时时间。
      }
      if (options.isFloatingIcon == undefined) {
        options.isFloatingIcon = true; //是否显示状态栏图标。
      }
      if (options.showDeliveryTime == undefined) {
        options.showDeliveryTime = false; //是否显示分发时间。
      }
      if (!options.badgeNumber) {
        options.badgeNumber = 1; //应用程序图标上显示的通知数。
      }
      if (!options.deliveryTime) {
        options.deliveryTime = 0; //通知发送时间。。
      }
      if (!options.autoDeletedTime) {
        options.autoDeletedTime = 1; //自动清除的时间(大于0，否者不显示角标)。
      }
      if (!options.label) {
        options.label = NotificationUtil.getNotificationLabel(); //通知标签。。
      }
      if (!options.creatorBundleName) {
        options.creatorBundleName = NotificationUtil.getCreatorBundleName(); //创建通知的包名。
      }
      if (!options.notificationSlotType) {
        options.notificationSlotType = notificationManager.SlotType.SERVICE_INFORMATION; //通道类型(服务提醒。)。
      }
      let actionButtons = new Array<notificationManager.NotificationActionButton>();
      if (options.actionButtons && options.actionButtons.length > 0) {
        actionButtons = options.actionButtons //通知按钮，最多三个按钮。
      }

      //创建wantAgent
      let wantAgentObj = await NotificationUtil.getWantAgent(options.id);
      //通知Request对象
      let notificationRequest: notificationManager.NotificationRequest = {
        id: options.id,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
          longText: {
            title: options.title,
            text: options.text,
            additionalText: options.additionalText,
            briefText: options.briefText,
            longText: options.longText,
            expandedTitle: options.expandedTitle
          }
        },
        isOngoing: options.isOngoing, //是否进行时通知。
        isStopwatch: options.isStopwatch, //是否显示已用时间。
        isAlertOnce: options.isAlertOnce, //设置是否仅有一次此通知提醒。
        badgeNumber: options.badgeNumber, //应用程序图标上显示的通知数。
        label: options.label, //通知标签。
        notificationSlotType: options.notificationSlotType, //通道类型。
        deliveryTime: options.deliveryTime, //通知发送时间。
        tapDismissed: options.tapDismissed, //通知是否自动清除。
        autoDeletedTime: options.autoDeletedTime, //自动清除的时间。
        isCountDown: options.isCountDown, //是否显示倒计时时间。
        isFloatingIcon: options.isFloatingIcon, //是否显示状态栏图标。
        showDeliveryTime: options.showDeliveryTime, //是否显示分发时间。
        creatorBundleName: options.creatorBundleName, //创建通知的包名。
        wantAgent: wantAgentObj, //WantAgent封装了应用的行为意图，点击通知时触发该行为。
        removalWantAgent: wantAgentObj, //当移除通知时，通知将被重定向到的WantAgent实例。
        actionButtons: actionButtons //通知按钮，最多三个按钮。
      };
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
   * 发布带有图片的通知（该方法为OpenHarmony的API,目前暂不支持HarmonyOS）
   * @param options  通知实体
   * @returns
   */
  static async publishPicture(options: NotificationPictureOptions): Promise<void> {
    try {
      if (!options) {
        options = new NotificationPictureOptions();
      }
      if (!options.title) {
        options.title = NotificationUtil.getNotificationTitle(); //通知标题（不可为空字符串）。
      }
      if (!options.text) {
        options.text = options.title; //通知内容（不可为空字符串）。
      }
      if (!options.additionalText) {
        options.additionalText = ''; //通知附加内容，是对通知内容的补充。
      }
      if (!options.briefText) {
        options.briefText = options.title; //通知概要内容，是对通知内容的总结（不可为空字符串）。
      }
      if (!options.expandedTitle) {
        options.expandedTitle = options.title; //通知展开时的标题（不可为空字符串）。
      }
      if (!options.picture) { //通知的图片内容(图像像素的总字节数不能超过2MB)。
        let ctx = getContext() as common.UIAbilityContext;
        let buffer: ArrayBuffer = ctx.resourceManager.getMediaContentSync($r("app.media.icon_ring")).buffer as ArrayBuffer;
        options.picture = await image.createImageSource(buffer).createPixelMap();
      }

      if (!options.id) {
        options.id = NotificationUtil.getNotificationId(); //通知ID。
      }
      if (options.isOngoing == undefined) {
        options.isOngoing = true; //是否进行时通知。
      }
      if (options.isStopwatch == undefined) {
        options.isStopwatch = false; //是否显示已用时间。
      }
      if (options.isAlertOnce == undefined) {
        options.isAlertOnce = false; //设置是否仅有一次此通知提醒。
      }
      if (options.tapDismissed == undefined) {
        options.tapDismissed = true; //通知是否自动清除。
      }
      if (options.isCountDown == undefined) {
        options.isCountDown = false; //是否显示倒计时时间。
      }
      if (options.isFloatingIcon == undefined) {
        options.isFloatingIcon = true; //是否显示状态栏图标。
      }
      if (options.showDeliveryTime == undefined) {
        options.showDeliveryTime = false; //是否显示分发时间。
      }
      if (!options.badgeNumber) {
        options.badgeNumber = 1; //应用程序图标上显示的通知数。
      }
      if (!options.deliveryTime) {
        options.deliveryTime = 0; //通知发送时间。。
      }
      if (!options.autoDeletedTime) {
        options.autoDeletedTime = 1; //自动清除的时间(大于0，否者不显示角标)。
      }
      if (!options.label) {
        options.label = NotificationUtil.getNotificationLabel(); //通知标签。。
      }
      if (!options.creatorBundleName) {
        options.creatorBundleName = NotificationUtil.getCreatorBundleName(); //创建通知的包名。
      }
      if (!options.notificationSlotType) {
        options.notificationSlotType = notificationManager.SlotType.SERVICE_INFORMATION; //通道类型(服务提醒。)。
      }
      let actionButtons = new Array<notificationManager.NotificationActionButton>();
      if (options.actionButtons && options.actionButtons.length > 0) {
        actionButtons = options.actionButtons //通知按钮，最多三个按钮。
      }

      //创建wantAgent
      let wantAgentObj = await NotificationUtil.getWantAgent(options.id);
      //通知Request对象
      let notificationRequest: notificationManager.NotificationRequest = {
        id: options.id,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE,
          picture: {
            title: options.title,
            text: options.text,
            additionalText: options.additionalText,
            briefText: options.briefText,
            expandedTitle: options.expandedTitle,
            picture: options.picture
          }
        },
        isOngoing: options.isOngoing, //是否进行时通知。
        isStopwatch: options.isStopwatch, //是否显示已用时间。
        isAlertOnce: options.isAlertOnce, //设置是否仅有一次此通知提醒。
        badgeNumber: options.badgeNumber, //应用程序图标上显示的通知数。
        label: options.label, //通知标签。
        notificationSlotType: options.notificationSlotType, //通道类型。
        deliveryTime: options.deliveryTime, //通知发送时间。
        tapDismissed: options.tapDismissed, //通知是否自动清除。
        autoDeletedTime: options.autoDeletedTime, //自动清除的时间。
        isCountDown: options.isCountDown, //是否显示倒计时时间。
        isFloatingIcon: options.isFloatingIcon, //是否显示状态栏图标。
        showDeliveryTime: options.showDeliveryTime, //是否显示分发时间。
        creatorBundleName: options.creatorBundleName, //创建通知的包名。
        wantAgent: wantAgentObj, //WantAgent封装了应用的行为意图，点击通知时触发该行为。
        removalWantAgent: wantAgentObj, //当移除通知时，通知将被重定向到的WantAgent实例。
        actionButtons: actionButtons //通知按钮，最多三个按钮。
      };
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
   * 取消通知,通过通知ID和通知标签取消已发布的通知，若label为空表示取消与指定通知ID相匹配的已发布通知。
   * @param id 通知id
   * @param label 通知标签，默认为空。
   * @returns
   */
  static async cancel(id: number, label?: string): Promise<void> {
    return await notificationManager.cancel(id, label);
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
   * 设置桌面角标数量，来自于通知数量。
   */
  static async setBadgeFromNotificationCount(): Promise<void> {
    try {
      let count = await NotificationUtil.getActiveNotificationCount();
      notificationManager.setBadgeNumber(count); //设置角标
    } catch (error) {
      const err = error as BusinessError;
      LogUtil.error(`NotificationUtil-setBadgeFromNotificationCount-异常：${NotificationUtil.getErrorMsg(err.code, err.code + " - " + err.message)}`);
    }
  }


  /**
   * 获取当前应用未删除的通知数量。
   */
  static async getActiveNotificationCount(): Promise<number> {
    return await notificationManager.getActiveNotificationCount();
  }


  /**
   * 获取当前应用未删除的通知列表。
   */
  static async getActiveNotifications(): Promise<Array<notificationManager.NotificationRequest>> {
    return await notificationManager.getActiveNotifications();
  }


  /**
   * 获取默认通知title
   * @returns
   */
  private static getNotificationTitle(): string {
    let context = getContext() as common.UIAbilityContext
    return '来自' + context.applicationInfo.label + '通知'
  }

  /**
   * 获取默认通知label
   * @returns
   */
  private static getNotificationLabel(): string {
    let context = getContext() as common.UIAbilityContext
    return context.applicationInfo.label
  }

  /**
   * 创建通知的包名
   */
  private static getCreatorBundleName() {
    let context = getContext() as common.UIAbilityContext
    return context.abilityInfo.bundleName
  }

  /**
   * 生成通知id（用时间戳当id）
   * @returns
   */
  private static getNotificationId(): number {
    return DateUtil.getTodayTime();
  }

  /**
   * 创建一个可拉起Ability的Want
   * @returns
   */
  private static async getWantAgent(noticeId: number): Promise<WantAgent> {
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
          parameters: {
            'params_notice': noticeId
          }
        }
      ],
      actionType: wantAgent.OperationType.START_ABILITY | wantAgent.OperationType.SEND_COMMON_EVENT,
      requestCode: 0,
      actionFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG]
    };
    return await wantAgent.getWantAgent(wantAgentInfo);
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


/**
 * 描述通知的请求参数。
 */
export class NotificationOptions {
  id?: number; //通知ID。
  isOngoing?: boolean; //是否进行时通知。
  isStopwatch?: boolean; //是否显示已用时间。
  isAlertOnce?: boolean; //设置是否仅有一次此通知提醒。
  badgeNumber?: number; //应用程序图标上显示的通知数。
  label?: string; //通知标签。
  wantAgent?: WantAgent; //WantAgent封装了应用的行为意图，点击通知时触发该行为。
  notificationSlotType?: notificationManager.SlotType; //通道类型。
  actionButtons?: Array<notificationManager.NotificationActionButton>; //通知按钮，最多三个按钮。
  deliveryTime?: number; //通知发送时间。
  tapDismissed?: boolean; //通知是否自动清除。
  autoDeletedTime?: number; //自动清除的时间。
  isCountDown?: boolean; //是否显示倒计时时间。
  isFloatingIcon?: boolean; //是否显示状态栏图标。
  showDeliveryTime?: boolean; //是否显示分发时间。
  creatorBundleName?: string; //创建通知的包名。
  removalWantAgent?: WantAgent; //当移除通知时，通知将被重定向到的WantAgent实例。当前不支持跳转UIAbility，只支持发布公共事件及跳转系统Service能力（WantAgent的OperationType >= 3）。
}


/**
 * 描述普通文本通知
 */
export class NotificationBasicOptions extends NotificationOptions {
  title: string = ''; //通知标题（不可为空字符串）。
  text: string = ''; //通知内容（不可为空字符串）。
  additionalText?: string = ''; //通知附加内容，是对通知内容的补充。
  callBack?: (noticeId: number) => void; //业务回调函数
}


/**
 * 描述多行文本通知。
 */
export class NotificationMultiLineOptions extends NotificationBasicOptions {
  briefText?: string = ''; //通知概要内容，是对通知内容的总结（不可为空字符串）。
  longTitle: string = ''; //通知展开时的标题（不可为空字符串）。
  lines: Array<string> = []; //通知的多行文本。
}


/**
 * 描述长文本通知
 */
export class NotificationLongTextOptions extends NotificationBasicOptions {
  briefText?: string = ''; //通知概要内容，是对通知内容的总结（不可为空字符串）。
  expandedTitle: string = ''; //通知展开时的标题（不可为空字符串）
  longText: string = ''; //通知的长文本（不可为空字符串）。
}


/**
 * 描述附有图片的通知。
 */
export class NotificationPictureOptions extends NotificationBasicOptions {
  briefText?: string = ''; //通知概要内容，是对通知内容的总结（不可为空字符串）。
  expandedTitle: string = ''; //通知展开时的标题（不可为空字符串）。
  picture?: image.PixelMap; //通知的图片内容(图像像素的总字节数不能超过2MB)。
}
