import { promptAction, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';

/**
 * 土司工具类（promptAction）
 */
@Preview
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("ToastUtil", "土司工具类（promptAction）");
  }


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("showToast()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("弹出土司，默认时长为2s");
            })
          Button("showShort()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showShort("弹出短土司，时长为:1.5s");
            })
          Button("showLong()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showLong("弹出短土司，时长为:10s");
            })
          Button("showToast()，当前样式")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("弹出土司，当前样式", {
                alignment: Alignment.Top,
                offset: { dx: 0, dy: 30 },
                textColor: Color.Pink,
                backgroundColor: '#00AA88',
                duration: 6000
              });
            })
          Button("设置默认样式(一)")
            .btnStyle()
            .onClick(() => {
              ToastUtil.setDefaultConfig((config) => {
                config.alignment = Alignment.Top
                config.offset = { dx: 0, dy: 80 }
                config.backgroundColor = Color.Red
                config.textColor = Color.White
                config.enableHoverMode = true
                config.hoverModeArea = HoverModeAreaType.BOTTOM_SCREEN
              });
              ToastUtil.showLong("样式(一)设置成功");
            })
          Button("设置默认样式(二)")
            .btnStyle()
            .onClick(() => {
              ToastUtil.setDefaultConfig((config) => {
                config.alignment = Alignment.Center
                config.offset = { dx: 0, dy: 0 }
                config.showMode = promptAction.ToastShowMode.DEFAULT
                config.duration = 2600
                config.backgroundColor = Color.Blue
                config.textColor = Color.White
                config.enableHoverMode = true
                config.hoverModeArea = HoverModeAreaType.TOP_SCREEN
              });
              ToastUtil.showLong("样式(二)设置成功");
            })
          Button("设置默认样式(三)")
            .btnStyle()
            .onClick(() => {
              ToastUtil.setDefaultConfig((config) => {
                config.alignment = Alignment.Bottom
                config.offset = { dx: 0, dy: -80 }
                config.textColor = Color.Red
                config.backgroundColor = Color.Black
                config.enableHoverMode = false
              });
              ToastUtil.showLong("样式(三)设置成功");
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