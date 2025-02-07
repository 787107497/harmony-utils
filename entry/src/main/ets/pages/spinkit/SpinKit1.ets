import { SpinKit, SpinType } from '@pura/spinkit';
import { ComposeTitleBar } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();

  aboutToAppear(): void {

  }

  build() {
    Column() {
      ComposeTitleBar({
        title: $r('app.string.spin_kit'),
        subtitle: $r('app.string.spinKit_desc'),
      })
      Divider()
      Scroll(this.scroller) {
        Grid() {
          GridItem() {
            SpinKit({ spinType: SpinType.spinA })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color1'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinB })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color2'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinC })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color3'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinD })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color4'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinE })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color5'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinF })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color6'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinG })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color7'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinH })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color8'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinI })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color2'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinJ })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color10'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinK })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color11'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinL })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color12'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinM })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color13'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinN })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color14'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinO })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color15'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinP })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color1'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinQ })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color2'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinR })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color3'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinS })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color4'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinT })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color5'))

          GridItem() {
            SpinKit({ spinType: SpinType.spinZ })
          }.aspectRatio(1)
          .backgroundColor($r('app.color.color7'))
        }
        .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
        .columnsTemplate('1fr 1fr 1fr')
        .columnsGap(0)
        .rowsGap(0)
        .width('100%')
        .aspectRatio(3 / 7)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}