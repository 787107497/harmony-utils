import { DescribeBean } from '../model/DescribeBean';

@Preview
@ComponentV2
export struct CardFlow {
  @Require @Param describe: DescribeBean;

  build() {
    Column() {
      Text(this.describe.name)
        .fontSize(20)
        .fontColor($r('app.color.color_main'))
        .fontWeight(FontWeight.Bold)
        .fontStyle(FontStyle.Italic)
        .fontFamily('MyFont')
        .width('100%')

      Text(this.describe.desc)
        .fontFamily('MyFont')
        .fontSize(15)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
    .shadow(ShadowStyle.OUTER_DEFAULT_SM)
    .backgroundColor($r('app.color.card_background'))
    .border({
      width: 0.5,
      color: $r('app.color.color_line'),
      radius: 5,
      style: BorderStyle.Solid
    })
    .margin(5)
    .padding({ left: 18, top: 15, right: 18, bottom: 15 })
  }


}