import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { ArrayUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { JSON } from '@kit.ArkTS';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * 集合工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  private array0: string[] = []
  private array1: string[] = [" 张三 ", "马哒哒 ", "李四", " 阿尼玛", "", "王五", "李四", "王五五", ""]
  private array2: string[] = ["张三 ", "马哒哒 ", "李四", " 阿尼玛", "李四", "王五", "李四", "王五"]
  private array3: string[] = ["黑龙江省", "哈尔滨市", "道里区", "砂山", "砀山", "高薪区"]
  private array4: number[] = [1, 100, 10, 0, 22, 68, 11];
  private array5: string[][] = [this.array1, this.array2, this.array3];


  @MockSetup
  mock() {
    this.describe = new DescribeBean("ArrayUtil", "集合工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("isNotEmpty()\nisEmpty()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let b1 = ArrayUtil.isNotEmpty(this.array0);
              let b2 = ArrayUtil.isEmpty(this.array0);
              let b3 = ArrayUtil.isNotEmpty(this.array1);
              let b4 = ArrayUtil.isEmpty(this.array1);
              LogUtil.error(`b1: ${b1}\nb2: ${b2}\nb3: ${b3}\nb4: ${b4}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("removeEmpty()\ntrim()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let array: string[] = [" 张三 ", "null", "希大大 ", "李四", "undefined", " 阿超", '', "王五 ", ""];
              let arr1 = ArrayUtil.removeEmpty(array); //去空
              LogUtil.error("arr1: " + arr1.join(','));
              let arr2 = ArrayUtil.trim(arr1); //去空格
              LogUtil.error("arr2: " + arr2.join(','));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("distinct()")
            .btnStyle()
            .onClick(() => {
              let array = ArrayUtil.distinct(this.array2); //去重
              LogUtil.error('array: ' + array.join(','));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("reverse()")
            .btnStyle()
            .onClick(() => {
              let array = ArrayUtil.reverse(this.array4);
              LogUtil.error('array: ' + array.join(','));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("filter()")
            .btnStyle()
            .onClick(() => {
              let array1 = ArrayUtil.filter(this.array4, (item) => item > 10);
              LogUtil.error('array1: ' + array1.join(','))
              let array2 = ArrayUtil.filter(this.array3, (item) => item.length > 3);
              LogUtil.error('array2: ' + array2.join(','));
              ToastUtil.showToast("请查看Log日志")
            })
          Button("append()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let array1 = ArrayUtil.append(this.array2, this.array3);
              LogUtil.error('array1: ' + array1.join(','));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("min()\nmax()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let min = ArrayUtil.min(this.array4);
              let max = ArrayUtil.max(this.array4);
              LogUtil.error(`min: ${min}\nmax: ${max}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("flatten()")
            .btnStyle()
            .onClick(() => {
              let array = ArrayUtil.flatten(this.array5);
              LogUtil.error('array: ' + array.join(','));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("union()")
            .btnStyle()
            .onClick(() => {
              let array = ArrayUtil.union(this.array5);
              LogUtil.error('array: ' + array.join(','));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("chunk()")
            .btnStyle()
            .onClick(() => {
              let array = ArrayUtil.chunk(this.array2, 2);
              LogUtil.error(JSON.stringify(array, null, 2));
              ToastUtil.showToast("请查看Log日志")
            })
          Button("contain()")
            .btnStyle()
            .onClick(() => {
              let array = ArrayUtil.contain(this.array1, "王五");
              LogUtil.error(JSON.stringify(array, null, 2));
              ToastUtil.showToast("请查看Log日志");
            })
          Button("remove()")
            .btnStyle()
            .onClick(() => {
              ArrayUtil.remove(this.array1, "王五");
              LogUtil.error(JSON.stringify(this.array1, null, 2));
              ToastUtil.showToast("请查看Log日志");
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