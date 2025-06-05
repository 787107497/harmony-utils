import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { KeyboardCallBack, KeyboardUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';

/**
 * 键盘工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  private controller: TextInputController = new TextInputController()
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  private callback: KeyboardCallBack = (show, height) => {
    LogUtil.error("onKeyboardListener-A: " + height);
    if (show) {
      ToastUtil.showToast(`键盘显示！高度为：${height}`);
    } else {
      ToastUtil.showToast(`键盘已关闭！`);
    }
  };

  @MockSetup
  mock() {
    this.describe = new DescribeBean("KeyboardUtil", "键盘工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("show()，主动拉起键盘")
            .btnStyle()
            .onClick(() => {
              KeyboardUtil.show("id_input_1000");
            })

          Button("hide()，关闭键盘")
            .btnStyle()
            .onClick(() => {
              KeyboardUtil.hide();
            })
          Button("onKeyboardListener()")
            .btnStyle()
            .onClick(() => {
              KeyboardUtil.onKeyboardListener((show, height) => {
                LogUtil.error("onKeyboardListener-B: " + height);
                if (show) {
                  ToastUtil.showToast(`键盘显示，高度为：${height}`);
                } else {
                  ToastUtil.showToast(`键盘已关闭！`);
                }
              });
            })
          Button("removeKeyboardListener()")
            .btnStyle()
            .onClick(() => {
              KeyboardUtil.removeKeyboardListener(); //移除所有
            })
          Button("onKeyboardListener()-指定")
            .btnStyle()
            .onClick(() => {
              KeyboardUtil.onKeyboardListener(this.callback);
            })
          Button("removeKeyboardListener()-指定")
            .btnStyle()
            .onClick(() => {
              KeyboardUtil.removeKeyboardListener(this.callback); //移除指定
            })

          TextInput({ placeholder: '请输入', controller: this.controller })
            .margin({ top: 30 })
            .width('90%')
            .id("id_input_1000")

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