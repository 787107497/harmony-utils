import { TextSheetOptions } from '../model/TextSheetOptions';


//自定义半模态
@Builder
export function TextSheetBuilder(options: TextSheetOptions) {
  TextSheetView({ options: options })
}

/**
 * 文本内容展示
 */
@Preview
@ComponentV2
export struct TextSheetView {
  private scroller: Scroller = new Scroller();
  @Require @Param options: TextSheetOptions;
  @Local content: string = '';

  aboutToAppear(): void {
    this.options.backgroundColor = this.options.backgroundColor ?? $r('app.color.main_background');
    this.content = this.options.content;
  }

  build() {
    Scroll(this.scroller) {
      Text(this.content)
        .textStyle()
    }
    .width('100%')
    .backgroundColor(Color.Transparent)
    .borderRadius(5)
    .clip(true)
  }
}


@Styles
function textStyle() {
  .width('calc(100% - 30vp)')
  .padding(12)
  .margin({ top: 6, bottom: 30 })
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}