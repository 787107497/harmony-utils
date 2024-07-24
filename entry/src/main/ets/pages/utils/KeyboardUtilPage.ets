import { ComposeTitleBar, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { KeyboardUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 键盘工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  private controller: TextInputController = new TextInputController()
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("KeyboardUtil", "键盘工具类");
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
          Button("hide()")
            .btnStyle()
            .onClick(() => {
              KeyboardUtil.hide(this.controller);
              ToastUtil.showToast("隐藏键盘")
            })
          Button("onKeyboardListener()")
            .btnStyle()
            .onClick(() => {
              KeyboardUtil.onKeyboardListener((show) => {
                ToastUtil.showToast(`键盘显示或隐藏：${show}`)
              })
            })
          Button("removeKeyboardListener()")
            .btnStyle()
            .onClick(() => {
              KeyboardUtil.removeKeyboardListener()
            })
          Button("onInputTextChanged()")
            .btnStyle()
            .onClick(() => {
              KeyboardUtil.onInputTextChanged((text: string) => {
                ToastUtil.showToast(`文本内容：${text}`)
              })
            })
          Button("removeInputTextChanged()")
            .btnStyle()
            .onClick(() => {
              KeyboardUtil.removeInputTextChanged()
            })
          TextInput({ placeholder: '请输入', controller: this.controller })
            .margin({ top: 30 })
            .width('90%')

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