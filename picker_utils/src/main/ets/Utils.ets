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

import fileUri from '@ohos.file.fileuri';
import fs from '@ohos.file.fs';

/**
 * TODO 工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class Utils {


  /**
   * 判断字符串是否为空(undefined、null、字符串长度为0)
   * @param str 被检测的字符串
   * @return 是否为空
   */
  static isEmpty(str: string | undefined | null): boolean {
    return str === undefined || str === null || str.length === 0;
  }

  /**
   * 判断字符串是否为非空。true为非空空，否则false
   * @param str
   * @returns
   */
  static isNotEmpty(str: string | undefined | null): boolean {
    return false === Utils.isEmpty(str);
  }


  /**
   * 通过URI或路径，获取FileUri
   * @param uriOrPath URI或路径
   * @returns
   */
  static getFileUri(uriOrPath: string): fileUri.FileUri {
    return new fileUri.FileUri(uriOrPath);
  }


  /**
   * 通过URI或路径，获取文件名。
   * @param uriOrPath URI或路径
   * @returns
   */
  static getFileName(uriOrPath: string): string {
    return Utils.getFileUri(uriOrPath).name;
  }

  /**
   * 通过URI或路径，获取文件路径
   * @param uriOrPath URI或路径
   * @returns
   */
  static getFilePath(uriOrPath: string): string {
    return Utils.getFileUri(uriOrPath).path;
  }


  /**
   * 以同步方法获取文件URI。
   * @param path 应用沙箱路径
   * @returns
   */
  static getUriFromPath(path: string): string {
    return fileUri.getUriFromPath(path);
  }


  /**
   * 根据文件名获取文件后缀
   * @param fileName 例如: test.txt  test.doc
   * @returns
   */
  static getFileExtention(fileName: string) {
    if (Utils.isNotEmpty(fileName) && fileName.includes(".")) {
      return fileName.substring(fileName.lastIndexOf(".") + 1);
    }
    return '';
  }



  /**
   * 打开文件，支持使用URI打开文件。使用Promise异步回调。
   * @param path string 文件的应用沙箱路径或URI。
   * @param mode number 打开文件的选项，必须指定如下选项中的一个，默认以只读方式打开。
   * @returns
   */
  static open(path: string, mode: number = fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE): Promise<fs.File> {
    return fs.open(path, mode);
  }

  /**
   * 打开文件，支持使用URI打开文件。以同步方法。
   * @param path string 文件的应用沙箱路径或URI。
   * @param mode number 打开文件的选项，必须指定如下选项中的一个，默认以只读方式打开。
   * @returns
   */
  static openSync(path: string, mode: number = fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE): fs.File {
    return fs.openSync(path, mode);
  }


  /**
   * 复制文件，使用Promise异步回调。
   * @param src string|number 待复制文件的路径或待复制文件的文件描述符。
   * @param dest string|number 目标文件路径或目标文件的文件描述符。
   * @param mode number 提供覆盖文件的选项，当前仅支持0，且默认为0。0：完全覆盖目标文件。
   * @returns
   */
  static copyFile(src: string | number, dest: string | number, mode: number = 0): Promise<void> {
    return fs.copyFile(src, dest, mode);
  }

  /**
   * 以同步方法复制文件。
   * @param src string|number 待复制文件的路径或待复制文件的文件描述符。
   * @param dest string|number 目标文件路径或目标文件的文件描述符。
   * @param mode number 提供覆盖文件的选项，当前仅支持0，且默认为0。0：完全覆盖目标文件。
   */
  static copyFileSync(src: string | number, dest: string | number, mode: number = 0) {
    fs.copyFileSync(src, dest, mode);
  }


  /**
   * 关闭文件，使用Promise异步回调。
   * @param file 已打开的File对象或已打开的文件描述符fd。
   * @returns
   */
  static close(file: fs.File | number): Promise<void> {
    return fs.close(file);
  }

  /**
   * 关闭文件，以同步方法。
   * @param file 已打开的File对象或已打开的文件描述符fd。
   */
  static closeSync(file: fs.File | number) {
    fs.closeSync(file);
  }


}
