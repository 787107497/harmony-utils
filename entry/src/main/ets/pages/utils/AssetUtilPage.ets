import { ComposeTitleBar, router } from '@kit.ArkUI';
import { DescribeBean } from '../../entity/DescribeBean';
import { MockSetup } from '@ohos/hamock';
import { AssetUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';

/**
 * 关键资产存储服务工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State readonly rkey: string = "key_harmony"
  @State readonly skey: string = "key_harmony_sync"

  @MockSetup
  mock() {
    this.describe = new DescribeBean("AssetUtil", "关键资产存储服务工具类");
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
          Button("add")
            .btnStyle()
            .onClick(() => {
              AssetUtil.add(this.rkey, "我是异步知产X!")
            })
          Button("get")
            .btnStyle()
            .onClick(async () => {
              let rStr = await AssetUtil.get(this.rkey)
              ToastUtil.showToast(`取值: ${rStr}`)
              LogUtil.error(`取值: ${rStr}`)
            })
          Button("addSync")
            .btnStyle()
            .onClick(() => {
              AssetUtil.addSync(this.skey, "我是同步知产X!")
            })
          Button("getSync")
            .btnStyle()
            .onClick(() => {
              let sStr = AssetUtil.getSync(this.skey)
              ToastUtil.showToast(`同步：${sStr}`)
            })
          Button("remove")
            .btnStyle()
            .onClick(() => {
              AssetUtil.remove(this.rkey).then(() => {
                ToastUtil.showToast("移除成功！")
              })
            })
          Button("removeSync")
            .btnStyle()
            .onClick(() => {
              AssetUtil.removeSync(this.skey)
              ToastUtil.showToast("移除成功!!!")
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