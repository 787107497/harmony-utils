import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { CacheUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';

/**
 * "缓存工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("CacheUtil", "缓存工具类");
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
              CacheUtil.put("pwd", "ABCD@12345");
              ToastUtil.showToast("缓存密码成功");
            })
          Button("get()")
            .btnStyle()
            .onClick(() => {
              let pwd = CacheUtil.get<string>("pwd");
              ToastUtil.showToast(`取值：${pwd}`);
            })
          Button("has()")
            .btnStyle()
            .onClick(() => {
              let pwd = CacheUtil.has("pwd");
              ToastUtil.showToast(`缓存是否存在：${pwd}`);
            })
          Button("remove()")
            .btnStyle()
            .onClick(() => {
              CacheUtil.remove("pwd");
              ToastUtil.showToast(`缓存移除成功！`);
            })
          Button("isEmpty()")
            .btnStyle()
            .onClick(() => {
              let blEmpty = CacheUtil.isEmpty();
              ToastUtil.showToast(`缓存是否为空：${blEmpty}`);
            })
          Button("clear()")
            .btnStyle()
            .onClick(() => {
              CacheUtil.clear();
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