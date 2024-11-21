import { AreaEntity } from '@nutpi/china_area';

@Preview
@Component
export struct RcpPage {
  private scroller: Scroller = new Scroller();
  private pefruits: string[] = ['peach1', 'peach2', 'peach3', 'peach4']
  private citys: AreaEntity[] = []

  aboutToAppear(): void {

    // this.citys=  AreaHelper.getAreaSync()
  }

  build() {
    Column() {
      Text("RCP")
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column() {
          Blank().layoutWeight(1)

          TextPicker({ range: this.pefruits })
            .defaultPickerItemHeight(50)
            .disappearTextStyle({
              color: '#ff2431',
              font: {
                size: '14fp',
                weight: FontWeight.Regular
              }
            })
            .textStyle({
              color: '#18FF31',
              font: {
                size: '16fp',
                weight: FontWeight.Regular
              }
            })
            .selectedTextStyle({
              color: '#ff00ff',
              font: {
                size: '20vp',
                weight: FontWeight.Medium
              }
            })
            .canLoop(true)
            .divider({
              strokeWidth: '2px',
              startMargin: 0,
              endMargin: 0,
              color: '#33FF0000'
            })
            .gradientHeight(36)
            .backgroundColor(Color.Pink)


          Blank().layoutWeight(1)
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
  }
}