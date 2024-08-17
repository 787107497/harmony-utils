import { ComposeTitleBar, router } from '@kit.ArkUI';
import { DescribeBean } from '../entity/DescribeBean';
import { MockSetup } from '../../../../oh_modules/@ohos/hamock';

import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { buffer } from '@kit.ArkTS';
import { AES, CryptoHelper, CryptoUtil, LogUtil, SHA, StrUtil } from '@pura/harmony-utils';
import { abilityAccessCtrl, common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';


/**
 * 测试页面
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("Test", "测试页面");
  }

  aboutToAppear(): void {

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
          Button("测试1")
            .btnStyle()
            .onClick(() => {
              let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
              let context: Context = getContext(this) as common.UIAbilityContext;


              // atManager.requestPermissionOnSetting(context, ['ohos.permission.CAMERA']).then((data: Array<abilityAccessCtrl.GrantStatus>) => {
              //   console.info('data:' + JSON.stringify(data));
              // }).catch((err: BusinessError) => {
              //   console.error('data:' + JSON.stringify(err));
              // });

            })
          Button("测试2")
            .btnStyle()
            .onClick(() => {


            })
          Button("测试3")
            .btnStyle()
            .onClick(() => {


            })
          Text().layoutWeight(1)
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