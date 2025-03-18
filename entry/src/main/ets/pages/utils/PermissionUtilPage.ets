import { router } from '@kit.ArkUI';
import { PermissionUtil, ToastUtil, WantUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { Permissions } from '@kit.AbilityKit';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * 申请授权工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("PermissionUtil", "申请授权工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("checkPermissions()")
            .btnStyle()
            .onClick(() => {
              let p: Permissions = 'ohos.permission.CAMERA'; //相机
              PermissionUtil.checkPermissions(p).then((result) => {
                ToastUtil.showToast(`检测是否授权，结果：${result}`);
              })
            })
          Button("checkRequestPermissions()")
            .btnStyle()
            .onClick(() => {
              let p: Permissions = 'ohos.permission.CAMERA'; //相机
              PermissionUtil.checkRequestPermissions(p).then((grant) => {
                ToastUtil.showToast(`检测并申请授权，结果：${grant}`);
                if (!grant) {
                  WantUtil.toAppSetting(); //拒绝权限，跳转APP设置页面
                }
              })
            })
          Button("requestPermissions()\nrequestPermissionOnSettingEasy()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let p: Permissions[] = ['ohos.permission.ACTIVITY_MOTION', 'ohos.permission.CAMERA','ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION'];
              PermissionUtil.requestPermissions(p).then((grant) => {
                if (grant) {
                  ToastUtil.showToast(`申请授权，已通过...`);
                } else { //拒绝权限，二次向用户申请授权
                  PermissionUtil.requestPermissionOnSettingEasy(p).then((result) => {
                    ToastUtil.showToast(`申请授权，结果：${result}`);
                  });
                }
              })
            })
          Button("requestPermissionsEasy()")
            .btnStyle()
            .onClick(() => {
              let p: Permissions[] = ['ohos.permission.ACTIVITY_MOTION', 'ohos.permission.CAMERA', 'ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION'];
              PermissionUtil.requestPermissionsEasy(p).then((result) => {
                ToastUtil.showToast(`申请授权，结果：${result}`);
              })
            })
          Button("最佳使用案例")
            .btnStyle()
            .onClick(() => {
              let ps: Permissions[] = ['ohos.permission.READ_IMAGEVIDEO', 'ohos.permission.WRITE_IMAGEVIDEO'];
              PermissionUtil.requestPermissions(ps).then((result) => {
                if (result) {
                  ToastUtil.showToast(`最佳使用案例授权，已通过...`);
                } else {
                  PermissionUtil.requestPermissionOnSetting(ps).then((grant) => {
                    ToastUtil.showToast(`最佳使用案例，结果：${grant}`);
                  })
                }
              })
            })
          Button("测试")
            .btnStyle()
            .onClick(() => {
              let ps: Permissions[] = ['ohos.permission.CAMERA', 'ohos.permission.READ_IMAGEVIDEO', 'ohos.permission.WRITE_IMAGEVIDEO'];
              PermissionUtil.requestPermissionsEasy(ps).then((grant)=>{
                ToastUtil.showToast(`申请授权，结果：${grant}`);
              })
            })

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
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}