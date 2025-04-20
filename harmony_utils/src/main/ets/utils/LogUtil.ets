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
import { BusinessError } from '@kit.BasicServicesKit';
import { StrUtil } from './StrUtil';


/**
 * TODO 日志工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class LogUtil {

  private static logSize: number = 2048;
  private static domain: number = 0x0000;
  private static tag: string = 'HarmonyUtilsLog'; //日志Tag
  private static showLog: boolean = true; //是否显示打印日志
  private static isHilog: boolean = true; //true-hilog、false-console


  /**
   * 初始化日志参数（该方法建议在Ability里调用）
   * @param domain
   * @param tag
   * @param showLog
   */
  static init(domain: number = LogUtil.domain, tag: string = LogUtil.tag, showLog: boolean = true, isHilog: boolean = true) {
    LogUtil.domain = domain;
    LogUtil.tag = tag;
    LogUtil.showLog = showLog;
    LogUtil.isHilog = isHilog;
  }

  /**
   * 设置日志对应的领域标识，范围是0x0~0xFFFF。（该方法建议在Ability里调用）
   * @param domain
   */
  static setDomain(domain: number = LogUtil.domain) {
    LogUtil.domain = domain
  }

  /**
   * 设置日志标识（该方法建议在Ability里调用）
   * @param tag
   */
  static setTag(tag: string = LogUtil.tag) {
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
  static debug(...args: string[] | object[]): void {
    LogUtil.uniLog(args, hilog.LogLevel.DEBUG);
  }

  /**
   * 打印INFO级别日志
   * @param args
   */
  static info(...args: string[] | object[]): void {
    LogUtil.uniLog(args, hilog.LogLevel.INFO);
  }

  /**
   * 打印WARN级别日志
   * @param args
   */
  static warn(...args: string[] | object[]): void {
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
  static fatal(...args: string[] | object[]): void {
    LogUtil.uniLog(args, hilog.LogLevel.FATAL);
  }


  /**
   * 打印JSON对象和JSON字符串
   * @param msg
   */
  static print(msg: object | string) {
    try {
      let content = '';
      if (typeof msg === 'object') {
        if (msg instanceof Error) {
          content = content + LogUtil.getErrorStr(msg, false);
        } else {
          content = content + LogUtil.getObjectToJson(msg, false);
        }
      } else if (typeof msg === 'string') {
        if ((StrUtil.startsWith(msg, '{') && StrUtil.endsWith(msg, '}')) || (StrUtil.startsWith(msg, '[') && StrUtil.endsWith(msg, ']'))) {
          let obj = JSON.parse(msg.toString()) ?? new Object(msg);
          content = content + LogUtil.getObjectToJson(obj, false);
        } else {
          content = content + msg;
        }
      }
      const len = Math.ceil(content.length / LogUtil.logSize);
      for (let i = 0; i < len; i++) {
        let end = (i + 1) * LogUtil.logSize;
        if (i === (len - 1)) {
          end = content.length;
        }
        let msg = '\n' + content.substring(i * LogUtil.logSize, end);
        LogUtil.levelLog(msg, hilog.LogLevel.DEBUG);
      }
    } catch (err) {
      let error = err as BusinessError; //异常了
      console.error(`LogUtil-print-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
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
    if (level === hilog.LogLevel.ERROR || level === hilog.LogLevel.FATAL) {
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
      let msg = '\n│  ' + content.substring(i * LogUtil.logSize, end);
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
          if (msg instanceof Error) {
            logMessage = logMessage + LogUtil.getErrorStr(msg);
          } else {
            logMessage = logMessage + LogUtil.getObjectToJson(msg);
          }
        } else if (typeof msg === 'string') {
          if ((StrUtil.startsWith(msg, '{') && StrUtil.endsWith(msg, '}')) || (StrUtil.startsWith(msg, '[') && StrUtil.endsWith(msg, ']'))) {
            let obj = JSON.parse(msg.toString()) ?? new Object(msg);
            logMessage = logMessage + LogUtil.getObjectToJson(obj);
          } else {
            logMessage = logMessage + msg;
            logMessage = logMessage.replaceAll('\n', '\n│  ');
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
  private static getObjectToJson(obj: object, line: boolean = true): string {
    try {
      let jsonStr = JSON.stringify(obj, null, 2);
      if (line) {
        jsonStr = jsonStr.replace(/\n/g, '\n│\t');
        if (jsonStr.endsWith('\t]')) {
          jsonStr = jsonStr.replace(/..$/, '  ]');
        } else if (jsonStr.endsWith('\t}')) {
          jsonStr = jsonStr.replace(/..$/, '  }');
        }
      }
      return jsonStr;
    } catch (err) {
      return '';
    }
  }

  /**
   * 获取Error字符串
   */
  private static getErrorStr(error: Error, line: boolean = true): string {
    let errObj: Record<string, string | number> = {};
    errObj['name'] = error.name;
    errObj['code'] = (error as BusinessError)?.code ?? '';
    errObj['message'] = error.message;
    errObj['stack'] = error.stack ?? '';
    let errorStr = LogUtil.getObjectToJson(errObj, line);
    return errorStr;
  }

  /**
   * 获取代码位置（性能开销比较大，当频繁创建带有调用栈信息的错误对象时，会对程序的性能产生明显影响）。
   */
  private static getLogLocation(): string {
    const errorStack = new Error().stack;
    const stackArray = errorStack?.split('\n');
    let errorLocation: string = stackArray?.filter(item => item !== null && item.length > 1)?.map(value => value.trim()
      .concat('\t'))?.splice(3).join('') ?? '';
    return `\n│  ${errorLocation}\n│➼${StrUtil.repeat('┄┄┄┄┄┄┄', 21)}`;
  }

  /**
   * 获取生成的日志边框
   */
  private static getLine(tag: string = '', length: number = 130): string {
    if (StrUtil.isNotEmpty(tag)) {
      return `┌${StrUtil.repeat('─', 15)}► ${tag} ◄${StrUtil.repeat('─', length - tag.length)}`;
    } else {
      return `└${StrUtil.repeat('─', 19)}${StrUtil.repeat('─', length)}`;
    }
  }


}