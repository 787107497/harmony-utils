import { AppUtil, LogUtil } from '@pura/harmony-utils';
import { ComponentContent } from '@kit.ArkUI';

@Preview
@Component
export struct DialogPage {
  private scroller: Scroller = new Scroller();
  @State contentNode?: ComponentContent<string> = undefined;

  aboutToAppear(): void {

  }

  build() {
    Column() {
      Text("弹框")
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("测试1")
            .btnStyle()
            .onClick(() => {
              let uiContext = AppUtil.getUIContext();
              let promptAction = uiContext.getPromptAction();
              this.contentNode = new ComponentContent(uiContext, wrapBuilder(buildText), "哈哈哈");
              promptAction.openCustomDialog(this.contentNode, {
                onWillDismiss: (action: DismissDialogAction) => {
                  LogUtil.error(`点击返回：${JSON.stringify(action)}`);

              }
              });

              setTimeout(() => {
                promptAction.closeCustomDialog(this.contentNode);
              }, 20000)


            })
          Button("测试2")
            .btnStyle()
            .onClick(() => {

            })
          Button("测试3")
            .btnStyle()
            .onClick(() => {

            })

          Blank().layoutWeight(1)
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
  }
}


@Builder
function buildText(params: string) {
  Row() {
    Column() {
      Text(params)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 36 })
    }.backgroundColor('#FFF0F0F0')
  }

  .transition(TransitionEffect.OPACITY.animation({ duration: 800 })
    .combine(TransitionEffect.translate({ y: 100 })))
} //自定义组件的内容


@Styles
function btnStyle() {
  .width('90%')
  .margin({ top: 10, bottom: 5 })
}

@Styles
function textStyle() {
  .width('95%')
  .padding(10)
  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  .margin({ top: 5, bottom: 10 })
  .backgroundColor(Color.White)
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}