import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { AppUtil, FileUtil, ImageUtil, LogUtil, ResUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { JSON } from '@kit.ArkTS';
import { TitleBarView } from '../../component/TitleBarView';
import { Utils } from '../../utils/Utils';

/**
 * 资源工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("ResUtil", "资源工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("getBoolean()\ngetBooleanByName()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let b1 = ResUtil.getBoolean($r('app.boolean.bl_debug'));
              let b2 = ResUtil.getBoolean($r('app.boolean.bl_debug').id);
              let b3 = ResUtil.getBoolean($r('app.boolean.bl_agree').id);
              let b4 = ResUtil.getBooleanByName('bl_agree');
              let b5 = ResUtil.getBooleanByName('bl_big');
              let resultStr = `${b1} --- ${b2} --- ${b3} --- ${b4} --- ${b5}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("getNumber()\ngetNumberByName()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let num1 = ResUtil.getNumber($r('app.integer.count'));
              let num2 = ResUtil.getNumber($r('app.integer.age').id);
              let num3 = ResUtil.getNumberByName('count');
              let num4 = ResUtil.getNumberByName('age');
              let resultStr = `${num1} --- ${num2} --- ${num3} --- ${num4}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("getStringSync()\ngetStringValue()\ngetStringByNameSync()\ngetStringByName()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let str1 = ResUtil.getStringSync($r('app.string.str_desc'), [30, 10200]);
              let str2 = ResUtil.getStringSync($r('app.string.module_desc').id);
              let str3 = await ResUtil.getStringValue($r('app.string.app_name'));
              let str4 = ResUtil.getStringByNameSync("str_desc", [30, 9600]);
              let str5 = ResUtil.getStringByNameSync('module_desc');
              let str6 = await ResUtil.getStringByName('app_name');
              let resultStr = `${str1}\n${str2}\n${str3}\n${str4}\n${str5}\n${str6}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("getStringArrayValueSync()\ngetStringArrayValue()\ngetStringArrayByNameSync()\ngetStringArrayByName()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let strArray1 = ResUtil.getStringArrayValueSync($r('app.strarray.font_size'));
              let strArray2 = await ResUtil.getStringArrayValue($r('app.strarray.font_size').id);
              let strArray3 = ResUtil.getStringArrayByNameSync("font_size");
              let strArray4 = await ResUtil.getStringArrayByName("font_size");
              let resultStr = `${strArray1}\n${strArray2}\n${strArray3}\n${strArray4}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("getPluralStringValueSync()\ngetPluralStringValue()\ngetPluralStringByNameSync()\ngetPluralStringByName()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let str1 = ResUtil.getPluralStringValueSync($r('app.plural.eat_apple'), 1);
              let str2 = await ResUtil.getPluralStringValue($r('app.plural.eat_apple'), 2);
              let str3 = ResUtil.getPluralStringByNameSync("eat_apple", 11);
              let str4 = await ResUtil.getPluralStringByName("eat_apple", 0);
              let resultStr = `${str1}\n${str2}\n${str3}\n${str4}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("getColorSync()\ngetColor()\ngetColorByNameSync()\ngetColorByName()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let color1 = ResUtil.getColorSync($r('app.color.color_main'));
              let color2 = await ResUtil.getColor($r('app.color.color_99'));
              let color3 = ResUtil.getColorByNameSync("color_main");
              let color4 = await ResUtil.getColorByName("color_99");
              let resultStr = `${color1}\n${color2}\n${color3}\n${color4}`;
              LogUtil.error(resultStr);
              Utils.showSheetText(resultStr);
            })
          Button("getMediaContentSync()\ngetMediaContent()\ngetMediaByNameSync()\ngetMediaByName()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let uint8Array1 = ResUtil.getMediaContentSync($r('app.media.test_as1'));
              let uint8Array2 = await ResUtil.getMediaContent($r('app.media.test_as4'));
              let uint8Array3 = ResUtil.getMediaByNameSync("test_as2");
              let uint8Array4 = await ResUtil.getMediaByName("test_as5");
              let jsonStr = `${FileUtil.getFormatFileSize(uint8Array1.byteLength)}\n${FileUtil.getFormatFileSize(uint8Array2.byteLength)}\n${FileUtil.getFormatFileSize(uint8Array3.byteLength)}\n${FileUtil.getFormatFileSize(uint8Array4.byteLength)}`;
              LogUtil.error(jsonStr);
              Utils.showSheetText(jsonStr);
            })
          Button("getMediaContentBase64Sync()\ngetMediaContentBase64()\ngetMediaBase64ByNameSync()\ngetMediaBase64ByName()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let str1 = ResUtil.getMediaContentBase64Sync($r('app.media.test_as1'));
              let str2 = await ResUtil.getMediaContentBase64($r('app.media.test_as4'));
              let str3 = ResUtil.getMediaBase64ByNameSync("test_as2");
              let str4 = await ResUtil.getMediaBase64ByName("test_as5");
              let pixelMap1 = await ImageUtil.base64ToPixelMap(str1);
              let pixelMap2 = await ImageUtil.base64ToPixelMap(str2);
              let pixelMap3 = await ImageUtil.base64ToPixelMap(str3);
              let pixelMap4 = await ImageUtil.base64ToPixelMap(str4);
              let s1 = FileUtil.getFormatFileSize(pixelMap1.getPixelBytesNumber());
              let s2 = FileUtil.getFormatFileSize(pixelMap2.getPixelBytesNumber());
              let s3 = FileUtil.getFormatFileSize(pixelMap3.getPixelBytesNumber());
              let s4 = FileUtil.getFormatFileSize(pixelMap4.getPixelBytesNumber());
              let jsonStr = `${s1}\n${s2}\n${s3}\n${s4}`;
              LogUtil.error(jsonStr);
              Utils.showSheetText(jsonStr);
            })
          Button("getRawFileContentSync()\ngetRawFileContent()\ngetRawFileContentStrSync()\ngetRawFileContentStr()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let uint8Array1 = ResUtil.getRawFileContentSync('demo/demo.txt');
              let uint8Array2 = await ResUtil.getRawFileContent('data_utils.json');
              let str3 = ResUtil.getRawFileContentStrSync("demo/demo.txt");
              let str4 = await ResUtil.getRawFileContentStr("demo/test.txt");
              let s1 = FileUtil.getFormatFileSize(uint8Array1.byteLength);
              let s2 = FileUtil.getFormatFileSize(uint8Array2.byteLength);
              let jsonStr = `文件大小：${s1}\n文件大小：${s2}\n\n${str3}\n\n${str4}`;
              LogUtil.error(jsonStr);
              Utils.showSheetText(jsonStr);
            })
          Button("getRawFileListSync()\ngetRawFileList()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let list1 = ResUtil.getRawFileListSync('demo');
              let list2 = await ResUtil.getRawFileList("");
              let jsonStr = `${JSON.stringify(list1, null, 2)}\n\n${JSON.stringify(list2, null, 2)}`;
              LogUtil.error(jsonStr);
              Utils.showSheetText(jsonStr);
            })
          Button("getRawFd()\ncloseRawFd()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let rawFileDescriptor = await ResUtil.getRawFd("test.txt");
              let jsonStr = `fd: ${rawFileDescriptor.fd}\n\noffset: ${rawFileDescriptor.offset}\n\nlength: ${rawFileDescriptor.length}`;
              ResUtil.closeRawFd("test.txt");
              LogUtil.error(jsonStr);
              Utils.showSheetText(jsonStr);
            })
          Button("addResource()")
            .btnStyle()
            .onClick(async () => {
              let path = AppUtil.getContext().bundleCodeDir + "/library-default-signed.hsp";
              ResUtil.addResource(path);
              ToastUtil.showToast("资源加载成功");
            })
          Button("removeResource()")
            .btnStyle()
            .onClick(async () => {
              let path = AppUtil.getContext().bundleCodeDir + "/library-default-signed.hsp";
              ResUtil.removeResource(path);
              ToastUtil.showToast("移除资源成功");
            })
          Button("isRawDir()")
            .btnStyle()
            .onClick(() => {
              let isRawDir = ResUtil.isRawDir("demo");
              let isRawDir2 = ResUtil.isRawDir("test.txt");
              let str = `isRawDir: ${isRawDir}\n\nisRawDir2: ${isRawDir2}`;
              LogUtil.error(str);
              Utils.showSheetText(str);
            })
          Button("getConfiguration()\ngetDeviceCapability()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let configuration = ResUtil.getConfigurationSync();
              let deviceCapability = ResUtil.getDeviceCapabilitySync();
              let jsonStr = `${JSON.stringify(configuration,null,2)}\n\n${JSON.stringify(deviceCapability,null,2)}`;
              LogUtil.error(jsonStr);
              Utils.showSheetText(jsonStr);
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
