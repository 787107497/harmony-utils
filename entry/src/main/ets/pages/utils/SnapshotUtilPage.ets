import { router } from '@kit.ArkUI';
import { LogUtil, SnapshotUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';
import { Utils } from '../../utils/Utils';

/**
 * 组件截图和窗口截图工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  private snapshotCallBack: VoidCallback = () => { //系统截图监听回调
    ToastUtil.showToast("您已成功截图！");
    LogUtil.error("您已成功截图！");
  }

  @MockSetup
  mock() {
    this.describe = new DescribeBean("SnapshotUtil", "组件截图和窗口截图工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("get()")
            .btnStyle()
            .onClick(async () => {
              let pixelMap1 = await SnapshotUtil.get('snapshot_id1');
              Utils.showSheetImg(pixelMap1);
            })
          Button("getSync()")
            .btnStyle()
            .onClick(() => {
              let pixelMap1 = SnapshotUtil.getSync('snapshot_id2');
              Utils.showSheetImg(pixelMap1);
            })
          Button("createFromBuilder()")
            .btnStyle()
            .onClick(() => {
              SnapshotUtil.createFromBuilder(() => {
                this.RandomBuilder()
              }).then((pixelMap) => {
                Utils.showSheetImg(pixelMap);
              }).catch((err: BusinessError) => {
                LogUtil.error("createFromBuilder-异常信息：\n" + JSON.stringify(err));
                ToastUtil.showToast("组件生成图片异常！");
              });
            })
          Button("snapshot()")
            .btnStyle()
            .onClick(async () => {
              let pixelMap3 = await SnapshotUtil.snapshot();
              Utils.showSheetImg(pixelMap3);
            })
          Button("onSnapshotListener()")
            .btnStyle()
            .onClick(() => {
              SnapshotUtil.onSnapshotListener(() => {
                ToastUtil.showToast("系统截图了！");
                LogUtil.error("系统截图了！");
              });
            })
          Button("removeSnapshotListener()")
            .btnStyle()
            .onClick(() => {
              SnapshotUtil.removeSnapshotListener();
            })
          
          Button("onSnapshotListener()-指定")
            .btnStyle()
            .onClick(() => {
              SnapshotUtil.onSnapshotListener(this.snapshotCallBack);
            })
          Button("removeSnapshotListener()-指定")
            .btnStyle()
            .onClick(() => {
              SnapshotUtil.removeSnapshotListener(this.snapshotCallBack);
            })

          Column() {
            Text("id组件截图1")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontStyle(FontStyle.Italic)
              .margin({ top: 10 })
            Column() {
              Text("id组件截图2")
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontStyle(FontStyle.Italic)
                .margin({ top: 10 })
              Image($r("app.media.test_as3"))
                .margin({ top: 10, bottom: 10 })
                .borderRadius(6)
            }
            .backgroundColor(Color.Pink)
            .borderRadius(10)
            .padding(10)
            .margin({ top: 10 })
            .width('95%')
            .id('snapshot_id2')
          }
          .backgroundColor(Color.Brown)
          .border({
            width: 5,
            radius: 5,
            color: Color.Orange,
            style: BorderStyle.Dashed
          })
          .padding(10)
          .width('90%')
          .margin({ top: 50 })
          .id('snapshot_id1')

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

}


@Styles
function btnStyle() {
  .width('90%')
  .margin({ top: 10, bottom: 5 })
}