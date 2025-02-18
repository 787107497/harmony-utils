import { DescribeBean } from '../../model/DescribeBean';
import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { AES } from '@pura/harmony-utils/src/main/ets/crypto/AES';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { CryptoHelper, CryptoUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * AES加解密
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
  @State gcmParams?: cryptoFramework.GcmParamsSpec = undefined;
  @State ivParams?: cryptoFramework.IvParamsSpec = undefined;


  @MockSetup
  mock() {
    this.describe = new DescribeBean("AES", "AES加解密");
  }

  aboutToAppear(): void {
    this.gcmParams = CryptoUtil.generateGcmParamsSpec();
    this.ivParams = CryptoUtil.generateIvParamsSpec();
  }


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("生成对称密钥，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let symKey1 = await AES.generateSymKey();
              LogUtil.error(`对称密钥1：${CryptoHelper.dataBlobToStr(symKey1.getEncoded(), 'hex')}`);
              let symKey2 = AES.generateSymKeySync();
              LogUtil.error(`对称密钥2：${CryptoHelper.dataBlobToStr(symKey2.getEncoded(), 'base64')}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("获取转换的对称密钥，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let smyKeyHexStr = "bf77a17b498a6e808048a734f2e992ab452c4c5f1c37f901a5a58f566b6b01d0"; //16进制字符串密钥
              let smyKeyBase64Str = "tlDExo6TzfIGyl36+BNEqR+Xxg83sAlvbzrvr3Seqlk="; //base64符串密钥
              let symKey1 = await CryptoUtil.getConvertSymKey('AES256', smyKeyHexStr, 'hex');
              let symKey2 = CryptoUtil.getConvertSymKeySync('AES256', smyKeyBase64Str, 'base64');
              LogUtil.error(`获取转换的对称密钥拉······`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("加解密（GCM模式），异步/同步")
            .btnStyle()
            .onClick(async () => {
              let smyKeyHexStr = "bf77a17b498a6e808048a734f2e992ab452c4c5f1c37f901a5a58f566b6b01d0"; //16进制字符串密钥
              let symKey = await CryptoUtil.getConvertSymKey('AES256', smyKeyHexStr, 'hex');
              let dataBlob = CryptoHelper.strToDataBlob(this.str1, 'utf-8'); //待加密数据

              let encryptDataBlob1 = await AES.encryptGCM(dataBlob, symKey, this.gcmParams!); //加密
              let decryptDataBlob1 = await AES.decryptGCM(encryptDataBlob1, symKey, this.gcmParams!); //解密
              let decryptStr1 = CryptoHelper.dataBlobToStr(decryptDataBlob1, 'utf-8');
              LogUtil.error(`解密（GCM模式）,异步：${decryptStr1}`);

              let encryptDataBlob2 = AES.encryptGCMSync(dataBlob, symKey, this.gcmParams!); //加密
              let decryptDataBlob2 = AES.decryptGCMSync(encryptDataBlob2, symKey, this.gcmParams!); //解密
              let decryptStr2 = CryptoHelper.dataBlobToStr(decryptDataBlob2, 'utf-8');
              LogUtil.error(`解密（GCM模式）,同步：${decryptStr2}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("加解密（CBC模式），异步/同步")
            .btnStyle()
            .onClick(async () => {
              let smyKeyBase64Str = "tlDExo6TzfIGyl36+BNEqR+Xxg83sAlvbzrvr3Seqlk="; //base64符串密钥
              let symKey = CryptoUtil.getConvertSymKeySync('AES256', smyKeyBase64Str, 'base64');
              let dataBlob = CryptoHelper.strToDataBlob(this.str2, 'utf-8'); //待加密数据

              let encryptDataBlob1 = await AES.encryptCBC(dataBlob, symKey, this.ivParams!); //加密
              let decryptDataBlob1 = await AES.decryptCBC(encryptDataBlob1, symKey, this.ivParams!); //解密
              let decryptStr1 = CryptoHelper.dataBlobToStr(decryptDataBlob1, 'utf-8');
              LogUtil.error(`解密（CBC模式）,异步：${decryptStr1}`);

              let encryptDataBlob2 = AES.encryptCBCSync(dataBlob, symKey, this.ivParams!); //加密
              let decryptDataBlob2 = AES.decryptCBCSync(encryptDataBlob2, symKey, this.ivParams!); //解密
              let decryptStr2 = CryptoHelper.dataBlobToStr(decryptDataBlob2, 'utf-8');
              LogUtil.error(`解密（CBC模式）,同步：${decryptStr2}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("加解密（ECB模式），异步/同步")
            .btnStyle()
            .onClick(async () => {
              let smyKeyBase64Str = "tlDExo6TzfIGyl36+BNEqR+Xxg83sAlvbzrvr3Seqlk="; //base64符串密钥
              let symKey = CryptoUtil.getConvertSymKeySync('AES256', smyKeyBase64Str, 'base64');
              let dataBlob = CryptoHelper.strToDataBlob(this.str1, 'utf-8'); //待加密数据

              let encryptDataBlob1 = await AES.encryptECB(dataBlob, symKey); //加密
              let decryptDataBlob1 = await AES.decryptECB(encryptDataBlob1, symKey); //解密
              let decryptStr1 = CryptoHelper.dataBlobToStr(decryptDataBlob1, 'utf-8');
              LogUtil.error(`解密（ECB模式）,异步：${decryptStr1}`);

              let encryptDataBlob2 = AES.encryptECBSync(dataBlob, symKey); //加密
              let decryptDataBlob2 = AES.decryptECBSync(encryptDataBlob2, symKey); //解密
              let decryptStr2 = CryptoHelper.dataBlobToStr(decryptDataBlob2, 'utf-8');
              LogUtil.error(`解密（ECB模式）,同步：${decryptStr2}`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("分段加解密（GCM模式），异步/同步")
            .btnStyle()
            .onClick(async () => {
              let smyKeyHexStr = "bf77a17b498a6e808048a734f2e992ab452c4c5f1c37f901a5a58f566b6b01d0"; //16进制字符串密钥
              let symKey = await CryptoUtil.getConvertSymKey('AES256', smyKeyHexStr, 'hex');
              let dataBlob = CryptoHelper.strToDataBlob(this.str3, 'utf-8'); //待加密数据

              let encryptDataBlob1 = await AES.encryptGCMSegment(dataBlob, symKey, this.gcmParams!); //加密
              let decryptDataBlob1 = await AES.decryptGCMSegment(encryptDataBlob1, symKey, this.gcmParams!); //解密
              let decryptStr1 = CryptoHelper.dataBlobToStr(decryptDataBlob1, 'utf-8');
              LogUtil.error(`分段解密（GCM模式）,异步：${decryptStr1}`);

              let encryptDataBlob2 = AES.encryptGCMSegmentSync(dataBlob, symKey, this.gcmParams!); //加密
              let decryptDataBlob2 = AES.decryptGCMSegmentSync(encryptDataBlob2, symKey, this.gcmParams!); //解密
              let decryptStr2 = CryptoHelper.dataBlobToStr(decryptDataBlob2, 'utf-8');
              LogUtil.error(`分段解密（GCM模式）,同步：${decryptStr2}`);
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