import { router } from '@kit.ArkUI';
import { AreaHelper } from '@nutpi/china_area';
import { DialogHelper } from '@pura/harmony-dialog';
import { StrUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * @nutpi/china_area，使用案例
 */
@Entry
@ComponentV2
export struct ChinaAreaPage {
  private scroller: Scroller = new Scroller();
  @Local describe: DescribeBean = router.getParams() as DescribeBean;
  @Local txtStr: string = "";


  aboutToAppear(): void {

  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("getAreaStr()")
            .btnStyle()
            .onClick(async () => {
AreaHelper.getAreaStr();
            })



          Blank().layoutWeight(1)

          Text(this.txtStr)
            .visibility(StrUtil.isNotEmpty(this.txtStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.main_background'))
  }

}


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
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}