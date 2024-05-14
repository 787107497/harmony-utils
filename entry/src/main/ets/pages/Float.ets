import { LogUtil, WindowUtil } from 'harmony_utils';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = '这是一个悬浮窗';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(30)
          .margin({ top: 15 })
          .fontWeight(FontWeight.Bold)
          .padding(20)
          .backgroundColor('#9900FF')
          .onClick(async () => {
            let wind: window.Window = await window.getLastWindow(getContext())
            LogUtil.print(wind.getWindowProperties())
            WindowUtil.closeWindow()
          })


      }
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.White)
      .borderRadius(10)
      .width('90%')
      .height('30%')
    }
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#33000000')
    .width('100%')
    .height('100%')
  }
}