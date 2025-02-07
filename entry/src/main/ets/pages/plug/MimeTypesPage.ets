import { ComposeTitleBar } from '@kit.ArkUI';
import { Mime } from '@pura/mime-types';


@Entry
@ComponentV2
export struct MimeTypesPage {
  private scroller: Scroller = new Scroller();


  aboutToAppear(): void {
    Mime.lookup("");
  }

  build() {
    Column() {
      ComposeTitleBar({
        title: $r('app.string.mime_types'),
        subtitle: $r('app.string.mime_types_desc'),
      })
      Scroll(this.scroller) {
        Column({ space: 15 }) {


          Blank().layoutWeight(1)
        }
        .padding({ left: 15, right: 15 })
      }
      .layoutWeight(1)
      .width('100%')
    }
  }
}