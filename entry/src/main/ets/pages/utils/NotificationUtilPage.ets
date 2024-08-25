import { ComposeTitleBar, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import {
    AppUtil, ImageUtil,
    NotificationBasicOptions, NotificationMultiLineOptions,
    NotificationUtil, StrUtil, ToastUtil
} from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 通知工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State notificationIds: Array<number> = [];
  @State notificationStr: string = ''

  @MockSetup
  mock() {
    this.describe = new DescribeBean("NotificationUtil", "通知工具类");
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
          Button("设置通知的默认统一配置")
            .btnStyle()
            .onClick(async () => {
              let wantAgent = await NotificationUtil.getDefaultWantAgent();
              let smallIcon = await ImageUtil.getPixelMapFromMedia($r('app.media.ic_launcher_round'));
              let largeIcon = await ImageUtil.getPixelMapFromMedia($r('app.media.ic_launcher'));
              let lPicture = await ImageUtil.getPixelMapFromMedia($r('app.media.as1'));

              NotificationUtil.setDefaultConfig((config) => {
                config.wantAgent = wantAgent
                config.removalWantAgent = wantAgent
                config.smallIcon = smallIcon
                config.largeIcon = largeIcon
                config.isFloatingIcon = true
                config.tapDismissed = true
                config.additionalText = "默认的统一配置"
                config.lockscreenPicture = lPicture
              })
            })
          Button("isNotificationEnabled")
            .btnStyle()
            .onClick(async () => {
              let isEnabled = await NotificationUtil.isNotificationEnabled();
              ToastUtil.showToast(`查询通知是否授权: ${isEnabled}`);
            })
          Button("authorizeNotification()")
            .btnStyle()
            .onClick(() => {
              NotificationUtil.authorizeNotification((grant) => {
                ToastUtil.showToast(`授权通知服务: ${grant ? '成功' : '失败'}`);
                if (!grant) {
                  AppUtil.toNotificationSetting(); //跳转通知设置页面
                }
              })
            })
          Button("publishBasic()")
            .btnStyle()
            .onClick(() => {
              let id = NotificationUtil.generateNotificationId(); //通知id
              let basicOptions: NotificationBasicOptions = {
                id: id,
                title: "鸿蒙工具包",
                text: "HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用",
                callBack: (id) => {
                  ToastUtil.showToast(`通知发送成功，id为：${id}`)
                  this.notificationIds.push(id)
                }
              }
              NotificationUtil.publishBasic(basicOptions);
            })
          Button("publishLongText()")
            .btnStyle()
            .onClick(() => {
              let id = NotificationUtil.generateNotificationId(); //通知id
              NotificationUtil.publishLongText({
                id: id,
                title: "鸿蒙工具包",
                text: "HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用",
                longText: "harmony-utils 一款高效的OpenHarmony/HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助初学者了解API，帮助开发者快速构建鸿蒙应用",
                briefText: "111111111111111111111111111111111111111111",
                expandedTitle: "OpenHarmony/HarmonyOS工具包",
              })
            })
          Button("publishMultiLine()")
            .btnStyle()
            .onClick(() => {
              let multiLineOptions: NotificationMultiLineOptions = {
                title: "鸿蒙工具包",
                text: "HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用",
                briefText: "222222222222222222222222222222222",
                longTitle: "HarmonyOS工具包",
                lines: ["帮助初学者了解API", "封装了常用工具类", "提供一系列简单易用的方法",
                  "帮助开发者快速构建鸿蒙应用"]
              }
              NotificationUtil.publishMultiLine(multiLineOptions);
            })
          Button("publishPicture()")
            .btnStyle()
            .onClick(async () => {
              let pixelMap = await ImageUtil.getPixelMapFromMedia($r('app.media.as1'))
              NotificationUtil.publishPicture({
                title: "鸿蒙工具包",
                text: "HarmonyOS工具包，封装了常用工具类。帮助开发者快速构建鸿蒙应用",
                briefText: "33333333333333333333333333333333",
                expandedTitle: "OpenHarmony/HarmonyOS工具包",
                picture: pixelMap
              })
            })
          Button("isSupportTemplate()")
            .btnStyle()
            .onClick(async () => {
              let blTemplate = await NotificationUtil.isSupportTemplate();
              ToastUtil.showToast(`查询模板是否存在: ${blTemplate}`);
            })
          Button("publishTemplate()")
            .btnStyle()
            .onClick(() => {
              NotificationUtil.publishTemplate({
                title: "鸿蒙工具包",
                text: "HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用",
                fileName: "漂亮小姐姐.mp4",
                progressValue: 72,
                callBack: (id) => {
                  ToastUtil.showToast(`通知发送成功，id为：${id}`)
                  this.notificationIds.push(id)
                }
              })
            })
          Button("cancelAll()")
            .btnStyle()
            .onClick(() => {
              NotificationUtil.cancelAll();
            })
          Button("setBadge()")
            .btnStyle()
            .onClick(() => {
              NotificationUtil.setBadge(96)
            })
          Button("clearBadge()")
            .btnStyle()
            .onClick(() => {
              NotificationUtil.clearBadge()
            })
          Button("getActiveNotificationCount()")
            .btnStyle()
            .onClick(async () => {
              let count = await NotificationUtil.getActiveNotificationCount();
              ToastUtil.showToast(`当前通知数量为：${count}`)
            })
          Button("setBadgeFromNotificationCount()")
            .btnStyle()
            .onClick(() => {
              NotificationUtil.setBadgeFromNotificationCount()
            })
          Button("getActiveNotifications()")
            .btnStyle()
            .onClick(async () => {
              let notifications = await NotificationUtil.getActiveNotifications();
              this.notificationStr = JSON.stringify(notifications, null, 2);
            })
          Text(this.notificationStr)
            .visibility(StrUtil.isNotEmpty(this.notificationStr) ? Visibility.Visible : Visibility.None)
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
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}