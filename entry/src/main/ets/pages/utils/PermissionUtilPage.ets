import { ComposeTitleBar, router } from '@kit.ArkUI';
import { ClickUtil, PermissionUtil, ToastUtil } from 'harmony_utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { Permissions } from '@kit.AbilityKit';

/**
 * 申请授权工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  aboutToAppear(): void {

  }

  onPageHide(): void {

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
          Button("checkPermissions()")
            .btnStyle()
            .onClick(() => {
              let p: Permissions = 'ohos.permission.APP_TRACKING_CONSENT'; //设备标识权限
              PermissionUtil.checkPermissions(p).then((result) => {
                ToastUtil.showToast(`检测是否授权，读取设备标识符：${result}`)
              })
            })
          Button("requestPermissions()")
            .btnStyle()
            .onClick(() => {
              let p: Permissions = 'ohos.permission.APP_TRACKING_CONSENT'; //设备标识权限
              PermissionUtil.requestPermissions(p).then((result) => {
                ToastUtil.showToast(`申请授权，读取设备标识符：${result}`)
              })
            })
          Button("checkRequestPermissions()")
            .btnStyle()
            .onClick(() => {
              let p: Permissions = 'ohos.permission.ACTIVITY_MOTION'; //应用读取用户的运动状态
              PermissionUtil.checkRequestPermissions(p).then((result) => {
                ToastUtil.showToast(`检测并申请授权，用户的运动状态：${result}`)
              })
            })
          Button("requestPermissionsList()")
            .btnStyle()
            .onClick(() => {
              let ps: Permissions[] = ['ohos.permission.CAMERA', 'ohos.permission.READ_MEDIA', 'ohos.permission.WRITE_MEDIA'];
              PermissionUtil.requestPermissionsList(ps).then((result) => {
                ToastUtil.showToast(`申请组合授权：${result}`)
              })
            })
          Button("toAppSetting()")
            .btnStyle()
            .onClick(() => {
              PermissionUtil.toAppSetting();
              ClickUtil.debounce(() => {
                ToastUtil.showToast("请在设置中开启权限！")
              }, 2000)
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
  .backgroundColor(Color.White)
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}