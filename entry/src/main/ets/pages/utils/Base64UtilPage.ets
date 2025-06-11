import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { Base64Util, LogUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { Utils } from '../../utils/Utils';

/**
 * Base64工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("Base64Util", "Base64工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("encodeSync()\nencodeToStrSync()\ndecodeSync()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let unit8Array = StrUtil.strToUint8Array("我是甜啦啦");
              let unit8Array1 = Base64Util.encodeSync(unit8Array);
              LogUtil.error(`unit8Array1: ${unit8Array1}`);
              let str = Base64Util.encodeToStrSync(unit8Array);
              LogUtil.error(`str: ${str}`);
              let unit8Array2 = Base64Util.decodeSync(str);
              LogUtil.error(`unit8Array2: ${unit8Array2}`);
              Utils.showSheetText(`unit8Array1: ${unit8Array1}\n\nstr: ${str}\n\nunit8Array2: ${unit8Array2}`);
            })
          Button("encode()\nencodeToStr()\ndecode()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let unit8Array = StrUtil.strToUint8Array("我是甜啦啦!");
              let unit8Array1 = await Base64Util.encode(unit8Array);
              LogUtil.error(`unit8Array1: ${unit8Array1}`);
              let str = await Base64Util.encodeToStr(unit8Array);
              LogUtil.error(`str: ${str}`);
              let unit8Array2 = await Base64Util.decode(unit8Array1);
              LogUtil.error(`unit8Array2: ${unit8Array2}`);
              let str2 = StrUtil.unit8ArrayToStr(unit8Array2);
              Utils.showSheetText(`unit8Array1: ${unit8Array1}\n\nstr: ${str}\n\nunit8Array2: ${unit8Array2}\n\nstr2: ${str2}`);
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
