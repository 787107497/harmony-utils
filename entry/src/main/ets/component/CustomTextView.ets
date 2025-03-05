
//自定义的文本组件
@Builder
export function CustomTextViewBuilder(content: string | Resource): void {
  CustomTextView({ content: content })
}

/**
 * showCustomContentDialog - 自定义的文本组件
 */
@ComponentV2
export struct CustomTextView {
  @Require @Param content: string | Resource;

  build() {
    Text(this.content)
      .fontSize(15)
      .fontStyle(FontStyle.Normal)
      .fontFamily('MyFont')
      .shadow(ShadowStyle.OUTER_DEFAULT_SM)
      .textShadow({
        color: Color.Red,
        radius: 2,
        type: ShadowType.COLOR,
        fill: true
      })
      .padding(10)
      .borderRadius(5)
      .backgroundColor($r('app.color.color_line'))
      .alignSelf(ItemAlign.Center)
      .width('100%')
  }
}