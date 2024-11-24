@Preview
@Component
export struct RoomPage {
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
          Text("美女欣赏")
            .width("100%")
            .fontSize(18)
            .fontColor(Color.Pink)
            .fontStyle(FontStyle.Italic)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .backgroundColor('#F0F0F0')
            .padding({ top: 12, bottom: 12 })

          Image('https://photo.4305.net.cn/upload/image/20230319/6381486004561976509381023.jpg')
            .objectFit(ImageFit.Auto)
            .width('90%')
            .margin(10)
          Image($r('app.media.test_as4'))
            .objectFit(ImageFit.Auto)
            .width('90%')
            .margin(10)

          Text("油画与艺术欣赏")
            .width("100%")
            .fontStyle(FontStyle.Italic)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Pink)
            .fontSize(20)
            .fontColor(Color.Black)
            .textAlign(TextAlign.Center)
            .backgroundColor('#F0F0F0')
            .padding({ top: 20, bottom: 15 })
            .margin({ top: 30 })

          Image('https://i.ebayimg.com/images/g/TqoAAOSwXBlmOfcs/s-l1600.webp')
            .objectFit(ImageFit.Auto)
            .width('100%')
            .margin({ top: 10, bottom: 10 })
          Image('https://i.ebayimg.com/images/g/x9MAAOSwBERmuRqE/s-l1600.webp')
            .objectFit(ImageFit.Auto)
            .width('90%')
            .margin({ top: 10, bottom: 10 })

          Blank().layoutWeight(1)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(Color.White)
    }
    .width("100%")
    .height("100%")
  }
}