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

import { WantAgent } from '@kit.AbilityKit';
import { notificationManager } from '@kit.NotificationKit';
import { image } from '@kit.ImageKit';


/**
 * TODO 通知工具类,描述通知的请求参数。
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export interface NotificationOptions {
  id?: number; //通知ID。
  notificationSlotType?: notificationManager.SlotType; //通道类型。
  showDeliveryTime?: boolean; //是否显示分发时间。
  deliveryTime?: number; //通知发送时间。
  tapDismissed?: boolean; //通知是否自动清除。
  autoDeletedTime?: number; //自动清除的时间。
  wantAgent?: WantAgent; //WantAgent封装了应用的行为意图，点击通知时触发该行为。
  extraInfo?: Record<string, Object>; //扩展参数
  isAlertOnce?: boolean; //设置是否仅有一次此通知提醒。
  isStopwatch?: boolean; //是否显示已用时间。
  isCountDown?: boolean; //是否显示倒计时时间。
  isFloatingIcon?: boolean; //是否显示状态栏图标。
  label?: string; //通知标签。
  actionButtons?: Array<notificationManager.NotificationActionButton>; //通知按钮，最多三个按钮。
  smallIcon?: image.PixelMap; //通知小图标。可选字段，图像像素的总字节数不超过100KB。实际显示效果依赖于设备能力和通知中心UI样式。
  largeIcon?: image.PixelMap; //通知大图标。可选字段，图像像素的总字节数不超过100KB。实际显示效果依赖于设备能力和通知中心UI样式。
  groupName?: string; //组通知名称。
  template?: notificationManager.NotificationTemplate; //通知模板。
  distributedOption?: notificationManager.DistributedOptions; //分布式通知的选项。
  removalWantAgent?: WantAgent; //当移除通知时，通知将被重定向到的WantAgent实例。当前不支持跳转UIAbility，只支持发布公共事件及跳转系统Service能力（WantAgent的OperationType >= 3）。
  badgeNumber?: number; //应用程序图标上显示的通知数。
  appMessageId?: string; //应用发送通知携带的唯一标识字段, 用于通知去重。如果同一应用通过本地和云端等不同途径发布携带相同appMessageId的通知，设备只展示一条消息，之后收到的重复通知会被静默去重，不展示、不提醒。去重标识仅在通知发布的24小时内有效，超过24小时或者设备重启失效。
  sound?: string; //应用通知自定义铃声，需要通过Push云侧获取自定义发送铃声权限后，该字段才会生效
}


/**
 * 描述普通文本通知
 */
export interface NotificationBasicOptions extends NotificationOptions {
  title: string; //通知标题（不可为空字符串）。
  text: string; //通知内容（不可为空字符串）。
  additionalText?: string; //通知附加内容，是对通知内容的补充。
  lockscreenPicture?: image.PixelMap; //通知在锁屏界面显示的图片。
}


/**
 * 描述长文本通知
 */
export interface NotificationLongTextOptions extends NotificationBasicOptions {
  briefText: string; //通知概要内容，是对通知内容的总结（不可为空字符串）。
  longText: string; //通知的长文本（不可为空字符串）。
  expandedTitle: string; //通知展开时的标题（不可为空字符串）
}


/**
 * 描述多行文本通知。
 */
export interface NotificationMultiLineOptions extends NotificationBasicOptions {
  briefText: string; //通知概要内容，是对通知内容的总结（不可为空字符串）。
  longTitle: string; //通知展开时的标题（不可为空字符串）。
  lines: Array<string>; //通知的多行文本。
}


/**
 * 描述附有图片的通知。
 */
export interface NotificationPictureOptions extends NotificationBasicOptions {
  briefText: string; //通知概要内容，是对通知内容的总结（不可为空字符串）。
  expandedTitle: string; //通知展开时的标题（不可为空字符串）。
  picture: image.PixelMap; //通知的图片内容(图像像素的总字节数不能超过2MB)。
}


/**
 * 描述模板的通知。
 */
export interface NotificationTemplateOptions extends NotificationBasicOptions {
  // title: string; //通知标题 和 下载标题，共用一个字段。
  fileName: string; //表示下载文件名。必填字段，值为字符串类型。
  progressValue: number; //表示下载进度，值为数值类型。
}