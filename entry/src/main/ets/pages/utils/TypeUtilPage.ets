import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, ToastUtil, TypeUtil } from '@pura/harmony-utils';
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

  aboutToAppear(): void {

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
              let bl1 = TypeUtil.isBoolean(true);
              let bl2 = TypeUtil.isBoolean("true");
              let num1 = TypeUtil.isNumber(188);
              let num2 = TypeUtil.isNumber("188");
              let str1 = TypeUtil.isString("哈哈");
              let str2 = TypeUtil.isString(null);
              let obj1 = TypeUtil.isObject(new User());
              let obj2 = TypeUtil.isObject("Object");
              let resultStr = `bl1：${bl1}\nbl2：${bl2}\n\nnum1：${num1}\nnum2：${num2}\n\nstr1：${str1}\nstr2：${str2}\n\nobj1：${obj1}\nobj2：${obj2}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("isArray()")
            .btnStyle()
            .onClick(() => {
              let array: string[] = ["黑龙江省", "哈尔滨市", "道里区", "砂山", "砀山", "高薪区"];
              let isArray1 = TypeUtil.isArray(array);
              let isArray2 = TypeUtil.isArray([]);
              let isArray3 = TypeUtil.isArray("哈哈哈");
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
              let bl1 = TypeUtil.isResource($r('app.string.app_name'));
              let bl2 = TypeUtil.isResource("哈哈哈");
              let bl3 = TypeUtil.isResource(new User());
              let bl4 = TypeUtil.isResource(null);
              let bl5 = TypeUtil.isResourceStr($r('app.string.app_name'));
              let bl6 = TypeUtil.isResourceStr("哈哈哈");
              let bl7 = TypeUtil.isResourceStr(undefined);
              let resultStr = `bl1：${bl1}\nbl2：${bl2}\nbl3：${bl3}\nbl4：${bl4}\n\nbl5：${bl5}\nbl6：${bl6}\nbl7：${bl7}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("isMap()\nisWeakMap()\nisSet()\nisWeakSet()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let map = new Map<string, object>();
              let weakMap: WeakMap<object, number> = new WeakMap();
              let set: Set<number> = new Set();
              let weakSet = new WeakSet();
              let isMap = TypeUtil.isMap(map);
              let isWeakMap = TypeUtil.isWeakMap(weakMap);
              let isSet = TypeUtil.isSet(set);
              let isWeakSet = TypeUtil.isWeakSet(weakSet);
              let resultStr = `isMap: ${isMap}\n\nisWeakMap: ${isWeakMap}\n\nisSet: ${isSet}\n\nisWeakSet: ${isWeakSet}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("isDate()")
            .btnStyle()
            .onClick(() => {
              let isDate = TypeUtil.isDate(new Date());
              LogUtil.error(`isDate: ${isDate}`);
              ToastUtil.showToast(`isDate: ${isDate}`);
            })
          Button("isArrayBuffer()\nisSharedArrayBuffer()\nisAnyArrayBuffer()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let isArrayBuffer = TypeUtil.isArrayBuffer(new ArrayBuffer(0));
              let isSharedArrayBuffer = TypeUtil.isSharedArrayBuffer(new SharedArrayBuffer(0));
              let isAnyArrayBuffer = TypeUtil.isAnyArrayBuffer(new ArrayBuffer(0));
              let resultStr = `isArrayBuffer: ${isArrayBuffer}\n\nisSharedArrayBuffer: ${isSharedArrayBuffer}\n\nisAnyArrayBuffer: ${isAnyArrayBuffer}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("isUint8Array()\nisUint16Array()\nisUint32Array()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let isUint8Array = TypeUtil.isUint8Array(new Uint8Array([]));
              let isUint16Array = TypeUtil.isUint16Array(new Uint16Array([]));
              let isUint32Array = TypeUtil.isUint32Array(new Uint32Array([]));
              let resultStr = `isUint8Array: ${isUint8Array}\n\nisUint16Array: ${isUint16Array}\n\nisUint32Array: ${isUint32Array}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("isInt8Array()\nisInt16Array()\nisInt32Array()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let isInt8Array = TypeUtil.isInt8Array(new Int8Array([]));
              let isInt16Array = TypeUtil.isInt16Array(new Int16Array([]));
              let isInt32Array = TypeUtil.isInt32Array(new Int32Array([]));
              let resultStr = `isInt8Array: ${isInt8Array}\n\nisInt16Array: ${isInt16Array}\n\nisInt32Array: ${isInt32Array}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("isTypedArray()")
            .btnStyle()
            .onClick(() => {
              let isTypedArray = TypeUtil.isTypedArray(new Float64Array([]));
              LogUtil.error(`isTypedArray: ${isTypedArray}`);
              ToastUtil.showToast(`isTypedArray: ${isTypedArray}`);
            })
          Button("isFunction()\nisAsyncFunction()\nisPromise()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let isFunction = TypeUtil.isFunction(this.aboutToAppear);
              let isAsyncFunction = TypeUtil.isAsyncFunction(this.aboutToAppear);
              let isPromise = TypeUtil.isPromise(Promise.resolve(1));
              let resultStr = `isFunction: ${isFunction}\n\nisAsyncFunction: ${isAsyncFunction}\n\nisPromise: ${isPromise}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("isProxy()\nisRegExp()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let user = new User();
              const proxy = new Proxy(user, user as ProxyHandler<User>);
              let isProxy = TypeUtil.isProxy(proxy);
              let isRegExp = TypeUtil.isRegExp(new RegExp('abc'));
              let resultStr = `isProxy: ${isProxy}\n\nisRegExp: ${isRegExp}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("isDataView()")
            .btnStyle()
            .onClick(() => {
              let dataView = new DataView(new ArrayBuffer(20));
              let isDataView = TypeUtil.isDataView(dataView);
              LogUtil.error(`isDataView: ${isDataView}`);
              ToastUtil.showToast(`isDataView: ${isDataView}`);
            })
          Button("isExternal()\nisNativeError()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let isNativeError1 = TypeUtil.isNativeError(new TypeError());
              let isNativeError2 = TypeUtil.isNativeError(new URIError());
              let isNativeError3 = TypeUtil.isNativeError("");
              let resultStr = `isNativeError1: ${isNativeError1}\n\nisNativeError2: ${isNativeError2}\n\nisNativeError3: ${isNativeError3}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
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