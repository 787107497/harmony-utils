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

import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { dataSharePredicates } from '@kit.ArkData';
import fs from '@ohos.file.fs';
import { Utils } from './Utils';
import { PICKER_DEFAULT_SELECT_NUMBER } from './CameraOptions';


/**
 * TODO 相册选择和保存,工具类
 *  需要权限：
 *    ohos.permission.READ_IMAGEVIDEO
 *    ohos.permission.WRITE_IMAGEVIDEO
 *
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class PhotoHelper {


  /**
   * 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频。
   * @param options
   *   MIMEType 可选择的媒体文件类型，若无此参数，则默认为图片和视频类型。
   *   maxSelectNumber 选择媒体文件数量的最大值(最大可设置的值为500，若不设置则默认为50或9)。
   *   isPhotoTakingSupported 是否支持拍照，true表示支持，false表示不支持，默认为true。
   *   isSearchSupported 是否支持搜索，true表示支持，false表示不支持，默认为true。
   *   isEditSupported 是否支持编辑照片，true表示支持，false表示不支持，默认为true。
   *   isOriginalSupported 是否显示选择原图按钮，true表示显示，false表示不显示，默认为false。
   *   preselectedUris 预选择图片的uri数据。
   *   isPreviewForSingleSelectionSupported 单选模式下是否需要进大图预览，true表示需要，false表示不需要，默认为true。
   *   recommendationOptions 图片推荐相关配置参数。
   *   subWindowName 子窗窗口名称。
   * @returns
   */
  static async select(options?: photoAccessHelper.PhotoSelectOptions): Promise<photoAccessHelper.PhotoSelectResult> {
    if (options === undefined) {
      options = new photoAccessHelper.PhotoSelectOptions();
      options.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE; //可选择的媒体文件类型，若无此参数，则默认为图片和视频类型。
      options.maxSelectNumber = PICKER_DEFAULT_SELECT_NUMBER; //选择媒体文件数量的最大值,默认9
      options.isPhotoTakingSupported = true; //支持拍照。
      options.isEditSupported = true; //支持编辑照片。
      options.isOriginalSupported = true; //显示选择原图按钮。
    }
    const photoPicker = new photoAccessHelper.PhotoViewPicker();
    let photoSelectResult: photoAccessHelper.PhotoSelectResult = await photoPicker.select(options);
    return photoSelectResult;
  }


  /**
   * 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频。
   * @param options
   *   MIMEType 可选择的媒体文件类型，若无此参数，则默认为图片和视频类型。
   *   maxSelectNumber 选择媒体文件数量的最大值(最大可设置的值为500，若不设置则默认为50或9)。
   *   isPhotoTakingSupported 是否支持拍照，true表示支持，false表示不支持，默认为true。
   *   isSearchSupported 是否支持搜索，true表示支持，false表示不支持，默认为true。
   *   isEditSupported 是否支持编辑照片，true表示支持，false表示不支持，默认为true。
   *   isOriginalSupported 是否显示选择原图按钮，true表示显示，false表示不显示，默认为false。
   *   preselectedUris 预选择图片的uri数据。
   *   isPreviewForSingleSelectionSupported 单选模式下是否需要进大图预览，true表示需要，false表示不需要，默认为true。
   *   recommendationOptions 图片推荐相关配置参数。
   *   subWindowName 子窗窗口名称。
   * @returns
   */
  static async selectEasy(options?: photoAccessHelper.PhotoSelectOptions): Promise<Array<string>> {
    let photoSelectResult: photoAccessHelper.PhotoSelectResult = await PhotoHelper.select(options);
    if (photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0) {
      return photoSelectResult.photoUris;
    } else {
      return [];
    }
  }


  /**
   * 申请权限保存。保存图片或视频到相册（已申请权限使用该方法“ohos.permission.WRITE_IMAGEVIDEO”）
   * @param photoType 创建的文件类型，IMAGE或者VIDEO类型。
   * @param extension 文件名后缀参数，例如：'jpg'。
   * @param options 创建选项，例如{title: 'testPhoto'}。
   * @returns
   */
  static async save(photoType: photoAccessHelper.PhotoType, extension: string, options?: photoAccessHelper.CreateOptions): Promise<string> {
    const photoHelper = photoAccessHelper.getPhotoAccessHelper(getContext());
    let uri = await photoHelper.createAsset(photoType, extension, options);
    await photoHelper.release();
    return uri;
  }


  /**
   * 弹窗授权保存。调用接口拉起保存确认弹窗。用户同意保存后，返回已创建并授予保存权限的uri列表，该列表永久生效，应用可使用该uri写入图片/视频。如果用户拒绝保存，将返回空列表。
   * @param srcFileUris 需保存到媒体库中的图片/视频文件对应的媒体库uri。注意： 仅支持处理图片、视频uri。
   * @param photoCreationConfigs 保存图片/视频到媒体库的配置，包括保存的文件名等，与srcFileUris保持一一对应。
   * @returns 返回给应用的媒体库文件uri列表。Uri已对应用授权，支持应用写入数据。
   */
  static async showAssetsCreationDialog(srcFileUris: Array<string>, photoCreationConfigs?: Array<photoAccessHelper.PhotoCreationConfig>): Promise<Array<string>>{
    const ImageExtensions = ["jpeg", "jpg", "png", "gif", "webp", "bmp", "heic", "heif", , "ico", "svg"]; //图片文件后缀
    const photoHelper = photoAccessHelper.getPhotoAccessHelper(getContext());
    if (photoCreationConfigs == undefined || photoCreationConfigs == null) {
      photoCreationConfigs = new Array<photoAccessHelper.PhotoCreationConfig>();
      for (let index = 0; index < srcFileUris.length; index++) {
        let fileName = Utils.getFileName(srcFileUris[index]); //文件名
        let fileExtention = Utils.getFileExtention(fileName); //文件后缀
        fileName = fileName.replace(`.${fileExtention}`, "");
        let photoType = ImageExtensions.includes(fileExtention.toLowerCase()) ? photoAccessHelper.PhotoType.IMAGE : photoAccessHelper.PhotoType.VIDEO;
        let photoCreationConfig: photoAccessHelper.PhotoCreationConfig = {
          title: fileName, //可选
          fileNameExtension: fileExtention,
          photoType: photoType,
          subtype: photoAccessHelper.PhotoSubtype.DEFAULT, //可选
        }
        photoCreationConfigs.push(photoCreationConfig);
      }
    }
    let desFileUris: Array<string> = await photoHelper.showAssetsCreationDialog(srcFileUris, photoCreationConfigs);
    await photoHelper.release(); //释放
    return desFileUris;
  }


  /**
   * 弹窗授权保存。调用接口拉起保存确认弹窗，并保存。
   * @param srcFileUris 需保存到媒体库中的图片/视频文件对应的媒体库uri。注意： 仅支持处理图片、视频uri。
   * @param photoCreationConfigs 保存图片/视频到媒体库的配置，包括保存的文件名等，与srcFileUris保持一一对应。
   * @returns 图片/视频文件是否保存成功。
   */
  static async showAssetsCreationDialogEasy(srcFileUris: Array<string>, photoCreationConfigs?: Array<photoAccessHelper.PhotoCreationConfig>): Promise<Array<string>> {
    let desFileUris: Array<string> = await PhotoHelper.showAssetsCreationDialog(srcFileUris, photoCreationConfigs);
    for (let index = 0; index < desFileUris.length; index++) {
      //将来源于应用沙箱的照片内容写入媒体库的目标uri
      let srcFile: fs.File = await Utils.open(srcFileUris[index], fs.OpenMode.READ_ONLY);
      let desFile: fs.File = await Utils.open(desFileUris[index], fs.OpenMode.WRITE_ONLY);
      await Utils.copyFile(srcFile.fd, desFile.fd);
      await Utils.close(srcFile);
      await Utils.close(desFile);
    }
    return desFileUris;
  }


  /**
   * 安全控件保存。提交媒体变更请求，插入图片/视频。
   * @param srcFileUri 需要确保srcFileUri对应的资源存在
   */
  static async applyChanges(srcFileUri: string): Promise<photoAccessHelper.PhotoAsset> {
    const context = getContext();
    const photoHelper = photoAccessHelper.getPhotoAccessHelper(context);
    const assetChangeRequest: photoAccessHelper.MediaAssetChangeRequest =
      photoAccessHelper.MediaAssetChangeRequest.createImageAssetRequest(context, srcFileUri);
    await photoHelper.applyChanges(assetChangeRequest);
    let photoAsset = assetChangeRequest.getAsset();
    await photoHelper.release();
    return photoAsset;
  }


  /**
   * 获取对应uri的PhotoAsset对象,用于读取文件信息。
   * @param uri 文件uri
   *    PhotoAsset - photoAccessHelper.PhotoKeys:
   *      URI  'uri'  文件uri。
   *      PHOTO_TYPE  'media_type'  媒体文件类型。
   *      DISPLAY_NAME  'display_name'  显示名字。
   *      SIZE  'size'  文件大小。
   *      DURATION  'duration'  持续时间（单位：毫秒）。
   *      WIDTH  'width'  图片宽度（单位：像素）。
   *      HEIGHT  'height'  图片高度（单位：像素）。
   *      DATE_TAKEN  'date_taken'  拍摄日期（文件拍照时间距1970年1月1日的秒数值）。
   *      ORIENTATION  'orientation'  图片文件的方向。
   *      TITLE  'title'  文件标题。
   *      getThumbnail 获取缩略图
   * @returns
   */
  static async getPhotoAsset(uri: string): Promise<photoAccessHelper.PhotoAsset> {
    const photoHelper = photoAccessHelper.getPhotoAccessHelper(getContext());
    const predicates: dataSharePredicates.DataSharePredicates = new dataSharePredicates.DataSharePredicates();
    //配置查询条件，使用PhotoViewPicker选择图片返回的uri进行查询
    predicates.equalTo('uri', uri);
    let fetchOption: photoAccessHelper.FetchOptions = {
      fetchColumns: ['media_type', 'display_name', 'size', 'title', 'width', 'height', 'date_taken',
        'uri', 'duration', 'orientation', 'date_added', 'date_modified', 'is_favorite'],
      predicates: predicates
    };
    let fetchResult: photoAccessHelper.FetchResult<photoAccessHelper.PhotoAsset> = await photoHelper.getAssets(fetchOption);
    //得到uri对应的PhotoAsset对象，读取文件的部分信息
    let photoAsset: photoAccessHelper.PhotoAsset = await fetchResult.getFirstObject();
    await photoHelper.release();
    return photoAsset;
  }


}