import { ComposeTitleBar, router } from '@kit.ArkUI';
import { DescribeBean } from '../entity/DescribeBean';
import { MockSetup } from '../../../../oh_modules/@ohos/hamock';
import { CryptoHelper, CryptoUtil, LogUtil, MD5, SHA, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { BusinessError } from '@kit.BasicServicesKit';
import { hash } from '@kit.CoreFileKit';

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
              let dataStr = "123456-哈哈！";

              let str1 = MD5.digestSync(dataStr);
              LogUtil.error("str1: " + str1);

              let str2 = MD5.digestSync(dataStr,'base64');
              LogUtil.error("str2: " + str2);

              let str3 = StrUtil.strToBase64(dataStr);
              LogUtil.error("str3: " + str3);

              let str4 = SHA.digestSync(dataStr, 'SHA1');
              LogUtil.error("str4: " + str4);

              let str5 = SHA.digestSync(dataStr, 'SHA256');
              LogUtil.error("str5: " + str5);

              let str6 = SHA.digestSync(dataStr, 'SHA512');
              LogUtil.error("str6: " + str6);

              let symKey = CryptoUtil.generateSymKeySync("SM4_128");
              let data = symKey.getEncoded().data;
              LogUtil.error("symKey1: "+data);
              LogUtil.error("symKey21: "+CryptoHelper.uint8ArrayToStr(data,'hex'))
              LogUtil.error("symKey22: "+CryptoHelper.uint8ArrayToStr(data,'base64'))
              LogUtil.error("symKey23: "+CryptoHelper.uint8ArrayToStr(data,'utf-8'))

            })
          Button("测试2")
            .btnStyle()
            .onClick(() => {
              let dataStr1 = "123456-哈哈！";
              let dataStr2 = 'MTIz';
              let dataStr3 = "MTIzNDU2LeWTiOWTiO+8gQ==";

              let arr1 = CryptoHelper.strToUint8Array(dataStr1, 'utf-8');
              let str1 = CryptoHelper.uint8ArrayToStr(arr1, 'utf-8');
              LogUtil.error("str1: " + str1);

              let arr2 = CryptoHelper.strToUint8Array(dataStr2, 'base64');
              let str2= CryptoHelper.uint8ArrayToStr(arr2, 'base64');
              LogUtil.error("str2: " + str2);

              let arr3 = CryptoHelper.strToUint8Array(dataStr3, 'base64');
              let str3 = CryptoHelper.uint8ArrayToStr(arr3, 'base64');
              LogUtil.error("str3: " + str3);

              let arr4 = CryptoHelper.strToUint8Array(dataStr3,"utf-8");
              LogUtil.error("arr4: " + arr4);
              let str4 = CryptoHelper.uint8ArrayToStr(arr4,'utf-8');
              LogUtil.error("str4: " + str4);

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