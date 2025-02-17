/**
 * 自定义组件
 */
@Preview
@ComponentV2
export struct ComLayout {
  private scroller: Scroller = new Scroller();
  @Local menus: string[] = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""];

  build() {
    Column() {
      Stack({ alignContent: Alignment.End }) {
        Text("分享")
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .align(Alignment.TopStart)
          .width('100%')

        Image($r('sys.media.ohos_ic_public_close'))
          .width(28)
          .aspectRatio(1)
          .margin(12)
          .padding(5)
          .backgroundColor($r('app.color.card_background'))
          .border({ width: 1, color: $r('app.color.color_line'), style: BorderStyle.Solid })
          .borderRadius(50)
          .align(Alignment.End)
          .alignSelf(ItemAlign.End)
      }
      .width('100%')

      Divider()
        .color($r('app.color.color_line'))
        .strokeWidth(1)
        .width('100%')
        .margin({ bottom: 5 })

      Grid() {
        ForEach(this.menus, (value: string, index: number) => {
          GridItem() {
            Column() {
              Image($r('app.media.icon_user'))
                .width('80%')
                .aspectRatio(1)
                .borderRadius(5)
              Text("菜单" + index)
                .fontSize(12)
                .margin({ top: 5 })
            }
            .margin(10)
            .alignItems(HorizontalAlign.Center)
          }
        }, (value: string, index: number) => `${value}_${index}`)
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
      .layoutDirection(GridDirection.Row)
    }
    .width('100%')
    .backgroundColor($r('app.color.main_background'))
    .borderRadius({ topLeft: 12, topRight: 12 })
  }
}