import { DialogAction } from '@pura/harmony-dialog';
import { TipOptions } from '../model/TipOptions';


//底部菜单
@Builder
export function TipBuilder(options: TipOptions) {
  TipLayout({ options: options })
}

/**
 * 自定义底部菜单组件
 */
@Preview
@ComponentV2
export struct TipLayout {
  @Require @Param options: TipOptions;

  aboutToAppear(): void {
    this.options.backgroundColor = this.options.backgroundColor ?? $r('app.color.main_background');
    this.options.backgroundBlurStyle = this.options.backgroundBlurStyle ?? BlurStyle.COMPONENT_ULTRA_THICK;
  }

  build() {
    Column() {
      Image($r('app.media.dialog_tip'))
        .width(100)
        .alignSelf(ItemAlign.Center)
        .margin({ top: 32 })

      Text(this.options.title)
        .fontColor($r('app.color.color15'))
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .align(Alignment.TopStart)
        .margin({ top: 6 })

      Text(this.options.content)
        .textAlign(TextAlign.Center)
        .alignSelf(ItemAlign.Center)
        .margin(18)
        .fontSize(14)

      Button("确定")
        .width(200)
        .height(36)
        .align(Alignment.Center)
        .alignSelf(ItemAlign.Center)
        .backgroundColor($r('app.color.color15'))
        .margin({ top: 5, bottom: 35 })
        .onClick(() => {
          if (this.options.onAction) {
            this.options.onAction(DialogAction.SURE, this.options.dialogId ?? "");
          }
        })
    }
    .width(`calc(100% - 50vp)`)
    .constraintSize({ maxWidth: 400 })
    .backgroundColor(this.options.backgroundColor)
    .backgroundBlurStyle(this.options.backgroundBlurStyle)
    .borderRadius(12)
    .clip(true)
  }

}