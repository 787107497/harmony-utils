import { AreaHelper, AreaEntity } from "@nutpi/china_area";
import { LogUtil, RegexUtil } from "@pura/harmony-utils";

@Preview
@Component
export struct RcpPage {
  private scroller: Scroller = new Scroller();
  private pefruits: string[] = ['peach1', 'peach2', 'peach3', 'peach4']

  private citys:AreaEntity[]=[]

  aboutToAppear(): void {

  this.citys=  AreaHelper.getAreaSync()
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

          TextPicker({ range: this.citys })


          TextInput({

          }).width('100%')
            .maxLength(10)
            .inputFilter(RegexUtil.REG_MOBILE, (value: string) => {
              LogUtil.error("inputFilter: "+value)

            })
            // .onChange((value: string | string[], index: number | number[]) => {
            //   console.info('Picker item changed, value: ' + value + ', index: ' + index)
            // })

          // Image($r('app.media.test_as2'))
          //   .objectFit(ImageFit.Fill)
          //   .width('98%')
          //   .margin({ top: 10, bottom: 10 })

          Blank().layoutWeight(1)
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
  }
}