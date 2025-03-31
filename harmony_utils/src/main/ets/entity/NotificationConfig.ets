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


import { notificationManager } from '@kit.NotificationKit';
import { WantAgent } from '@kit.AbilityKit';
import { image } from '@kit.ImageKit';


/**
 * TODO 通知工具类,默认配置参数
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export class NotificationConfig {
  notificationSlotType: notificationManager.SlotType = notificationManager.SlotType.SERVICE_INFORMATION; //通道类型，默认服务类型。
  deliveryTime?: number; //通知发送时间。
  tapDismissed: boolean = false; //通知是否自动清除。
  autoDeletedTime?: number; //自动清除的时间(大于0，否者不显示角标)。
  wantAgent?: WantAgent; //WantAgent封装了应用的行为意图，点击通知时触发该行为。
  extraInfo?: Record<string, Object>; //扩展参数
  isAlertOnce: boolean = false; //设置是否仅有一次此通知提醒。
  isStopwatch: boolean = false; //是否显示已用时间。
  isCountDown: boolean = false; //是否显示倒计时时间。
  isFloatingIcon: boolean = true; //是否显示状态栏图标。
  label?: string; //通知标签。
  badgeIconStyle?: number; //通知角标类型。
  showDeliveryTime: boolean = false; //是否显示分发时间。
  actionButtons?: Array<notificationManager.NotificationActionButton>; //通知按钮，最多三个按钮。
  smallIcon?: image.PixelMap; //通知小图标。可选字段，图像像素的总字节数不超过100KB。实际显示效果依赖于设备能力和通知中心UI样式。
  largeIcon?: image.PixelMap; //通知大图标。可选字段，图像像素的总字节数不超过100KB。实际显示效果依赖于设备能力和通知中心UI样式。
  groupName?: string; //组通知名称。
  template?: notificationManager.NotificationTemplate; //通知模板。
  distributedOption?: notificationManager.DistributedOptions; //分布式通知的选项。
  removalWantAgent?: WantAgent; //当移除通知时，通知将被重定向到的WantAgent实例。当前不支持跳转UIAbility，只支持发布公共事件及跳转系统Service能力（WantAgent的OperationType >= 3）。
  badgeNumber?: number = 1; //应用程序图标上显示的通知数。
  appMessageId?: string; //应用发送通知携带的唯一标识字段, 用于通知去重。如果同一应用通过本地和云端等不同途径发布携带相同appMessageId的通知，设备只展示一条消息，之后收到的重复通知会被静默去重，不展示、不提醒。去重标识仅在通知发布的24小时内有效，超过24小时或者设备重启失效。
  sound?: string; //应用通知自定义铃声，需要通过Push云侧获取自定义发送铃声权限后，该字段才会生效

  additionalText?: string; //通知附加内容，是对通知内容的补充。
  lockscreenPicture?: image.PixelMap; //通知在锁屏界面显示的图片。

}