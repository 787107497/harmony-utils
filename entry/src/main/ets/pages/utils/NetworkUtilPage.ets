import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, NetworkUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';

/**
 * 对象工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("NetworkUtil", "网络相关工具类");
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
          Button("hasDefaultNet()")
            .btnStyle()
            .onClick(async () => {
              let hasDefaultNet = await NetworkUtil.hasDefaultNet();
              ToastUtil.showToast(`手机是否有网：${hasDefaultNet}`)
            })
          Button("hasDefaultNetSync()")
            .btnStyle()
            .onClick(() => {
              let hasDefaultNet = NetworkUtil.hasDefaultNetSync();
              ToastUtil.showToast(`手机是否有网：${hasDefaultNet}`)
            })
          Button("hasNetWiFi()")
            .btnStyle()
            .onClick(async () => {
              let hasNetWiFi = await NetworkUtil.hasNetWiFi();
              ToastUtil.showToast(`手机是否是Wi-Fi：${hasNetWiFi}`)
            })
          Button("getNetBearType()")
            .btnStyle()
            .onClick(async () => {
              let type = await NetworkUtil.getNetBearType();
              ToastUtil.showToast(`网络类型：${type}`)
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
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}