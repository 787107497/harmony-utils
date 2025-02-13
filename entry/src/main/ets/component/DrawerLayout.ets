import { DialogHelper } from '@pura/harmony-dialog';
import { KeyboardUtil } from '@pura/harmony-utils';
import { DrawerOptions } from '../utils/DrawerOptions';

//DrawerLayout
@Builder
export function DrawerBuilder(options: DrawerOptions) {
  DrawerLayout({ options: options })
}


/**
 * 自定义DrawerLayout组件
 */
@Preview
@ComponentV2
export struct DrawerLayout {
  @Require @Param options: DrawerOptions
  private scroller: Scroller = new Scroller();
  private controller: TextInputController = new TextInputController();
  @Local bottom: number = 0; //单位vp

  aboutToAppear(): void {
    //监听键盘高度
    KeyboardUtil.onKeyboardListener((show: boolean, height: number) => {
      if (show) {
        this.bottom = px2vp(height);
      } else {
        this.bottom = 0;
      }
    });
  }

  build() {
    Column() {
      Scroll(this.scroller) {
        Column() {
          Column() {
            Row() {
              Image($r('app.media.icon_user'))
                .objectFit(ImageFit.Auto)
                .width(60)
                .height(60)
                .borderRadius(5)
                .margin({ left: 12 })
              Column() {
                Text("桃花镇童长老")
                  .fontSize(18)
                Text("研发工程师")
                  .fontSize(12)
                  .margin({ top: 5 })
                Text("QQ群：1029219059")
                  .fontSize(10)
                  .fontWeight(FontWeight.Bold)
                  .margin({ top: 5 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 12 })
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .margin(30)
            .padding({ top: 15 })

            Divider().height(2).color($r('app.color.color_line'))
            Image($r('app.media.test_as2'))
              .objectFit(ImageFit.Auto)
              .width('100%')
              .border({ width: 12, style: BorderStyle.Solid, color: $r('app.color.card_background') })
          }

          Button('关闭')
            .type(ButtonType.Capsule)
            .controlSize(ControlSize.NORMAL)
            .margin({ top: 20, right: 12 })
            .alignSelf(ItemAlign.End)
            .onClick(() => { //关闭Drawer
              DialogHelper.closeDialog(this.options.dialogId ?? "");
            })
          Blank().layoutWeight(1)
          Text('处理键盘与弹框间距问题')
            .fontColor(Color.Red)
            .margin(12)
          TextInput({ placeholder: '请输入', controller: this.controller })
            .width('90%')
            .margin({ bottom: 28 })
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
    .height(`calc(100% - ${this.bottom}vp)`)
    .width(this.options.width)
    .backgroundColor($r('app.color.main_background'))
  }
}