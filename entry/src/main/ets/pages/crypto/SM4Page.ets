import { DescribeBean } from '../../model/DescribeBean';
import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { SM4 } from '@pura/harmony-utils/src/main/ets/crypto/SM4';
import { CryptoHelper, CryptoUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { TitleBarView } from '../../component/TitleBarView';
import { Utils } from '../../utils/Utils';

/**
 * SM4加解密
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
  @State gcmParams?: cryptoFramework.GcmParamsSpec = undefined;
  @State ivParams?: cryptoFramework.IvParamsSpec = undefined;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("SM4", "SM4加解密");
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
              let symKey1 = await SM4.generateSymKey();
              let symKeyStr1 = CryptoHelper.dataBlobToStr(symKey1.getEncoded(), 'hex');
              LogUtil.error(`对称密钥1：${symKeyStr1}`);
              let symKey2 = SM4.generateSymKeySync();
              let symKeyStr2 = CryptoHelper.dataBlobToStr(symKey2.getEncoded(), 'base64');
              LogUtil.error(`对称密钥2：${symKeyStr2}`);
              Utils.showSheetText(`对称密钥1：${symKeyStr1}\n\n对称密钥2：${symKeyStr2}`);
            })
          Button("获取转换的对称密钥，异步/同步")
            .btnStyle()
            .onClick(async () => {
              let smyKeyHexStr = "da4eed5a22f8883e2339c0b563161c38"; //16进制字符串密钥
              let smyKeyBase64Str = "2k7tWiL4iD4jOcC1YxYcOA=="; //base64符串密钥
              let symKey1 = await CryptoUtil.getConvertSymKey('SM4_128', smyKeyHexStr, 'hex');
              let symKey2 = CryptoUtil.getConvertSymKeySync('SM4_128', smyKeyBase64Str, 'base64');
              LogUtil.error(`获取转换的对称密钥拉！！！`);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("加解密（GCM模式），异步/同步")
            .btnStyle()
            .onClick(async () => {
              let smyKeyHexStr = "da4eed5a22f8883e2339c0b563161c38"; //16进制字符串密钥
              let symKey = await CryptoUtil.getConvertSymKey('SM4_128', smyKeyHexStr, 'hex');
              let dataBlob = CryptoHelper.strToDataBlob(this.str1, 'utf-8'); //待加密数据

              let encryptDataBlob1 = await SM4.encryptGCM(dataBlob, symKey, this.gcmParams!); //加密
              let encryptStr1 = CryptoHelper.dataBlobToStr(encryptDataBlob1, 'utf-8');
              LogUtil.error(`加密（GCM模式）,异步：${encryptStr1}`);
              let decryptDataBlob1 = await SM4.decryptGCM(encryptDataBlob1, symKey, this.gcmParams!); //解密
              let decryptStr1 = CryptoHelper.dataBlobToStr(decryptDataBlob1, 'utf-8');
              LogUtil.error(`解密（GCM模式）,异步：${decryptStr1}`);

              let encryptDataBlob2 = SM4.encryptGCMSync(dataBlob, symKey, this.gcmParams!); //加密
              let encryptStr2 = CryptoHelper.dataBlobToStr(encryptDataBlob2, 'utf-8');
              LogUtil.error(`加密（GCM模式）,同步：${encryptStr2}`);
              let decryptDataBlob2 = SM4.decryptGCMSync(encryptDataBlob2, symKey, this.gcmParams!); //解密
              let decryptStr2 = CryptoHelper.dataBlobToStr(decryptDataBlob2, 'utf-8');
              LogUtil.error(`解密（GCM模式）,同步：${decryptStr2}`);
              Utils.showSheetText(`加密（GCM模式）,异步：${encryptStr1}\n\n解密（GCM模式）,异步：${decryptStr1}\n\n加密（GCM模式）,同步：${encryptStr2}\n\n解密（GCM模式）,同步：${decryptStr2}`);
            })
          Button("加解密（CBC模式），异步/同步")
            .btnStyle()
            .onClick(async () => {
              let smyKeyBase64Str = "2k7tWiL4iD4jOcC1YxYcOA=="; //base64符串密钥
              let symKey = CryptoUtil.getConvertSymKeySync('SM4_128', smyKeyBase64Str, 'base64');
              let dataBlob = CryptoHelper.strToDataBlob(this.str2, 'utf-8'); //待加密数据

              let encryptDataBlob1 = await SM4.encryptCBC(dataBlob, symKey, this.ivParams!); //加密
              let encryptStr1 = CryptoHelper.dataBlobToStr(encryptDataBlob1, 'utf-8');
              LogUtil.error(`加密（CBC模式）,异步：${encryptStr1}`);
              let decryptDataBlob1 = await SM4.decryptCBC(encryptDataBlob1, symKey, this.ivParams!); //解密
              let decryptStr1 = CryptoHelper.dataBlobToStr(decryptDataBlob1, 'utf-8');
              LogUtil.error(`解密（CBC模式）,异步：${decryptStr1}`);

              let encryptDataBlob2 = SM4.encryptCBCSync(dataBlob, symKey, this.ivParams!); //加密
              let encryptStr2 = CryptoHelper.dataBlobToStr(encryptDataBlob2, 'utf-8');
              LogUtil.error(`加密（CBC模式）,同步：${encryptStr2}`);
              let decryptDataBlob2 = SM4.decryptCBCSync(encryptDataBlob2, symKey, this.ivParams!); //解密
              let decryptStr2 = CryptoHelper.dataBlobToStr(decryptDataBlob2, 'utf-8');
              LogUtil.error(`解密（CBC模式）,同步：${decryptStr2}`);
              Utils.showSheetText(`加密（CBC模式）,异步：${encryptStr1}\n\n解密（CBC模式）,异步：${decryptStr1}\n\n加密（CBC模式）,同步：${encryptStr2}\n\n解密（CBC模式）,同步：${decryptStr2}`);
            })
          Button("加解密（ECB模式），异步/同步")
            .btnStyle()
            .onClick(async () => {
              let smyKeyBase64Str = "2k7tWiL4iD4jOcC1YxYcOA=="; //base64符串密钥
              let symKey = CryptoUtil.getConvertSymKeySync('SM4_128', smyKeyBase64Str, 'base64');
              let dataBlob = CryptoHelper.strToDataBlob(this.str1, 'utf-8'); //待加密数据

              let encryptDataBlob1 = await SM4.encryptECB(dataBlob, symKey); //加密
              let encryptStr1 = CryptoHelper.dataBlobToStr(encryptDataBlob1, 'utf-8');
              LogUtil.error(`加密（ECB模式）,异步：${encryptStr1}`);
              let decryptDataBlob1 = await SM4.decryptECB(encryptDataBlob1, symKey); //解密
              let decryptStr1 = CryptoHelper.dataBlobToStr(decryptDataBlob1, 'utf-8');
              LogUtil.error(`解密（ECB模式）,异步：${decryptStr1}`);

              let encryptDataBlob2 = SM4.encryptECBSync(dataBlob, symKey); //加密
              let encryptStr2 = CryptoHelper.dataBlobToStr(encryptDataBlob2, 'utf-8');
              LogUtil.error(`加密（ECB模式）,同步：${encryptStr2}`);
              let decryptDataBlob2 = SM4.decryptECBSync(encryptDataBlob2, symKey); //解密
              let decryptStr2 = CryptoHelper.dataBlobToStr(decryptDataBlob2, 'utf-8');
              LogUtil.error(`解密（ECB模式）,同步：${decryptStr2}`);
              Utils.showSheetText(`加密（ECB模式）,异步：${encryptStr1}\n\n解密（ECB模式）,异步：${decryptStr1}\n\n加密（ECB模式）,同步：${encryptStr2}\n\n解密（ECB模式）,同步：${decryptStr2}`);
            })
          Button("分段加解密（GCM模式），异步/同步")
            .btnStyle()
            .onClick(async () => {
              let smyKeyHexStr = "da4eed5a22f8883e2339c0b563161c38"; //16进制字符串密钥
              let symKey = await CryptoUtil.getConvertSymKey('SM4_128', smyKeyHexStr, 'hex');
              let dataBlob = CryptoHelper.strToDataBlob(this.str3, 'utf-8'); //待加密数据

              let encryptDataBlob1 = await SM4.encryptGCMSegment(dataBlob, symKey, this.gcmParams!); //加密
              let encryptStr1 = CryptoHelper.dataBlobToStr(encryptDataBlob1, 'utf-8');
              LogUtil.error(`分段加密（GCM模式）,异步：${encryptStr1}`);
              let decryptDataBlob1 = await SM4.decryptGCMSegment(encryptDataBlob1, symKey, this.gcmParams!); //解密
              let decryptStr1 = CryptoHelper.dataBlobToStr(decryptDataBlob1, 'utf-8');
              LogUtil.error(`分段解密（GCM模式）,异步：${decryptStr1}`);

              let encryptDataBlob2 = SM4.encryptGCMSegmentSync(dataBlob, symKey, this.gcmParams!); //加密
              let encryptStr2 = CryptoHelper.dataBlobToStr(encryptDataBlob2, 'utf-8');
              LogUtil.error(`分段加密（GCM模式）,同步：${encryptStr2}`);
              let decryptDataBlob2 = SM4.decryptGCMSegmentSync(encryptDataBlob2, symKey, this.gcmParams!); //解密
              let decryptStr2 = CryptoHelper.dataBlobToStr(decryptDataBlob2, 'utf-8');
              LogUtil.error(`分段解密（GCM模式）,同步：${decryptStr2}`);
              Utils.showSheetText(`分段加密（GCM模式）,异步：${encryptStr1}\n\n分段解密（GCM模式）,异步：${decryptStr1}\n\n分段加密（GCM模式）,同步：${encryptStr2}\n\n分段解密（GCM模式）,同步：${decryptStr2}`);
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
