import errorManager from '@ohos.app.ability.errorManager';
import { DateUtil } from './DateUtil';
import { LogUtil } from './LogUtil';
import { BusinessError } from '@kit.BasicServicesKit';
import { FileUtil } from './FileUtil';
import { FilePickerUtil } from './FilePickerUtil';
import { StrUtil } from './StrUtil';
import { ToastUtil } from '../action/ToastUtil';


/**
 * 全局异常捕获，崩溃日志收集
 */
export class CrashUtil {

  private constructor() {}

  private static observerId = -1;
  private static ErrorFilePath = ''; //错误日志文件路径


  /**
   * 注册错误观测器。注册后可以捕获到应用产生的js crash，应用崩溃时进程不会退出。将异常信息写入本地文件。
   */
  static onError() {
    try {
      CrashUtil.observerId = errorManager.on('error', {
        onUnhandledException(errMsg) {
          let errStr = `${DateUtil.getTodayStr()} - 异常信息：\n${errMsg}\n\n\n`;
          let dirPath = FileUtil.getFilesDirOrPath("ErrorLog") //错误日志路径
          let access = FileUtil.accessSync(dirPath)
          if (!access) {
            FileUtil.mkdir(dirPath)
          }
          CrashUtil.ErrorFilePath = `${dirPath}/errorLog.txt`
          FileUtil.writeEasy(CrashUtil.ErrorFilePath, errStr);
        },
        onException(errObject) {
          // let errStr = `${DateUtil.getTodayStr()} - 异常信息2：\n${JSON.stringify(errObject)}\n\n\n`;
        }
      });
    } catch (error) {
      LogUtil.error("CrashUtil：" + JSON.stringify(error))
    }
  }


  /**
   * 注销错误观测器。
   */
  static offError() {
    try {
      errorManager.off('error', CrashUtil.observerId, (err: BusinessError) => {
        if (err) {
          LogUtil.error("CrashUtil：" + JSON.stringify(err))
        }
      });
    } catch (error) {
      LogUtil.error("CrashUtil：" + JSON.stringify(error))
    }
  }


  /**
   * 导出错误日志
   */
  static onExportErrorLog() {
    if (StrUtil.isNotEmpty(CrashUtil.ErrorFilePath)) {
      FilePickerUtil.saveDocument(['errorLog.txt']).then((documentSaveResult: Array<string>) => {
        if (documentSaveResult && documentSaveResult.length > 0) {
          let saveUri = documentSaveResult[0];
          FileUtil.copy(CrashUtil.ErrorFilePath, saveUri);
        }
      })
    } else {
      ToastUtil.showToast("暂无日志文件");
    }
  }



}