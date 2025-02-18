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
 *
 * https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 */

import errorManager from '@ohos.app.ability.errorManager';
import { appRecovery, common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { DateUtil } from './DateUtil';
import { LogUtil } from './LogUtil';
import { FileUtil } from './FileUtil';
import { PickerUtil } from './PickerUtil';
import { StrUtil } from './StrUtil';
import { ToastUtil } from '../action/ToastUtil';
import { GlobalContext } from './GlobalContext';
import { CRASH_ID_KEY } from '../entity/constraint';


/**
 * TODO 全局异常捕获，崩溃日志收集
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059
 */
export class CrashUtil {

  private static observerId: number = -100;
  private static ErrorFilePath: string = ''; //错误日志文件路径


  /**
   * 注册错误观测器。注册后可以捕获到应用产生的js crash，应用崩溃时进程不会退出。将异常信息写入本地文件。
   */
  static onError() {
    try {
      let cacheId = GlobalContext.getContext().getObject(CRASH_ID_KEY) as number;
      if (cacheId !== undefined && cacheId !== -100) {
        CrashUtil.offError(); //如果存在，就先注销错误观测器。
      }
      CrashUtil.observerId = errorManager.on('error', {
        onUnhandledException(errMsg) {
          let errStr = `${DateUtil.getTodayStr()} - 异常信息：\n${errMsg}\n\n\n`;
          CrashUtil.ErrorFilePath = FileUtil.getFilesDirPath("ErrorLog", "errorLog.txt")
          FileUtil.writeEasy(CrashUtil.ErrorFilePath, errStr);
        },
        onException(errObject) {
          // let errStr = `${DateUtil.getTodayStr()} - 异常信息2：\n${JSON.stringify(errObject)}\n\n\n`;
        }
      });
      GlobalContext.getContext().setObject(CRASH_ID_KEY, CrashUtil.observerId);
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`CrashUtil-onError-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }


  /**
   * 注销错误观测器。
   */
  static offError() {
    try {
      if (CrashUtil.observerId === -100) {
        let cacheId = GlobalContext.getContext().getObject(CRASH_ID_KEY) as number;
        if (cacheId && cacheId != -100) {
          CrashUtil.observerId = cacheId;
        }
      }
      errorManager.off('error', CrashUtil.observerId, (err: BusinessError) => {
        if (err) {
          LogUtil.error("CrashUtil：" + JSON.stringify(err))
          return;
        }
        GlobalContext.getContext().setObject(CRASH_ID_KEY, -100);
      });
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`CrashUtil-offError-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }


  /**
   * 导出错误日志
   */
  static onExportErrorLog() {
    CrashUtil.ErrorFilePath = FileUtil.getFilesDirPath("ErrorLog", "errorLog.txt")
    if (StrUtil.isNotEmpty(CrashUtil.ErrorFilePath)) {
      PickerUtil.saveDocumentEasy(['errorLog.txt']).then((documentSaveResult: Array<string>) => {
        if (documentSaveResult && documentSaveResult.length > 0) {
          let saveUri = documentSaveResult[0];
          let file = FileUtil.openSync(saveUri);
          FileUtil.copyFile(CrashUtil.ErrorFilePath, file.fd).then(() => {
            FileUtil.close(file.fd);
          });
        }
      })
    } else {
      ToastUtil.showToast("暂无日志文件");
    }
  }


  /**
   * 读取错误日志文件
   */
  static async readErrorText(): Promise<string> {
    CrashUtil.ErrorFilePath = FileUtil.getFilesDirPath("ErrorLog", "errorLog.txt")
    if (StrUtil.isNotEmpty(CrashUtil.ErrorFilePath)) {
      if (FileUtil.accessSync(CrashUtil.ErrorFilePath)) {
        return await FileUtil.readText(CrashUtil.ErrorFilePath);
      }
    }
    return '';
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
    appRecovery.restartApp()
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
      return appRecovery.saveAppState(context) //主动保存Ability的状态
    } else {
      return appRecovery.saveAppState() //保存当前App状态
    }
  }


}