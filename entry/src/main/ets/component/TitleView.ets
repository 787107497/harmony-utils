
@ComponentV2
export struct TitleView {
  @Param title: string = ''

  build() {
    Column() {
      Text(this.title)
        .fontFamily('MyFont')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .height(48)
        .width('100%')
        .backgroundColor($r('app.color.bar_background'))

      Divider()
        .height(1)
        .color($r('app.color.color_line'))
        .backgroundColor($r('app.color.color_line'))
    }
  }


}