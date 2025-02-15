import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { PasteboardUtil, PermissionUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { Permissions } from '@kit.AbilityKit';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * 剪贴板工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State txtStr: string = ''

  @MockSetup
  mock() {
    this.describe = new DescribeBean("PasteboardUtil", "剪贴板工具类");
  }


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("申请应用读取剪贴板权限")
            .btnStyle()
            .onClick(() => {
              let p: Permissions = 'ohos.permission.READ_PASTEBOARD'; //允许应用读取剪贴板
              PermissionUtil.checkRequestPermissions(p).then((result) => {
                ToastUtil.showToast(`检测并申请授权，允许应用读取剪贴板：${result}`)
              })

            })
          Button("setDataText()")
            .btnStyle()
            .onClick(() => {
              let text = "harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。"
              PasteboardUtil.setDataText(text).then(() => {
                ToastUtil.showToast("设置成功")
              })
            })
          Button("getDataStr()")
            .btnStyle()
            .onClick(async () => {
              let str = await PasteboardUtil.getDataStr();
              this.txtStr = `剪贴板的内容1：\n${str}`;
            })
          Button("setDataHtml()")
            .btnStyle()
            .onClick(() => {
              let html = "<!DOCTYPE html>\n" + "<html>\n" + "<head>\n" + "<meta charset=\"utf-8\">\n" + "<title>HTML-PASTEBOARD_HTML</title>\n" + "</head>\n" + "<body>\n" + "<h1>HEAD</h1>\n" + "<p>一个富文本</p>\n" + "</body>\n" + "</html>";
              PasteboardUtil.setDataHtml(html).then(() => {
                ToastUtil.showToast("设置成功")
              })
            })
          Button("getData()")
            .btnStyle()
            .onClick(async () => {
              let html = (await PasteboardUtil.getData()).getPrimaryHtml();
              this.txtStr = `剪贴板的内容2：\n${html}`;
            })
          Button("setDataUri()")
            .btnStyle()
            .onClick(() => {
              let dataUri = 'data_ability:///com.example.myapplication1/user.txt';
              PasteboardUtil.setDataHtml(dataUri).then(() => {
                ToastUtil.showToast("设置成功")
              })
            })
          Button("getDataStr()")
            .btnStyle()
            .onClick(async () => {
              let uri = await PasteboardUtil.getDataStr();
              this.txtStr = `剪贴板的内容3：\n${uri}`;
            })
          Button("clearData()")
            .btnStyle()
            .onClick(() => {
              PasteboardUtil.clearData();
            })
          Button("hasDataSync()")
            .btnStyle()
            .onClick(() => {
              let has = PasteboardUtil.hasDataSync();
              ToastUtil.showToast(`剪贴板中是否有内容：${has}`)
            })

          Text(this.txtStr)
            .visibility(StrUtil.isNotEmpty(this.txtStr) ? Visibility.Visible : Visibility.None)
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
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}