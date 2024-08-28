import { ComponentContent, PromptAction } from '@kit.ArkUI';
import { DialogParams } from '../model/DialogParams';

export class Dialog {
  private uiContext: UIContext;
  private promptAction?: PromptAction;
  private componentContent?: ComponentContent<DialogParams>

  constructor(uiContext: UIContext) {
    this.uiContext = uiContext;
  }


  show(param: DialogParams) {
    this.promptAction=this.uiContext.getPromptAction();
    // this.componentContent=new ComponentContent(this.uiContext,wrapBuilder())
  }

}


@Builder
function buildAlertDialogView(param:DialogParams){
  Column() {
    if (param.title) {
      Text(param.title)
        .width('100%')
        .fontWeight(FontWeight.Medium)
        .fontColor("#333333")
        .fontSize(20)
        .margin({ top: 18 })
    }
    Text(param.content)
      .width('100%')
      .fontWeight(FontWeight.Medium)
      .fontColor("#666666")
      .fontSize(14)
      .margin({ top: 18, bottom: 8 })

    Row() {
      if (param.leftText) {
        Button(param.leftText)
          .height(40)
          .fontSize(16)
          .fontColor('#666666')
          .layoutWeight(1)
          .fontWeight(FontWeight.Medium)
          .margin({ right: 5 })
          .backgroundColor('#ffffff')
          .onClick(() => {
            param?.leftClick?.()
          })
      }

      Button(param.rightText)
        .height(40)
        .fontSize(16)
        .fontColor('#ff06bcef')
        .layoutWeight(1)
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#ffffff')
        .onClick(() => {
          param?.rightClick?.()
        })
    }
  }
  .width("90%")
  .height('auto')
  .padding({ left: 25, right: 25, bottom: 15 })
  .backgroundColor(Color.White)
  .borderRadius(25)
}