/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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
import hilog from '@ohos.hilog';

export class LogUtil {
  static DOMAIN = 0xD002230;
  static TAG = "LiveEvenBus ";

  static debug(message, ...args) {
    hilog.debug(LogUtil.DOMAIN, LogUtil.TAG, message, args)
  }

  static info(message, ...args) {
    hilog.info(LogUtil.DOMAIN, LogUtil.TAG, message, args)
  }

  static log(message, ...args) {
    hilog.debug(LogUtil.DOMAIN, LogUtil.TAG, message, args)
  }

  static warn(message, ...args) {
    hilog.warn(LogUtil.DOMAIN, LogUtil.TAG, message, args)
  }

  static error(message, ...args) {
    hilog.error(LogUtil.DOMAIN, LogUtil.TAG, message, args)
  }
}