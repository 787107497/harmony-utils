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
import { BusinessError } from '@kit.BasicServicesKit';
import { WriteOptions } from '@kit.CoreFileKit';
import { appRecovery, common, Want } from '@kit.AbilityKit';
import { DateUtil } from './DateUtil';
import { LogUtil } from './LogUtil';
import { FileUtil } from './FileUtil';
import { AppUtil } from './AppUtil';


/**
 * TODO 全局异常捕获，崩溃日志收集
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class CrashUtil {

  private static observerId: number | undefined = undefined;
  private static errorFilePath: string | undefined = undefined; //错误日志文件路径




  /**
   * 注册错误观测器。注册后可以捕获到应用产生的js crash，应用崩溃时进程不会退出。将异常信息写入本地文件。
   */
  static onHandledException() {
    try {
      if (CrashUtil.observerId === undefined) {
        CrashUtil.observerId = errorManager.on('error', {
          onUnhandledException(errMsg) {
            let errStr = `${DateUtil.getTodayStr()} - 异常信息：\n${errMsg}\n\n\n`;

            // FileUtil.writeEasy(CrashUtil.ErrorFilePath, errStr);
          },
          onException(errObject) {
            // let errStr = `${DateUtil.getTodayStr()} - 异常信息2：\n${JSON.stringify(errObject)}\n\n\n`;
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
  static onExceptionDestroy() {
    try {
      if (CrashUtil.observerId) {
        errorManager.off('error', CrashUtil.observerId, (err: BusinessError) => {
          if (err) {
            LogUtil.error("CrashUtil：" + JSON.stringify(err));
          }
        });
      }
    } catch (err) {
      LogUtil.error(err);
    }
  }


  // /**
  //  * 导出错误日志
  //  */
  // static onExportErrorLog() {
  //   CrashUtil.ErrorFilePath = FileUtil.getFilesDirPath("ErrorLog", "errorLog.txt")
  //   if (StrUtil.isNotEmpty(CrashUtil.ErrorFilePath)) {
  //     // PickerUtil.saveDocumentEasy(['errorLog.txt']).then((documentSaveResult: Array<string>) => {
  //     //   if (documentSaveResult && documentSaveResult.length > 0) {
  //     //     let saveUri = documentSaveResult[0];
  //     //     let file = FileUtil.openSync(saveUri);
  //     //     FileUtil.copyFile(CrashUtil.ErrorFilePath, file.fd).then(() => {
  //     //       FileUtil.close(file.fd);
  //     //     });
  //     //   }
  //     // })
  //   } else {
  //     ToastUtil.showToast("暂无日志文件");
  //   }
  // }


  /**
   * 获取错误日志文件路径
   * @returns
   */
  static getErrorFilePath(): string {
    if (CrashUtil.errorFilePath === undefined) {
      CrashUtil.errorFilePath = FileUtil.getFilesDirPath("harmony_utils_error_log", "ErrorLog.json"); //错误日志文件路径
    }
    return CrashUtil.errorFilePath;
  }


  /**
   * 读取错误日志文件的JSON字符串。
   */
  static async getErrorJson(): Promise<string> {
    const errorFilePath = CrashUtil.getErrorFilePath();
    if (FileUtil.accessSync(errorFilePath)) {
      return await FileUtil.readText(errorFilePath);
    }
    return '';
  }




  /**
   * 将数据写入文件，并关闭文件。
   */
  private static writeStr(path: string, str: string): number {
    const file = FileUtil.openSync(path);
    const offset = FileUtil.statSync(file.fd).size;
    if (offset === 0) {
      str = `[${str}]`;
    } else {
      str = `,${str}`;
    }
    const options: WriteOptions = { offset: offset, encoding: 'utf-8' };
    let result = FileUtil.writeSync(file.fd, str, options);
    FileUtil.closeSync(file.fd); //关闭文件
    return result;
  }



  /**
   * 启用应用恢复功能，参数按顺序填入；该接口调用后，应用从启动器启动时第一个Ability支持恢复。该方法已过时，推荐使用：AppUtil.enableAppRecovery()
   */
  static enableAppRecovery(restart: appRecovery.RestartFlag = appRecovery.RestartFlag.ALWAYS_RESTART,
    saveOccasion: appRecovery.SaveOccasionFlag = appRecovery.SaveOccasionFlag.SAVE_WHEN_ERROR,
    saveMode: appRecovery.SaveModeFlag.SAVE_WITH_FILE = appRecovery.SaveModeFlag.SAVE_WITH_FILE) {
    AppUtil.enableAppRecovery(restart, saveOccasion, saveMode);
  }

  /**
   * 重启APP，并拉起应用启动时第一个Ability，可以配合errorManager相关接口使用。该方法已过时，推荐使用：AppUtil.restartApp()
   */
  static restartApp() {
    AppUtil.restartApp()
  }

  /**
   * 设置下次恢复主动拉起场景下的Ability。该Ability必须为当前包下的UIAbility。该方法已过时，推荐使用：AppUtil.setRestartWant()
   */
  static setRestartWant(want: Want) {
    AppUtil.setRestartWant(want);
  }

  /**
   * 保存当前App状态 或 主动保存Ability的状态，这个状态将在下次恢复启动时使用。可以配合errorManager相关接口使用。该方法已过时，推荐使用：AppUtil.saveAppState()
   */
  static saveAppState(context?: common.UIAbilityContext): boolean {
    return AppUtil.saveAppState(context);
  }


}