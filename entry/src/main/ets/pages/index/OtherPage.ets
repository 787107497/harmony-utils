import { BusinessError, commonEventManager } from '@kit.BasicServicesKit';
import { LogUtil } from '@pura/harmony-utils';

@Preview
@Component
export struct OtherPage {
  private scroller: Scroller = new Scroller();

  onCreateSub(): void {

  }

  build() {
    Column() {
      Text("我的")
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column() {
          Blank().layoutWeight(1)

          Text("更多组件向您赶来...")
            .fontSize(24)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .onClick(()=>{

            })

          Blank().layoutWeight(1)

        }
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width("100%")
    .height("100%")
    .onAppear(() => {
      this.onCreateSub()
    })
  }
}