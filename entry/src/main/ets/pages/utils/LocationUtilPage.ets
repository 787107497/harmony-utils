import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LocationUtil, LogUtil, StrUtil, ToastUtil, WantUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { geoLocationManager } from '@kit.LocationKit';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * 定位工具类(WGS-84坐标系)
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State addrStr: string = ''
  private locationCallBack1: Callback<geoLocationManager.Location> = (location) => {
    this.addrStr = `位置变化订阅1：\n${JSON.stringify(location, null, 2)}`
  }
  private locationCallBack2: Callback<geoLocationManager.Location> = (location) => {
    this.addrStr = `位置变化订阅2：\n${JSON.stringify(location, null, 2)}`
  }

  @MockSetup
  mock() {
    this.describe = new DescribeBean("LocationUtil", "定位工具类(WGS-84坐标系)");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("isLocationEnabled()")
            .btnStyle()
            .onClick(() => {
              let isLocationEnabled = LocationUtil.isLocationEnabled()
              ToastUtil.showToast(`定位是否开启：${isLocationEnabled}`);
            })
          Button("requestLocationPermissions()")
            .btnStyle()
            .onClick(() => {
              LocationUtil.requestLocationPermissions().then((grant) => {
                if (grant) { //已授权
                  ToastUtil.showToast("授权成功");
                } else {
                  ToastUtil.showToast("请在设置中开启定位权限");
                  WantUtil.toAppSetting();
                }
              })
            })
          Button("getCurrentLocationEasy()")
            .btnStyle()
            .onClick(() => {
              LocationUtil.getCurrentLocationEasy().then((location) => {
                this.addrStr = `当前位置1：\n${JSON.stringify(location, null, 2)}\n\n`;
                LocationUtil.getGeoAddressFromLocation(location.latitude, location.longitude, 2).then((address) => {
                  this.addrStr = this.addrStr + `当前位置2：\n${JSON.stringify(address, null, 2)}`;
                })
              }).catch((err: BusinessError) => {
                this.addrStr = `当前位置~异常信息：\n错误码： ${err.code}\n错误信息：${err.message}`;
              });
            })
          Button("getCurrentLocation()")
            .btnStyle()
            .onClick(() => {
              LocationUtil.getCurrentLocation().then((location) => {
                this.addrStr = `当前位置：\n${JSON.stringify(location, null, 2)}`;
              }).catch((err: BusinessError) => {
                this.addrStr = `当前位置~异常信息：\n错误码： ${err.code}\n错误信息：${err.message}`;
              });
            })
          Button("onLocationChangeEasy()")
            .btnStyle()
            .onClick(() => {
              let errCode = LocationUtil.onLocationChangeEasy(this.locationCallBack1);
              if (errCode != 0) {
                this.addrStr = `开启位置变化订阅-异常信息：\n${LocationUtil.getErrorMsg(errCode, "")}`;
              }
            })
          Button("onLocationChange()")
            .btnStyle()
            .onClick(() => {
              let locationRequest: geoLocationManager.LocationRequest = {
                'priority': geoLocationManager.LocationRequestPriority.FIRST_FIX, //表示快速获取位置优先，如果应用希望快速拿到一个位置，可以将优先级设置为该字段。
                'scenario': geoLocationManager.LocationRequestScenario.UNSET, //表示未设置优先级，表示LocationRequestPriority无效。
                'timeInterval': 10, //表示上报位置信息的时间间隔，单位是秒。默认值为1，取值范围为大于等于0。10秒钟获取一下位置
                'distanceInterval': 0, //表示上报位置信息的距离间隔。单位是米，默认值为0，取值范围为大于等于0。
                'maxAccuracy': 0 //表示精度信息，单位是米。
              }; //开启位置变化订阅，默认Request参数
              let errCode = LocationUtil.onLocationChange(locationRequest, this.locationCallBack2);
              if (errCode != 0) {
                this.addrStr = `开启位置变化订阅-异常信息：\n${LocationUtil.getErrorMsg(errCode, "")}`;
              }
            })
          Button("offLocationChange()")
            .btnStyle()
            .onClick(() => {
              // LocationUtil.offLocationChange(this.locationCallBack2);
              let errCode = LocationUtil.offLocationChange();
              if (errCode == 0) {
                ToastUtil.showToast("关闭位置变化订阅，成功");
              } else {
                this.addrStr = `关闭位置变化订阅~异常信息：\n${LocationUtil.getErrorMsg(errCode, "")}`;
              }
            })
          Button("isGeocoderAvailable")
            .btnStyle()
            .onClick(() => {
              let isGeocoderAvailable = LocationUtil.isGeocoderAvailable();
              LogUtil.error(`地理编码与逆地理编码服务是否可用：${isGeocoderAvailable}`);
              ToastUtil.showToast(`编码服务是否可用：${isGeocoderAvailable}`);
            })
          Button("getGeoAddressFromLocationName()")
            .btnStyle()
            .onClick(async () => {
              let locationName: string = '上海市浦东新区'; //上海市浦东新区
              let address = await LocationUtil.getGeoAddressFromLocationName(locationName, 10)
                .catch((err: BusinessError) => {
                  LogUtil.error("地理编码-异常信息1：\n" + JSON.stringify(err, null, 2));
                });
              this.addrStr = `地理编码：\n${JSON.stringify(address, null, 2)}`;
              LogUtil.error(JSON.stringify(address, null, 2));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("getAddressFromLocationName()")
            .btnStyle()
            .onClick(async () => {
              let locationName: string = '上海市浦东新区'; //上海市浦东新区
              let address = await LocationUtil.getAddressFromLocationName(locationName)
                .catch((err: BusinessError) => {
                  LogUtil.error("地理编码-异常信息2：\n" + JSON.stringify(err, null, 2));
                });
              this.addrStr = `地理编码：\n${JSON.stringify(address, null, 2)}`;
              LogUtil.error(JSON.stringify(address, null, 2));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("getGeoAddressFromLocation()")
            .btnStyle()
            .onClick(async () => {
              let latitude: number = 40;
              let longitude: number = 117;
              let address = await LocationUtil.getGeoAddressFromLocation(latitude, longitude)
                .catch((err: BusinessError) => {
                  LogUtil.error("逆地理编码-异常信息2：\n" + JSON.stringify(err, null, 2));
                });
              this.addrStr = `逆地理编码：\n${JSON.stringify(address, null, 2)}`;
              LogUtil.error(JSON.stringify(address, null, 2));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("getAddressFromLocation()")
            .btnStyle()
            .onClick(async () => {
              let latitude: number = 40;
              let longitude: number = 117;
              let address = await LocationUtil.getAddressFromLocation(latitude, longitude)
                .catch((err: BusinessError) => {
                  LogUtil.error("逆地理编码-异常信息2：\n" + JSON.stringify(err, null, 2));
                });
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
          Button("calculateDistance()")
            .btnStyle()
            .onClick(() => {
              let distance = LocationUtil.calculateDistance(38, 118, 39, 119);
              LogUtil.error(`距离：${distance}米`);
              ToastUtil.showToast(`距离：${distance}米`);
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
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}