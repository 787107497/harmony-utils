import { DescribeBean } from '../entity/DescribeBean';

@ComponentV2
export struct CardLabel {
  @Require @Param describe: DescribeBean;

  build() {
    Column() {
      Text(this.describe.name)
        .fontFamily('MyFont')
        .fontSize(26)
        // .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
        .width('100%')
      Text(this.describe.desc)
        .fontFamily('MyFont')
        .fontSize(16)
        .fontColor($r('app.color.color_main'))
        .fontStyle(FontStyle.Italic)
        .width('100%')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
    .shadow(ShadowStyle.OUTER_DEFAULT_SM)
    .backgroundColor($r('app.color.card_background'))
    .border({
      width: 0.5,
      color: $r('app.color.color_line'),
      radius: 6,
      style: BorderStyle.Solid
    })
    .padding({ left: 18, top: 15, right: 18, bottom: 15 })
    .margin({ left: 15, top: 10, right: 15, bottom: 10 })
  }


}