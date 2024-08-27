@Preview
@Component
export struct RcpPage {
  private scroller: Scroller = new Scroller();

  build() {
    Column() {
      Text("RCP")
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column() {
          Image($r('app.media.test_as3'))
            .objectFit(ImageFit.Fill)
            .width('98%')
            .margin({ top: 10, bottom: 10 })

          Image($r('app.media.test_as4'))
            .objectFit(ImageFit.Fill)
            .width('98%')
            .margin({ top: 10, bottom: 10 })

          Blank().layoutWeight(1)
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
  }
}