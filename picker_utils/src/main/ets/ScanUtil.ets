/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-utils
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { detectBarcode, generateBarcode, scanBarcode, scanCore } from '@kit.ScanKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { image } from '@kit.ImageKit';
import { PhotoHelper } from './PhotoHelper';


/**
 * TODO 码工具类（扫码、码图生成、图片识码）
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class ScanUtil {


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
    if (options === undefined) {
      options = { scanTypes: [scanCore.ScanType.ALL], enableMultiMode: true, enableAlbum: true };
    }
    return scanBarcode.startScanForResult(getContext(), options); //启动扫码，拉起扫码界面
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
    if (options === undefined) {
      options = {
        scanType: scanCore.ScanType.QR_CODE,
        height: 1024,
        width: 1024,
        margin: 5
      };
    }
    return generateBarcode.createBarcode(content, options);
  }


  /**
   * 调用图片识码，使用Promise方式异步返回识码结果。
   * @param uri 图片路径。
   * @param options 启动图片识码参数
   *   scanTypes 设置扫码类型，默认扫码ALL（全部码类型）。
   *   enableMultiMode 是否开启多码识别，默认false。true：多码识别、false：单码识别。
   *   enableAlbum 是否开启相册，默认true。true-开启相册扫码、false-关闭相册扫码。
   * @returns ScanResult 扫码结果:
   *   scanType 码类型。
   *   originalValue 码识别内容结果。
   *   scanCodeRect 码识别位置信息。
   */
  static async decode(uri: string, options?: scanBarcode.ScanOptions): Promise<Array<scanBarcode.ScanResult>> {
    const inputImage: detectBarcode.InputImage = { uri: uri };
    if (options === undefined) {
      options = { scanTypes: [scanCore.ScanType.ALL], enableMultiMode: true, enableAlbum: true };
    }
    return await detectBarcode.decode(inputImage, options);
  }


  /**
   * 调用图像数据识码能力，使用Promise异步回调返回识码结果
   * @param image 待识别的图像数据
   * @param options 启动图像数据识码参数
   *   scanTypes 设置扫码类型，默认扫码ALL（全部码类型）。
   *   enableMultiMode 是否开启多码识别，默认false。true：多码识别、false：单码识别。
   *   enableAlbum 是否开启相册，默认true。true-开启相册扫码、false-关闭相册扫码。
   * @returns
   */
  static async decodeImage(image: detectBarcode.ByteImage,
    options?: scanBarcode.ScanOptions): Promise<detectBarcode.DetectResult> {
    if (options === undefined) {
      options = { scanTypes: [scanCore.ScanType.ALL], enableMultiMode: true, enableAlbum: true };
    }
    return await detectBarcode.decodeImage(image, options);
  }


  /**
   * 通过picker拉起图库并选择图片,并调用图片识码
   * @param options
   * @returns
   */
  static async onPickerScanForResult(options?: scanBarcode.ScanOptions): Promise<Array<scanBarcode.ScanResult>> {
    const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
    photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
    photoSelectOptions.maxSelectNumber = 1; //单选
    photoSelectOptions.isPhotoTakingSupported = true; //支持拍照。
    photoSelectOptions.isEditSupported = false;
    photoSelectOptions.isOriginalSupported = false;
    let uris = await PhotoHelper.select(photoSelectOptions);
    return ScanUtil.decode(uris[0], options);
  }


  /**
   * 判断当前设备是否支持码能力
   * @returns
   */
  static canIUseScan() {
    return canIUse('SystemCapability.Multimedia.Scan.ScanBarcode');
  }


  /**
   * 调用图片识码，该方法已过时，推荐使用：ScanUtil.decode()。
   */
  static onDetectBarCode(uri: string, options?: scanBarcode.ScanOptions): Promise<Array<scanBarcode.ScanResult>> {
    return ScanUtil.decode(uri, options);
  }


}