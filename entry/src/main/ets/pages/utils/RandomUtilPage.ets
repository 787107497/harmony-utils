import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, RandomUtil, StrUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { Utils } from '../../utils/Utils';

/**
 * 随机工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("RandomUtil", "随机工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("getRandomInt()\ngetRandomLimit()\ngetRandomNumber()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let n1 = RandomUtil.getRandomInt();
              let n2 = RandomUtil.getRandomLimit(1000);
              let n3 = RandomUtil.getRandomNumber(10000, 1000000);
              let txtStr = `随机数1：${n1}\n随机数2：${n2}\n随机数3：${n3}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("getRandomChineseChar()\ngetRandomChinese()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str1 = RandomUtil.getRandomChineseChar();
              let str2 = RandomUtil.getRandomChinese(12);
              let txtStr = `随机汉字：${str1}\n随机汉字：${str2}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("getRandomBoolean()\ngetRandomColor()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let b1 = RandomUtil.getRandomBoolean();
              let b2 = RandomUtil.getRandomBoolean();
              let c3 = RandomUtil.getRandomColor();
              let txtStr = `随机Boolean值1：${b1}\n随机Boolean值2：${b2}\n随机颜色：${c3}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("getRandomStr()")
            .btnStyle()
            .onClick(() => {
              let r1 = RandomUtil.getRandomStr(15, "ACCDEFGHIJKMNL");
              let r2 = RandomUtil.getRandomStr(12, "accdefghijkmnl");
              let r3 = RandomUtil.getRandomStr(16, "1234567890");
              let r4 = RandomUtil.getRandomStr(10, "哈呵嘿哼噢哦呸嗷");
              let txtStr = `随机1：${r1}\n随机2：${r2}\n随机3：${r3}\n随机4：${r4}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("getRandomDataBlob()\ngetRandomUint8Array()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let dataBlob = RandomUtil.getRandomDataBlob(8);
              let unit8Array = RandomUtil.getRandomUint8Array(8);
              let txtStr = `dataBlob：\n${dataBlob.data}\n\n3unit8Array：\n${unit8Array}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })

          Button("generateUUID36()\ngenerateUUID32()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let uuid36 = RandomUtil.generateUUID36();
              let uuid32 = RandomUtil.generateUUID32();
              let txtStr = `36位UUID：\n${uuid36}\n\n32位UUID：\n${uuid32}`;
              LogUtil.error(txtStr);
              Utils.showSheetText(txtStr);
            })
          Button("generateRandomUUID()\ngenerateRandomBinaryUUID")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let uuid1 = RandomUtil.generateRandomUUID();
              let uuid2 = RandomUtil.generateRandomBinaryUUID();
              let txtStr = `使用加密安全随机数生成器生成随机的string类型UUID：\n${uuid1}\n\n使用加密安全随机数生成器生成随机的Uint8Array类型UUID：\n${uuid2}`;
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