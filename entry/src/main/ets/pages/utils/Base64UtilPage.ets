import { ComposeTitleBar, router } from '@kit.ArkUI';
import { Base64Util, LogUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * Base64工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  aboutToAppear(): void {

  }

  onBackPress(): boolean {
    return false;
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
          Button("encodeSync()\nencodeToStrSync()\ndecodeSync()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let unit8Array = StrUtil.strToUint8Array("我是甜啦啦");
              let unit8Array1 = Base64Util.encodeSync(unit8Array);
              LogUtil.error(`unit8Array1: ${unit8Array1}`)
              let str = Base64Util.encodeToStrSync(unit8Array);
              LogUtil.error(`str: ${str}`)
              let unit8Array2 = Base64Util.decodeSync(str);
              LogUtil.error(`unit8Array2: ${unit8Array2}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("encode()\nencodeToStr()\ndecode()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let unit8Array = StrUtil.strToUint8Array("我是甜啦啦");
              let unit8Array1 = await Base64Util.encode(unit8Array);
              LogUtil.error(`unit8Array1S: ${unit8Array1}`)
              let str = await Base64Util.encodeToStr(unit8Array);
              LogUtil.error(`strS: ${str}`)
              let unit8Array2 = await Base64Util.decode(unit8Array1);
              LogUtil.error(`unit8Array2S: ${unit8Array2}`)
              ToastUtil.showToast("请查看Log日志")
            })

          Text('').layoutWeight(1)
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
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}