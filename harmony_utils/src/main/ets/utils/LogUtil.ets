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

import hilog from '@ohos.hilog';
import { JSON } from '@kit.ArkTS';
import { StrUtil } from './StrUtil';
import { LOGGER_DOMAIN, LOGGER_TAG } from '../entity/constraint';


/**
 * TODO 日志工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class LogUtil {

  private static logSize: number = 2048;
  private static domain: number = LOGGER_DOMAIN;
  private static tag: string = LOGGER_TAG; //日志Tag
  private static showLog: boolean = true; //是否显示打印日志
  private static isHilog: boolean = false; //true-hilog、false-console


  /**
   * 初始化日志参数（该方法建议在Ability里调用）
   * @param domain
   * @param tag
   * @param showLog
   */
  static init(domain: number = LOGGER_DOMAIN, tag: string = LOGGER_TAG, showLog: boolean = true, isHilog: boolean = true) {
    LogUtil.domain = domain;
    LogUtil.tag = tag;
    LogUtil.showLog = showLog;
    LogUtil.isHilog = isHilog;
  }

  /**
   * 设置日志对应的领域标识，范围是0x0~0xFFFF。（该方法建议在Ability里调用）
   * @param domain
   */
  static setDomain(domain: number = LOGGER_DOMAIN) {
    LogUtil.domain = domain
  }

  /**
   * 设置日志标识（该方法建议在Ability里调用）
   * @param tag
   */
  static setTag(tag: string = LOGGER_TAG) {
    LogUtil.tag = tag
  }

  /**
   * 是否打印日志（该方法建议在Ability里调用）
   * @param showLog
   */
  static setShowLog(showLog: boolean = true) {
    LogUtil.showLog = showLog
  }

  /**
   * 日志打印方式
   * @param isHilog，true-hilog、false-console
   */
  public static setHilog(isHilog: boolean) {
    LogUtil.isHilog = isHilog;
  }


  /**
   * 打印DEBUG级别日志
   * @param args
   */
  static debug(...args: string[]): void {
    LogUtil.uniLog(args, hilog.LogLevel.DEBUG);
  }

  /**
   * 打印INFO级别日志
   * @param args
   */
  static info(...args: string[]): void {
    LogUtil.uniLog(args, hilog.LogLevel.INFO);
  }

  /**
   * 打印WARN级别日志
   * @param args
   */
  static warn(...args: string[]): void {
    LogUtil.uniLog(args, hilog.LogLevel.WARN);
  }

  /**
   * 打印ERROR级别日志
   * @param args
   */
  static error(...args: string[] | object[]): void {
    LogUtil.uniLog(args, hilog.LogLevel.ERROR);
  }

  /**
   * 打印FATAL级别日志
   * @param args
   */
  static fatal(...args: string[]): void {
    LogUtil.uniLog(args, hilog.LogLevel.FATAL);
  }


  /**
   * 统一日志输出
   */
  private static uniLog(message: string[] | object[], level: hilog.LogLevel) {
    if (!LogUtil.showLog) {
      return; //不打印日志
    }
    let topLine = LogUtil.getLine(LogUtil.tag);
    LogUtil.levelLog(topLine, level);
    if (level === hilog.LogLevel.ERROR) {
      let locationLog = LogUtil.getLogLocation(); //代码位置
      LogUtil.levelLog(locationLog, level);
    }
    const content = LogUtil.getMessage(message);
    const len = Math.ceil(content.length / LogUtil.logSize);
    for (let i = 0; i < len; i++) {
      let end = (i + 1) * LogUtil.logSize;
      if (i === (len - 1)) {
        end = content.length;
      }
      let msg = '\n|  ' + content.substring(i * LogUtil.logSize, end);
      LogUtil.levelLog(msg, level);
    }
    let bottomLine = LogUtil.getLine('');
    LogUtil.levelLog(bottomLine, level);
  }


  /**
   * 日志打印
   */
  private static levelLog(msg: string, level: hilog.LogLevel) {
    if (LogUtil.isHilog) { //hilog打印日志
      switch (level) {
        case hilog.LogLevel.DEBUG:
          hilog.debug(LogUtil.domain, LogUtil.tag, msg);
          break
        case hilog.LogLevel.INFO:
          hilog.info(LogUtil.domain, LogUtil.tag, msg);
          break
        case hilog.LogLevel.WARN:
          hilog.warn(LogUtil.domain, LogUtil.tag, msg);
          break
        case hilog.LogLevel.ERROR:
          hilog.error(LogUtil.domain, LogUtil.tag, msg);
          break
        case hilog.LogLevel.FATAL:
          hilog.fatal(LogUtil.domain, LogUtil.tag, msg);
          break
      }
    } else { //console打印日志
      switch (level) {
        case hilog.LogLevel.DEBUG:
          console.debug(msg);
          break
        case hilog.LogLevel.INFO:
          console.info(msg);
          break
        case hilog.LogLevel.WARN:
          console.warn(msg);
          break
        case hilog.LogLevel.ERROR:
          console.error(msg);
          break
        case hilog.LogLevel.FATAL:
          console.log(msg);
          break
      }
    }
  }

  /**
   * 获取格式化日志内容
   */
  private static getMessage(message: string[] | object[]): string {
    try {
      let logMessage = '';
      message.forEach((msg: string | object) => {
        if (typeof msg === 'object') {
          logMessage = logMessage + LogUtil.getObjectToJson(msg);
        } else if (typeof msg === 'string') {
          if ((StrUtil.startsWith(msg, '{') && StrUtil.endsWith(msg, '}')) || (StrUtil.startsWith(msg, '[') && StrUtil.endsWith(msg, ']'))) {
            let obj = JSON.parse(msg.toString()) ?? new Object(msg);
            logMessage = logMessage + LogUtil.getObjectToJson(obj);
          } else {
            logMessage = logMessage + msg;
          }
        }
      });
      return logMessage;
    } catch (err) {
      return message.toString();
    }
  }

  /**
   * 对象转JSON字符串
   */
  private static getObjectToJson(obj: object): string {
    try {
      let jsonStr = JSON.stringify(obj, null, 2);
      jsonStr = jsonStr.replace(/\n/g, '\n|\t');
      if (jsonStr.endsWith('\t]')) {
        jsonStr = jsonStr.replace(/..$/, '  ]');
      } else if (jsonStr.endsWith('\t}')) {
        jsonStr = jsonStr.replace(/..$/, '  }');
      }
      return jsonStr;
    } catch (err) {
      return '';
    }
  }

  /**
   * 获取代码位置（性能开销比较大，当频繁创建带有调用栈信息的错误对象时，会对程序的性能产生明显影响）。
   */
  private static getLogLocation(): string {
    const errorStack = new Error().stack;
    const stackArray = errorStack?.split('\n');
    let errorLocation: string = stackArray?.filter(item => item !== null && item.length > 6).splice(-2).join('\n') ?? '';
    errorLocation = errorLocation.replaceAll(' ', '').replaceAll('\n', '\n|\t');
    return `\n|  ${errorLocation}`;
  }

  /**
   * 获取生成的日志边框
   */
  private static getLine(tag: string = '', length: number = 160): string {
    if (StrUtil.isNotEmpty(tag)) {
      return `┌${StrUtil.repeat('─', 10)} ${tag} ${StrUtil.repeat('─', length - tag.length - 2)}`;
    } else {
      return `└${StrUtil.repeat('─', 10)}${StrUtil.repeat('─', length)}`;
    }
  }


}

// export default new LogUtil() //单例（在ES6模块中，当你使用 import 导入一个模块时，实际上是在导入该模块的值的一个引用。这意味着在另一个模块中修改该值会影响原始模块中的值。）