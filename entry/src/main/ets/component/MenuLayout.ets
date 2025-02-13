import { DialogHelper } from '@pura/harmony-dialog';
import { MyCustomOptions } from '../utils/MyCustomOptions';


//底部菜单
@Builder
export function MyCustomBuilder(options: MyCustomOptions) {
  MenuLayout({ options: options })
}

/**
 * 自定义底部菜单组件
 */
@Preview
@ComponentV2
export struct MenuLayout {
  @Require @Param options: MyCustomOptions;

  build() {
    Column() {
      Text(this.options.msg)
        .fontColor(Color.Blue)
        .fontWeight(FontWeight.Bold)
        .fontSize(16)
        .padding(20)
        .margin({ top: 20 })
      Image($r('app.media.test_as2'))
        .width("100%")
        .margin({ top: 5 })

      Blank().layoutWeight(1)
      Button("关闭，自定义弹框")
        .onClick(() => {
          DialogHelper.closeDialog(this.options.dialogId ?? ""); //关闭弹框
        })
      Blank().layoutWeight(1)
    }
    .height(this.options.height)
    .width("100%")
    .padding(10)
    .backgroundColor(Color.White)
  }
}