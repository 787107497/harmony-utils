/**
 * showCustomContentDialog - 自定义的图片文本组件
 */
@ComponentV2
export struct CustomImageView {
  @Require @Param content: ResourceStr;
  @Require @Param src: Resource;

  build() {
    Scroll() {
      Column() {
        Text(this.content)
          .fontSize(13)
          .fontStyle(FontStyle.Normal)
          .fontFamily('MyFont')
          .padding(5)
          .textShadow({
            color: Color.Red,
            radius: 2,
            type: ShadowType.COLOR,
            fill: true
          })
          .alignSelf(ItemAlign.Center)
          .width('100%')

        Image(this.src)
          .width("100%")
          .objectFit(ImageFit.Fill)
          .margin({ top: 10 })
          .borderRadius(2)
      }
      .width("100%")
      .padding(10)
    }
    .backgroundColor($r('app.color.color_line'))
    .borderRadius(5)
  }
}