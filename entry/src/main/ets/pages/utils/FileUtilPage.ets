import { router } from '@kit.ArkUI';
import fs from '@ohos.file.fs';
import { MockSetup } from '@ohos/hamock';
import { DateUtil, FileUtil, LogUtil, PreferencesUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { PickerUtil } from '@pura/picker_utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { fileShare } from '@kit.CoreFileKit';
import { Utils } from '../../utils/Utils';
import { JSON } from '@kit.ArkTS';

/**
 * 文件操作相关工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State filePath: string = '' //文件路径
  @State cacheUri: string = ''; //缓存本地Uri，上次保存的Uri。
  @State jsonStr: string = ''


  @MockSetup
  mock() {
    this.describe = new DescribeBean("FileUtil", "文件操作相关工具类");
  }

  aboutToAppear(): void {
    this.filePath = FileUtil.getFilesDirPath('download/wps/txt', 'demo.txt');

  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("accessSync()\nmkdirSync()\nwriteEasy()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              this.filePath = FileUtil.getFilesDirPath('download/wps/txt', 'demo.txt')
              FileUtil.writeEasy(this.filePath, "harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包。帮助开发者快速构建鸿蒙应用。")
              ToastUtil.showToast('文件(demo.txt)创建和写入成功')
            })
          Button("getFilesDirPath()\ngetCacheDirPath()\ngetTempDirPath()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let path1 = FileUtil.getFilesDirPath('');
              let path2 = FileUtil.getFilesDirPath("", "zuPus.txt");
              let path3 = FileUtil.getFilesDirPath('download/wps/ppt', 'dev.text');
              let path4 = FileUtil.getFilesDirPath("download/wps/wps");
              let path5 = FileUtil.getFilesDirPath(`${getContext().filesDir}/download/apk`, "app.apk");
              let path6 = FileUtil.getFilesDirPath(`${getContext().filesDir}/download/wps/ppt`);
              let path7 = FileUtil.getCacheDirPath('download/wps/ppt', 'dev_s.text');
              let path8 = FileUtil.getTempDirPath('download/wps/ppt', 'dev_max.text');
              let paths = `${path1}\n\n${path2}\n\n${path3}\n\n${path4}\n\n${path5}\n\n${path6}\n\n${path7}\n\n${path8}`
              Utils.showSheetText(paths);
              LogUtil.info(paths);
            })
          Button("hasDirPath()\ngetFileExtention()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let hasDirPath1 = FileUtil.hasDirPath("download/wps/测试.PDF");
              let hasDirPath2 = FileUtil.hasDirPath(`${FileUtil.getFilesDirPath("download/wps", "测试文档.doc")}`);
              let fileExtention = FileUtil.getFileExtention("/data/storage/el2/base/haps/entry/files/download/demo.txt");
              let fileExtention2 = FileUtil.getFileExtention("妹纸.png");
              let resultStr = `hasDirPath1: ${hasDirPath1}\n\nhasDirPath2: ${hasDirPath2}\n\nfileExtention: ${fileExtention}\n\nfileExtention2: ${fileExtention2}`
              Utils.showSheetText(resultStr);
              LogUtil.info(resultStr);
            })
          Button("getFileDirSize()")
            .btnStyle()
            .onClick(() => {
              let path = FileUtil.getFilesDirPath("");
              let fileDirSize = FileUtil.getFileDirSize(path);
              ToastUtil.showToast(`文件夹下所有文件的大小：${fileDirSize}`);
            })
          Button("readTextSync()")
            .btnStyle()
            .onClick(() => {
              if (FileUtil.accessSync(this.filePath)) {
                let txt = FileUtil.readTextSync(this.filePath);
                Utils.showSheetText(txt);
                LogUtil.info(txt);
              } else {
                ToastUtil.showToast("文件不存在，请先创建和写入")
              }
            })
          Button("getFileName()\ngetParentPath()\ngetParentUri()\ngetFilePath()\ngetFileUri()\ngetUriFromPath()\nisFile()\nisDirectory()")
            .labelStyle({ maxLines: 10 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              if (FileUtil.accessSync(this.filePath)) {
                let name = FileUtil.getFileName(this.filePath)
                let parentPath = FileUtil.getParentPath(this.filePath);
                let parentUri = FileUtil.getParentUri(this.filePath);
                let strUri = "file://com.tong.yuyan.utils/data/storage/el2/base/haps/entry/files/download/wps/txt/demo.txt";
                let filePath = FileUtil.getFilePath(strUri);
                let fileUri = FileUtil.getFileUri(this.filePath);
                let uri = FileUtil.getUriFromPath(this.filePath);
                let isFile = FileUtil.isFile(this.filePath);
                let isDirectory = FileUtil.isDirectory(this.filePath);
                let name_path_uri = `name:\n${name}\n\nparentPath:\n${parentPath}\n\nparentUri:\n${parentUri}\n\nfilePath:\n${filePath}\n\nfileUri:\n${fileUri}\n\nuri:\n${uri}\n\nisFile:\n${isFile}\n\nisDirectory:\n${isDirectory}`
                Utils.showSheetText(name_path_uri);
                LogUtil.info(name_path_uri);
              } else {
                ToastUtil.showToast("文件不存在，请先创建和写入")
              }
            })
          Button("openSync()\nwriteSync()\nreadSync()\ncloseSync()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let path = FileUtil.getFilesDirPath("", "test.txt");
              let file = FileUtil.openSync(path);
              FileUtil.writeSync(file.fd, `"HUAWEI MatePad 11.5"S 对应的API版本是多少？`)
              FileUtil.closeSync(file.fd); //关闭文件
              file = FileUtil.openSync(path);
              let buffer: ArrayBuffer = new ArrayBuffer(180);
              FileUtil.readSync(file.fd, buffer);
              let bufferStr = StrUtil.bufferToStr(buffer);
              FileUtil.closeSync(file.fd); //关闭文件
              Utils.showSheetText(bufferStr);
              LogUtil.info(bufferStr);
            })
          Button("stat()")
            .btnStyle()
            .onClick(() => {
              if (FileUtil.accessSync(this.filePath)) {
                let stat = FileUtil.statSync(this.filePath);
                let jsonStr = `${stat.ino} - ${stat.mode} - ${stat.uid} - ${stat.gid} - ${stat.size} - ${stat.atime} - ${stat.mtime} - ${stat.isDirectory()} - ${stat.isFile()}`;
                Utils.showSheetText(jsonStr);
                LogUtil.info(jsonStr);
              } else {
                ToastUtil.showToast("文件不存在，请先创建和写入 目标文件")
              }
            })
          Button("truncate()\nlstat()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              FileUtil.truncate(this.filePath, 15); //截断
              let stat = FileUtil.lstatSync(this.filePath);
              let jsonStr = `${stat.ino} - ${stat.mode} - ${stat.uid} - ${stat.gid} - ${stat.size} - ${stat.atime} - ${stat.mtime} - ${stat.isDirectory()} - ${stat.isFile()}`;
              LogUtil.info(jsonStr);
              Utils.showSheetText(jsonStr);
            })
          Button("fsync()")
            .btnStyle()
            .onClick(() => {
              let file = FileUtil.openSync(this.filePath);
              FileUtil.fsync(file.fd).then(() => {
                LogUtil.info("同步成功！");
              }).catch((err: BusinessError) => {
                LogUtil.error("同步失败， error信息: " + err.message + ", error code: " + err.code);
              }).finally(() => {
                FileUtil.closeSync(file);
              });
            })
          Button("fdatasync()")
            .btnStyle()
            .onClick(() => {
              let file = FileUtil.openSync(this.filePath);
              FileUtil.fdatasync(file.fd).then(() => {
                LogUtil.info("sync data succeed");
                ToastUtil.showToast("sync data succeed");
              }).catch((err: BusinessError) => {
                LogUtil.error("sync data failed with error message: " + err.message + ", error code: " + err.code);
              }).finally(() => {
                FileUtil.closeSync(file);
              });
            })
          Button("createStream()")
            .btnStyle()
            .onClick(() => {
              FileUtil.createStream(this.filePath, "a+").then((stream: fs.Stream) => {
                stream.closeSync();
                LogUtil.info("createStream succeed");
                ToastUtil.showToast("createStream succeed");
              }).catch((err: BusinessError) => {
                LogUtil.error("createStream failed with error message: " + err.message + ", error code: " + err.code);
              });
            })
          Button("fdopenStream()")
            .btnStyle()
            .onClick(() => {
              let file = FileUtil.openSync(this.filePath);
              FileUtil.fdopenStream(file.fd, "r+").then((stream: fs.Stream) => {
                console.info("openStream succeed");
                ToastUtil.showToast("openStream succeed");
                stream.closeSync();
              }).catch((err: BusinessError) => {
                console.error("openStream failed with error message: " + err.message + ", error code: " + err.code);
                fs.closeSync(file); //文件流打开失败后，文件描述符需要手动关闭
              });
            })
          Button("dup()")
            .btnStyle()
            .onClick(() => {
              let file = FileUtil.openSync(this.filePath, fs.OpenMode.READ_WRITE);
              let fd: number = file.fd;
              let file2 = FileUtil.dup(fd);
              LogUtil.info("The name of the file2 is " + file2.name);
              ToastUtil.showToast("The name of the file2 is " + file2.name);
              FileUtil.closeSync(file);
              FileUtil.closeSync(file2);
            })
          Button("utimes()")
            .btnStyle()
            .onClick(() => {
              let filePath = FileUtil.getFilesDirPath('download/wps/txt', 'demo_time.txt');
              let file = FileUtil.openSync(filePath, fs.OpenMode.READ_WRITE);
              FileUtil.writeSync(file.fd, "harmony-utils一款高效的OpenHarmony/HarmonyOS工具包。帮助开发者快速构建鸿蒙应用！");
              FileUtil.closeSync(file);
              FileUtil.utimes(filePath, new Date().getTime());
              ToastUtil.showToast("操作成功！");
            })
          Button("mkdtemp()")
            .btnStyle()
            .onClick(() => {
              let path = FileUtil.getFilesDirPath() + "/临时目录/download/temp";
              let tempPath = FileUtil.mkdtempSync(path);
              ToastUtil.showToast("操作成功: " + tempPath);
            })


          Button("copyFile()")
            .btnStyle()
            .onClick(() => {
              let path = FileUtil.getFilesDirPath("download/wps", "test_cpoy.txt");
              if (FileUtil.accessSync(this.filePath)) {
                FileUtil.copyFile(this.filePath, path).then(() => {
                  let size = FileUtil.lstatSync(path).size;
                  ToastUtil.showToast("文件拷贝成功：" + size);
                })
              } else {
                ToastUtil.showToast("文件不存在，请先创建和写入 目标文件")
              }
            })
          Button("copy()")
            .btnStyle()
            .onClick(() => {
              let path = FileUtil.getFilesDirPath("download");
              let path2 = FileUtil.getFilesDirPath("copy目录");
              if (FileUtil.accessSync(path)) {
                let progressListener: fs.ProgressListener = (progress: fs.Progress) => {
                  LogUtil.info(`progressSize: ${progress.processedSize}, totalSize: ${progress.totalSize}`);
                };
                FileUtil.copy(FileUtil.getUriFromPath(path), FileUtil.getUriFromPath(path2),
                  { "progressListener": progressListener }).then(() => {
                  let size = FileUtil.lstatSync(path2).size;
                  ToastUtil.showToast("文件夹拷贝成功：" + size);
                }).catch((err: BusinessError) => {
                  ToastUtil.showToast("文件夹拷贝异常：" + err.message);
                })
              } else {
                ToastUtil.showToast("文件夹不存在，请先创建");
              }
            })
          Button("copyDir()")
            .btnStyle()
            .onClick(() => {
              let path = FileUtil.getFilesDirPath("download");
              let path2 = FileUtil.getFilesDirPath("copyDir目录");
              if (FileUtil.accessSync(path)) {
                FileUtil.copyDir(path, path2).then(() => {
                  let size = FileUtil.lstatSync(path2).size;
                  ToastUtil.showToast("文件夹拷贝成功：" + size);
                }).catch((err: BusinessError) => {
                  ToastUtil.showToast("文件夹拷贝异常：" + err.message);
                })
              } else {
                ToastUtil.showToast("文件夹不存在，请先创建");
              }
            })
          Button("moveFile()")
            .btnStyle()
            .onClick(() => {
              let path = FileUtil.getFilesDirPath("download/wps", "test_cpoy.txt");
              let path2 = FileUtil.getFilesDirPath("download/txt", "test_cpoy.txt");
              if (FileUtil.accessSync(path)) {
                FileUtil.moveFile(path, path2).then(() => {
                  ToastUtil.showToast("移动文件成功");
                })
              } else {
                ToastUtil.showToast("文件不存在")
              }
            })
          Button("moveDir()")
            .btnStyle()
            .onClick(() => {
              let path = FileUtil.getFilesDirPath("copyDir目录");
              let path2 = FileUtil.getFilesDirPath("moveDir目录");
              if (FileUtil.accessSync(path)) {
                FileUtil.moveDir(path, path2).then(() => {
                  ToastUtil.showToast("文件夹移动成功");
                }).catch((err: BusinessError) => {
                  ToastUtil.showToast("文件夹移动异常：" + err.message);
                })
              } else {
                ToastUtil.showToast("文件夹不存在，请先创建");
              }
            })
          Button("rename()")
            .btnStyle()
            .onClick(() => {
              let path = FileUtil.getFilesDirPath("", "test_cpoy.txt");
              let path2 = FileUtil.getFilesDirPath("", "test_cpoy2.txt");
              if (FileUtil.accessSync(path)) {
                FileUtil.rename(path, path2);
                ToastUtil.showToast("重命名成功");
              } else {
                ToastUtil.showToast("文件不存在，请先创建或拷贝 目标文件")
              }
            })
          Button("listFileSync()")
            .btnStyle()
            .onClick(() => {
              let dirPath = FileUtil.getFilesDirPath("");
              let listFile = FileUtil.listFileSync(dirPath, { recursion: true });
              let listFileStr = listFile.join('\n');
              Utils.showSheetText(listFileStr);
              LogUtil.info(listFileStr);
            })
          Button("unlink()")
            .btnStyle()
            .onClick(() => {
              FileUtil.unlink(this.filePath).then(() => {
                ToastUtil.showToast("删除单个文件成功");
              }).catch((err: BusinessError) => {
                ToastUtil.showToast("删除单个文件失败！");
              });
            })
          Button("rmdir()")
            .btnStyle()
            .onClick(() => {
              let dirPath = FileUtil.getFilesDirPath("");
              FileUtil.rmdir(dirPath).then(() => {
                ToastUtil.showToast("删除整个目录成功");
              });
            })

          Button("saveDocument()")
            .btnStyle()
            .onClick(() => {
              let fileName = `test_${DateUtil.getTodayTime()}.txt`;
              PickerUtil.saveDocument({newFileNames:[fileName]}).then((uris) => {
                let uri = uris[0];
                this.cacheUri = uri
                PreferencesUtil.put("picker_cache_uri", this.cacheUri);
                let txtStr = `“harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。\n\n`;
                FileUtil.writeEasy(uri, txtStr).then(() => {
                  this.jsonStr = `文件保存成功，返回uris：\n${uri}`;
                  ToastUtil.showToast("文件保存成功！");
                }).catch((err: BusinessError) => {
                  this.jsonStr = `文件保存，异常：\n${JSON.stringify(err)}`;
                })
              }).catch((err: BusinessError) => {
                this.jsonStr = `调用保存文件，异常：\n${JSON.stringify(err)}`;
              })
            })
          Button("checkPersistentPermission()")
            .btnStyle()
            .onClick(() => {
              LogUtil.error("授权uri："+this.cacheUri)
              if (StrUtil.isNotEmpty(this.cacheUri)) {
                let policie: fileShare.PolicyInfo = {
                  uri: this.cacheUri,
                  operationMode: fileShare.OperationMode.READ_MODE | fileShare.OperationMode.WRITE_MODE
                }
                FileUtil.checkPersistentPermission([policie]).then(() => {
                  this.jsonStr = `检查权限，成功！\n${this.cacheUri}`;
                }).catch((err: BusinessError) => {
                  this.jsonStr = `检查权限，异常：\n${JSON.stringify(err)}`;
                });
              } else {
                ToastUtil.showToast("请先调用saveDocument()保存文件，在操作！");
              }
            })
          Button("persistPermissionEasy()")
            .btnStyle()
            .onClick(() => {
              if (StrUtil.isNotEmpty(this.cacheUri)) {
                FileUtil.persistPermissionEasy([this.cacheUri]).then(() => {
                  this.jsonStr = `授权，已授权！\n${this.cacheUri}`;
                  let file = FileUtil.openSync(this.cacheUri); //uri是否可用，读取文件
                  this.jsonStr = this.jsonStr + `\n\n文件名：${file.name}`;
                  LogUtil.error("file: " + file.name);
                }).catch((err: BusinessError) => {
                  this.jsonStr = `授权，异常：\n${JSON.stringify(err)}`;
                });
              } else {
                ToastUtil.showToast("请先调用saveDocument()保存文件，在操作！");
              }
            })
          Button("revokePermissionEasy()")
            .btnStyle()
            .onClick(() => {
              if (StrUtil.isNotEmpty(this.cacheUri)) {
                FileUtil.revokePermissionEasy([this.cacheUri]).then(() => {
                  this.jsonStr = `移除授权，成功！`;
                  let file = FileUtil.openSync(this.cacheUri); //uri是否可用，读取文件
                  this.jsonStr = this.jsonStr + `\n\n文件名：${file.name}`;
                  LogUtil.error("file: " + file.name);
                }).catch((err: BusinessError) => {
                  this.jsonStr = `移除授权，异常：\n${JSON.stringify(err)}`;
                });
              } else {
                ToastUtil.showToast("请先调用saveDocument()保存文件，在操作！");
              }
            })
          Button("activatePermissionEasy()")
            .btnStyle()
            .onClick(() => {
              if (StrUtil.isNotEmpty(this.cacheUri)) {
                FileUtil.activatePermissionEasy([this.cacheUri]).then(() => {
                  this.jsonStr = `使能操作，成功！\n${this.cacheUri}`;
                }).catch((err: BusinessError) => {
                  this.jsonStr = `使能操作，异常：\n${JSON.stringify(err)}`;
                })
              } else {
                ToastUtil.showToast("请先调用saveDocument()保存文件，在操作！");
              }
            })
          Button("deactivatePermissionEasy()")
            .btnStyle()
            .onClick(() => {
              if (StrUtil.isNotEmpty(this.cacheUri)) {
                FileUtil.deactivatePermissionEasy([this.cacheUri]).then(() => {
                  this.jsonStr = `取消使能授权，成功！\n${this.cacheUri}`;
                }).catch((err: BusinessError) => {
                  this.jsonStr = `取消使能授权，异常：\n${JSON.stringify(err)}`;
                })
              } else {
                ToastUtil.showToast("请先调用saveDocument()保存文件，在操作！");
              }
            })

          Text(this.jsonStr)
            .visibility(StrUtil.isNotEmpty(this.jsonStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getFormatFileSize()")
            .btnStyle()
            .onClick(() => {
              let sizeStr = FileUtil.getFormatFileSize(1020450901);
              ToastUtil.showToast(`文件大小：${sizeStr}`);
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

@Styles
function textStyle() {
  .width('95%')
  .padding(10)
  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  .margin({ top: 5, bottom: 10 })
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}