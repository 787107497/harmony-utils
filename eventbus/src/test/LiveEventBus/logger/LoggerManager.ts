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

export default class LoggerManager implements Logger {
  private enable: boolean = true
  private logger: Logger

  constructor(logger: Logger) {
    this.logger = logger

  }

  public isEnable(): boolean {
    return this.enable;
  }

  public setEnable(enable: boolean): void{
    this.enable = enable
  }

  public getLogger(): Logger{

    return this.logger
  }

  public setLogger(logger: Logger) {
    this.logger = logger
  }

  log(level: Level, msg: string, th?: Error): void{
    if (this.enable) {
      this.logger.log(level, msg, th);
    }
  }
}