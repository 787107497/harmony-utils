import { ComposeTitleBar, router } from '@kit.ArkUI';
import { CrashUtil, FileUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 全局异常捕获，崩溃日志收集
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State errorTxt: string = '';

  aboutToAppear(): void {

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
          Button("onError()")
            .btnStyle()
            .onClick(() => {
              CrashUtil.onError(); //注册错误观测器
              ToastUtil.showToast("注册错误观测器,成功")
            })
          Button("offError()")
            .btnStyle()
            .onClick(() => {
              CrashUtil.offError(); //注销错误观测器
              ToastUtil.showToast("注销错误观测器,成功")
            })
          Button("onExportErrorLog()")
            .btnStyle()
            .onClick(() => {
              CrashUtil.onExportErrorLog(); //导出错误日志文件
            })
          Button("readErrorText")
            .btnStyle()
            .onClick(async () => {
              this.errorTxt = await CrashUtil.readErrorText(); //读取错误文件
            })
          Button("制造异常")
            .btnStyle()
            .onClick(() => {
              let path = 'null';
              FileUtil.openSync(path)
            })
          Text(this.errorTxt)
            .visibility(StrUtil.isNotEmpty(this.errorTxt) ? Visibility.Visible : Visibility.None)
            .textStyle()

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