import { ComposeTitleBar, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { AppUtil, LocationUtil, LogUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
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

  @MockSetup
  mock() {
    this.describe = new DescribeBean("LocationUtil", "定位工具类(WGS-84坐标系)");
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
              let isLocationEnabled = LocationUtil.isLocationEnabled()
              ToastUtil.showToast(`定位是否开启：${isLocationEnabled}`)
            })
          Button("requestLocationPermissions()")
            .btnStyle()
            .onClick(() => {
              LocationUtil.requestLocationPermissions().then((grant) => {
                if (grant) { //已授权
                  ToastUtil.showToast("授权成功")
                } else {
                  ToastUtil.showToast("请在设置中开启定位权限")
                  AppUtil.toAppSetting()
                }
              })
            })
          Button("getCurrentLocationEasy()")
            .btnStyle()
            .onClick(() => {
              LocationUtil.requestLocationPermissions().then((grant) => {
                if (grant) { //已授权
                  LocationUtil.getCurrentLocationEasy((location) => {
                    this.addrStr = `定位信息：\n${JSON.stringify(location, null, 2)}`
                  })
                } else {
                  ToastUtil.showToast("请在设置中开启定位权限")
                  AppUtil.toAppSetting()
                }
              })
            })
          Button("onLocationChangeEasy()")
            .btnStyle()
            .onClick(() => {
              LocationUtil.requestLocationPermissions().then((grant) => {
                if (grant) { //已授权
                  LocationUtil.onLocationChangeEasy((location) => {
                    this.addrStr = `开启位置变化订阅：\n${JSON.stringify(location, null, 2)}`
                  })
                } else {
                  ToastUtil.showToast("请在设置中开启定位权限")
                  AppUtil.toAppSetting()
                }
              })
            })
          Button("offLocationChange()")
            .btnStyle()
            .onClick(() => {
              LocationUtil.offLocationChange()
              ToastUtil.showToast("关闭位置变化订阅，成功")
            })

          Button("isGeocoderAvailable")
            .btnStyle()
            .onClick(() => {
              let isGeocoderAvailable = LocationUtil.isGeocoderAvailable();
              LogUtil.error(`地理编码与逆地理编码服务是否可用：${isGeocoderAvailable}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("getAddressFromLocationName()")
            .btnStyle()
            .onClick(async () => {
              let locationName: string = '上海市浦东新区'; //上海市浦东新区
              let address = await LocationUtil.getAddressFromLocationName(locationName);
              this.addrStr = `地理编码：\n${JSON.stringify(address, null, 2)}`;
              LogUtil.error(JSON.stringify(address, null, 2));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("getAddressFromLocation()")
            .btnStyle()
            .onClick(async () => {
              let latitude: number = 40;
              let longitude: number = 117;
              let address = await LocationUtil.getAddressFromLocation(latitude, longitude);
              this.addrStr = `逆地理编码：\n${JSON.stringify(address, null, 2)}`;
              LogUtil.error(JSON.stringify(address, null, 2));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("getCountryCode()")
            .btnStyle()
            .onClick(async () => {
              let code = await LocationUtil.getCountryCode();
              ToastUtil.showToast(`当前的国家码：${code}`);
            })

          Text(this.addrStr)
            .visibility(StrUtil.isNotEmpty(this.addrStr) ? Visibility.Visible : Visibility.None)
            .textStyle()

          Blank().layoutWeight(1)
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