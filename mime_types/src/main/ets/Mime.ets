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


export class Mime {


  /**
   * 根据文件名获取MIME类型
   * @param fileName 文件名 'test.txt'
   * @returns 输出：text/plain
   */
  static lookup(fileName: string): string {
    const fileExtention = Mime.getFileExtention(fileName);
    return Mime.contentType(fileExtention);
  }


  /**
   * 根据文件名的后缀名获取MIME类型
   * @param fileExtention 文件后缀名，例如：html txt .doc .ts .mp3
   * @returns MIME类型名称，输出：text/html
   */
  static contentType(fileExtention: string): string {
    const typeDescriptor = Mime.getTypeDescriptorByFileExtension(fileExtention);
    const mimeTypes = typeDescriptor.mimeTypes;
    if (mimeTypes && mimeTypes.length > 0) {
      return mimeTypes[0];
    } else {
      return '*/*';
    }
  }


  /**
   * 根据MIME类型获取文件扩展名
   * @param mimeType MIME类型名称 'text/css'
   * @returns 输出：css
   */
  static extension(mimeType: string): string {
    const typeDescriptor = Mime.getTypeDescriptorByMIMEType(mimeType)
    const filenameExtensions = typeDescriptor.filenameExtensions;
    if (filenameExtensions && filenameExtensions.length > 0) {
      return filenameExtensions[0];
    } else {
      return '';
    }
  }


  /**
   * 根据 文件名/文件path/文件uri/文件url，获取文件后缀名
   * @param src 例如: test.txt  test.doc
   * @returns
   */
  static getFileExtention(src: string): string {
    if (src.length > 1 && src.includes(".")) {
      return src.substring(src.lastIndexOf(".") + 1);
    }
    return '';
  }


  /**
   * 根据文件后缀名获取对应文件类型的图标
   * @param fileExtention 文件后缀名，例如：html txt doc ts mp3
   */
  static getIconFileByFileExtension(fileExtention: string): string {
    const descriptor = Mime.getTypeDescriptorByFileExtension(fileExtention);
    return descriptor.iconFile;
  }

  /**
   * 根据MIME类型获取对应文件类型的图标
   * @param mimeType MIME类型名称 'text/css'
   */
  static getIconFileByMIMEType(mimeType: string): string {
    const descriptor = Mime.getTypeDescriptorByMIMEType(mimeType);
    return descriptor.iconFile;
  }


  /**
   * 根据文件后缀名获取TypeDescriptor（标准化数据类型的描述类）
   * @param fileExtention 文件后缀名，例如：html txt .doc .ts .mp3
   */
  static getTypeDescriptorByFileExtension(fileExtention: string, belongsTo?: string): uniformTypeDescriptor.TypeDescriptor {
    fileExtention = fileExtention.startsWith('.') ? fileExtention : `.${fileExtention}`;
    const dataType = uniformTypeDescriptor.getUniformDataTypeByFilenameExtension(fileExtention, belongsTo);
    const typeDescriptor = uniformTypeDescriptor.getTypeDescriptor(dataType);
    return typeDescriptor;
  }


  /**
   * 根据文件MIME类型，获取TypeDescriptor（标准化数据类型的描述类）
   * @param mimeType MIME类型名称，例如：'image/jpeg' 'image/png'
   */
  static getTypeDescriptorByMIMEType(mimeType: string): uniformTypeDescriptor.TypeDescriptor {
    const dataType = uniformTypeDescriptor.getUniformDataTypeByMIMEType(mimeType);
    const typeDescriptor = uniformTypeDescriptor.getTypeDescriptor(dataType);
    return typeDescriptor;
  }


}