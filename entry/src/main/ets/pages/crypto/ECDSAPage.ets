import { DescribeBean } from '../../entity/DescribeBean';
import { ComposeTitleBar, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { CryptoHelper, CryptoUtil, ECDSA, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';

/**
 * ECDSA工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  readonly str1: string = "鸿蒙技术交流QQ群：569512366";
  readonly str2: string = "harmony-utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。";
  readonly str3: string = "harmony-utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。gitee地址：https://gitee.com/tongyuyan/harmony-utils。github主页地址：https://github.com/787107497。";
  @State keyPair?: cryptoFramework.KeyPair = undefined; //非对称密钥


  @MockSetup
  mock() {
    this.describe = new DescribeBean("ECDSA", "ECDSA工具类");
  }

  async aboutToAppear(): Promise<void> {
    this.keyPair = await CryptoUtil.generateKeyPair('ECC256'); //生成密钥
  }


  build() {
    Column() {
      ComposeTitleBar({
        title: this.describe.name,
        subtitle: this.describe.desc,
      })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("生成密钥，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let keyPair1 = await CryptoUtil.generateKeyPair('ECC256');
              let pubKeyStr1 = CryptoHelper.dataBlobToStr(keyPair1.pubKey.getEncoded(), 'hex'); //将公钥转换成base64字符串。
              LogUtil.error(`pubKeyStr1: ${pubKeyStr1}`);
              let priKeyStr1 = CryptoHelper.dataBlobToStr(keyPair1.priKey.getEncoded(), 'hex'); //将私钥转换成base64符符串。
              LogUtil.error(`priKeyStr1: ${priKeyStr1}`);

              let keyPair2 = CryptoUtil.generateKeyPairSync('ECC256');
              let pubKeyStr2 = CryptoHelper.dataBlobToStr(keyPair2.pubKey.getEncoded(), 'base64'); //将公钥转换成base64字符串。
              LogUtil.error(`pubKeyStr2: ${pubKeyStr2}`);
              let priKeyStr2 = CryptoHelper.dataBlobToStr(keyPair2.priKey.getEncoded(), 'base64'); //将私钥转换成base64符符串。
              LogUtil.error(`priKeyStr2: ${priKeyStr2}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("获取转换的密钥，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let pubKeyStr = "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEptg0wJLGmD1njk5pPu3JpNZoPUOvgMkU2NYr78x9vF8h2mlbxnKKvwiTGnaSyAfJvbAM5NUxMAlVSogtNWQ88Q=="; //base64字符串密钥
              let priKeyStr = "MDECAQEEIJuB45XgD6yK9wFOyI0VrYHRFBAJfDNunBaggcyoqcJ+oAoGCCqGSM49AwEH"; //base64字符串密钥

              let keyPair1 = await CryptoUtil.getConvertKeyPair('ECC256', pubKeyStr, priKeyStr, 'base64');
              let keyPair2 = CryptoUtil.getConvertKeyPairSync('ECC256', pubKeyStr, priKeyStr, 'base64');
              LogUtil.error(`获取转换的密钥成功拉~~~~~~~`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("签名与验签，同步")
            .btnStyle()
            .onClick(() => {
              let dataBlob = CryptoHelper.strToDataBlob(this.str1, 'utf-8');
              let signDataBlob = ECDSA.signSync(dataBlob, this.keyPair!.priKey);
              let signStr = CryptoHelper.dataBlobToStr(signDataBlob, 'hex');
              LogUtil.error(`签名，同步: ${signStr}`);
              let verify =  ECDSA.verifySync(dataBlob, signDataBlob, this.keyPair!.pubKey);
              LogUtil.error(`验签，同步: ${verify}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("签名与验签，异步")
            .btnStyle()
            .onClick(async () => {
              let dataBlob = CryptoHelper.strToDataBlob(this.str1, 'utf-8');
              let signDataBlob = await ECDSA.sign(dataBlob, this.keyPair!.priKey);
              let signStr = CryptoHelper.dataBlobToStr(signDataBlob, 'hex');
              LogUtil.error(`签名，异步: ${signStr}`);
              let verify = await ECDSA.verify(dataBlob, signDataBlob, this.keyPair!.pubKey);
              LogUtil.error(`验签，异步: ${verify}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("分段签名与分段验签，同步")
            .btnStyle()
            .onClick( () => {
              let data = CryptoHelper.strToUint8Array(this.str3, 'utf-8');
              let signDataBlob = ECDSA.signSegmentSync(data, this.keyPair!.priKey);
              let signStr = CryptoHelper.dataBlobToStr(signDataBlob, 'base64');
              LogUtil.error(`分段签名，同步: ${signStr}`);
              let verify = ECDSA.verifySegmentSync(data, signDataBlob, this.keyPair!.pubKey);
              LogUtil.error(`分段验签，同步: ${verify}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("分段签名与分段验签，异步")
            .btnStyle()
            .onClick(async () => {
              let data = CryptoHelper.strToUint8Array(this.str3, 'utf-8');
              let signDataBlob = await ECDSA.signSegment(data, this.keyPair!.priKey);
              let signStr = CryptoHelper.dataBlobToStr(signDataBlob, 'base64');
              LogUtil.error(`分段签名，异步: ${signStr}`);
              let verify = await ECDSA.verifySegment(data, signDataBlob, this.keyPair!.pubKey);
              LogUtil.error(`分段验签，异步: ${verify}`);
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
  .backgroundColor(Color.White)
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}