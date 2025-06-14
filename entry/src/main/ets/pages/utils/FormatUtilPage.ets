import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { Any } from '@pura/harmony-dialog';
import { FormatUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { Utils } from '../../utils/Utils';

/**
 * 格式化工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("FormatUtil", "格式化工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("isPhone()\ngetPhoneFormat()\ngetPhoneLocationName()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let phone: string = "18969062528";
              let bl = FormatUtil.isPhone(phone);
              let format = FormatUtil.getPhoneFormat(phone);
              let locationName = FormatUtil.getPhoneLocationName(phone);
              let resultStr = `isPhone: ${bl}\n\ngetPhoneFormat: ${format}\n\ngetPhoneLocationName: ${locationName}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("transliterator()")
            .btnStyle()
            .onClick(() => {
              let str = FormatUtil.transliterator("中国");
              LogUtil.error(`transliterator: ${str}`);
              ToastUtil.showToast(`transliterator: ${str}`);
            })
          Button("getFormatPhone()")
            .btnStyle()
            .onClick(() => {
              let str = FormatUtil.getFormatPhone("13909606520");
              LogUtil.error(`格式化后的手机号码: ${str}`);
              ToastUtil.showToast(`格式化后的手机号码: ${str}`);
            })
          Button("getFormatCardNo()")
            .btnStyle()
            .onClick(() => {
              let str = FormatUtil.getFormatCardNo("110101199001011234");
              LogUtil.error(`格式化后的身份证号: ${str}`);
              ToastUtil.showToast(`格式化后的身份证号: ${str}`);
            })
          Button("getFormatFileSize()")
            .btnStyle()
            .onClick(() => {
              let str = FormatUtil.getFormatFileSize(1024102400);
              LogUtil.error(`文件大小: ${str}`);
              ToastUtil.showToast(`文件大小: ${str}`);
            })
          Button("getTruncateText()")
            .btnStyle()
            .onClick(() => {
              let str = FormatUtil.getTruncateText("女人什么年龄是最好？任何年龄都可以。因为每个年龄段都有不一样的美。看XX的穿搭你就会发现成熟女性的魅力，反而会更加的吸引人。", 20);
              LogUtil.error(`缩短长文本: ${str}`);
              ToastUtil.showToast(`${str}`);
            })
          Button("getIconFont()")
            .btnStyle()
            .onClick(() => {
              let str = FormatUtil.getIconFont("e631");
              LogUtil.error(`getIconFont: ${str}`);
              ToastUtil.showToast(`getIconFont: ${str}`);
            })
          Button("getQueryValue()")
            .btnStyle()
            .onClick(() => {
              let url = "https://blog.csdn.net/article?spm=blog1024&name=李斯";
              let value1 = FormatUtil.getQueryValue(url, 'spm');
              let value2 = FormatUtil.getQueryValue(url, 'name');
              let value3 = FormatUtil.getQueryValue(url, 'mona');
              LogUtil.error(`value1: ${value1}\nvalue2: ${value2}\nvalue3: ${value3}`);
              ToastUtil.showToast(`value1: ${value1}\nvalue2: ${value2}\nvalue3: ${value3}`);
            })
          Button("getParamsUrl()")
            .btnStyle()
            .onClick(() => {
              let map = new Map<string, Any>();
              map.set("id", 100011);
              map.set("name", '王五');
              map.set("sex", undefined);
              let url = FormatUtil.getParamsUrl("https://blog.csdn.net?id=100012", map);
              LogUtil.error(`url: ${url}`);
              ToastUtil.showToast(`${url}`);
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