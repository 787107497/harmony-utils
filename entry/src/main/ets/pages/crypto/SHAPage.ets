import { DescribeBean } from '../../model/DescribeBean';
import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { CryptoUtil, LogUtil, SHA, ToastUtil } from '@pura/harmony-utils';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * SHA工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  readonly str1: string = "鸿蒙技术交流QQ群：1029219059";
  readonly str2: string = "harmony-utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。";
  readonly str3: string = "harmony-utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。gitee地址：https://gitee.com/tongyuyan/harmony-utils。github主页地址：https://github.com/787107497。";
  @State symKey?: cryptoFramework.SymKey = undefined;


  @MockSetup
  mock() {
    this.describe = new DescribeBean("SHA", "SHA工具类");
  }

  aboutToAppear(): void {
    this.symKey = CryptoUtil.generateSymKeySync("HMAC|SHA256");
  }


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("摘要，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let digest1 = await SHA.digest(this.str1);
              LogUtil.error(`摘要，异步: ${digest1}`);

              let digest2 = SHA.digestSync(this.str1);
              LogUtil.error(`摘要，同步: ${digest2}`);

              let digest3 = SHA.digestSync(this.str1, 'SHA512');
              LogUtil.error(`摘要:\t ${digest3}`);

              let digest4 = SHA.digestSync(this.str1, 'SHA512', 'base64');
              LogUtil.error(`摘要:\t ${digest4}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("分段摘要，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let digest1 = await SHA.digestSegment(this.str3);
              LogUtil.error(`分段摘要，异步: ${digest1}`);

              let digest2 = SHA.digestSegmentSync(this.str3);
              LogUtil.error(`分段摘要，同步: ${digest2}`);

              let digest3 = SHA.digestSegmentSync(this.str3, 'SHA256', 'base64', 256);
              LogUtil.error(`分段摘要:\t ${digest3}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("消息认证码计算，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let digest1 = await SHA.hmac(this.str1);
              LogUtil.error(`消息认证码计算，异步: ${digest1}`);

              let digest2 = SHA.hmacSync(this.str1);
              LogUtil.error(`消息认证码计算，同步: ${digest2}`);

              let digest3 = SHA.hmacSync(this.str1, 'SHA256', this.symKey!);
              LogUtil.error(`消息认证码计算:\t ${digest3}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("分段消息认证码计算，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let digest1 = await SHA.hmacSegment(this.str3);
              LogUtil.error(`分段消息认证码计算，异步: ${digest1}`);

              let digest2 = SHA.hmacSegmentSync(this.str3);
              LogUtil.error(`分段消息认证码计算，同步: ${digest2}`);

              let digest3 = SHA.hmacSegmentSync(this.str3, 'SHA256', this.symKey!, 'hex', 256);
              LogUtil.error(`分段消息认证码计算:\t ${digest3}`);
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