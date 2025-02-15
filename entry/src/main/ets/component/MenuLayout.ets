import { DialogHelper } from '@pura/harmony-dialog';
import { MenuOptions } from '../model/MenuOptions';
import { Callback } from '@ohos.base';
import { MenuBean } from '../model/MenuBean';
import { DisplayUtil, RandomUtil } from '@pura/harmony-utils';


//底部菜单
@Builder
export function MenuBuilder(options: MenuOptions) {
  MenuLayout({ options: options, onItemClick: options.onItemClick })
}

/**
 * 自定义底部菜单组件
 */
@Preview
@ComponentV2
export struct MenuLayout {
  @Require @Param options: MenuOptions;
  @Event onItemClick: Callback<MenuBean>;


  aboutToAppear(): void {
    this.options.backgroundColor = this.options.backgroundColor ?? $r('app.color.main_background');
    this.options.backgroundBlurStyle = this.options.backgroundBlurStyle ?? BlurStyle.COMPONENT_ULTRA_THICK;
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.End }) {
        Text(this.options.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .align(Alignment.TopStart)
          .width('100%')

        Image($r('sys.media.ohos_ic_public_close'))
          .width(28)
          .aspectRatio(1)
          .margin({
            top: 12,
            bottom: 12,
            left: 12,
            right: 20
          })
          .padding(5)
          .borderRadius(50)
          .border({ width: 1, color: $r('app.color.color_line'), style: BorderStyle.Solid })
          .backgroundColor($r('app.color.card_background'))
          .onClick((event) => {
            DialogHelper.closeDialog(this.options.dialogId ?? "");
          })
      }
      .width('100%')

      Divider()
        .color($r('app.color.color_line'))
        .strokeWidth(1)
        .width('100%')

      Grid() {
        ForEach(this.options.menus, (bean: MenuBean, index: number) => {
          GridItem() {
            Column() {
              Image((typeof bean.icon === 'string') ? $r(bean.icon) : bean.icon)
                .objectFit(ImageFit.Auto)
                .width('70%')
                .aspectRatio(1)
                .borderRadius(6)
                .backgroundColor(`${RandomUtil.getRandomColor()}`)
              Text(bean.text)
                .fontSize(12)
                .margin({ top: 5 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              bean.index = index;
              this.onItemClick(bean);
            })
          }
        }, (value: MenuBean, index: number) => `${value.text}_${index}`)
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
      .rowsGap(20)
      .columnsGap(5)
      .layoutDirection(GridDirection.Row)
      .margin({ top: 20, bottom: 25 })
      .width('100%')
      .height(`${px2vp(DisplayUtil.getWidth()) * 0.72}`)
    }
    .width('100%')
    .backgroundColor(this.options.backgroundColor)
    .backgroundBlurStyle(this.options.backgroundBlurStyle)
    .borderRadius({ topLeft: 12, topRight: 12 })
    .clip(true)

  }
}