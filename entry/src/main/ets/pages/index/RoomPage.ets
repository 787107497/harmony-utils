@Preview
@Component
export struct RoomPage {
  private scroller: Scroller = new Scroller();

  build() {
    Column() {
      Text("数据库")
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column() {
          Image('https://n.sinaimg.cn/sinacn10113/332/w1024h1708/20190806/29ae-iatixpm8624904.jpg')
            .objectFit(ImageFit.Auto)
            .width('98%')
            .margin({ top: 10, bottom: 10 })

          Image('https://photo.4305.net.cn/upload/image/20230319/6381486004561976509381023.jpg')
            .objectFit(ImageFit.Auto)
            .width('98%')
            .margin({ top: 10, bottom: 10 })


          Blank().layoutWeight(1)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width("100%")
    .height("100%")
  }
}