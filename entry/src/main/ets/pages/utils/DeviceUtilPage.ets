import { router } from '@kit.ArkUI';
import { DeviceUtil, LogUtil, PermissionUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { resourceManager } from '@kit.LocalizationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';
import { DialogHelper } from '@pura/harmony-dialog';
import { Utils } from '../../utils/Utils';

/**
 * 设备相关工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;


  @MockSetup
  mock() {
    this.describe = new DescribeBean("DeviceUtil", "设备相关工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("getDeviceId()")
            .btnStyle()
            .onClick(() => {
              let id = DeviceUtil.getDeviceId();
              DialogHelper.showToast(`当前设备号为：${id}`);
            })
          Button("deleteDeviceId()")
            .btnStyle()
            .onClick(async () => {
              DeviceUtil.deleteDeviceId();
              ToastUtil.showToast("移除设备ID成功！")
            })
          Button("getODID()")
            .btnStyle()
            .onClick(() => {
              let ODID = DeviceUtil.getODID();
              DialogHelper.showToast(`开发者匿名设备标识符为：${ODID}`);
            })
          Button("getOAID()")
            .btnStyle()
            .onClick(async () => {
              PermissionUtil.requestPermissionsEasy("ohos.permission.APP_TRACKING_CONSENT").then(async (grant) => {
                if (grant) {
                  DeviceUtil.getOAID().then((id) => {
                    ToastUtil.showToast("开放匿名设备标识符位：" + id);
                  }).catch((err: BusinessError) => {
                    ToastUtil.showToast(`开放匿名设备标识符获取失败，${err.message}！`);
                  });
                } else {
                  ToastUtil.showToast("您拒绝了权限！")
                }
              });
            })
          Button("getAAID()")
            .btnStyle()
            .onClick(async () => {
              let AAID = await DeviceUtil.getAAID();
              DialogHelper.showToast(`AAID为：${AAID}`);
            })
          Button("deleteAAID()")
            .btnStyle()
            .onClick(async () => {
              await DeviceUtil.deleteAAID();
              DialogHelper.showToast(`AAID删除成功！`);
            })

          Button("getBrand()\ngetProductModel()\ngetBrandModel()\ngetMarketName()\ngetHardwareModel()\ngetManufacture()")
            .labelStyle({ maxLines: 8 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str: string = '';
              str = str + `设备品牌名称:  ${DeviceUtil.getBrand()}`;
              str = str + `\n认证型号:  ${DeviceUtil.getProductModel()}`;
              str = str + `\n设备品牌型号:  ${DeviceUtil.getBrandModel()}`;
              str = str + `\n外部产品系列名称:  ${DeviceUtil.getMarketName()}`;
              str = str + `\n硬件版本号:  ${DeviceUtil.getHardwareModel()}`;
              str = str + `\n设备厂家名称:  ${DeviceUtil.getManufacture()}`;
              Utils.showSheetText(str);
            })
          Button("getOsFullName()\ngetDisplayVersion()\ngetBuildVersion()\ngetSdkApiVersion()\ngetOsVersion()")
            .labelStyle({ maxLines: 8 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str: string = '';
              str = str + `系统版本:  ${DeviceUtil.getOsFullName()}`;
              str = str + `\n产品版本:  ${DeviceUtil.getDisplayVersion()}`;
              str = str + `\nBuild版本号:  ${DeviceUtil.getBuildVersion()}`;
              str = str + `\n系统软件API版本:  ${DeviceUtil.getSdkApiVersion()}`;
              str = str + `\nOS版本号:  ${DeviceUtil.getOsVersion()}`;
              Utils.showSheetText(str);
            })
          Button("getAbiList()\ngetOsReleaseType()\ngetDeviceType()\ngetDeviceTypeStr()")
            .labelStyle({ maxLines: 8 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str: string = '';
              str = str + `处理器类型（ABI）:  ${DeviceUtil.getAbiList()}`;
              str = str + `\n系统的发布类型:  ${DeviceUtil.getOsReleaseType()}`;
              str = str + `\n当前设备类型:  ${DeviceUtil.getDeviceType()}`;
              str = str + `\n当前设备类型:  ${DeviceUtil.getDeviceTypeStr()}`;
              Utils.showSheetText(str);
            })
          Button("getConfiguration()")
            .btnStyle()
            .onClick(() => {
              DeviceUtil.getConfiguration().then((result) => {
                Utils.showSheetText(JSON.stringify(result, null, 2));
              });
            })
          Button("getConfigurationSync()")
            .btnStyle()
            .onClick(() => {
              let configuration = DeviceUtil.getConfigurationSync();
              let jsonStr = JSON.stringify(configuration, null, 2);
              Utils.showSheetText(jsonStr);
            })
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
                let jsonStr = JSON.stringify(result, null, 2);
                Utils.showSheetText(jsonStr);
              });
            })
          Button("getDeviceCapabilitySync()")
            .btnStyle()
            .onClick(() => {
              let deviceCapability = DeviceUtil.getDeviceCapabilitySync();
              let jsonStr = JSON.stringify(deviceCapability, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("getScreenDensity()")
            .btnStyle()
            .onClick(() => {
              let density = DeviceUtil.getScreenDensity();
              ToastUtil.showToast(`前设备屏幕密度: ${density}`)
            })
          Button("getBatterySOC()\ngetBatteryCapacityLevel()\ngetHealthStatus()\ngetBatteryTemperature()\ngetVoltage()\ngetNowCurrent()")
            .labelStyle({ maxLines: 8 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str: string = '';
              str = str + `当前设备剩余电池电量百分比:  ${DeviceUtil.getBatterySOC()}`;
              str = str + `\n当前设备电池电量的等级:  ${DeviceUtil.getBatteryCapacityLevel()}`;
              str = str + `\n当前设备电池的健康状态:  ${DeviceUtil.getHealthStatus()}`;
              str = str + `\n当前设备电池的温度:  ${DeviceUtil.getBatteryTemperature()}`;
              str = str + `\n当前设备电池的电压:  ${DeviceUtil.getVoltage()}`;
              str = str + `\n当前设备电池的电流:  ${DeviceUtil.getNowCurrent()}`;
              Utils.showSheetText(str);
            })
          Button("isActive()\nisStandby()\ngetPowerMode()")
            .labelStyle({ maxLines: 8 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str: string = '';
              str = str + `当前设备是否处于活动状态:  ${DeviceUtil.isActive()}`;
              str = str + `\n当前设备是否进入待机低功耗续航模式:  ${DeviceUtil.isStandby()}`;
              str = str + `\n当前设备的电源模式:  ${DeviceUtil.getPowerMode()}`;
              Utils.showSheetText(str);
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

          Blank().layoutWeight(1)
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