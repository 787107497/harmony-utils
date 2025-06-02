import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { CrashUtil, FileUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { JSON } from '@kit.ArkTS';
import { DialogHelper } from '@pura/harmony-dialog';
import { Utils } from '../../utils/Utils';
import { PickerUtil } from '@pura/picker_utils';

/**
 * 全局异常捕获，崩溃日志收集
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State errorTxt: string = '';

  @MockSetup
  mock() {
    this.describe = new DescribeBean("CrashUtil", "全局异常捕获，崩溃日志收集");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("onHandled()")
            .btnStyle()
            .onClick(() => {
              CrashUtil.onHandled((exceptionInfo)=>{
                LogUtil.error(JSON.stringify(exceptionInfo, null, 2));
              });
              ToastUtil.showToast("注册观测器，成功！");
            })
          Button("onDestroy()")
            .btnStyle()
            .onClick(() => {
              CrashUtil.onDestroy(); //注销错误观测器
              ToastUtil.showToast("注销误观测器,成功！");
            })
          Button("isHandled()")
            .btnStyle()
            .onClick(() => {
              let isHandled = CrashUtil.isHandled();
              ToastUtil.showToast(`误观测器是否存在：${isHandled}`);
            })
          Button("制造异常1")
            .btnStyle()
            .onClick(() => {
              let path = 'null';
              FileUtil.openSync(path);
            })
          Button("制造异常2")
            .btnStyle()
            .onClick(() => {
              throw new Error('未知异常！');
            })
          Button("access()")
            .btnStyle()
            .onClick(() => {
              let access = CrashUtil.access();
              ToastUtil.showToast(`日志文件是否存在：${access}`);
            })
          Button("delete()")
            .btnStyle()
            .onClick(() => {
              CrashUtil.delete();
              ToastUtil.showToast(`日志文件删除成功！`);
            })
          Button("getFilePath()")
            .btnStyle()
            .onClick(() => {
              let path = CrashUtil.getFilePath();
              LogUtil.error(`异常日志文件路径：${path}`);
              if (FileUtil.accessSync(path)) { //判断文件是否存在，存在，直接保存在DOWNLOAD文件目录下
                PickerUtil.saveDocumentEasy(['异常日志文件.txt']).then((documentSaveResult: Array<string>) => {
                  if (documentSaveResult && documentSaveResult.length > 0) {
                    let saveUri = documentSaveResult[0];
                    LogUtil.error(`saveUri: ${saveUri}`);
                    let file = FileUtil.openSync(saveUri);
                    FileUtil.copyFile(path, file.fd).then(() => {
                      FileUtil.close(file.fd);
                    });
                  }
                });
              } else {
                ToastUtil.showToast("暂无日志文件");
              }
            })
          Button("导出日志文件")
            .btnStyle()
            .onClick(() => {
              let path = CrashUtil.getFilePath();
              LogUtil.error(`异常日志文件路径：${path}`);
              if (FileUtil.accessSync(path)) { //判断文件是否存在，存在然后导出
                PickerUtil.saveDocument({ newFileNames: ["日志文件.txt"] }).then((uris) => {
                  LogUtil.error(`saveUri2: ${uris[0]}`);
                  let file = FileUtil.openSync(uris[0]);
                  FileUtil.copyFile(path, file.fd).then(() => {
                    FileUtil.close(file.fd);
                  });
                });
              } else {
                ToastUtil.showToast("暂无日志文件");
              }
            })
          Button("getExceptionJson()")
            .btnStyle()
            .onClick(async () => {
              if (CrashUtil.access()) {
                let jsonStr = await CrashUtil.getExceptionJson(); //读取JSON
                Utils.showSheetText(jsonStr);
              } else {
                ToastUtil.showToast("暂无日志文件");
              }
            })
          Button("getExceptionList()")
            .btnStyle()
            .onClick(async () => {
              if (CrashUtil.access()) {
                let list = await CrashUtil.getExceptionList();
                DialogHelper.showToast(`异常个数：${list.length}`);
              } else {
                ToastUtil.showToast("暂无日志文件");
              }
            })
          Button("重启APP")
            .btnStyle()
            .onClick(() => {
              CrashUtil.restartApp();
            })

          Blank().layoutWeight(1)
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor($r('app.color.main_background'))
  }
}


@Styles
function btnStyle() {
  .width('90%')
  .margin({ top: 10, bottom: 5 })
}