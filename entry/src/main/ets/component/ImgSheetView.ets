import { TISheetOptions } from '../model/TISheetOptions';

//自定义半模态
@Builder
export function ImgSheetBuilder(options: TISheetOptions) {
  ImgSheetView({ options: options })
}

/**
 * 图片内容展示
 */
@Preview
@ComponentV2
export struct ImgSheetView {
  private scroller: Scroller = new Scroller();
  @Require @Param options: TISheetOptions;
  @Local src: string | PixelMap | Resource = "";

  aboutToAppear(): void {
    this.options.backgroundColor = this.options.backgroundColor ?? $r('app.color.main_background');
    this.src = this.options.content;
  }

  build() {
    Column() {
      Scroll(this.scroller) {
        Image(this.src).width('100%')
      }
      .width('calc(100% - 30vp)')
      .margin({ top: 6, bottom: 30 })
      .padding(12)
      .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
    }
    .width('100%')
    .backgroundColor(Color.Transparent)
    .borderRadius(5)
    .clip(true)
  }
}