import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { TempUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 温度转换工具类，华氏度与摄氏度相互转换
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("TempUtil", "温度转换工具类，华氏度与摄氏度相互转换");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("F2C()")
            .btnStyle()
            .onClick(() => {
              let c = TempUtil.F2C(81.5)
              ToastUtil.showToast(`转换后的摄氏度：${c}`)
            })
          Button("C2F()")
            .btnStyle()
            .onClick(() => {
              let f = TempUtil.C2F(27.5);
              ToastUtil.showToast(`转换后的华氏度${f}`)
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