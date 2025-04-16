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

import { uniformTypeDescriptor } from '@kit.ArkData';
import { filePreview } from '@kit.PreviewKit';
import { FileUtil } from './FileUtil';
import { AppUtil } from './AppUtil';
import { WantUtil } from './WantUtil';


/**
 * TODO 文件预览工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class PreviewUtil {
  /**
   * 通过传入文件预览信息，打开预览窗口。1秒内重复调用无效。
   * @param previewInfo 文件的预览信息
   * @returns
   */
  static openPreview(previewInfo: filePreview.PreviewInfo): Promise<void> {
    return filePreview.openPreview(AppUtil.getContext(), previewInfo);
  }


  /**
   * 通过传入文件的uri，打开预览窗口。1秒内重复调用无效。
   * @param uri 文件的uri
   * @returns
   */
  static async openPreviewEasy(uri: string): Promise<void> {
    const previewInfo = PreviewUtil.generatePreviewInfo(uri);
    return filePreview.openPreview(AppUtil.getContext(), previewInfo);
  }


  /**
   * 根据文件的uri判断文件是否可预览
   * @param uri 文件的uri
   * @returns
   */
  static canPreview(uri: string): Promise<boolean> {
    return filePreview.canPreview(AppUtil.getContext(), uri);
  }


  /**
   * 判断预览窗口是否已经存在
   */
  static hasDisplayed(): Promise<boolean> {
    return filePreview.hasDisplayed(AppUtil.getContext());
  }


  /**
   * 关闭预览窗口，仅当预览窗口存在时起效。
   */
  static closePreview() {
    return filePreview.closePreview(AppUtil.getContext());
  }


  /**
   * 加载预览文件信息。仅当预览窗口存在时起效。
   * @param previewInfo 文件的预览信息
   * @returns
   */
  static loadData(previewInfo: filePreview.PreviewInfo) {
    return filePreview.loadData(AppUtil.getContext(), previewInfo);
  }


  /**
   * 加载预览文件信息。仅当预览窗口存在时起效。
   * @param uri 文件的uri
   * @returns
   */
  static async loadDataEasy(uri: string): Promise<void> {
    const previewInfo = PreviewUtil.generatePreviewInfo(uri);
    return filePreview.loadData(AppUtil.getContext(), previewInfo);
  }


  /**
   * 调用其他应用预览文件
   * @param uri 文件的uri
   * @param write 是否有写入权限
   * @returns
   */
  static onSharePreview(uri: string, write: boolean = true): Promise<void> {
    return WantUtil.openFile(uri, write);
  }


  /**
   * 根据文件uri构建PreviewInfo
   * @param uri 文件的uri
   * @returns
   */
  static generatePreviewInfo(uri: string): filePreview.PreviewInfo {
    const fileName = FileUtil.getFileName(uri);
    const fileExtention = FileUtil.getFileExtention(fileName);
    const mimeType = PreviewUtil.getMimeType(fileExtention);
    let previewInfo: filePreview.PreviewInfo = {
      title: fileName,
      uri: uri,
      mimeType: mimeType
    };
    return previewInfo;
  }


  /**
   * 根据文件后缀名获取TypeDescriptor（标准化数据类型的描述类）
   * @param fileExtention 文件后缀名，例如：html txt doc ts mp3
   */
  static getTypeDescriptor(fileExtention: string): uniformTypeDescriptor.TypeDescriptor {
    const dataType = uniformTypeDescriptor.getUniformDataTypeByFilenameExtension(`.${fileExtention}`);
    const typeDescriptor = uniformTypeDescriptor.getTypeDescriptor(dataType);
    return typeDescriptor;
  }


  /**
   * 根据文件后缀名获取文件mimeType
   * @param fileExtention 文件后缀名，例如：html txt doc ts mp3
   */
  static getMimeType(fileExtention: string): string {
    const typeDescriptor = PreviewUtil.getTypeDescriptor(fileExtention);
    const mimeTypes = typeDescriptor.mimeTypes;
    if (mimeTypes && mimeTypes.length > 0) {
      return mimeTypes[0];
    } else {
      return '*/*';
    }
  }


  /**
   * 根据文件后缀名获取对应文件类型的图标
   * @param fileExtention 文件后缀名，例如：html txt doc ts mp3
   */
  static getIconFileStr(fileExtention: string): string {
    const descriptor = PreviewUtil.getTypeDescriptor(fileExtention);
    return descriptor.iconFile;
  }


  /**
   * 判断当前设备是否支持文件预览能力
   * @returns
   */
  static canIUsePreview() {
    return canIUse("SystemCapability.FileManagement.FilePreview.Core")
  }


}