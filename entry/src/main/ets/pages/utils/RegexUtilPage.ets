import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, RegexUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 正则工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("RegexUtil", "正则工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("isPhone()")
            .btnStyle()
            .onClick(() => {
              let phone: string = "18969062528";
              let bl = RegexUtil.isPhone(phone);
              LogUtil.error(`isPhone: ${bl}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("isMatch()")
            .btnStyle()
            .onClick(() => {
              let url = "https://ohpm.openharmony.cn/#/cn/publisher/663b99a5788eb334c83d9cd5";
              let blUrl = RegexUtil.isMatch(url, RegexUtil.REG_URL);
              let num = "123479";
              let blNum = RegexUtil.isMatch(num, RegexUtil.REG_NUMBERS);
              let cardNo = "340322199601100668";
              let blCardNo = RegexUtil.isMatch(cardNo, RegexUtil.REG_CITIZEN_ID);
              let date = "2024-10-15 21:18";
              let blDate = RegexUtil.isMatch(date, RegexUtil.REG_TIME);
              LogUtil.error(`是否是URL: ${blUrl}`);
              LogUtil.error(`是否是数字: ${blNum}`);
              LogUtil.error(`是否是身份证号: ${blCardNo}`);
              LogUtil.error(`是否是时间: ${blDate}`);

              ToastUtil.showToast("请查看Log日志");
            })
          Button("isEmoji()\nisEmail()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let email: string = "787107497@qq.com";
              let bl2 = RegexUtil.isEmail(email);
              LogUtil.error(`是否是邮件: ${bl2}`);
              let str = "hdc shell aa start -a EntryAbility -b com.harmony.utils in 253 ms";
              let isEmoji = RegexUtil.isEmoji(str);
              LogUtil.error(`判断字符串是否包含表情: ${isEmoji}`);
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