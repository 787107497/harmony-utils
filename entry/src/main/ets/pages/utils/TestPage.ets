import { ComposeTitleBar, router } from '@kit.ArkUI';
import { DescribeBean } from '../../entity/DescribeBean';
import { MockSetup } from '@ohos/hamock';
import { AssetUtil, LogUtil, PreferencesUtil, ToastUtil } from '@pura/harmony-utils';
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
            .onClick(async () => {
              let name =await AssetUtil.get("name")
              LogUtil.error("name: " + name)
            })
          Button("测试2")
            .btnStyle()
            .onClick(() => {
              AssetUtil.getSync("name")

            })
          Button("测试3")
            .btnStyle()
            .onClick(() => {
              new Promise<string>((resolve, reject) => {
                ToastUtil.showToast("111111111111111111")
              }).catch((err:BusinessError)=>{
                LogUtil.error("异常信息: "+err)
                LogUtil.error("异常信息: "+JSON.stringify(err))
              })

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