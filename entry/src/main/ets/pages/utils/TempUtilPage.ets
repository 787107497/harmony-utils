import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { TempUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';

/**
 * 温度转换工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("TempUtil", "温度转换工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("C2F()")
            .btnStyle()
            .onClick(() => {
              let f = TempUtil.C2F(27.5);
              ToastUtil.showToast(`转换后的华氏度：${f}`);
            })
          Button("F2C()")
            .btnStyle()
            .onClick(() => {
              let c = TempUtil.F2C(81.5)
              ToastUtil.showToast(`转换后的摄氏度：${c}`);
            })
          Button("C2K()")
            .btnStyle()
            .onClick(() => {
              let k = TempUtil.C2K(25);
              ToastUtil.showToast(`转换后的开尔文：${k}`);
            })
          Button("K2C()")
            .btnStyle()
            .onClick(() => {
              let c = TempUtil.K2C(298.15);
              ToastUtil.showToast(`转换后的摄氏度：${c}`);
            })
          Button("F2K()")
            .btnStyle()
            .onClick(() => {
              let k = TempUtil.F2K(77);
              ToastUtil.showToast(`转换后的开尔文：${k}`);
            })
          Button("K2F()")
            .btnStyle()
            .onClick(() => {
              let f = TempUtil.K2F(298.15);
              ToastUtil.showToast(`转换后的华氏度：${f}`);
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