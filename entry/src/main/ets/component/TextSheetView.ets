import { TISheetOptions } from '../model/TISheetOptions';


//自定义半模态
@Builder
export function TextSheetBuilder(options: TISheetOptions) {
  TextSheetView({ options: options })
}

/**
 * 文本内容展示
 */
@Preview
@ComponentV2
export struct TextSheetView {
  private scroller: Scroller = new Scroller();
  @Require @Param options: TISheetOptions;
  @Local content: string = '';

  aboutToAppear(): void {
    this.options.backgroundColor = this.options.backgroundColor ?? $r('app.color.main_background');
    this.content = this.options.content as string;
  }

  build() {
    Column() {
      Scroll(this.scroller) {
        Text(this.content)
          .width('100%')
      }
      .layoutWeight(this.content.length > 360 ? 1 : 0)
      .width('calc(100% - 30vp)')
      .margin({ top: 6, bottom: 30 })
      .padding(12)
      .border({
        width: 1,
        color: Color.Grey,
        radius: 10,
        style: BorderStyle.Dashed
      })
    }
    .width('100%')
    .backgroundColor(Color.Transparent)
    .borderRadius(5)
    .clip(true)
  }
}