import { DescribeBean } from '../../model/DescribeBean';
import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { SM2 } from '@pura/harmony-utils/src/main/ets/crypto/SM2';
import { CryptoHelper } from '@pura/harmony-utils/src/main/ets/crypto/CryptoHelper';
import { LogUtil, ToastUtil } from '@pura/harmony-utils';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * SM2加解密
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
  @State keyPair?: cryptoFramework.KeyPair = undefined; //非对称密钥

  @MockSetup
  mock() {
    this.describe = new DescribeBean("SM2", "SM2加解密");
  }

  aboutToAppear(): void {
    this.genConvertKeyPair();
  }

  //生成非对称密钥
  genConvertKeyPair(){
    let pubKeyStr = "MFkwEwYHKoZIzj0CAQYIKoEcz1UBgi0DQgAEYIZ4YCxXfIKvy3Fzmpl43hk7ojUsZqoZyww1YYtw4bICcaD/KmKy+OO4bMTnbrjbjNfJQaVApDTOW9a+PvazXQ=="; //base64字符串公钥
    let priKeyStr = "MDECAQEEIKu8PGHEU4Wxiw6xwb0loj0NVLlR7vGe5jYgan8u+hKboAoGCCqBHM9VAYIt"; //base64字符串私钥
    this.keyPair = SM2.getConvertKeyPairSync(pubKeyStr, priKeyStr, 'base64');
  }


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("生成密钥，异步")
            .btnStyle()
            .onClick(async () => {
              let keyPair = await SM2.generateKeyPair();
              let pubKey = keyPair.pubKey; //公钥
              let priKey = keyPair.priKey; //私钥
              let pubKeyStr = CryptoHelper.dataBlobToStr(pubKey.getEncoded(), 'hex'); //将公钥转换成16进制字符串。
              LogUtil.error(`pubKeyStr1: ${pubKeyStr}`);
              let priKeyStr = CryptoHelper.dataBlobToStr(priKey.getEncoded(), 'hex'); //将私钥转换成16进制字符串。
              LogUtil.error(`priKeyStr1: ${priKeyStr}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("生成密钥，同步")
            .btnStyle()
            .onClick(() => {
              let keyPair = SM2.generateKeyPairSync();
              let pubKey = keyPair.pubKey; //公钥
              let priKey = keyPair.priKey; //私钥
              let pubKeyStr = CryptoHelper.dataBlobToStr(pubKey.getEncoded(), 'base64'); //将公钥转换成base64字符串。
              LogUtil.error(`pubKeyStr2: ${pubKeyStr}`);
              let priKeyStr = CryptoHelper.dataBlobToStr(priKey.getEncoded(), 'base64'); //将私钥转换成base64符符串。
              LogUtil.error(`priKeyStr2: ${priKeyStr}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("获取转换的密钥，异步")
            .btnStyle()
            .onClick(async () => {
              let pubKeyStr = "3059301306072a8648ce3d020106082a811ccf5501822d034200045417bebc296d14ebed6b6d0298019935677c5a8549150adf82e5c51f567066a7e8186915b10d3a8f0c544b2c03ee39ff3063125b53b906cc4da2232ae127c178"; //16进制字符串密钥
              let priKeyStr = "3031020101042035ae8b8faec0e80e64b26d5239d60c7a694aaa84bd106ed12f4600d9fe2cbd09a00a06082a811ccf5501822d"; //16进制字符串密钥
              let keyPair = await SM2.getConvertKeyPair(pubKeyStr, priKeyStr, 'hex');
              let pubKey = keyPair.pubKey; //公钥
              let priKey = keyPair.priKey; //私钥
              let pubKeyStr3 = CryptoHelper.dataBlobToStr(pubKey.getEncoded(), 'hex'); //将公钥转换成16进制字符串。
              LogUtil.error(`pubKeyStr3: ${pubKeyStr3}`);
              let priKeyStr3 = CryptoHelper.dataBlobToStr(priKey.getEncoded(), 'hex'); //将私钥转换成16进制字符串。
              LogUtil.error(`priKeyStr3: ${priKeyStr3}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("获取转换的密钥，同步")
            .btnStyle()
            .onClick(() => {
              let pubKeyStr = "MFkwEwYHKoZIzj0CAQYIKoEcz1UBgi0DQgAEYIZ4YCxXfIKvy3Fzmpl43hk7ojUsZqoZyww1YYtw4bICcaD/KmKy+OO4bMTnbrjbjNfJQaVApDTOW9a+PvazXQ=="; //base64字符串密钥
              let priKeyStr= "MDECAQEEIKu8PGHEU4Wxiw6xwb0loj0NVLlR7vGe5jYgan8u+hKboAoGCCqBHM9VAYIt"; //base64字符串密钥
              let keyPair = SM2.getConvertKeyPairSync(pubKeyStr, priKeyStr, 'base64');
              let pubKey = keyPair.pubKey; //公钥
              let priKey = keyPair.priKey; //私钥
              let pubKeyStr4 = CryptoHelper.dataBlobToStr(pubKey.getEncoded(), 'base64'); //将公钥转换成base64字符串。
              LogUtil.error(`pubKeyStr4: ${pubKeyStr4}`);
              let priKeyStr4 = CryptoHelper.dataBlobToStr(priKey.getEncoded(), 'base64'); //将私钥转换成base64符符串。
              LogUtil.error(`priKeyStr4: ${priKeyStr4}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("转换SM2公钥")
            .btnStyle()
            .onClick(() => {
              //16进制的C1C2C3格式的SM2公钥
              let pubKeyStr = "04FB40A51A9D6E9333A73B3633BA72B0989BD69F54420108E7036C8FA0E6C6142C422F70D75063AC98EC9E2D2CB82B847C51979A1485DAB5573ABCC0FC69B5988E";
              let pubKey = SM2.getSM2PubKey(pubKeyStr); //将16进制的C1C2C3格式的SM2公钥转换为鸿蒙所需的ASN.1格式公钥
              let pubKeyStr1 = CryptoHelper.dataBlobToStr(pubKey.getEncoded(), 'hex'); //将公钥转换成16进制字符串。
              LogUtil.error(`转换后的公钥: ${pubKeyStr1}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("转换SM2私钥")
            .btnStyle()
            .onClick(() => {
              let priKeyStr="6330B599ECD23ABDC74B9A5B7B5E00E553005F72743101C5FAB83AEB579B7074";
              let priKey = SM2.getSM2PriKey(priKeyStr);
              let priKeyStr1 = CryptoHelper.dataBlobToStr(priKey.getEncoded(), 'hex'); //将私钥转换成base64符符串。
              LogUtil.error(`转换后的私钥: ${priKeyStr1}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("转换SM2密文")
            .btnStyle()
            .onClick(() => {
              let msg = "鸿蒙技术交流QQ群：569512366"; //待加密字符串
              let msgDataBlob = CryptoHelper.strToDataBlob(msg, 'utf-8');
              let encryptDataBlob = SM2.encryptSync(msgDataBlob, this.keyPair!.pubKey); //加密

              let c1c2c3Str = SM2.getCipherTextSpec(encryptDataBlob, 0); //转换密文
              LogUtil.error(`C1C2C3密文: ${c1c2c3Str}`);

              let c1c3c2Str = SM2.getCipherTextSpec(encryptDataBlob, 1); //转换密文
              LogUtil.error(`C1C3C2密文: ${c1c3c2Str}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("加解密，异步")
            .btnStyle()
            .onClick(async () => {
              let msg = "鸿蒙技术交流QQ群：569512366"; //待加密字符串
              let msgDataBlob = CryptoHelper.strToDataBlob(msg, 'utf-8');
              let encryptDataBlob = await SM2.encrypt(msgDataBlob, this.keyPair!.pubKey); //加密
              let decryptDataBlob = await SM2.decrypt(encryptDataBlob, this.keyPair!.priKey); //解密
              let decryptMsg = CryptoHelper.dataBlobToStr(decryptDataBlob, 'utf-8');
              LogUtil.error(`加解密后: ${decryptMsg}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("加解密，同步")
            .btnStyle()
            .onClick(() => {
              let msg = "harmony-utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。"; //待加密字符串
              let msgDataBlob = CryptoHelper.strToDataBlob(msg, 'utf-8');
              let encryptDataBlob = SM2.encryptSync(msgDataBlob, this.keyPair!.pubKey); //加密
              let decryptDataBlob = SM2.decryptSync(encryptDataBlob, this.keyPair!.priKey); //解密
              let decryptMsg = CryptoHelper.dataBlobToStr(decryptDataBlob, 'utf-8');
              LogUtil.error(`加解密后: ${decryptMsg}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("签名与验签，异步")
            .btnStyle()
            .onClick(async () => {
              let msg = "harmony-utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。";
              let dataBlob = CryptoHelper.strToDataBlob(msg, 'utf-8');
              let signDataBlob =await SM2.sign(dataBlob, this.keyPair!.priKey);
              let signStr = CryptoHelper.dataBlobToStr(signDataBlob, 'hex');
              LogUtil.error(`签名，异步: ${signStr}`);
              let verify = await SM2.verify(dataBlob, signDataBlob, this.keyPair!.pubKey);
              LogUtil.error(`验签，异步: ${verify}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("签名与验签，同步")
            .btnStyle()
            .onClick(() => {
              let msg = "harmony-utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。";
              let dataBlob = CryptoHelper.strToDataBlob(msg, 'utf-8');
              let signDataBlob = SM2.signSync(dataBlob, this.keyPair!.priKey);
              let signStr = CryptoHelper.dataBlobToStr(signDataBlob, 'hex');
              LogUtil.error(`签名，同步: ${signStr}`);
              let verify =  SM2.verifySync(dataBlob, signDataBlob, this.keyPair!.pubKey);
              LogUtil.error(`验签，同步: ${verify}`);
              ToastUtil.showToast("请查看Log日志");
            })

          Button("分段签名与分段验签，异步")
            .btnStyle()
            .onClick(async () => {
              let dataStr = "harmony-utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。gitee地址：https://gitee.com/tongyuyan/harmony-utils。github主页地址：https://github.com/787107497。";
              let data = CryptoHelper.strToUint8Array(dataStr, 'utf-8');
              let signDataBlob = await SM2.signSegment(data, this.keyPair!.priKey);
              let signStr = CryptoHelper.dataBlobToStr(signDataBlob, 'base64');
              LogUtil.error(`分段签名，异步: ${signStr}`);
              let verify = await SM2.verifySegment(data, signDataBlob, this.keyPair!.pubKey);
              LogUtil.error(`分段验签，异步: ${verify}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("分段签名与分段验签，同步")
            .btnStyle()
            .onClick(() => {
              let dataStr = "harmony-utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。gitee地址：https://gitee.com/tongyuyan/harmony-utils。github主页地址：https://github.com/787107497。";
              let data = CryptoHelper.strToUint8Array(dataStr, 'utf-8');
              let signDataBlob = SM2.signSegmentSync(data, this.keyPair!.priKey);
              let signStr = CryptoHelper.dataBlobToStr(signDataBlob, 'base64');
              LogUtil.error(`分段签名，同步: ${signStr}`);
              let verify = SM2.verifySegmentSync(data, signDataBlob, this.keyPair!.pubKey);
              LogUtil.error(`分段验签，同步: ${verify}`);
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