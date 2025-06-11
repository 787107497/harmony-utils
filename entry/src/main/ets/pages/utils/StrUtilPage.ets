import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { FileUtil, LogUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { BusinessError } from '@kit.BasicServicesKit';
import { Utils } from '../../utils/Utils';

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
      TitleBarView({ describe: this.describe })
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
              let bl1 = StrUtil.isNull(str1);
              let bn1 = StrUtil.isNotNull(str1);
              let bl2 = StrUtil.isNull(str2);
              let bn2 = StrUtil.isNotNull(str2);
              let bl3 = StrUtil.isNull(str3);
              let bn3 = StrUtil.isNotNull(str3);
              let str = `bl0: ${bl0} \t\t\t bn0: ${bn0}\nbl1: ${bl1} \t\t\t bn1: ${bn1}\nbl2: ${bl2} \t\t\t bn2: ${bn2}\nbl3: ${bl3} \t\t\t bn3: ${bn3}`;
              LogUtil.error(str);
              Utils.showSheetText(str);
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
              let bl1 = StrUtil.isEmpty(str1);
              let bn1 = StrUtil.isNotEmpty(str1);
              let bl2 = StrUtil.isEmpty(str2);
              let bn2 = StrUtil.isNotEmpty(str2);
              let bl3 = StrUtil.isEmpty(str3);
              let bn3 = StrUtil.isNotEmpty(str3);
              let str = `bl0: ${bl0} \t\t\t bn0: ${bn0}\nbl1: ${bl1} \t\t\t bn1: ${bn1}\nbl2: ${bl2} \t\t\t bn2: ${bn2}\nbl3: ${bl3} \t\t\t bn3: ${bn3}`;
              LogUtil.error(str);
              Utils.showSheetText(str);
            })
          Button("isBlank()\nisNotBlank()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str0 = '\t\n  ';
              let str1 = '      ';
              let str2 = " \t \t ";
              let str3 = " 哈 哈 ";
              let bl0 = StrUtil.isBlank(str0);
              let bn0 = StrUtil.isNotBlank(str0);
              let bl1 = StrUtil.isBlank(str1);
              let bn1 = StrUtil.isNotBlank(str1);
              let bl2 = StrUtil.isBlank(str2);
              let bn2 = StrUtil.isNotBlank(str2);
              let bl3 = StrUtil.isBlank(str3);
              let bn3 = StrUtil.isNotBlank(str3);
              let str = `bl0: ${bl0} \t\t\t bn0: ${bn0}\nbl1: ${bl1} \t\t\t bn1: ${bn1}\nbl2: ${bl2} \t\t\t bn2: ${bn2}\nbl3: ${bl3} \t\t\t bn3: ${bn3}`;
              LogUtil.error(str);
              Utils.showSheetText(str);
            })
          Button("trim()\ntrimAll()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(()=>{
              let str1 = " 　 H e llo  　 World \t ";
              let str2 = "   呵呵\n嘿\t嘿   哈哈 ";
              let txtStr = `str1:\n${str1}\ntrim后：\n${StrUtil.trim(str1)}\ntrimAll后：\n${StrUtil.trimAll(str1)}\n\n\nstr2:\n${str2}\ntrim后：\n${StrUtil.trim(str2)}\ntrimAll后：\n${StrUtil.trimAll(str2)}`;
              Utils.showSheetText(txtStr);
            })
          Button("toStr")
            .btnStyle()
            .onClick(()=>{
              let num = StrUtil.toStr(1000);
              let bl = StrUtil.toStr(true);
              let str1 = StrUtil.toStr(undefined);
              let str2 = StrUtil.toStr(null);
              let str3 = StrUtil.toStr("成功了！");
              LogUtil.error(`${num}\n${bl}\n${str1}\n${str2}\n${str3}`);
              Utils.showSheetText(`${num}\n${bl}\n${str1}\n${str2}\n${str3}`);
            })
          Button("startsWith()\nendsWith()\nreplace()\nrepeat()\nreplaceAll()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let str1 = "大聪明是一个好人,DSB也是一个好人";
              let str2 = "千秋万代";
              let startsWith = StrUtil.startsWith(str1, "大聪明");
              let endsWith = StrUtil.endsWith(str1, "好人");
              let str = StrUtil.replace(str1, "阿超", "张三");
              let strs = StrUtil.repeat(str2, 6);
              let strAll = StrUtil.replaceAll(str1, "好人", " HAO-REN ");
              LogUtil.error(`startsWith: ${startsWith}\nendsWith: ${endsWith}\nstr: ${str}\nstrs: ${strs}`);
              LogUtil.error(`replaceAll: ${strAll}`);
              Utils.showSheetText(`startsWith: ${startsWith}\nendsWith: ${endsWith}\nstr: ${str}\nstrs: ${strs}\n\nreplaceAll: ${strAll}`);
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
              Utils.showSheetText(`str1: ${str1}\nstr2: ${str2}\nstr3: ${str3}`);
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
              LogUtil.error(`bl1: ${bl1}\nbl2: ${bl2}\nbl3: ${bl3}`);
              LogUtil.error(`bl4: ${bl4}\nbl5: ${bl5}\nbl6: ${bl6}`);
              Utils.showSheetText(`bl1: ${bl1}\nbl2: ${bl2}\nbl3: ${bl3}\n\nbl4: ${bl4}\nbl5: ${bl5}\nbl6: ${bl6}`);
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
              Utils.showSheetText(`unit8Array: ${unit8Array}\n\nstr: ${str}`);
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
              Utils.showSheetText(`base64Str: ${base64Str}\n\nstr: ${str}`);
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
              LogUtil.error(`str: ${str}`);
              Utils.showSheetText(`buff: ${buff.byteLength}\n\nstr: ${str}`);
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
              LogUtil.error(`buff1: ${buff1.byteLength}`);
              let unit8Array = StrUtil.bufferToUint8Array(buff1);
              LogUtil.error(`unit8Array: ${unit8Array}`);
              let buff = StrUtil.unit8ArrayToBuffer(unit8Array);
              LogUtil.error(`buff: ${buff.byteLength}`);
              Utils.showSheetText(`buff1: ${buff1.byteLength}\n\nunit8Array: ${unit8Array}\n\nbuff: ${buff.byteLength}`);
            })
          Button("getErrorStr()")
            .btnStyle()
            .onClick(() => {
              let error = new Error("未知异常！");
              let errorStr = StrUtil.getErrorStr(error as BusinessError);
              try {
                let path = 'null';
                FileUtil.openSync(path);
              } catch (err) {
                let errStr = StrUtil.getErrorStr(err);
                Utils.showSheetText(`${errorStr}\n\n${errStr}`);
              }
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
              Utils.showSheetText(`错误码1: ${errStr1}\n\n错误码2: ${errStr2}`);
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