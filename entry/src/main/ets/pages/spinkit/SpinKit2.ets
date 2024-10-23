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
        title: $r('app.string.app_name'),
        subtitle: $r('app.string.module_desc'),
      })
      Divider()
      Scroll(this.scroller) {
        Grid() {
          GridItem() {
            SpinKit({
              spinType: SpinType.spinA,
              spinColor: $r('app.color.color1'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinB,
              spinColor: $r('app.color.color3'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinC,
              spinColor: $r('app.color.color4'),
              spinSize: 65
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinD,
              spinColor: $r('app.color.color4'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinE,
              spinColor: $r('app.color.color5'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinF,
              spinColor: $r('app.color.color6'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinG,
              spinColor: $r('app.color.color7'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinH,
              spinColor: $r('app.color.color8'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinI,
              spinColor: $r('app.color.color9'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinJ,
              spinColor: $r('app.color.color10'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinK,
              spinColor: $r('app.color.color11'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinL,
              spinColor: $r('app.color.color12'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinM,
              spinColor: $r('app.color.color13'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinN,
              spinColor: $r('app.color.color14'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinO,
              spinColor: $r('app.color.color9'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinP,
              spinColor: $r('app.color.color9'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinQ,
              spinColor: $r('app.color.color9'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinR,
              spinColor: $r('app.color.color9'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinS,
              spinColor: $r('app.color.color9'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinT,
              spinColor: $r('app.color.color9'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)

          GridItem() {
            SpinKit({
              spinType: SpinType.spinZ,
              spinColor: $r('app.color.color9'),
              spinSize: 60
            })
          }.aspectRatio(1)
          .backgroundColor(Color.White)
        }
        .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
        .columnsTemplate('1fr 1fr 1fr')
        .columnsGap(1)
        .rowsGap(1)
        .width('100%')
        .aspectRatio(3 / 7)
        .backgroundColor('#EEEEEE')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}