import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, NumberUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * number工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("NumberUtil", "number工具类");
  }


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("isNumber()")
            .btnStyle()
            .onClick(() => {
              let bl1 = NumberUtil.isNumber(12345);
              let bl2 = NumberUtil.isNumber("12345");
              let bl3 = NumberUtil.isNumber(1.212345);
              let bl4 = NumberUtil.isNumber(true);
              let bl5 = NumberUtil.isNumber(null);
              let bl6 = NumberUtil.isNumber(undefined);
              LogUtil.error(`bl1: ${bl1}\nbl2: ${bl2}\nbl3: ${bl3}`)
              LogUtil.error(`bl4: ${bl4}\nbl5: ${bl5}\nbl6: ${bl6}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("toInt()")
            .btnStyle()
            .onClick(() => {
              let n1 = NumberUtil.toInt("0.12579");
              let n2 = NumberUtil.toInt("12345");
              let n3 = NumberUtil.toInt("128.15624");
              let n4 = NumberUtil.toInt("1.212345");
              LogUtil.error(`n1: ${n1}\nn2: ${n2}\nn3: ${n3}\nn4: ${n4}\n`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("toFloat()")
            .btnStyle()
            .onClick(() => {
              let f1 = NumberUtil.toFloat("0.12579");
              let f2 = NumberUtil.toFloat("12345");
              let f3 = NumberUtil.toFloat("128.15624");
              let f4 = NumberUtil.toFloat("1.212345");
              LogUtil.error(`f1: ${f1}\nf2: ${f2}\nf3: ${f3}\nf4: ${f4}\n`)
              ToastUtil.showToast("请查看Log日志")
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