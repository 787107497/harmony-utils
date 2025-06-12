import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { FormatUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { User } from '../../model/User';
import { Utils } from '../../utils/Utils';

/**
 * 格式化工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("FormatUtil", "格式化工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("isBoolean()\nisNumber()\nisString()\nisObject()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let bl1 = FormatUtil.isBoolean(true);
              let bl2 = FormatUtil.isBoolean("true");
              let num1 = FormatUtil.isNumber(188);
              let num2 = FormatUtil.isNumber("188");
              let str1 = FormatUtil.isString("哈哈");
              let str2 = FormatUtil.isString(null);
              let obj1 = FormatUtil.isObject(new User());
              let obj2 = FormatUtil.isObject("Object");
              let resultStr = `bl1：${bl1}\nbl2：${bl2}\n\nnum1：${num1}\nnum2：${num2}\n\nstr1：${str1}\nstr2：${str2}\n\nobj1：${obj1}\nobj2：${obj2}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("isArray()")
            .btnStyle()
            .onClick(() => {
              let array: string[] = ["黑龙江省", "哈尔滨市", "道里区", "砂山", "砀山", "高薪区"];
              let isArray1 = FormatUtil.isArray(array);
              let isArray2 = FormatUtil.isArray([]);
              let isArray3 = FormatUtil.isArray("哈哈哈");
              let resultStr = `isArray1：${isArray1}\n\nisArray2：${isArray2}\n\nisArray3：${isArray3}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("isResource()\nisResourceStr()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let bl1 = FormatUtil.isResource($r('app.string.app_name'));
              let bl2 = FormatUtil.isResource("哈哈哈");
              let bl3 = FormatUtil.isResource(new User());
              let bl4 = FormatUtil.isResource(null);
              let bl5 = FormatUtil.isResourceStr($r('app.string.app_name'));
              let bl6 = FormatUtil.isResourceStr("哈哈哈");
              let bl7 = FormatUtil.isResourceStr(undefined);
              let resultStr = `bl1：${bl1}\nbl2：${bl2}\nbl3：${bl3}\nbl4：${bl4}\n\nbl5：${bl5}\nbl6：${bl6}\nbl7：${bl7}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("isPhone()\ngetPhoneFormat()\ngetPhoneLocationName()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let phone: string = "18969062528";
              let bl = FormatUtil.isPhone(phone);
              let format = FormatUtil.getPhoneFormat(phone);
              let locationName = FormatUtil.getPhoneLocationName(phone);
              let resultStr = `isPhone: ${bl}\n\ngetPhoneFormat: ${format}\n\ngetPhoneLocationName: ${locationName}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("transliterator()")
            .btnStyle()
            .onClick(() => {
              let str = FormatUtil.transliterator("中国");
              LogUtil.error(`transliterator: ${str}`);
              ToastUtil.showToast(`transliterator: ${str}`);
            })
          Button("getIconFont()")
            .btnStyle()
            .onClick(() => {
              let str = FormatUtil.getIconFont("e631");
              LogUtil.error(`getIconFont: ${str}`);
              ToastUtil.showToast(`getIconFont: ${str}`);
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