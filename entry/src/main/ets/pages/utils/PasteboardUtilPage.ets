import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { ImageUtil, PasteboardUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { TitleBarView } from '../../component/TitleBarView';
import { pasteboard } from '@kit.BasicServicesKit';
import { Utils } from '../../utils/Utils';
import { JSON } from '@kit.ArkTS';
import { Want } from '@kit.AbilityKit';

/**
 * 剪贴板工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

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
              PasteboardUtil.requestPermissions().then((result) => {
                ToastUtil.showToast(`检测并申请授权，允许应用读取剪贴板：${result}`);
              });
            })
          Button("getSystemPasteboard()")
            .btnStyle()
            .onClick(() => {
              let systemPasteboard = PasteboardUtil.getSystemPasteboard();
              ToastUtil.showToast(`SystemPasteboard获取成功！`);
            })
          Button("hasData()")
            .btnStyle()
            .onClick(() => {
              let hasData = PasteboardUtil.hasDataSync();
              ToastUtil.showToast(`系统剪贴板中是否有内容：${hasData}`);
            })
          Button("setData()")
            .btnStyle()
            .onClick(() => {
              let text = "一款高效的OpenHarmony/HarmonyOS工具包。"
              PasteboardUtil.setDataSync(pasteboard.MIMETYPE_TEXT_PLAIN, text);
              ToastUtil.showToast("设置成功");
            })
          Button("getData()")
            .btnStyle()
            .onClick(() => {
              let text = PasteboardUtil.getDataSync().getPrimaryText();
              ToastUtil.showToast(`剪切板内容为：${text}`);
            })
          Button("setDataText()")
            .btnStyle()
            .onClick(() => {
              let text = "harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。"
              PasteboardUtil.setDataText(text).then(() => {
                ToastUtil.showToast("设置成功！");
              })
            })
          Button("getDataText()")
            .btnStyle()
            .onClick(async () => {
              let str = await PasteboardUtil.getDataText();
              ToastUtil.showToast(`剪切板内容为：${str}`);
            })
          Button("setDataHtml()")
            .btnStyle()
            .onClick(() => {
              let html = "<!DOCTYPE html>\n" + "<html>\n" + "<head>\n" + "<meta charset=\"utf-8\">\n" +
                "<title>HTML-PASTEBOARD_HTML</title>\n" + "</head>\n" + "<body>\n" + "<h1>HEAD</h1>\n" +
                "<p>一个富文本</p>\n" + "</body>\n" + "</html>";
              PasteboardUtil.setDataHtml(html).then(() => {
                ToastUtil.showToast("设置成功");
              })
            })
          Button("getDataHtml()")
            .btnStyle()
            .onClick(async () => {
              let html = await PasteboardUtil.getDataHtml();
              ToastUtil.showToast(`剪切板内容为：${html}`);
            })
          Button("setDataUri()")
            .btnStyle()
            .onClick(() => {
              let dataUri = 'dataability:///com.example.myapplication1/user.txt';
              PasteboardUtil.setDataUri(dataUri).then(() => {
                ToastUtil.showToast("设置成功");
              })
            })
          Button("getDataUri()")
            .btnStyle()
            .onClick(() => {
              let uri = PasteboardUtil.getDataUriSync();
              ToastUtil.showToast(`剪切板内容为：${uri}`);
            })
          Button("getDataStr()")
            .btnStyle()
            .onClick(() => {
              let str = PasteboardUtil.getDataStrSync();
              ToastUtil.showToast(`剪切板内容为：${str}`);
            })
          Button("setDataWant()")
            .btnStyle()
            .onClick(() => {
              let want: Want = {
                deviceId: 'device_666666',
                bundleName: 'com.example.myapplication',
                abilityName: 'FuncAbility',
                moduleName: 'entry'
              };
              PasteboardUtil.setDataWantSync(want);
              ToastUtil.showToast("设置成功");
            })
          Button("getDataWant()")
            .btnStyle()
            .onClick(() => {
              let want = PasteboardUtil.getDataWantSync();
              if (want) {
                let jsonStr = JSON.stringify(want, null, 2);
                Utils.showSheetText(jsonStr);
              }else {
                ToastUtil.showToast("剪切板内容为空，请先设置内容");
              }
            })
          Button("setDataPixelMap()")
            .btnStyle()
            .onClick(async () => {
              let pixelMap = await ImageUtil.getPixelMapFromMedia($r("app.media.test_as4"))
              PasteboardUtil.setDataPixelMap(pixelMap).then(() => {
                ToastUtil.showToast("设置成功");
              });
            })
          Button("getDataPixelMap()")
            .btnStyle()
            .onClick(() => {
              let pixelMap = PasteboardUtil.getDataPixelMapSync();
              if (pixelMap) {
                Utils.showSheetImg(pixelMap);
              } else {
                ToastUtil.showToast("剪切板内容为空，请先设置内容");
              }
            })
          Button("getDataEasy()")
            .btnStyle()
            .onClick(() => {
              let data = PasteboardUtil.getDataEasy();
              if (data && typeof data === 'string') {
                Utils.showSheetText(data);
              } else if (data && typeof data === 'object') {
                if (typeof (data as PixelMap).getImageInfo === 'function') {
                  Utils.showSheetImg(data as PixelMap);
                } else {
                  Utils.showSheetText(JSON.stringify(data, null, 2));
                }
              } else {
                ToastUtil.showToast("剪切板内容为空，请先设置内容");
              }
            })
          Button("clearData()")
            .btnStyle()
            .onClick(() => {
              PasteboardUtil.clearDataSync();
              ToastUtil.showToast(`清空成功！`);
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