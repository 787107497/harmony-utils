import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, NetworkUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { Utils } from '../../utils/Utils';
import { connection } from '@kit.NetworkKit';

/**
 * 对象工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  private autoCancel?: boolean=undefined;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("NetworkUtil", "网络相关工具类");
  }

  aboutToAppear(): void {
    LogUtil.error(`${this.autoCancel}`);
    let autoCancel = this.autoCancel ?? true
    LogUtil.error(`${autoCancel}`);
    let  autoCancel1 = this.autoCancel ?? false
    LogUtil.error(`${autoCancel1}`);

  }


  onBackPress(): boolean {
    return false;
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("isDefaultNetMeteredSync()")
            .btnStyle()
            .onClick(() => {
              let hasDefaultNet = NetworkUtil.isDefaultNetMeteredSync();
              ToastUtil.showToast(`当前网络上的数据流量使用是否被计量：${hasDefaultNet}`);
            })
          Button("hasDefaultNetSync()")
            .btnStyle()
            .onClick(() => {
              let hasDefaultNet = NetworkUtil.hasDefaultNetSync();
              ToastUtil.showToast(`默认数据网络是否被激活：${hasDefaultNet}`);
            })
          Button("getDefaultNet()")
            .btnStyle()
            .onClick(async () => {
              let defaultNet = await NetworkUtil.getDefaultNet();
              let jsonStr = JSON.stringify(defaultNet, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("getAppNet()")
            .btnStyle()
            .onClick(async () => {
              let appNet = await NetworkUtil.getAppNet();
              let jsonStr = JSON.stringify(appNet, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("getAllNets()")
            .btnStyle()
            .onClick(async () => {
              let allNet = await NetworkUtil.getAllNets();
              let jsonStr = JSON.stringify(allNet, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("isNetworkAvailable()")
            .btnStyle()
            .onClick(() => {
              let isNetwork = NetworkUtil.isNetworkAvailable();
              ToastUtil.showToast(`当前网络是否可用：${isNetwork}`);
            })
          Button("hasNetMobile()")
            .btnStyle()
            .onClick(() => {
              let hasNetMobile = NetworkUtil.hasNetMobile();
              ToastUtil.showToast(`当前网络是否是蜂窝网络：${hasNetMobile}`);
            })
          Button("hasNetWiFi()")
            .btnStyle()
            .onClick(() => {
              let hasNetWiFi = NetworkUtil.hasNetWiFi();
              ToastUtil.showToast(`当前网络是否是Wi-Fi网络：${hasNetWiFi}`);
            })
          Button("hasNetEthernet()")
            .btnStyle()
            .onClick(() => {
              let hasNetEthernet = NetworkUtil.hasNetEthernet();
              ToastUtil.showToast(`当前网络是否是以太网网络：${hasNetEthernet}`);
            })
          Button("hasNetVPN()")
            .btnStyle()
            .onClick(() => {
              let hasNetVPN = NetworkUtil.hasNetVPN();
              ToastUtil.showToast(`当前网络是否是VPN网络：${hasNetVPN}`);
            })
          Button("hasNetBearType()")
            .btnStyle()
            .onClick(() => {
              let hasNet = NetworkUtil.hasNetBearType(connection.NetBearType.BEARER_WIFI);
              ToastUtil.showToast(`是否存在指定的网络：${hasNet}`);
            })
          Button("getNetBearTypes()")
            .btnStyle()
            .onClick(() => {
              let netBearTypes = NetworkUtil.getNetBearTypes();
              let jsonStr = JSON.stringify(netBearTypes, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("getNetBearType()")
            .btnStyle()
            .onClick(async () => {
              let type = await NetworkUtil.getNetBearType();
              ToastUtil.showToast(`网络类型：${type}`)
            })
          Button("getNetCapabilitiesSync()")
            .btnStyle()
            .onClick(() => {
              let netCapabilities = NetworkUtil.getNetCapabilitiesSync();
              let jsonStr = JSON.stringify(netCapabilities, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("getConnectionPropertiesSync()")
            .btnStyle()
            .onClick(() => {
              let connectionProperties = NetworkUtil.getConnectionPropertiesSync();
              let jsonStr = JSON.stringify(connectionProperties, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("getIpAddress()")
            .btnStyle()
            .onClick(() => {
              let ip = NetworkUtil.getIpAddress();
              ToastUtil.showToast(ip)
            })
          Button("register()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("请查看Log日志")
              NetworkUtil.register((netHandle) => {
                LogUtil.error(`订阅网络可用事件回调：${JSON.stringify(netHandle)}`);
              }, () => {
                LogUtil.error(`订阅网络不可用事件回调。`);
              }, (netCapabilityInfo) => {
                LogUtil.error(`订阅网络能力变化事件回调：${JSON.stringify(netCapabilityInfo)}`);
              }, (nNetConnectionPropertyInfo) => {
                LogUtil.error(`订阅网络连接信息变化事件回调：${JSON.stringify(nNetConnectionPropertyInfo)}`);
              }, (netBlockStatusInfo) => {
                LogUtil.error(`订阅网络阻塞状态事件回调：${JSON.stringify(netBlockStatusInfo)}`);
              }, (netHandle) => {
                LogUtil.error(`订阅网络丢失事件回调：${JSON.stringify(netHandle)}`);
              })
            })
          Button("unregister()")
            .btnStyle()
            .onClick(() => {
              NetworkUtil.unregister()
              ToastUtil.showToast("取消订阅默认网络状态变化监听")
            })
          Divider().strokeWidth(1).color(Color.Grey).margin(12)
          Button("isNRSupported()")
            .btnStyle()
            .onClick(() => {
              let isNRSupported = NetworkUtil.isNRSupported();
              ToastUtil.showToast(`当前设备是否支持NR：${isNRSupported}`);
            })
          Button("isRadioOn()")
            .btnStyle()
            .onClick(async () => {
              let isRadioOn = await NetworkUtil.isRadioOn();
              ToastUtil.showToast(`Radio是否打开：${isRadioOn}`);
            })
          Button("getPrimarySlotId()")
            .btnStyle()
            .onClick(async () => {
              let slotId = await NetworkUtil.getPrimarySlotId();
              ToastUtil.showToast(`主卡所在卡槽的索引号：${slotId}`);
            })
          Button("getOperatorName()")
            .btnStyle()
            .onClick(async () => {
              let operatorName = await NetworkUtil.getOperatorName();
              ToastUtil.showToast(`运营商名称：${operatorName}`);
            })
          Button("getNetworkState()")
            .btnStyle()
            .onClick(async () => {
              let networkState = await NetworkUtil.getNetworkState();
              let jsonStr = JSON.stringify(networkState, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("getNetworkSelectionMode()")
            .btnStyle()
            .onClick(async () => {
              let mode = await NetworkUtil.getNetworkSelectionMode();
              let jsonStr = JSON.stringify(mode, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("getSignalInformation()")
            .btnStyle()
            .onClick(async () => {
              let signalInformation = await NetworkUtil.getSignalInformation();
              let jsonStr = JSON.stringify(signalInformation, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("getNetworkType()")
            .btnStyle()
            .onClick(async () => {
              let networkType = await NetworkUtil.getNetworkType();
              ToastUtil.showToast(`网络类型：${networkType}`);
            })
          Button("getNetworkTypeStr()")
            .btnStyle()
            .onClick(async () => {
              let networkType = await NetworkUtil.getNetworkTypeStr();
              ToastUtil.showToast(`网络类型：${networkType}`);
            })
          Divider().strokeWidth(3).color(Color.Gray).margin(12)
          Button("getDefaultCellularDataSlotId()")
            .btnStyle()
            .onClick(async () => {
              let slotId = await NetworkUtil.getDefaultCellularDataSlotId();
              ToastUtil.showToast(`默认移动数据的SIM卡：${slotId}`);
            })
          Button("getCellularDataFlowType()")
            .btnStyle()
            .onClick(async () => {
              let dataFlowType = await NetworkUtil.getCellularDataFlowType();
              let jsonStr = JSON.stringify(dataFlowType, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("getCellularDataState()")
            .btnStyle()
            .onClick(async () => {
              let state = await NetworkUtil.getCellularDataState();
              ToastUtil.showToast(`分组交换域(PS域)的连接状态：${state}`);
            })
          Button("isCellularDataEnabled()")
            .btnStyle()
            .onClick(async () => {
              let enabled = await NetworkUtil.isCellularDataEnabled();
              ToastUtil.showToast(`蜂窝数据业务是否启用：${enabled}`);
            })



          Divider().strokeWidth(3).color(Color.Gray).margin(12)

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