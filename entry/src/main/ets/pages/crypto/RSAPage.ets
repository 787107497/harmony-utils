import { DescribeBean } from '../../model/DescribeBean';
import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { CryptoHelper, LogUtil, RSA, ToastUtil } from '@pura/harmony-utils';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * RSA加解密
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  readonly str1: string = "鸿蒙技术交流QQ群：1029219059";
  readonly str2: string = "harmony-utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。";
  readonly str3: string = "harmony-utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。gitee地址：https://gitee.com/tongyuyan/harmony-utils。github主页地址：https://github.com/787107497。";
  @State keyPair?: cryptoFramework.KeyPair = undefined; //非对称密钥


  @MockSetup
  mock() {
    this.describe = new DescribeBean("RSA", "RSA加解密");
  }

  aboutToAppear(): void {
    this.keyPair = RSA.generateKeyPairSync(); //生成密钥
  }


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("生成密钥，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let keyPair1 = await RSA.generateKeyPair();
              let pubKeyStr1 = CryptoHelper.dataBlobToStr(keyPair1.pubKey.getEncoded(), 'hex'); //将公钥转换成base64字符串。
              LogUtil.error(`pubKeyStr1: ${pubKeyStr1}`);
              let priKeyStr1 = CryptoHelper.dataBlobToStr(keyPair1.priKey.getEncoded(), 'hex'); //将私钥转换成base64符符串。
              LogUtil.error(`priKeyStr1: ${priKeyStr1}`);

              let keyPair2 = RSA.generateKeyPairSync();
              let pubKeyStr2 = CryptoHelper.dataBlobToStr(keyPair2.pubKey.getEncoded(), 'base64'); //将公钥转换成base64字符串。
              LogUtil.error(`pubKeyStr2: ${pubKeyStr2}`);
              let priKeyStr2 = CryptoHelper.dataBlobToStr(keyPair2.priKey.getEncoded(), 'base64'); //将私钥转换成base64符符串。
              LogUtil.error(`priKeyStr2: ${priKeyStr2}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("获取转换的密钥，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let pubKeyStr = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDUpsnavHoapoKtOOM9NKqTt6BpPe07ZzxhMcLAm5dtFQ6zRyJwT3czHGnh1BM2FATvLTDGLkmKc/Ww27//lFbrbqBE19R/5y8UPRpbUdACZ28yqzdiaquovUndhTH/CnLzcPM7VnWO0gp3/kbg5WizkZtUTRHL+Nu4OHbbesO1wIDAQAB"; //base64字符串密钥
              let priKeyStr = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMNSmydq8ehqmgq044z00qpO3oGk97TtnPGExwsCbl20VDrNHInBPdzMcaeHUEzYUBO8tMMYuSYpz9bDbv/+UVutuoETX1H/nLxQ9GltR0AJnbzKrN2Jqq6i9Sd2FMf8KcvNw8ztWdY7SCnf+RuDlaLORm1RNEcv427g4dtt6w7XAgMBAAECgYANvgsii9i3VIDADhgQe80ypFftYTD4btti9seWU7Z2K1Ddzj6axpjWpx+7/L4+md2Qde915pBoSfrQjnGJ21fX7vpqOVdDWS7lseYfM50z8ZMpZewxJNBkSGYQEazMYDfyCFMjZmB4guf/uu0B2JN/YtA8Ed7JJlkXmVLh4ReYSQJBAOIhzozpcIuGOBjylQdN+MokiL14gnAh6hiwnusD9JlTSJbQonUXkhikaf0WphxBVPSngZDdi3FYla/CDUAScBMCQQDdHwsJZ1oShtbJltaUCEsJHTWLwYm8V8tTOpHGJU8/u1mBK3pVZlwnfzzrj2oLl5iBpMHF197TPNi5gjrjM6atAkA/4pMrBixQjqu8iJQHy0R1P1sORER9j2dGcGeFN8nbo0bHrMuozu7sXU7APKzTILXypHwbRCvH6uHnFKiPqGXXAkAUsjEgQjImBcTYvWt8E4Kiab93QzgXDsiTE6pNN3TBbFGmS2F52MjLUZdsHNI6H4hAqiEQ2XGbp9hJFK1aUp1JAkEAjP4fbqrAUjGiG+EbjEffV625kACb6q9Wz+vbspMPqcr5TU2AxxSW65Yilq4pKYq8O+qXnVdOpX7DjrWA1kg2JA=="; //base64字符串密钥

              let keyPair1 = await RSA.getConvertKeyPair(pubKeyStr, priKeyStr, 'base64');
              let keyPair2 = RSA.getConvertKeyPairSync(pubKeyStr, priKeyStr, 'base64');
              LogUtil.error(`获取转换的密钥成功拉~~~~~~~`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("加解密，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let keyPair1 = await RSA.generateKeyPair(); //生成密钥
              let dataBlob = CryptoHelper.strToDataBlob(this.str1, 'utf-8'); //待加密数据
              let encryptDataBlob = await RSA.encrypt(dataBlob, keyPair1.pubKey); //加密
              let decryptDataBlob = await RSA.decrypt(encryptDataBlob, keyPair1.priKey); //解密
              let decryptStr = CryptoHelper.dataBlobToStr(decryptDataBlob, 'utf-8');
              LogUtil.error(`加解密，异步：${decryptStr}`);

              let keyPair2 = RSA.generateKeyPairSync('RSA2048|PRIMES_2'); //生成密钥
              let dataBlob2 = CryptoHelper.strToDataBlob(this.str1, 'utf-8'); //待加密数据
              let encryptDataBlob2 = RSA.encryptSync(dataBlob2, keyPair2.pubKey, 'RSA2048|PKCS1'); //加密
              let decryptDataBlob2 = RSA.decryptSync(encryptDataBlob2, keyPair2.priKey, 'RSA2048|PKCS1'); //解密
              let decryptStr2 = CryptoHelper.dataBlobToStr(decryptDataBlob2, 'utf-8');
              LogUtil.error(`加解密，同步：${decryptStr2}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("分段加解密，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let keyPair1 = await RSA.generateKeyPair("RSA1024|PRIMES_2"); //生成密钥
              let dataBlob = CryptoHelper.strToDataBlob(this.str2, 'utf-8'); //待加密数据
              let encryptDataBlob = await RSA.encryptSegment(dataBlob, keyPair1.pubKey, 'RSA2048|PKCS1'); //加密
              let decryptDataBlob = await RSA.decryptSegment(encryptDataBlob, keyPair1.priKey, 'RSA2048|PKCS1'); //解密
              let decryptStr = CryptoHelper.dataBlobToStr(decryptDataBlob, 'utf-8');
              LogUtil.error(`分段加解密，异步：${decryptStr}`);

              let keyPair2 = RSA.generateKeyPairSync(); //生成密钥
              let dataBlob2 = CryptoHelper.strToDataBlob(this.str3, 'utf-8'); //待加密数据
              let encryptDataBlob2 = RSA.encryptSegmentSync(dataBlob2, keyPair2.pubKey); //加密
              let decryptDataBlob2 = RSA.decryptSegmentSync(encryptDataBlob2, keyPair2.priKey); //解密
              let decryptStr2 = CryptoHelper.dataBlobToStr(decryptDataBlob2, 'utf-8');
              LogUtil.error(`分段加解密，同步：${decryptStr2}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("签名与验签，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let dataBlob = CryptoHelper.strToDataBlob(this.str1, 'utf-8');

              let signDataBlob1 = await RSA.sign(dataBlob, this.keyPair!.priKey);
              let signStr1 = CryptoHelper.dataBlobToStr(signDataBlob1, 'hex');
              LogUtil.error(`签名，异步: ${signStr1}`);
              let verify1 = await RSA.verify(dataBlob, signDataBlob1, this.keyPair!.pubKey);
              LogUtil.error(`验签，异步: ${verify1}`);

              let signDataBlob = RSA.signSync(dataBlob, this.keyPair!.priKey);
              let signStr = CryptoHelper.dataBlobToStr(signDataBlob, 'hex');
              LogUtil.error(`签名，同步: ${signStr}`);
              let verify = RSA.verifySync(dataBlob, signDataBlob, this.keyPair!.pubKey);
              LogUtil.error(`验签，同步: ${verify}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("分段签名与分段验签，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let data = CryptoHelper.strToUint8Array(this.str3, 'utf-8');

              let signDataBlob = await RSA.signSegment(data, this.keyPair!.priKey);
              let signStr = CryptoHelper.dataBlobToStr(signDataBlob, 'base64');
              LogUtil.error(`分段签名，异步: ${signStr}`);
              let verify = await RSA.verifySegment(data, signDataBlob, this.keyPair!.pubKey);
              LogUtil.error(`分段验签，异步: ${verify}`);

              let signDataBlob2 = RSA.signSegmentSync(data, this.keyPair!.priKey);
              let signStr2 = CryptoHelper.dataBlobToStr(signDataBlob2, 'base64');
              LogUtil.error(`分段签名，同步: ${signStr2}`);
              let verify2 = RSA.verifySegmentSync(data, signDataBlob2, this.keyPair!.pubKey);
              LogUtil.error(`分段验签，同步: ${verify2}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("签名恢复，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let dataBlob = CryptoHelper.strToDataBlob(this.str1, 'utf-8');
              let signDataBlob = RSA.signSync(dataBlob, this.keyPair!.priKey, 'RSA1024|PKCS1|NoHash|OnlySign');

              let recoverDataBlob = await RSA.recover(signDataBlob, this.keyPair!.pubKey);
              if (recoverDataBlob != null) {
                let recoverStr = CryptoHelper.dataBlobToStr(recoverDataBlob, 'utf-8');
                LogUtil.error(`签名恢复，异步: ${recoverStr}`);
              } else {
                LogUtil.error(`签名恢复，异步: 恢复数据为空！`);
              }

              let recoverDataBlob2 = RSA.recoverSync(signDataBlob, this.keyPair!.pubKey);
              if (recoverDataBlob2 != null) {
                let recoverStr2 = CryptoHelper.dataBlobToStr(recoverDataBlob2, 'utf-8');
                LogUtil.error(`签名恢复，同步: ${recoverStr2}`);
              } else {
                LogUtil.error(`签名恢复，同步: 恢复数据为空！`);
              }
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