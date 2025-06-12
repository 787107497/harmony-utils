import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, NumberUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { Utils } from '../../utils/Utils';

/**
 * number工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("NumberUtil", "number工具类");
  }


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("isNaN()\nisFinite()\nisInteger()\nisSafeInteger()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let isNaN1 = NumberUtil.isNaN(112);
              let isNaN2 = NumberUtil.isNaN(Number.NaN);
              let isFinite1 = NumberUtil.isFinite(112);
              let isFinite2 = NumberUtil.isFinite(Number.MAX_VALUE);
              let isInteger1 = NumberUtil.isInteger(112);
              let isInteger2 = NumberUtil.isInteger(11.2);
              let isSafeInteger1 = NumberUtil.isSafeInteger(-112);
              let isSafeInteger2 = NumberUtil.isSafeInteger(112);
              let txtStr = `isNaN1：${isNaN1}\t\tisNaN2：${isNaN2}\n\nisFinite1：${isFinite1}\t\tisFinite2：${isFinite2}\n\nisInteger1：${isInteger1}\t\tisInteger2：${isInteger2}\n\nisSafeInteger1：${isSafeInteger1}\t\tisSafeInteger2：${isSafeInteger2}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("isNumber()")
            .btnStyle()
            .onClick(() => {
              let bl1 = NumberUtil.isNumber(12345);
              let bl2 = NumberUtil.isNumber("12345");
              let bl3 = NumberUtil.isNumber(1.212345);
              let bl4 = NumberUtil.isNumber(true);
              let bl5 = NumberUtil.isNumber(null);
              let bl6 = NumberUtil.isNumber(undefined);
              let str = `bl1: ${bl1}\nbl2: ${bl2}\nbl3: ${bl3}\n\nbl4: ${bl4}\nbl5: ${bl5}\nbl6: ${bl6}`;
              LogUtil.error(str);
              Utils.showSheetText(str);
            })
          Button("isEven()\nisOdd()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let isEven = NumberUtil.isEven(112);
              let isOdd = NumberUtil.isOdd(112);
              let txtStr = `isEven：${isEven}\n\nisOdd：${isOdd}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("toNumber()")
            .btnStyle()
            .onClick(() => {
              let n1 = NumberUtil.toNumber("0.12579AB");
              let n2 = NumberUtil.toNumber("123456");
              let n3 = NumberUtil.toNumber("128.15624");
              let n4 = NumberUtil.toNumber("哈哈");
              let txtStr = `n1: ${n1}\nn2: ${n2}\nn3: ${n3}\nn4: ${n4}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("toInt()")
            .btnStyle()
            .onClick(() => {
              let n1 = NumberUtil.toInt("0.12579");
              let n2 = NumberUtil.toInt("12345");
              let n3 = NumberUtil.toInt("128.15624");
              let n4 = NumberUtil.toInt("哈哈");
              let txtStr = `n1: ${n1}\nn2: ${n2}\nn3: ${n3}\nn4: ${n4}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("toFloat()")
            .btnStyle()
            .onClick(() => {
              let f1 = NumberUtil.toFloat("0.12579");
              let f2 = NumberUtil.toFloat("12345");
              let f3 = NumberUtil.toFloat("128.15624");
              let f4 = NumberUtil.toFloat("呵呵");
              let txtStr = `f1: ${f1}\nf2: ${f2}\nf3: ${f3}\nf4: ${f4}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("average()")
            .btnStyle()
            .onClick(() => {
              let average1 = NumberUtil.average(1, 2, 3, 4, 5, 6, 7, 8, 9);
              let average2 = NumberUtil.average(...[1, 3, 5, 7, 9, 11, 13, 15, 17, 19]);
              let txtStr = `average1: ${average1}\n\naverage2: ${average2}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("add()\nsub()\nsum()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let add = NumberUtil.add(112, 200);
              let sub = NumberUtil.sub(200, 112);
              let sum = NumberUtil.sum(10, 12, 16, 18, 36, 22);
              let txtStr = `add：${add}\n\nsub：${sub}\n\nsum：${sum}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("toDecimal()")
            .btnStyle()
            .onClick(() => {
              let n1 = NumberUtil.toDecimal(112).toNumber();
              let n2 = NumberUtil.toDecimal("200").toNumber();
              let n3 = NumberUtil.toDecimal("0200").toNumber();
              let n4 = NumberUtil.toDecimal("0.20").toNumber();
              let n5 = NumberUtil.toDecimal(0.2222).toNumber();
              let txtStr = `n1：${n1}\n\nn2：${n2}\n\nn3：${n3}\n\nn4：${n4}\n\nn5：${n5}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("addDecimal()")
            .btnStyle()
            .onClick(() => {
              let n1 = NumberUtil.addDecimal(112, 200).toNumber();
              let n2 = NumberUtil.addDecimal("200", "300").toNumber();
              let n3 = NumberUtil.addDecimal("200", 600).toNumber();
              let txtStr = `n1：${n1}\n\nn2：${n2}\n\nn3：${n3}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("subDecimal()")
            .btnStyle()
            .onClick(() => {
              let n1 = NumberUtil.subDecimal(112, 20).toNumber();
              let n2 = NumberUtil.subDecimal("200", 100).toNumber();
              let n3 = NumberUtil.subDecimal("200", 55).toNumber();
              let txtStr = `n1：${n1}\n\nn2：${n2}\n\nn3：${n3}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("sumDecimal()")
            .btnStyle()
            .onClick(() => {
              let n1 = NumberUtil.sumDecimal(1, 3, 5, 7, 9).toNumber();
              let n2 = NumberUtil.sumDecimal("1", "3", "5", "7", "9").toNumber();
              let n3 = NumberUtil.sumDecimal("10", 15, "25", "35", 45).toNumber();
              let txtStr = `n1：${n1}\n\nn2：${n2}\n\nn3：${n3}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
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
