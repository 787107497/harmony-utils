import { ComposeTitleBar, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 字符串工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("StrUtil", "字符串工具类");
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
          Button("isNull()\nisNotNull()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str0 = '哈哈哈哈';
              let str1 = '';
              let str2 = null;
              let str3 = undefined;
              let bl0 = StrUtil.isNull(str0);
              let bn0 = StrUtil.isNotNull(str0);
              LogUtil.error(`bl0: ${bl0}  bn0: ${bn0}`)
              let bl1 = StrUtil.isNull(str1);
              let bn1 = StrUtil.isNotNull(str1);
              LogUtil.error(`bl1: ${bl1}  bn1: ${bn1}`)
              let bl2 = StrUtil.isNull(str2);
              let bn2 = StrUtil.isNotNull(str2);
              LogUtil.error(`bl2: ${bl2}  bn2: ${bn2}`)
              let bl3 = StrUtil.isNull(str3);
              let bn3 = StrUtil.isNotNull(str3);
              LogUtil.error(`bl3: ${bl3}  bn3: ${bn3}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("isEmpty()\nisNotEmpty()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str0 = '哈哈哈哈';
              let str1 = '';
              let str2 = null;
              let str3 = undefined;
              let bl0 = StrUtil.isEmpty(str0);
              let bn0 = StrUtil.isNotEmpty(str0);
              LogUtil.error(`bl0: ${bl0}  bn0: ${bn0}`)
              let bl1 = StrUtil.isEmpty(str1);
              let bn1 = StrUtil.isNotEmpty(str1);
              LogUtil.error(`bl1: ${bl1}  bn1: ${bn1}`)
              let bl2 = StrUtil.isEmpty(str2);
              let bn2 = StrUtil.isNotEmpty(str2);
              LogUtil.error(`bl2: ${bl2}  bn2: ${bn2}`)
              let bl3 = StrUtil.isEmpty(str3);
              let bn3 = StrUtil.isNotEmpty(str3);
              LogUtil.error(`bl3: ${bl3}  bn3: ${bn3}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("startsWith()\nendsWith()\nreplace()\nrepeat()\nreplaceAll()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str1 = "阿超是一个好人,小阿超也是一个好人";
              let str2 = "千秋万代";
              let startsWith = StrUtil.startsWith(str1, "阿超");
              let endsWith = StrUtil.endsWith(str1, "好人");
              let str = StrUtil.replace(str1, "阿超", "张三");
              let strs = StrUtil.repeat(str2, 6);
              let strAll = StrUtil.replaceAll(str1, "好人", " HAO-REN ");
              LogUtil.error(`startsWith: ${startsWith}\nendsWith: ${endsWith}\nstr: ${str}\nstrs: ${strs}`)
              LogUtil.error(`replaceAll: ${strAll}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("toLower()\ntoUpper()\ncapitalize()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str = "anima,For generations to come, Forever Immortal,IT is SB";
              let str1 = StrUtil.toLower(str);
              let str2 = StrUtil.toUpper(str);
              let str3 = StrUtil.capitalize(str);
              LogUtil.error(`str1: ${str1}\nstr2: ${str2}\nstr3: ${str3}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("equal()\nnotEqual()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let bl1 = StrUtil.equal("ASX1", "ASX1");
              let bl2 = StrUtil.equal("ASX1", "AS1");
              let bl3 = StrUtil.notEqual("AS1", "ASX1");
              let bl4 = StrUtil.equal(26, 26);
              let bl5 = StrUtil.equal(26, 29);
              let bl6 = StrUtil.notEqual(22, 32);
              LogUtil.error(`bl1: ${bl1}\nbl2: ${bl2}\nbl3: ${bl3}`)
              LogUtil.error(`bl4: ${bl4}\nbl5: ${bl5}\nbl6: ${bl6}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("strToUint8Array()\nunit8ArrayToStr()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str1 = "我是笑哈哈";
              let unit8Array = StrUtil.strToUint8Array(str1);
              LogUtil.error(`unit8Array: ${unit8Array}`)
              let str = StrUtil.unit8ArrayToStr(unit8Array);
              LogUtil.error(`str: ${str}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("strToBase64()\nbase64ToStr()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str1 = "我是笑面虎";
              let base64Str = StrUtil.strToBase64(str1);
              LogUtil.error(`base64Str: ${base64Str}`)
              let str = StrUtil.base64ToStr(base64Str);
              LogUtil.error(`str: ${str}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("strToBuffer()\nbufferToStr()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str1 = "我是乐哈哈";
              let buff = StrUtil.strToBuffer(str1);
              LogUtil.error(`buff: ${buff.byteLength}`)
              let str = StrUtil.bufferToStr(buff);
              LogUtil.error(`str: ${str}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("bufferToUint8Array()\nunit8ArrayToBuffer()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str1 = "我是甜啦啦";
              let buff1 = StrUtil.strToBuffer(str1);
              LogUtil.error(`buff1: ${buff1.byteLength}`)
              let unit8Array = StrUtil.bufferToUint8Array(buff1)
              LogUtil.error(`unit8Array: ${unit8Array}`)
              let buff = StrUtil.unit8ArrayToBuffer(unit8Array);
              LogUtil.error(`buff: ${buff.byteLength}`)
              ToastUtil.showToast("请查看Log日志")
            })

          Button("getErrnoToString()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let errStr1 = StrUtil.getErrnoToString(202);
              let errStr2 = StrUtil.getErrnoToString(1600004);
              LogUtil.error(`错误码1: ${errStr1}`);
              LogUtil.error(`错误码2: ${errStr2}`);
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
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}