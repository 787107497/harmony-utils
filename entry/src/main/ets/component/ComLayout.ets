/**
 * 自定义组件
 */
@Preview
@ComponentV2
export struct ComLayout {

  private controller: TextInputController = new TextInputController();

  build() {
    Column() {
      Column() {
        Row() {
          Image($r('app.media.icon_user'))
            .objectFit(ImageFit.Auto)
            .width(60)
            .height(60)
            .borderRadius(5)
            .margin({ left: 12 })

          Column() {
            Text("桃花镇童长老")
              .fontSize(15)
            Text("研发工程师")
              .fontSize(12)
              .margin({ top: 5 })
            Text("QQ群：1029219059")
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 5 })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 12 })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin(30)

        Divider()

        Image($r('app.media.test_as2'))
          .width('100%')
          .border({ width: 12, style: BorderStyle.Solid, color: $r('sys.color.comp_outline_color') })
      }
      .backgroundColor($r('sys.color.comp_background_gray'))

      Button('关闭')
        .type(ButtonType.Capsule)
        .controlSize(ControlSize.NORMAL)
        .margin({ top: 20, right: 12 })
        .alignSelf(ItemAlign.End)
        .onClick(()=>{

        })

      Blank().layoutWeight(1)

      TextInput({ placeholder: '请输入', controller: this.controller })
        .width('90%')
        .margin({ bottom: 12 })

    }
    .height('100%')
    .width("100%")
    .backgroundColor($r('app.color.main_background'))
  }
}