import { detectBarcode, generateBarcode, scanBarcode, scanCore } from '@kit.ScanKit';
import { image } from '@kit.ImageKit';
import { picker } from '@kit.CoreFileKit';
import { LogUtil } from './LogUtil';
import { AppUtil } from './AppUtil';
import { BusinessError } from '@kit.BasicServicesKit';


/**
 * 码工具类（扫码、码图生成、图片识码）
 */
export class ScanUtil {

  private constructor() {}


  /**
   * 调用默认界面扫码，使用Promise方式异步返回解码结果。
   * @param options
   *   scanTypes 设置扫码类型，默认扫码ALL（全部码类型）。
   *   enableMultiMode 是否开启多码识别，默认false。true：多码识别、false：单码识别。
   *   enableAlbum 是否开启相册，默认true。true-开启相册扫码、false-关闭相册扫码。
   * @returns ScanResult 扫码结果:
   *   scanType 码类型。
   *   originalValue 码识别内容结果。
   *   scanCodeRect 码识别位置信息。
   */
  static startScanForResult(options?: scanBarcode.ScanOptions): Promise<scanBarcode.ScanResult> {
    if (!options) {
      options = { scanTypes: [scanCore.ScanType.ALL], enableMultiMode: true, enableAlbum: true };
    }
    return scanBarcode.startScanForResult(AppUtil.getContext(), options); //启动扫码，拉起扫码界面
  }


  /**
   * 码图生成，使用Promise异步返回生成的码图。
   * @param content 码内容字符串
   * @param options 用于设置生成码图的参数:
   *     scanType  码类型。
   *     width 码图宽，单位：px。取值范围：[200, 4096]。
   *     height  码图高，单位：px。取值范围：[200, 4096]。
   *     margin  边距，单位：px，默认值为1，取值范围：[1, 10]。
   *     level 纠错水平，默认值为LEVEL_H。此参数只在生成QR码时有效。
   *     backgroundColor 生成码图背景颜色，HEX格式颜色，默认为白色（0xffffff）。
   *     pixelMapColor  生成码图颜色，HEX格式颜色，默认为黑色（0x000000）。
   * @returns
   */
  static generateBarcode(content: string, options?: generateBarcode.CreateOptions): Promise<image.PixelMap> {
    if (!options) {
      options = { scanType: scanCore.ScanType.QR_CODE, height: 800, width: 800, margin: 5 }
    }
    return generateBarcode.createBarcode(content, options);
  }


  /**
   * 通过picker拉起图库并选择图片,并调用图片识码
   * @param options
   * @returns
   */
  static async onPickerScanForResult(options?: scanBarcode.ScanOptions): Promise<Array<scanBarcode.ScanResult>> {
    try {
      let photoOption = new picker.PhotoSelectOptions();
      photoOption.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      photoOption.maxSelectNumber = 1;
      let photoPicker = new picker.PhotoViewPicker();
      let uris = await photoPicker.select(photoOption);
      return await ScanUtil.onDetectBarCode(uris[0], options);
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`ScanUtil-onPickerScanForResult-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return [];
    }
  }


  /**
   * 调用图片识码，使用Promise方式异步返回识码结果。
   * @param uri 图片路径。
   * @param options
   *   scanTypes 设置扫码类型，默认扫码ALL（全部码类型）。
   *   enableMultiMode 是否开启多码识别，默认false。true：多码识别、false：单码识别。
   *   enableAlbum 是否开启相册，默认true。true-开启相册扫码、false-关闭相册扫码。
   * @returns ScanResult 扫码结果:
   *   scanType 码类型。
   *   originalValue 码识别内容结果。
   *   scanCodeRect 码识别位置信息。
   */
  static onDetectBarCode(uri: string, options?: scanBarcode.ScanOptions): Promise<Array<scanBarcode.ScanResult>> {
    let inputImage: detectBarcode.InputImage = { uri: uri }
    if (!options) {
      options = { scanTypes: [scanCore.ScanType.ALL], enableMultiMode: true, enableAlbum: true }
    }
    return detectBarcode.decode(inputImage, options);
  }


  /**
   * 判断当前设备是否支持码能力
   * @returns
   */
  static canIUseScan() {
    return canIUse('SystemCapability.Multimedia.Scan.ScanBarcode');
  }


}