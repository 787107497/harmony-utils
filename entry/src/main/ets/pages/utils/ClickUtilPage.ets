import { ComposeTitleBar, router } from '@kit.ArkUI';
import { ClickUtil, ToastUtil } from 'harmony_utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 节流、防抖 工具类（可用于点击事件，防止按钮被重复点击）
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

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
          Button("throttle()")
            .btnStyle()
            .onClick(() => {
              ClickUtil.throttle(() => {
                ToastUtil.showToast("你好啊！");
              }, 1200)
            })
          Button("debounce()")
            .btnStyle()
            .onClick(() => {
              ClickUtil.debounce(() => {
                ToastUtil.showToast("点了我！");
              }, 1200)
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