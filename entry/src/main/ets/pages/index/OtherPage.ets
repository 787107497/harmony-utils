@Preview
@Component
export struct OtherPage {
  private scroller: Scroller = new Scroller();

  build() {
    Column() {
      Text("艺术欣赏")
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column() {
          Image('https://i.ebayimg.com/images/g/TqoAAOSwXBlmOfcs/s-l1600.webp')
            .objectFit(ImageFit.Auto)
            .width('98%')
            .margin({ top: 10, bottom: 10 })

          Blank().layoutWeight(1)
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width("100%")
    .height("100%")
  }
}