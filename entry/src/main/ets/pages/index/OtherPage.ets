import { DateUtil, LogUtil } from '@pura/harmony-utils';

@Preview
@Component
export struct OtherPage {
  private scroller: Scroller = new Scroller();


  onCreateSub(): void {
DateUtil.getFormatDate()
    // NumberUtil.toInt()
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
            .onClick(() => {
              let array=["1月","2月","3月","4月","5月","6月"];
              let bl = array.includes("1月")
              let bl2 = array.includes("10月")
              LogUtil.error("bl: " + bl)
              LogUtil.error("bl: " + bl2)

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