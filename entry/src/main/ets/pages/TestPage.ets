import { ComposeTitleBar, router } from '@kit.ArkUI';
import { DescribeBean } from '../entity/DescribeBean';
import { MockSetup } from '../../../../oh_modules/@ohos/hamock';

import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { buffer } from '@kit.ArkTS';
import { AES, CryptoHelper, CryptoUtil, LogUtil, StrUtil } from '@pura/harmony-utils';


/**
 * 测试页面
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("Test", "测试页面");
  }

  aboutToAppear(): void {

  }

  genKeyMaterialBlob(): cryptoFramework.DataBlob {
    let arr = [
      0xba, 0x3d, 0xc2, 0x71, 0x21, 0x1e, 0x30, 0x56,
      0xad, 0x47, 0xfc, 0x5a, 0x46, 0x39, 0xee, 0x7c,
      0xba, 0x3b, 0xc2, 0x71, 0xab, 0xa0, 0x30, 0x72]; // 密钥长度为192位，即24字节。
    let keyMaterial = new Uint8Array(arr);
    return { data: keyMaterial };
  }

  // 字符串转成字节流
  stringToUint8Array(str: string) {
    return new Uint8Array(buffer.from(str, 'utf-8').buffer);
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
          Button("测试1")
            .btnStyle()
            .onClick(() => {

              let iv = CryptoUtil.generateIvParamsSpec();
              // let symKey = CryptoUtil.generateSymKeySync("AES256"); //294A2561FEFDF08D
              let symKey = CryptoUtil.getConvertSymKeySync('AES256', 'test', 'utf-8')

              let data = CryptoHelper.strToDataBlob("AES加解密CBC模式！", 'utf-8'); //待加密数据
              let encryptData = AES.encryptCBCSync(data, symKey, iv)
              LogUtil.error("encryptStr: " + CryptoHelper.dataBlobToStr(encryptData, "hex"))

              let decryptData = AES.decryptCBCSync(encryptData, symKey, iv);
              let decryptStr = CryptoHelper.dataBlobToStr(decryptData, "hex")
              LogUtil.error("decryptStr: " + decryptStr);
              LogUtil.error("解密后的数据： " + CryptoHelper.uint8ArrayToString1(decryptData.data));


            })
          Button("测试2")
            .btnStyle()
            .onClick(() => {


            })
          Button("测试3")
            .btnStyle()
            .onClick(() => {


            })
          Text().layoutWeight(1)
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