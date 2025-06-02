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

import errorManager from '@ohos.app.ability.errorManager';
import { BusinessError, Callback } from '@kit.BasicServicesKit';
import { WriteOptions } from '@kit.CoreFileKit';
import { appRecovery, common, Want } from '@kit.AbilityKit';
import { LogUtil } from './LogUtil';
import { FileUtil } from './FileUtil';
import { ExceptionInfo } from '../entity/ExceptionInfo';
import { JSONUtil } from './JSONUtil';
import { StrUtil } from './StrUtil';
import { JSON } from '@kit.ArkTS';


/**
 * TODO 全局异常捕获，崩溃日志收集
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class CrashUtil {

  private static observerId: number | undefined = undefined;
  private static errorFilePath: string | undefined = undefined; //错误日志文件路径


  /**
   * 注册错误观测器，该方法建议在Ability里调用。
   * 注册后可以捕获到应用产生的js crash，应用崩溃时进程不会退出。将异常信息写入本地文件。
   * @param callback 异常回调，可以在该回调里上传异常信息；
   */
  static onHandled(callback: Callback<ExceptionInfo>) {
    try {
      if (CrashUtil.observerId === undefined) {
        CrashUtil.observerId = errorManager.on('error', {
          //将在js运行时引发用户未捕获的异常时调用。
          onUnhandledException(errMsg) {},
          //将在js运行时引发用户未捕获的异常时调用。
          onException(errObject) {
            let info: ExceptionInfo = new ExceptionInfo(errObject.name, errObject.message, errObject.stack ?? "");
            let filePath = CrashUtil.getFilePath();
            let infoJson = JSON.stringify(info, null, 2);
            CrashUtil.writeStr(filePath, infoJson);
            callback(info);
          }
        });
      }
    } catch (err) {
      LogUtil.error(err);
    }
  }


  /**
   * 注销错误观测器。
   */
  static onDestroy() {
    try {
      if (CrashUtil.observerId !== undefined) {
        errorManager.off('error', CrashUtil.observerId, (err: BusinessError) => {
          LogUtil.error('observerId: '+CrashUtil.observerId)
          if (err) {
            LogUtil.error(err);
            return
          }
          CrashUtil.observerId = undefined;
        });
      }
    } catch (err) {
      LogUtil.error(err);
    }
  }


  /**
   * 判断错误观测器是否存在
   * @returns
   */
  static isHandled(): boolean {
    return CrashUtil.observerId !== undefined;
  }


  /**
   * 获取日志文件路径（用于读取日志文件、导出日志文件）。
   * @returns
   */
  static getFilePath(): string {
    if (CrashUtil.errorFilePath === undefined) {
      CrashUtil.errorFilePath = FileUtil.getFilesDirPath("harmony_utils_log", "ExceptionLog.json"); //错误日志文件路径
    }
    return CrashUtil.errorFilePath;
  }

  /**
   * 判断日志文件是否存在
   * @returns
   */
  static access(): boolean {
    const path = CrashUtil.getFilePath();
    return FileUtil.accessSync(path);
  }

  /**
   * 删除日志文件
   * @returns
   */
  static delete() {
    if (CrashUtil.access()) {
      const path = CrashUtil.getFilePath();
      FileUtil.unlinkSync(path);
    }
  }


  /**
   * 获取异常日志的JSON字符串。
   */
  static async getExceptionJson(): Promise<string> {
    const errorFilePath = CrashUtil.getFilePath();
    if (FileUtil.accessSync(errorFilePath)) {
      return await FileUtil.readText(errorFilePath);
    }
    return '';
  }


  /**
   * 获取异常日志的集合。
   */
  static async getExceptionList(): Promise<ExceptionInfo[]> {
    let json = await CrashUtil.getExceptionJson();
    if (StrUtil.isNotEmpty(json)) {
      return JSONUtil.jsonToArray<ExceptionInfo>(json);
    }
    return [];
  }


  /**
   * 启用应用恢复功能，参数按顺序填入。该接口调用后，应用从启动器启动时第一个Ability支持恢复。
   * @param restart RestartFlag 应用重启标志。
   *    ALWAYS_RESTART  0  总是重启应用。
   *    RESTART_WHEN_JS_CRASH  0x0001  发生JS_CRASH时重启应用。
   *    RESTART_WHEN_APP_FREEZE  0x0002  发生APP_FREEZE时重启应用。
   *    NO_RESTART  0xFFFF  总是不重启应用。
   * @param saveOccasion SaveOccasionFlag 保存条件标志
   *    SAVE_WHEN_ERROR  0x0001  当发生应用故障时保存。
   *    SAVE_WHEN_BACKGROUND  0x0002  当应用切入后台时保存。
   * @param saveMode SaveModeFlag  状态保存标志
   *    SAVE_WITH_FILE  0x0001  每次状态保存都会写入到本地文件缓存。
   *    SAVE_WITH_SHARED_MEMORY  0x0002  状态先保存在内存中，应用故障退出时写入到本地文件缓存。
   */
  static enableAppRecovery(restart: appRecovery.RestartFlag = appRecovery.RestartFlag.ALWAYS_RESTART,
    saveOccasion: appRecovery.SaveOccasionFlag = appRecovery.SaveOccasionFlag.SAVE_WHEN_ERROR,
    saveMode: appRecovery.SaveModeFlag.SAVE_WITH_FILE = appRecovery.SaveModeFlag.SAVE_WITH_FILE) {
    appRecovery.enableAppRecovery(restart, saveOccasion, saveMode);
  }


  /**
   * 重启APP，并拉起应用启动时第一个Ability，可以配合errorManager相关接口使用。
   * 如果该Ability存在已经保存的状态，这些状态数据会在Ability的OnCreate生命周期回调的want参数中作为wantParam属性传入。
   * API10时将启动由setRestartWant指定的Ability。如果没有指定则按以下规则启动：
   *   如果当前应用前台的Ability支持恢复，则重新拉起该Ability。
   *   如果存在多个支持恢复的Ability处于前台，则只拉起最后一个。
   *   如果没有Ability处于前台，则不拉起。
   */
  static restartApp() {
    appRecovery.restartApp();
  }


  /**
   * 设置下次恢复主动拉起场景下的Ability。该Ability必须为当前包下的UIAbility。
   * @param want 通过设置Want中"bundleName"和"abilityName"字段来指定恢复重启的Ability。
   */
  static setRestartWant(want: Want) {
    appRecovery.setRestartWant(want);
  }


  /**
   * 保存当前App状态 或 主动保存Ability的状态，这个状态将在下次恢复启动时使用。可以配合errorManager相关接口使用
   * @param context UIAbilityContext  需要保存状态的UIAbility所对应的context。
   * @returns
   */
  static saveAppState(context?: common.UIAbilityContext): boolean {
    if (context) {
      return appRecovery.saveAppState(context); //主动保存Ability的状态
    } else {
      return appRecovery.saveAppState(); //保存当前App状态
    }
  }


  /**
   * 将数据写入文件，并关闭文件。
   */
  private static writeStr(path: string, str: string): number {
    const file = FileUtil.openSync(path);
    let offset = FileUtil.statSync(file.fd).size;
    if (offset === 0) {
      str = `[${str}]`;
    } else {
      offset = offset - 1;
      str = `,${str}]`;
    }
    const options: WriteOptions = { offset: offset, encoding: 'utf-8' };
    let result = FileUtil.writeSync(file.fd, str, options);
    FileUtil.closeSync(file.fd); //关闭文件
    return result;
  }


}