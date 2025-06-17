/*
 * Copyright (C) 2022 Huawei Device Co., Ltd.
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

import Logger from './Logger'
import Level from './Level'
import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG:string = "[LiveEventBus]";
const DOMAIN:number = 0xFF
export default class DefaultLogger implements Logger{
  log(level: Level, msg: string, th?: Error): void{
    if (level == Level.SEVERE) {
      if (th) {
        if (th.stack) {
          hilog.error(DOMAIN, TAG, " %{public}s  Error:%{public}s - %{public}s  stack:%{public}s", [msg, th.name, th.message, th.stack]);
        } else {
          hilog.error(DOMAIN, TAG, " %{public}s  Error:%{public}s ", [msg, th.message]);
        }
      } else {
        hilog.error(DOMAIN, TAG, "%{public}s ", [msg]);
      }
    } else if (level == Level.WARNING) {
      if (th) {
        if (th.stack) {
          hilog.warn(DOMAIN, TAG, " %{public}s  Error:%{public}s - %{public}s  stack:%{public}s", [msg, th.name, th.message, th.stack]);
        } else {
          hilog.warn(DOMAIN, TAG, " %{public}s  Error:%{public}s ", [msg, th.message]);
        }
      } else {
        hilog.warn(DOMAIN, TAG, "%{public}s ", [msg]);
      }
    } else if (level == Level.INFO) {
      if (th) {
        if (th.stack) {
          hilog.info(DOMAIN, TAG, " %{public}s  Error:%{public}s - %{public}s  stack:%{public}s", [msg, th.name, th.message, th.stack]);
        } else {
          hilog.info(DOMAIN, TAG, " %{public}s  Error:%{public}s ", [msg, th.message]);
        }
      } else {
        hilog.info(DOMAIN, TAG, "%{public}s ", [msg]);
      }
    } else if (level == Level.CONFIG) {
      if (th) {
        if (th.stack) {
          hilog.debug(DOMAIN, TAG, " %{public}s  Error:%{public}s - %{public}s  stack:%{public}s", [msg, th.name, th.message, th.stack]);
        } else {
          hilog.debug(DOMAIN, TAG, " %{public}s  Error:%{public}s ", [msg, th.message]);
        }
      } else {
        hilog.debug(DOMAIN, TAG, "%{public}s ", [msg]);
      }
    } else if (level != Level.OFF) {
      if (th) {
        if (th.stack) {
          hilog.info(DOMAIN, TAG, " %{public}s  Error:%{public}s - %{public}s  stack:%{public}s", [msg, th.name, th.message, th.stack]);
        } else {
          hilog.info(DOMAIN, TAG, " %{public}s  Error:%{public}s ", [msg, th.message]);
        }
      } else {
        hilog.info(DOMAIN, TAG, "%{public}s ", [msg]);
      }
    }
  }
}