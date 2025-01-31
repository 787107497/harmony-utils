@ComponentV2
export struct TabItemView {
  @Require @Param text: string | Resource;
  @Require @Param icon: string | Resource;
  @Require @Param check: boolean;

  build() {
    Column() {
      Image(this.icon)
        .width(26)
        .height(26)
        .objectFit(ImageFit.Auto)
        .fillColor(this.check ? $r('app.color.color_main') : $r('app.color.color_default'))
      Text(this.text)
        .fontSize(15)
        .fontColor(this.check ? $r('app.color.color_main') : $r('app.color.color_default'))
        .fontStyle(FontStyle.Normal)
        .margin({ top: 5 })
        .fontFamily('MyFont')
    }
    .backgroundColor(Color.Transparent)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .alignSelf(ItemAlign.Center)
  }
}