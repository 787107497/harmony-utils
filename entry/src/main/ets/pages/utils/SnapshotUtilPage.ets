import { ComposeTitleBar, router } from '@kit.ArkUI';
import { LogUtil, SnapshotUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { image } from '@kit.ImageKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { MockSetup } from '@ohos/hamock';

/**
 * 组件截图和窗口截图工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State pixelMap1?: image.PixelMap = undefined;
  @State pixelMap2?: image.PixelMap = undefined;
  @State pixelMap3?: image.PixelMap = undefined;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("SnapshotUtil", "组件截图和窗口截图工具类");
  }


  @Builder
  RandomBuilder() {
    Column() {
      Text("Builder截图")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontStyle(FontStyle.Italic)
        .margin({ top: 20 })
      Image($r("app.media.test_as4"))
        .margin({ top: 30, bottom: 10 })
        .padding(10)
        .width('95%')
        .backgroundColor(Color.Pink)
    }
    .backgroundColor(Color.Blue)
    .padding(10)
    .width('100%')
    .aspectRatio(1)
    .margin({ top: 50 })
    .id("rBuilder")
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
          Button("get()")
            .btnStyle()
            .onClick(async () => {
              this.pixelMap1 = await SnapshotUtil.get('column_id')
            })
          Image(this.pixelMap1)
            .visibility(this.pixelMap1 ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("createFromBuilder()")
            .btnStyle()
            .onClick(() => {
              SnapshotUtil.createFromBuilder(() => {
                this.RandomBuilder()
              }).then((pixelMap) => {
                this.pixelMap2 = pixelMap;
              }).catch((err: BusinessError) => {
                LogUtil.error("createFromBuilder-异常信息：" + JSON.stringify(err))
              })
            })
          Image(this.pixelMap2)
            .visibility(this.pixelMap2 ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("snapshot()")
            .btnStyle()
            .onClick(async () => {
              this.pixelMap3 = await SnapshotUtil.snapshot()
            })
          Image(this.pixelMap3)
            .visibility(this.pixelMap3 ? Visibility.Visible : Visibility.None)
            .textStyle()

          Column() {
            Text("id组件截图")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontStyle(FontStyle.Italic)
              .margin({ top: 10 })
            Image($r("app.media.test_as3"))
              .margin({ top: 10, bottom: 10 })
          }
          .backgroundColor(Color.Pink)
          .padding(10)
          .width('90%')
          .margin({ top: 50 })
          .id('column_id')

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