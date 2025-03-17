import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LRUCacheUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';

/**
 * "LRUCache缓存工具类 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  private lruCache: LRUCacheUtil = LRUCacheUtil.getInstance();

  @MockSetup
  mock() {
    this.describe = new DescribeBean("LRUCacheUtil", "LRUCache缓存工具类");
  }


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("put()")
            .btnStyle()
            .onClick(() => {
              this.lruCache.put("pwd", "abcd@12345");
              ToastUtil.showToast("缓存密码成功");
            })
          Button("get()")
            .btnStyle()
            .onClick(() => {
              let pwd = this.lruCache.get<string>("pwd");
              ToastUtil.showToast(`取值：${pwd}`);
            })
          Button("has()")
            .btnStyle()
            .onClick(() => {
              let pwd = this.lruCache.has("pwd");
              ToastUtil.showToast(`缓存是否存在：${pwd}`);
            })
          Button("isEmpty()")
            .btnStyle()
            .onClick(() => {
              let blEmpty = this.lruCache.isEmpty();
              ToastUtil.showToast(`缓存是否为空：${blEmpty}`);
            })
          Button("getCapacity()")
            .btnStyle()
            .onClick(() => {
              let count = this.lruCache.getCapacity();
              ToastUtil.showToast(`当前缓冲区的容量：${count}`);
            })
          Button("updateCapacity()")
            .btnStyle()
            .onClick(() => {
              this.lruCache.updateCapacity(128);
              ToastUtil.showToast(`重新设置lruCache的容量成功`);
            })
          Button("clear()")
            .btnStyle()
            .onClick(() => {
              this.lruCache.clear();
              ToastUtil.showToast(`清除缓存数据成功`);
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
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}