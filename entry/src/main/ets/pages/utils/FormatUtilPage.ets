import { ComposeTitleBar, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { FormatUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../entity/DescribeBean';

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
              LogUtil.error(`isPhone: ${bl}`);
              let format = FormatUtil.getPhoneFormat(phone);
              LogUtil.error(`getPhoneFormat: ${format}`);
              let locationName = FormatUtil.getPhoneLocationName(phone);
              LogUtil.error(`getPhoneLocationName: ${locationName}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("transliterator()")
            .btnStyle()
            .onClick(() => {
              let str = FormatUtil.transliterator("中国");
              LogUtil.error(`transliterator: ${str}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("getIconFont()")
            .btnStyle()
            .onClick(() => {
              let str = FormatUtil.getIconFont("e631");
              LogUtil.error(`getIconFont: ${str}`);
              ToastUtil.showToast("请查看Log日志");
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
  .backgroundColor(Color.White)
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}