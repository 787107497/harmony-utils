import { Callback } from '@ohos.base';
import { MenuBean } from '../model/MenuBean';
import { DisplayUtil, RandomUtil } from '@pura/harmony-utils';
import { MenuSheetOptions } from '../model/MenuSheetOptions';


//自定义半模态，底部菜单
@Builder
export function MenuSheetBuilder(options: MenuSheetOptions) {
  MenuSheetLayout({ options: options, onItemClick: options.onItemClick })
}

/**
 * 自定义底部菜单组件
 */
@Preview
@ComponentV2
export struct MenuSheetLayout {
  @Require @Param options: MenuSheetOptions;
  @Event onItemClick: Callback<MenuBean>;


  aboutToAppear(): void {
    this.options.backgroundColor = this.options.backgroundColor ?? $r('app.color.main_background');
  }

  build() {
    Column() {

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
    .borderRadius({ topLeft: 12, topRight: 12 })
    .clip(true)
  }

}