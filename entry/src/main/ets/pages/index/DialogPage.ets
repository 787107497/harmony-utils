@Preview
@Component
export struct DialogPage {
  private scroller: Scroller = new Scroller();

  aboutToAppear(): void {


  }

  build() {
    Column() {
      Text("弹框")
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
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
  }
}