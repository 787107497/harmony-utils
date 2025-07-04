import { DescribeBean } from '../../model/DescribeBean';
import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { CryptoUtil, LogUtil, MD5, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * MD5工具类
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
    this.describe = new DescribeBean("MD5", "MD5工具类");
  }

  aboutToAppear(): void {
    this.symKey = CryptoUtil.generateSymKeySync("AES256");
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
              let digest1 = await MD5.digest(this.str1);
              LogUtil.error(`摘要，异步: ${digest1}`);
              let digest2 = MD5.digestSync(this.str1);
              LogUtil.error(`摘要，同步1: ${digest2}`);
              let digest3 = MD5.digestSync(this.str1, 'base64');
              LogUtil.error(`摘要，同步2: ${digest3}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("分段摘要，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let digest1 = await MD5.digestSegment(this.str3);
              LogUtil.error(`分段摘要，异步: ${digest1}`);
              let digest2 = MD5.digestSegmentSync(this.str3);
              LogUtil.error(`分段摘要，同步1: ${digest2}`);
              let digest3 = MD5.digestSegmentSync(this.str3, 'base64', 256);
              LogUtil.error(`分段摘要，同步2: ${digest3}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("消息认证码计算，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let digest1 = await MD5.hmac(this.str1, this.symKey!);
              LogUtil.error(`消息认证码计算，异步: ${digest1}`);
              let digest2 = MD5.hmacSync(this.str1, this.symKey!);
              LogUtil.error(`消息认证码计算，同步1: ${digest2}`);
              let digest3 = MD5.hmacSync(this.str1, this.symKey!, 'base64');
              LogUtil.error(`消息认证码计算，同步2: ${digest3}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("分段消息认证码计算，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let digest1 = await MD5.hmacSegment(this.str3, this.symKey!);
              LogUtil.error(`分段消息认证码计算，异步: ${digest1}`);
              let digest2 = MD5.hmacSegmentSync(this.str3, this.symKey!);
              LogUtil.error(`分段消息认证码计算，同步1: ${digest2}`);
              let digest3 = MD5.hmacSegmentSync(this.str3, this.symKey!, 'hex', 256);
              LogUtil.error(`分段消息认证码计算，同步2: ${digest3}`);
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