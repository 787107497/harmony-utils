import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { ClickUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';

/**
 * 节流、防抖 工具类（可用于点击事件，防止按钮被重复点击） */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("ClickUtil", "节流、防抖 工具类（可用于点击事件，防止按钮被重复点击）");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("throttle()")
            .btnStyle()
            .onClick(() => {
              ClickUtil.throttle(() => {
                ToastUtil.showToast("你好啊！X1");
              }, 1200)
            })
          Button("throttle()")
            .btnStyle()
            .onClick(() => {
              ClickUtil.throttle(() => {
                ToastUtil.showToast("你好啊！X2");
              })
            })

          Button("debounce()，单点击")
            .btnStyle()
            .onClick(() => {
              ClickUtil.debounce(() => {
                ToastUtil.showToast("点了我！D1");
              }, 1200)
            })
          Button("debounce()，多点击事件")
            .btnStyle()
            .onClick(() => {
              ClickUtil.debounce(() => {
                ToastUtil.showToast("点了我！D2S");
              }, 1200, "1000001")
            })
          Button("debounce()，多点击事件")
            .btnStyle()
            .onClick(() => {
              ClickUtil.debounce(() => {
                ToastUtil.showToast("点了我！D3S");
              }, 1200, "1000002")
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
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}