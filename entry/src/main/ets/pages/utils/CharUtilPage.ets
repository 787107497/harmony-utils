import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { CharUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 字符工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("CharUtil", "字符工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("isDigit()\nisLetter()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let b1 = CharUtil.isDigit('6')
              let b2 = CharUtil.isDigit('A')
              let b3 = CharUtil.isDigit('瑶')
              let b4 = CharUtil.isDigit('6a')
              let b5 = CharUtil.isDigit('66')
              LogUtil.error(`1、 ${b1} --- ${b2} --- ${b3} --- ${b4} --- ${b5}`)
              let bl1 = CharUtil.isLetter('A')
              let bl2 = CharUtil.isLetter('6')
              let bl3 = CharUtil.isLetter('瑶')
              let bl4 = CharUtil.isLetter('a6')
              let bl5 = CharUtil.isLetter('ac')
              LogUtil.error(`2、 ${bl1} --- ${bl2} --- ${bl3} --- ${bl4} --- ${bl5}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("isLowerCase()\nisUpperCase()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let b1 = CharUtil.isLowerCase('a')
              let b2 = CharUtil.isLowerCase('ad')
              let b3 = CharUtil.isLowerCase('瑶')
              let b4 = CharUtil.isLowerCase('6abc')
              let b5 = CharUtil.isLowerCase('Abc')
              let b6 = CharUtil.isLowerCase('aBC')
              LogUtil.error(`3、 ${b1} --- ${b2} --- ${b3} --- ${b4} --- ${b5} --- ${b6}`)
              let bl1 = CharUtil.isUpperCase('A')
              let bl2 = CharUtil.isUpperCase('AB')
              let bl3 = CharUtil.isUpperCase('瑶')
              let bl4 = CharUtil.isUpperCase('6cba')
              let bl5 = CharUtil.isUpperCase('cBA')
              let bl6 = CharUtil.isUpperCase('Cba')
              LogUtil.error(`4、 ${bl1} --- ${bl2} --- ${bl3} --- ${bl4} --- ${bl5} --- ${bl6}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("isSpaceChar()\nisWhitespace()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let b1 = CharUtil.isSpaceChar(' ')
              let b2 = CharUtil.isSpaceChar('a d')
              let b3 = CharUtil.isSpaceChar('a ')
              let b4 = CharUtil.isSpaceChar(' ')
              LogUtil.error(`5、 ${b1} --- ${b2} --- ${b3} --- ${b4}`)
              let bl1 = CharUtil.isWhitespace('  ')
              let bl2 = CharUtil.isWhitespace('A  B')
              let bl3 = CharUtil.isWhitespace('a  ')
              let bl4 = CharUtil.isWhitespace(' ')
              LogUtil.error(`6、 ${bl1} --- ${bl2} --- ${bl3} --- ${bl4}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("isRTL()\nisIdeograph()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let b1 = CharUtil.isRTL('我尼玛a')
              let b2 = CharUtil.isRTL('ad')
              let b3 = CharUtil.isRTL('瑶')
              let b4 = CharUtil.isRTL('6abc')
              let b5 = CharUtil.isRTL('Abc')
              let b6 = CharUtil.isRTL('aBC')
              LogUtil.error(`7、 ${b1} --- ${b2} --- ${b3} --- ${b4} --- ${b5} --- ${b6}`)
              let bl1 = CharUtil.isIdeograph('我尼玛')
              let bl2 = CharUtil.isIdeograph('AB')
              let bl3 = CharUtil.isIdeograph('ABC瑶')
              let bl4 = CharUtil.isIdeograph('我尼玛6cba')
              let bl5 = CharUtil.isIdeograph('cBA')
              let bl6 = CharUtil.isIdeograph('Cba')
              LogUtil.error(`8、 ${bl1} --- ${bl2} --- ${bl3} --- ${bl4} --- ${bl5} --- ${bl6}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("isBlankChar()\nisAscii()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let b1 = CharUtil.isBlankChar(6)
              let b2 = CharUtil.isBlankChar(126)
              let b3 = CharUtil.isBlankChar(666)
              let b4 = CharUtil.isBlankChar(66666)
              LogUtil.error(`7、 ${b1} --- ${b2} --- ${b3} --- ${b4}`)
              let bl1 = CharUtil.isAscii('A')
              let bl2 = CharUtil.isAscii('B')
              let bl3 = CharUtil.isAscii('瑶')
              let bl4 = CharUtil.isAscii('6cba')
              LogUtil.error(`8、 ${bl1} --- ${bl2} --- ${bl3} --- ${bl4}`)
              ToastUtil.showToast("请查看Log日志")
            })

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
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}