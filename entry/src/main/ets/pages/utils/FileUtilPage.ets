import { ComposeTitleBar, router } from '@kit.ArkUI';
import { FileUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 文件操作相关工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State filePath: string = '' //文件路径
  @State txt: string = ''
  @State paths: string = ''
  @State resultStr: string = ''
  @State name_path_uri: string = ''
  @State bufferStr: string = ''
  @State listFileStr: string = ''
  @State jsonStr: string = ''

  aboutToAppear(): void {
    this.filePath = FileUtil.getFilesDirPath('download/wps/txt', 'demo.txt');
  }

  onBackPress(): boolean {
    return false;
  }

  build() {
    Column() {
      ComposeTitleBar({
        title: this.describe.name,
        subtitle: this.describe.desc,
      })
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
              this.paths = `${path1}\n\n${path2}\n\n${path3}\n\n${path4}\n\n${path5}\n\n${path6}\n\n${path7}\n\n${path8}`
            })
          Text(this.paths)
            .visibility(StrUtil.isNotEmpty(this.paths) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("hasDirPath()\ngetFileExtention()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let hasDirPath1 = FileUtil.hasDirPath("download/wps")
              let hasDirPath2 = FileUtil.hasDirPath(`${getContext().filesDir}/download/wps`)
              let fileExtention = FileUtil.getFileExtention("demo.txt")
              let fileExtention2 = FileUtil.getFileExtention("妹纸.png")
              this.resultStr = `hasDirPath1: ${hasDirPath1}\n\nhasDirPath2: ${hasDirPath2}\n\nfileExtention: ${fileExtention}\n\nfileExtention2: ${fileExtention2}`
            })
          Text(this.resultStr)
            .visibility(StrUtil.isNotEmpty(this.resultStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("readTextSync()")
            .btnStyle()
            .onClick(() => {
              if (FileUtil.accessSync(this.filePath)) {
                this.txt = FileUtil.readTextSync(this.filePath);
              } else {
                ToastUtil.showToast("文件不存在，请先创建和写入")
              }
            })
          Text(this.txt)
            .visibility(StrUtil.isNotEmpty(this.txt) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getFileName()\ngetParentPath()\ngetFileUri()\ngetUriFromPath()\nisFile()\nisDirectory()")
            .labelStyle({ maxLines: 6 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              if (FileUtil.accessSync(this.filePath)) {
                let name = FileUtil.getFileName(this.filePath)
                let parentPath = FileUtil.getParentPath(this.filePath);
                let fileUri = FileUtil.getFileUri(this.filePath);
                let uri = FileUtil.getUriFromPath(this.filePath);
                let isFile = FileUtil.isFile(this.filePath);
                let isDirectory = FileUtil.isDirectory(this.filePath);
                this.name_path_uri = `name:\n${name}\n\nparentPath:\n${parentPath}\n\nfileUri:\n${fileUri}\n\nuri:\n${uri}\n\nisFile:\n${isFile}\n\nisDirectory:\n${isDirectory}`
              } else {
                ToastUtil.showToast("文件不存在，请先创建和写入")
              }
            })
          Text(this.name_path_uri)
            .visibility(StrUtil.isNotEmpty(this.name_path_uri) ? Visibility.Visible : Visibility.None)
            .textStyle()
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
              let buffer: ArrayBuffer = new ArrayBuffer(4096);
              FileUtil.readSync(file.fd, buffer);
              this.bufferStr = StrUtil.bufferToStr(buffer);
              FileUtil.closeSync(file.fd); //关闭文件
            })
          Text(this.bufferStr)
            .visibility(StrUtil.isNotEmpty(this.bufferStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("copyFile()")
            .btnStyle()
            .onClick(() => {
              let path = FileUtil.getFilesDirPath("", "test_cpoy.txt");
              if (FileUtil.accessSync(this.filePath)) {
                FileUtil.copyFile(this.filePath, path).then(() => {
                  let size = FileUtil.lstatSync(path).size;
                  ToastUtil.showToast("文件拷贝成功：" + size);
                })
              } else {
                ToastUtil.showToast("文件不存在，请先创建和写入 目标文件")
              }
            })
          Button("listFileSync()")
            .btnStyle()
            .onClick(() => {
              let dirPath = FileUtil.getFilesDirPath("");
              let listFile = FileUtil.listFileSync(dirPath, { recursion: true });
              this.listFileStr = listFile.join('\n');
            })
          Text(this.listFileStr)
            .visibility(StrUtil.isNotEmpty(this.listFileStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("unlink()")
            .btnStyle()
            .onClick(() => {
              FileUtil.unlink(this.filePath).then(() => {
                ToastUtil.showToast("删除单个文件成功")
              })
            })
          Button("rmdir()")
            .btnStyle()
            .onClick(() => {
              let dirPath = FileUtil.getFilesDirPath("");
              FileUtil.rmdir(dirPath).then(() => {
                ToastUtil.showToast("删除整个目录成功")
              })
            })
          Button("getRawFileContentStr()")
            .btnStyle()
            .onClick(() => {
              FileUtil.getRawFileContentStr('data.json').then((result) => {
                this.jsonStr = result;
                ToastUtil.showToast("RawFile文件读取成功")
              })
            })
          Text(this.jsonStr)
            .visibility(StrUtil.isNotEmpty(this.jsonStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getFormatFileSize()")
            .btnStyle()
            .onClick(() => {
              let sizeStr = FileUtil.getFormatFileSize(1020450901)
              ToastUtil.showToast(`文件大小：${sizeStr}`)
            })

          Text('').layoutWeight(1)
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
  .backgroundColor(Color.White)
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}