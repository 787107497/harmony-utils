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

import picker from '@ohos.file.picker';
import { camera, cameraPicker } from '@kit.CameraKit';
import { CameraOptions } from '../entity/CameraOptions';
import { AppUtil } from './AppUtil';
import { PICKER_DEFAULT_SELECT_NUMBER } from '../entity/constraint';
import { FileUtil } from './FileUtil';
import { fileShare } from '@kit.CoreFileKit';


/**
 * TODO 拍照、文件(文件、图片、视频、音频)选择和保存,工具类
 *
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059
 */
export class PickerUtil {


  /**
   * 调用系统相机，拍照、录视频
   * @param options
   * @returns
   */
  static async cameraEasy(options: CameraOptions = new CameraOptions()): Promise<string> {
    let pickerResult = await PickerUtil.camera(options);
    return pickerResult.resultUri;
  }


  /**
   * 调用系统相机，拍照、录视频
   * @param options
   * @returns
   */
  static async camera(options: CameraOptions = new CameraOptions()): Promise<cameraPicker.PickerResult> {
    const pickerProfile: cameraPicker.PickerProfile = {
      cameraPosition: options.cameraPosition ? options.cameraPosition : camera.CameraPosition.CAMERA_POSITION_BACK,
      videoDuration: options.videoDuration,
      saveUri: options.saveUri
    };
    let pickerResult = await cameraPicker.pick(AppUtil.getContext(), options.mediaTypes, pickerProfile);
    return pickerResult;
  }


  /**
   * 通过选择模式拉起PhotoViewPicker界面，用户可以选择一个或多个图片/视频。（该方法系统已废弃，推荐使用PhotoHelper工具类）
   * @param options
   *  MIMEType PhotoViewMIMETypes 可选择的媒体文件类型，若无此参数，则默认为图片和视频类型。
   *  maxSelectNumber	number 选择媒体文件数量的最大值(默认值为50，最大值为500)。
   * @returns
   */
  static async selectPhoto(options?: picker.PhotoSelectOptions): Promise<Array<string>> {
    if (options === undefined) {
      options = new picker.PhotoSelectOptions();
      options.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE; //可选择的媒体文件类型，若无此参数，则默认为图片和视频类型。
      options.maxSelectNumber = PICKER_DEFAULT_SELECT_NUMBER; //选择媒体文件数量的最大值,默认9。
    }
    const photoPicker = new picker.PhotoViewPicker(AppUtil.getContext());
    let photoSelectResult: picker.PhotoSelectResult = await photoPicker.select(options);
    return photoSelectResult.photoUris;
  }


  /**
   * 通过保存模式拉起photoPicker进行保存图片或视频资源的文件名，若无此参数，则默认需要用户自行输入。（该方法系统已废弃，推荐使用PhotoHelper工具类）
   * @param newFileNames 拉起photoPicker进行保存图片或视频资源的文件名，若无此参数，则默认需要用户自行输入。
   * @returns
   */
  static async savePhoto(newFileNames?: Array<string>): Promise<Array<string>> {
    const photoPicker = new picker.PhotoViewPicker(AppUtil.getContext());
    const PhotoSaveOptions = new picker.PhotoSaveOptions();
    if (newFileNames !== undefined && newFileNames.length > 0) {
      PhotoSaveOptions.newFileNames = newFileNames;
    }
    return photoPicker.save(PhotoSaveOptions);
  }


  /**
   * 通过选择模式拉起documentPicker界面，用户可以选择一个或多个文件。
   * @param options
   *  maxSelectNumber number 选择文件最大个数，上限500，有效值范围1-500（选择目录仅对具有该系统能力的设备开放。且目录选择的最大个数为1）。默认值是1。系统能力： SystemCapability.FileManagement.UserFileService
   *  defaultFilePathUri string 指定选择的文件或者目录路径
   *  fileSuffixFilters Array<string> 选择文件的后缀类型，传入字符串数组，每一项代表一个后缀选项，每一项内部用"|"分为两部分，第一部分为描述，第二部分为过滤后缀。没有"|"则没有描述，该项整体是一个过滤后缀。每项过滤后缀可以存在多个后缀名，则每一个后缀名之间用英文逗号进行分隔，传入数组长度不能超过100。仅对具有该系统能力的设备开放。默认全部过滤，即显示所有文件。系统能力： SystemCapability.FileManagement.UserFileService
   *  selectMode DocumentSelectMode 支持选择的资源类型，比如：文件、文件夹和二者混合，仅对具有该系统能力的设备开放，默认值是文件类型。系统能力： SystemCapability.FileManagement.UserFileService.FolderSelection
   *  authMode boolean 拉起授权picker，默认为false（非授权模式）。当authMode为true时为授权模式，defaultFilePathUri必填，表明待授权uri。仅对具有该系统能力的设备开放，系统能力： SystemCapability.FileManagement.UserFileService.FolderSelection
   * @returns
   */
  static async selectDocument(options?: picker.DocumentSelectOptions): Promise<Array<string>> {
    if (options === undefined) {
      options = new picker.DocumentSelectOptions();
      options.maxSelectNumber = PICKER_DEFAULT_SELECT_NUMBER; //选择媒体文件数量的最大值,默认9。
      options.selectMode = picker.DocumentSelectMode.FILE; //支持选择的资源类型,默认文件
    }
    const documentPicker = new picker.DocumentViewPicker();
    return documentPicker.select(options);
  }


  /**
   * 通过保存模式拉起documentPicker界面，用户可以保存一个或多个文件。
   * @param newFileNames Array<string> 拉起documentPicker进行保存的文件名，若无此参数，则默认需要用户自行输入。
   * @returns 返回DOWNLOAD的文件夹下的文件path。
   */
  static async saveDocumentEasy(newFileNames: Array<string>): Promise<Array<string>> {
    const documentSaveOptions = new picker.DocumentSaveOptions();
    documentSaveOptions.pickerMode = picker.DocumentPickerMode.DOWNLOAD;
    if (newFileNames !== undefined && newFileNames.length > 0) {
      documentSaveOptions.newFileNames = newFileNames;
    }
    let downloadUri = await PickerUtil.saveDocument(documentSaveOptions);
    const path = FileUtil.getFileUri(downloadUri[0]).path;
    let uris = new Array<string>();
    for (let index = 0; index < newFileNames.length; index++) {
      uris.push(`${path}/${newFileNames[index]}`);
    }
    return uris;
  }


  /**
   * 通过保存模式拉起documentPicker界面，用户可以保存一个或多个文件。
   * @param options
   *  newFileNames Array<string> 拉起documentPicker进行保存的文件名，若无此参数，则默认需要用户自行输入。
   *  defaultFilePathUri string 指定保存的文件或者目录路径。
   *  fileSuffixChoices Array<string> 保存文件的后缀类型。传入字符串数组，每一项代表一个后缀选项，每一项内部用"|"分为两部分，第一部分为描述，第二部分为要保存的后缀。没有"|"则没有描述，该项整体是一个保存的后缀。默认没有后缀类型。
   *  pickerMode DocumentPickerMode 拉起picker的类型, 默认为DEFAULT。当pickerMode设置为DOWNLOAD时，用户配置的参数newFileNames、defaultFilePathUri和fileSuffixChoices将不会生效。
   * @returns
   */
  static async saveDocument(options?: picker.DocumentSaveOptions): Promise<Array<string>> {
    const documentPicker = new picker.DocumentViewPicker(AppUtil.getContext());
    return documentPicker.save(options);
  }


  /**
   * 通过选择模式拉起audioPicker界面（目前拉起的是documentPicker，audioPicker在规划中），用户可以选择一个或多个音频文件。
   * @param maxSelectNumber number 选择媒体文件数量的最大值(默认值为50，最大值为500)。
   * @returns
   */
  static async selectAudio(options?: picker.AudioSelectOptions): Promise<Array<string>> {
    if (options === undefined) {
      options = new picker.AudioSelectOptions();
      options.maxSelectNumber = PICKER_DEFAULT_SELECT_NUMBER; //选择媒体文件数量的最大值,默认9
    }
    const audioPicker = new picker.AudioViewPicker(AppUtil.getContext());
    return audioPicker.select(options);
  }


  /**
   * 通过保存模式拉起audioPicker界面（目前拉起的是documentPicker，audioPicker在规划中），用户可以保存一个或多个音频文件。
   * @param newFileNames 拉起audioPicker进行保存音频资源的文件名，若无此参数，则默认需要用户自行输入。
   * @returns 返回保存文件的uri数组。
   */
  static async saveAudio(newFileNames?: Array<string>): Promise<Array<string>> {
    const audioPicker = new picker.AudioViewPicker(AppUtil.getContext());
    const audioSaveOptions = new picker.AudioSaveOptions();
    if (newFileNames !== undefined && newFileNames.length > 0) {
      audioSaveOptions.newFileNames = newFileNames;
    }
    return audioPicker.save(audioSaveOptions);
  }


  /**
   * 对所选择的多个文件或目录URI持久化授权。（需要权限：ohos.permission.FILE_ACCESS_PERSIST）
   * @param uris string 需要授予或使能权限的URI。
   * @param operationMode  number 授予或使能权限的URI访问模式，参考OperationMode，例如： fileShare.OperationMode.READ_MODE ：允许读授权。fileShare.OperationMode.READ_MODE | fileShare.OperationMode.WRITE_MODE ：允许读写授权。
   * @returns 无返回结果的Promise对象。
   */
  static async persistPermissionEasy(uris: Array<string>,
    operationMode: number = fileShare.OperationMode.READ_MODE | fileShare.OperationMode.WRITE_MODE): Promise<void> {
    let policies: Array<fileShare.PolicyInfo> = new Array<fileShare.PolicyInfo>();
    for (let index = 0; index < uris.length; index++) {
      let policyInfo: fileShare.PolicyInfo = { uri: uris[index], operationMode: operationMode };
      policies.push(policyInfo);
    }
    return fileShare.persistPermission(policies);
  }

  /**
   * 对所选择的多个文件或目录URI持久化授权。（需要权限：ohos.permission.FILE_ACCESS_PERSIST）
   * @returns 无返回结果的Promise对象。
   */
  static async persistPermission(policies: Array<fileShare.PolicyInfo>): Promise<void> {
    return fileShare.persistPermission(policies);
  }


  /**
   * 对所选择的多个文件或目录uri取消持久化授权。（需要权限：ohos.permission.FILE_ACCESS_PERSIST）
   * @param uris string 需要授予或使能权限的URI。
   * @param operationMode  number 授予或使能权限的URI访问模式，参考OperationMode，例如： fileShare.OperationMode.READ_MODE ：允许读授权。fileShare.OperationMode.READ_MODE | fileShare.OperationMode.WRITE_MODE ：允许读写授权。
   * @returns 无返回结果的Promise对象。
   */
  static async revokePermissionEasy(uris: Array<string>,
    operationMode: number = fileShare.OperationMode.READ_MODE | fileShare.OperationMode.WRITE_MODE): Promise<void> {
    let policies: Array<fileShare.PolicyInfo> = new Array<fileShare.PolicyInfo>();
    for (let index = 0; index < uris.length; index++) {
      let policyInfo: fileShare.PolicyInfo = { uri: uris[index], operationMode: operationMode };
      policies.push(policyInfo);
    }
    return fileShare.revokePermission(policies);
  }

  /**
   * 对所选择的多个文件或目录uri取消持久化授权。（需要权限：ohos.permission.FILE_ACCESS_PERSIST）
   * @returns 无返回结果的Promise对象。
   */
  static async revokePermission(policies: Array<fileShare.PolicyInfo>): Promise<void> {
    return fileShare.revokePermission(policies);
  }


  /**
   * 对已经持久化授权的权限进行使能操作，否则已经持久化授权的权限仍存在不能使用的情况。（需要权限：ohos.permission.FILE_ACCESS_PERSIST）
   * @param uris string 需要授予或使能权限的URI。
   * @param operationMode  number 授予或使能权限的URI访问模式，参考OperationMode，例如： fileShare.OperationMode.READ_MODE ：允许读授权。fileShare.OperationMode.READ_MODE | fileShare.OperationMode.WRITE_MODE ：允许读写授权。
   * @returns 无返回结果的Promise对象。
   */
  static async activatePermissionEasy(uris: Array<string>,
    operationMode: number = fileShare.OperationMode.READ_MODE | fileShare.OperationMode.WRITE_MODE): Promise<void> {
    let policies: Array<fileShare.PolicyInfo> = new Array<fileShare.PolicyInfo>();
    for (let index = 0; index < uris.length; index++) {
      let policyInfo: fileShare.PolicyInfo = { uri: uris[index], operationMode: operationMode };
      policies.push(policyInfo);
    }
    return fileShare.activatePermission(policies);
  }

  /**
   * 对已经持久化授权的权限进行使能操作，否则已经持久化授权的权限仍存在不能使用的情况。（需要权限：ohos.permission.FILE_ACCESS_PERSIST）
   * @returns 无返回结果的Promise对象。
   */
  static async activatePermission(policies: Array<fileShare.PolicyInfo>): Promise<void> {
    return fileShare.activatePermission(policies);
  }


  /**
   * 取消使能授权过的多个文件或目录。（需要权限：ohos.permission.FILE_ACCESS_PERSIST）
   * @param uris string 需要授予或使能权限的URI。
   * @param operationMode  number 授予或使能权限的URI访问模式，参考OperationMode，例如： fileShare.OperationMode.READ_MODE ：允许读授权。fileShare.OperationMode.READ_MODE | fileShare.OperationMode.WRITE_MODE ：允许读写授权。
   * @returns 无返回结果的Promise对象。
   */
  static async deactivatePermissionEasy(uris: Array<string>,
    operationMode: number = fileShare.OperationMode.READ_MODE | fileShare.OperationMode.WRITE_MODE): Promise<void> {
    let policies: Array<fileShare.PolicyInfo> = new Array<fileShare.PolicyInfo>();
    for (let index = 0; index < uris.length; index++) {
      let policyInfo: fileShare.PolicyInfo = { uri: uris[index], operationMode: operationMode };
      policies.push(policyInfo);
    }
    return fileShare.deactivatePermission(policies);
  }

  /**
   * 取消使能授权过的多个文件或目录。（需要权限：ohos.permission.FILE_ACCESS_PERSIST）
   * @returns 无返回结果的Promise对象。
   */
  static async deactivatePermission(policies: Array<fileShare.PolicyInfo>): Promise<void> {
    return fileShare.deactivatePermission(policies);
  }


  /**
   * 校验所选择的多个文件或目录URI持久化授权。（需要权限：ohos.permission.FILE_ACCESS_PERSIST）
   * @param uris string 需要授予或使能权限的URI。
   * @param operationMode  number 授予或使能权限的URI访问模式，参考OperationMode，例如： fileShare.OperationMode.READ_MODE ：允许读授权。fileShare.OperationMode.READ_MODE | fileShare.OperationMode.WRITE_MODE ：允许读写授权。
   * @returns Promise对象，返回true表示有持久化授权，false表示不具有持久化授权。
   */
  static async checkPersistentPermission(policies: Array<fileShare.PolicyInfo>): Promise<Array<boolean>> {
    return fileShare.checkPersistentPermission(policies);
  }


}