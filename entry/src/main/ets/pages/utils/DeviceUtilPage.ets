import { ComposeTitleBar, router } from '@kit.ArkUI';
import { DeviceUtil, LogUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { resourceManager } from '@kit.LocalizationKit';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * 设备相关工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State deviceIdStr: string = ''
  @State configurationStr: string = '';
  @State configurationStr2: string = '';
  @State capabilityStr: string = '';
  @State capabilityStr2: string = '';

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
          Button("getDeviceId()")
            .btnStyle()
            .onClick(async () => {
              let id = await DeviceUtil.getDeviceId();
              this.deviceIdStr = `当前设备号为：\n${id}`
            })
          Text(this.deviceIdStr)
            .visibility(StrUtil.isNotEmpty(this.deviceIdStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getConfiguration()")
            .btnStyle()
            .onClick(() => {
              DeviceUtil.getConfiguration().then((result) => {
                this.configurationStr = JSON.stringify(result, null, 2)
              })
            })
          Text(this.configurationStr)
            .visibility(StrUtil.isNotEmpty(this.configurationStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getConfigurationSync()")
            .btnStyle()
            .onClick(() => {
              let configuration = DeviceUtil.getConfigurationSync();
              this.configurationStr2 = JSON.stringify(configuration, null, 2)
            })
          Text(this.configurationStr2)
            .visibility(StrUtil.isNotEmpty(this.configurationStr2) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getDirection()")
            .btnStyle()
            .onClick(() => {
              let direction = DeviceUtil.getDirection();
              ToastUtil.showToast(`当前设备屏幕方向: ${direction === resourceManager.Direction.DIRECTION_VERTICAL ? "竖屏" : "横屏"}`)
            })
          Button("getDeviceCapability()")
            .btnStyle()
            .onClick(() => {
              DeviceUtil.getDeviceCapability().then((result) => {
                this.capabilityStr = JSON.stringify(result, null, 2);
              })
            })
          Text(this.capabilityStr)
            .visibility(StrUtil.isNotEmpty(this.capabilityStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getDeviceCapabilitySync()")
            .btnStyle()
            .onClick(() => {
              let deviceCapability = DeviceUtil.getDeviceCapabilitySync();
              this.capabilityStr2 = JSON.stringify(deviceCapability, null, 2)
            })
          Text(this.capabilityStr2)
            .visibility(StrUtil.isNotEmpty(this.capabilityStr2) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getDeviceType()")
            .btnStyle()
            .onClick(() => {
              let deviceType = DeviceUtil.getDeviceType()
              ToastUtil.showToast(`当前设备类型为：${deviceType}`)
            })
          Button("getDeviceTypeStr()")
            .btnStyle()
            .onClick(() => {
              let getDeviceTypeStr = DeviceUtil.getDeviceTypeStr()
              ToastUtil.showToast(`当前设备为：${getDeviceTypeStr}`)
            })
          Button("getScreenDensity()")
            .btnStyle()
            .onClick(() => {
              let density = DeviceUtil.getScreenDensity();
              ToastUtil.showToast(`前设备屏幕密度: ${density}`)
            })
          Button("startVibration()")
            .btnStyle()
            .onClick(() => {
              DeviceUtil.startVibration().then(() => {
                ToastUtil.showToast("开启设备振动")
              }).catch((error: BusinessError) => {
                LogUtil.error(`startVibration-异常 ~ code: ${error.code} -·- message: ${error.message}`);
              });
            })
          Button("stopVibration()")
            .btnStyle()
            .onClick(() => {
              DeviceUtil.stopVibration().then(() => {
                ToastUtil.showToast("停止设备振动")
              }).catch((error: BusinessError) => {
                LogUtil.error(`stopVibration-异常 ~ code: ${error.code} -·- message: ${error.message}`);
              });
            })

          Text('').layoutWeight(1)
        }
        .justifyContent(FlexAlign.Start)
        .margin({ top: 5, bottom: 5 })
        .layoutWeight(1)
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