import { ComposeTitleBar, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, RandomUtil, StrUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 随机工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State txtStr: string = ''

  @MockSetup
  mock() {
    this.describe = new DescribeBean("RandomUtil", "随机工具类");
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
          Button("randomInt()\nrandomLimit()\nrandomNumber()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let n1 = RandomUtil.randomInt();
              let n2 = RandomUtil.randomLimit(1000);
              let n3 = RandomUtil.randomNumber(10000, 1000000);
              this.txtStr = `随机数1：${n1}\n随机数2：${n2}\n随机数3：${n3}`;
              LogUtil.error(this.txtStr);
            })
          Button("randomBoolean()\nrandomChinese()\nrandomColor()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let b1 = RandomUtil.randomBoolean();
              let z2 = RandomUtil.randomChinese();
              let c3 = RandomUtil.randomColor();
              this.txtStr = `随机Boolean值：${b1}\n随机汉字：${z2}\n随机颜色：${c3}`;
              LogUtil.error(this.txtStr);
            })
          Button("randomStr()")
            .btnStyle()
            .onClick(() => {
              let r1 = RandomUtil.randomStr(15, "ACCDEFGHIJKMNL");
              let r2 = RandomUtil.randomStr(12, "accdefghijkmnl");
              let r3 = RandomUtil.randomStr(16, "1234567890");
              let r4 = RandomUtil.randomStr(10, "哈呵嘿哼噢哦呸嗷");
              this.txtStr = `随机1：${r1}\n随机2：${r2}\n随机3：${r3}\n随机4：${r4}`;
              LogUtil.error(this.txtStr);
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
              this.txtStr = `36位UUID：\n${uuid36}\n\n32位UUID：\n${uuid32}`;
              LogUtil.error(this.txtStr);
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
              this.txtStr = `使用加密安全随机数生成器生成随机的string类型UUID：\n${uuid1}\n\n使用加密安全随机数生成器生成随机的Uint8Array类型UUID：\n${uuid2}`;
              LogUtil.error(this.txtStr);
            })
          Text(this.txtStr)
            .visibility(StrUtil.isNotEmpty(this.txtStr) ? Visibility.Visible : Visibility.None)
            .textStyle()

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