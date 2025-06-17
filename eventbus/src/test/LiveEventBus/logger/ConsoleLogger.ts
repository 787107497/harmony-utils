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

const TAG:string = "[LiveEventBus] ";
export default class ConsoleLogger implements Logger{

  log(level: Level, msg: string, th?: Error): void{
    if (level == Level.SEVERE) {
      console.log(msg);

      if (th) {
        if (th.stack) {
          console.error(`${TAG}  ${msg} Error: ${th.name} -  ${th.message}  stack: ${th.stack}`);
        } else {
          console.error(`${TAG}  ${msg} Error: ${th.name} -  ${th.message} `);
        }
      } else {
        console.error(`${TAG}  ${msg} `);
      }
    } else if (level == Level.WARNING) {
      if (th) {
        if (th.stack) {
          console.warn(`${TAG}  ${msg} WARNING: ${th.name} -  ${th.message}  stack: ${th.stack}`);
        } else {
          console.warn(`${TAG}  ${msg} WARNING: ${th.name} -  ${th.message} `);
        }
      } else {
        console.warn(`${TAG}  ${msg} `);
      }
    } else if (level == Level.INFO) {
      if (th) {
        if (th.stack) {
          console.info(`${TAG}  ${msg} INFO: ${th.name} -  ${th.message}  stack: ${th.stack}`);
        } else {
          console.info(`${TAG}  ${msg} INFO: ${th.name} -  ${th.message}  `);
        }
      } else {
        console.info(`${TAG}  ${msg} `);
      }
    } else if (level == Level.CONFIG) {
      if (th) {
        if (th.stack) {
          console.debug(`${TAG}  ${msg} Debug: ${th.name} -  ${th.message}  stack: ${th.stack}`);
        } else {
          console.debug(`${TAG}  ${msg} Debug: ${th.name} -  ${th.message}  `);
        }
      } else {
        console.debug(`${TAG}  ${msg} `);
      }
    } else if (level != Level.OFF) {
      if (th) {
        if (th.stack) {
          console.info(`${TAG}  ${msg} Info: ${th.name} -  ${th.message}  stack: ${th.stack}`);
        } else {
          console.info(`${TAG}  ${msg} Info: ${th.name} -  ${th.message}  `);
        }
      } else {
        console.info(`${TAG}  ${msg} `);
      }
    }
  }


}
