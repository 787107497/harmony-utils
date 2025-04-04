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
// import fs, { WriteOptions } from '@ohos.file.fs';
import { BusinessError } from '@kit.BasicServicesKit';
import { DateUtil } from './DateUtil';
import { LogUtil } from './LogUtil';
import { FileUtil } from './FileUtil';
import { StrUtil } from './StrUtil';
import { ToastUtil } from '../action/ToastUtil';
import { GlobalContext } from './GlobalContext';
import { CRASH_ID_KEY } from '../entity/constraint';




/**
 * TODO 全局异常捕获，崩溃日志收集
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class CrashUtil {

  private static observerId: number = -100;
  private static ErrorFilePath: string =""
  // private static ErrorFilePath: string = FileUtil.getFilesDirPath("harmony_utils_error_log", "ErrorLog.json"); //错误日志文件路径


  static onHandledException() {

  }

  // export declare function onExceptionDestroy(): void;
  // export declare function onHandledException(bean?: ErrorInitBean): void;



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
      // PickerUtil.saveDocumentEasy(['errorLog.txt']).then((documentSaveResult: Array<string>) => {
      //   if (documentSaveResult && documentSaveResult.length > 0) {
      //     let saveUri = documentSaveResult[0];
      //     let file = FileUtil.openSync(saveUri);
      //     FileUtil.copyFile(CrashUtil.ErrorFilePath, file.fd).then(() => {
      //       FileUtil.close(file.fd);
      //     });
      //   }
      // })
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
   * 将数据写入文件，并关闭文件。
   * @param path string 文件的应用沙箱路径或URI。
   * @param str string 待写入文件的数据，可来自缓冲区或字符串。。
   */
  // static writeStr(path: string, str: string): number {
  //   const file = FileUtil.openSync(path, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
  //   const offset = FileUtil.statSync(file.fd).size;
  //   if (offset === 0) {
  //     str = `[${str}]`;
  //   } else {
  //     str = `,${str}`;
  //   }
  //   const options: WriteOptions = { offset: offset, encoding: 'utf-8' };
  //   let result = FileUtil.writeSync(file.fd, str, options);
  //   FileUtil.closeSync(file.fd); //关闭文件
  //   return result;
  // }


}