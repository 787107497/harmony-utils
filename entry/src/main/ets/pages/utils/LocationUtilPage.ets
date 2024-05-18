import { ComposeTitleBar, router } from '@kit.ArkUI';
import { LocationUtil, StrUtil } from 'harmony_utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 定位工具类(WGS-84坐标系)
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State addrStr: string = ''

  aboutToAppear(): void {

  }

  onBackPress(): boolean {
    return false;
  }

  build() {
    Column() {
      ComposeTitleBar({
        title: this.describe.name,
        subtitle: this.describe.desc,
      })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("isLocationEnabled()")
            .btnStyle()
            .onClick(() => {
              LocationUtil.isLocationEnabled()

            })
          Button("requestLocationPermissions()")
            .btnStyle()
            .onClick(() => {

            })
          Button("getCurrentLocationEasy()")
            .btnStyle()
            .onClick(() => {

            })
          Button("onLocationChangeEasy()")
            .btnStyle()
            .onClick(() => {

            })
          Button("offLocationChange()")
            .btnStyle()
            .onClick(() => {

            })

          Button("getAddressFromLocationName()")
            .btnStyle()
            .onClick(() => {

            })
          Button("getAddressFromLocation()")
            .btnStyle()
            .onClick(() => {

            })
          Button("getCountryCode()")
            .btnStyle()
            .onClick(() => {

            })

          Text(this.addrStr)
            .visibility(StrUtil.isNotEmpty(this.addrStr) ? Visibility.Visible : Visibility.None)
            .textStyle()

          Text('').layoutWeight(1)
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
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
  .backgroundColor(Color.White)
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}