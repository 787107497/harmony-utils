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
import fs, { ListFileOptions, ReadOptions, ReadTextOptions, WriteOptions } from '@ohos.file.fs';
import { StrUtil } from './StrUtil';
import { fileShare } from '@kit.CoreFileKit';

/**
 * TODO 文件操作相关工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class FileUtil {

  static readonly separator: string = '/';

  /**
   * 获取文件目录下的文件夹路径或文件路径。
   * @param dirPath 文件路径；支持完整路径和相对路径（download/wps/doc）；dirPath传空字符串表示根目录
   * @param fileName 文件名（test.text）；fileName传空字符串表示文件夹路径
   * @param blHap true：HAP级别文件路径、 false：App级别文件路径
   * @returns
   */
  static getFilesDirPath(dirPath: string = "", fileName: string = "", blHap: boolean = true): string {
    let filePath = blHap ? getContext().filesDir : getContext().getApplicationContext().filesDir; //根目录
    if (StrUtil.isNotEmpty(dirPath)) {
      if (StrUtil.startsWith(dirPath, filePath)) { //路径中包含根目录，是完整路径。
        filePath = dirPath;
      } else { //路径中不包含根目录，拼接成完整路径。
        filePath = filePath + FileUtil.separator + dirPath;
      }
      if (!FileUtil.accessSync(filePath)) {
        FileUtil.mkdirSync(filePath); //如果文件夹不存在就创建
      }
    }
    if (StrUtil.isNotEmpty(fileName)) {
      filePath = filePath + FileUtil.separator + fileName;
    }
    return filePath;
  }


  /**
   * 获取缓存目录下的文件夹路径或文件路径。
   * @param dirPath 文件路径；支持完整路径和相对路径（download/wps/doc）；dirPath传空字符串表示根目录
   * @param fileName 文件名（test.text）；fileName传空字符串表示文件夹路径
   * @param blHap true：HAP级别文件路径、 false：App级别文件路径
   * @returns
   */
  static getCacheDirPath(dirPath: string = "", fileName: string = "", blHap: boolean = true): string {
    let filePath = blHap ? getContext().cacheDir : getContext().getApplicationContext().cacheDir; //根目录
    if (StrUtil.isNotEmpty(dirPath)) {
      if (FileUtil.hasDirPath(dirPath)) { //路径中包含根目录，是完整路径。
        filePath = dirPath;
      } else { //路径中不包含根目录，拼接成完整路径。
        filePath = filePath + FileUtil.separator + dirPath;
      }
      if (!FileUtil.accessSync(filePath)) {
        FileUtil.mkdirSync(filePath); //如果文件夹不存在就创建
      }
    }
    if (StrUtil.isNotEmpty(fileName)) {
      filePath = filePath + FileUtil.separator + fileName;
    }
    return filePath;
  }


  /**
   * 获取临时目录下的文件夹路径或文件路径。
   * @param dirPath 文件路径；支持完整路径和相对路径（download/wps/doc）；dirPath传空字符串表示根目录
   * @param fileName 文件名（test.text）；fileName传空字符串表示文件夹路径
   * @param blHap true：HAP级别文件路径、 false：App级别文件路径
   * @returns
   */
  static getTempDirPath(dirPath: string = "", fileName: string = "", blHap: boolean = true): string {
    let filePath = blHap ? getContext().tempDir : getContext().getApplicationContext().tempDir; //根目录
    if (StrUtil.isNotEmpty(dirPath)) {
      if (FileUtil.hasDirPath(dirPath)) { //路径中包含根目录，是完整路径。
        filePath = dirPath;
      } else { //路径中不包含根目录，拼接成完整路径。
        filePath = filePath + FileUtil.separator + dirPath;
      }
      if (!FileUtil.accessSync(filePath)) {
        FileUtil.mkdirSync(filePath); //如果文件夹不存在就创建
      }
    }
    if (StrUtil.isNotEmpty(fileName)) {
      filePath = filePath + FileUtil.separator + fileName;
    }
    return filePath;
  }


  /**
   * 判断是否是完整路径
   * @param path 文件路径
   */
  static hasDirPath(path: string): boolean {
    return StrUtil.startsWith(path, "/data/storage/") || StrUtil.startsWith(path, "/storage/");
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
    return FileUtil.getFileUri(uriOrPath).name;
  }

  /**
   * 通过URI或路径，获取文件路径
   * @param uriOrPath URI或路径
   * @returns
   */
  static getFilePath(uriOrPath: string): string {
    return FileUtil.getFileUri(uriOrPath).path;
  }


  /**
   * 通过URI或路径，获取对应文件父目录的URI。
   * @param uriOrPath URI或路径
   */
  static getParentUri(uriOrPath: string): string {
    return FileUtil.getFileUri(uriOrPath).getFullDirectoryUri();
  }

  /**
   * 通过URI或路径，获取对应文件父目录的路径名。
   * @param uriOrPath URI或路径
   */
  static getParentPath(uriOrPath: string): string {
    const parentUri = FileUtil.getParentUri(uriOrPath);
    return FileUtil.getFilePath(parentUri)
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
    if (StrUtil.isNotEmpty(fileName) && fileName.includes(".")) {
      return fileName.substring(fileName.lastIndexOf(".") + 1);
    }
    return '';
  }


  /**
   * 获取指定文件夹下所有文件的大小或指定文件大小。
   * @param path 文件夹路径 或 文件路径
   */
  static getFileDirSize(path: string): number {
    if (FileUtil.accessSync(path)) { //path存在
      if (FileUtil.isDirectory(path)) { //文件夹
        let count: number = 0;
        FileUtil.listFileSync(path, { recursion: true }).forEach((filePath) => {
          count = count + FileUtil.lstatSync(path + filePath).size
        })
        return count;
      } else { //文件
        return FileUtil.lstatSync(path).size
      }
    }
    return 0;
  }


  /**
   * 判断文件是否是普通文件。
   * @param file string|number 文件应用沙箱路径path或已打开的文件描述符fd。
   * @returns
   */
  static isFile(file: string | number): boolean {
    return fs.statSync(file).isFile();
  }

  /**
   * 判断文件是否是目录。
   * @param file string|number 文件应用沙箱路径path或已打开的文件描述符fd。
   * @returns
   */
  static isDirectory(file: string | number): boolean {
    return fs.statSync(file).isDirectory();
  }


  /**
   * 重命名文件或文件夹，使用Promise异步回调。
   * @param oldPath string 文件的应用沙箱原路径。
   * @param newPath string 文件的应用沙箱新路径。
   * @returns
   */
  static rename(oldPath: string, newPath: string): Promise<void> {
    return fs.rename(oldPath, newPath);
  }

  /**
   * 重命名文件或文件夹，以同步方法。
   * @param oldPath string 文件的应用沙箱原路径。
   * @param newPath string 文件的应用沙箱新路径。
   * @returns
   */
  static renameSync(oldPath: string, newPath: string) {
    fs.renameSync(oldPath, newPath);
  }


  /**
   * 创建目录，当recursion指定为true，可多层级创建目录，使用Promise异步回调。
   * @param path 目录的应用沙箱路径。
   * @param recursion 是否多层级创建目录。recursion指定为true时，可多层级创建目录。recursion指定为false时，仅可创建单层目录。
   * @returns
   */
  static mkdir(path: string, recursion: boolean = true): Promise<void> {
    if (recursion) {
      return fs.mkdir(path, recursion);
    } else {
      return fs.mkdir(path);
    }
  }

  /**
   * 创建目录以同步方法，当recursion指定为true，可多层级创建目录。
   * @param path 目录的应用沙箱路径。
   * @param recursion 是否多层级创建目录。recursion指定为true时，可多层级创建目录。recursion指定为false时，仅可创建单层目录。
   */
  static mkdirSync(path: string, recursion: boolean = true) {
    if (recursion) {
      fs.mkdirSync(path, recursion);
    } else {
      fs.mkdirSync(path);
    }
  }


  /**
   * 删除整个目录，使用Promise异步回调。
   * @param path 目录的应用沙箱路径。
   * @returns
   */
  static rmdir(path: string): Promise<void> {
    return fs.rmdir(path);
  }

  /**
   * 删除整个目录，以同步方法。
   * @param path 目录的应用沙箱路径。
   */
  static rmdirSync(path: string) {
    return fs.rmdirSync(path);
  }


  /**
   * 删除单个文件，使用Promise异步回调。
   * @param path 文件的应用沙箱路径。
   * @returns
   */
  static unlink(path: string): Promise<void> {
    return fs.unlink(path);
  }

  /**
   * 删除单个文件，以同步方法。
   * @param path 文件的应用沙箱路径。
   * @returns
   */
  static unlinkSync(path: string) {
    fs.unlinkSync(path);
  }


  /**
   * 检查文件是否存在，使用Promise异步回调。
   * @param path 文件应用沙箱路径。
   * @returns
   */
  static access(path: string): Promise<boolean> {
    return fs.access(path);
  }

  /**
   * 检查文件是否存在，以同步方法。
   * @param path 文件应用沙箱路径。
   * @returns
   */
  static accessSync(path: string): boolean {
    return fs.accessSync(path);
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
   * 从文件读取数据，使用Promise异步回调。
   * @param fd number 已打开的文件描述符。
   * @param buffer ArrayBuffer 用于保存读取到的文件数据的缓冲区。
   * @param options 支持如下选项：
   *                 offset，number类型，表示期望读取文件的位置。可选，默认从当前位置开始读。
   *                 length，number类型，表示期望读取数据的长度。可选，默认缓冲区长度。
   * @returns
   */
  static read(fd: number, buffer: ArrayBuffer, options?: ReadOptions): Promise<number> {
    return fs.read(fd, buffer, options)
  }

  /**
   * 从文件读取数据，以同步方法。
   * @param fd number 已打开的文件描述符。
   * @param buffer ArrayBuffer 用于保存读取到的文件数据的缓冲区。
   * @param options 支持如下选项：
   *                 offset，number类型，表示期望读取文件的位置。可选，默认从当前位置开始读。
   *                 length，number类型，表示期望读取数据的长度。可选，默认缓冲区长度。
   * @returns
   */
  static readSync(fd: number, buffer: ArrayBuffer, options?: ReadOptions): number {
    return fs.readSync(fd, buffer, options)
  }

  /**
   * 基于文本方式读取文件（即直接读取文件的文本内容），使用Promise异步回调。
   * @param filePath 文件的应用沙箱路径。
   * @param options 支持如下选项：
   *                 offset，number类型，表示期望读取文件的位置。可选，默认从当前位置开始读取。
   *                 length，number类型，表示期望读取数据的长度。可选，默认文件长度。
   *                 encoding，string类型，当数据是 string 类型时有效，表示数据的编码方式，默认 'utf-8'，仅支持 'utf-8'。
   * @returns
   */
  static readText(filePath: string, options?: ReadTextOptions): Promise<string> {
    return fs.readText(filePath, options);
  }

  /**
   * 基于文本方式读取文件（即直接读取文件的文本内容），以同步方法。
   * @param filePath 文件的应用沙箱路径。
   * @param options 支持如下选项：
   *                 offset，number类型，表示期望读取文件的位置。可选，默认从当前位置开始读取。
   *                 length，number类型，表示期望读取数据的长度。可选，默认文件长度。
   *                 encoding，string类型，当数据是 string 类型时有效，表示数据的编码方式，默认 'utf-8'，仅支持 'utf-8'。
   * @returns
   */
  static readTextSync(filePath: string, options?: ReadTextOptions): string {
    return fs.readTextSync(filePath, options);
  }


  /**
   * 将数据写入文件，使用Promise异步回调。
   * @param fd number 已打开的文件描述符。
   * @param buffer ArrayBuffer|string 待写入文件的数据，可来自缓冲区或字符串。
   * @param options 支持如下选项：
   *                 offset，number类型，表示期望写入文件的位置。可选，默认从当前位置开始写。
   *                 length，number类型，表示期望写入数据的长度。可选，默认缓冲区长度。
   *                 encoding，string类型，当数据是string类型时有效，表示数据的编码方式，默认 'utf-8'。当前仅支持 'utf-8'。
   * @returns Promise对象。返回实际写入的数据长度，单位字节。
   */
  static write(fd: number, buffer: ArrayBuffer | string, options?: WriteOptions): Promise<number> {
    return fs.write(fd, buffer, options)
  }

  /**
   * 将数据写入文件，以同步方法。
   * @param fd number 已打开的文件描述符。
   * @param buffer ArrayBuffer|string 待写入文件的数据，可来自缓冲区或字符串。
   * @param options 支持如下选项：
   *                 offset，number类型，表示期望写入文件的位置。可选，默认从当前位置开始写。
   *                 length，number类型，表示期望写入数据的长度。可选，默认缓冲区长度。
   *                 encoding，string类型，当数据是string类型时有效，表示数据的编码方式，默认 'utf-8'。当前仅支持 'utf-8'。
   * @returns 返回实际写入的数据长度，单位字节。
   */
  static writeSync(fd: number, buffer: ArrayBuffer | string, options?: WriteOptions): number {
    return fs.writeSync(fd, buffer, options)
  }

  /**
   * 将数据写入文件，并关闭文件。
   * @param path string 文件的应用沙箱路径或URI。
   * @param buffer ArrayBuffer|string 待写入文件的数据，可来自缓冲区或字符串。
   * @param append 是否追加，true-追加，false-不追加（直接覆盖）
   * @returns Promise对象。返回实际写入的数据长度，单位字节。
   */
  static async writeEasy(path: string, buffer: ArrayBuffer | string, append: boolean = true): Promise<number> {
    const file = FileUtil.openSync(path, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
    const offset = append ? FileUtil.statSync(file.fd).size : 0
    const options: WriteOptions = { offset: offset, encoding: 'utf-8' };
    let result = await FileUtil.write(file.fd, buffer, options);
    FileUtil.close(file.fd); //关闭文件
    return result;
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


  /**
   * 列出文件夹下所有文件名，支持递归列出所有文件名（包含子目录下），支持文件过滤，使用Promise异步回调。
   * @param path string 文件夹的应用沙箱路径。
   * @param options 文件过滤选项。默认不进行过滤。
   *                  recursion boolean 是否递归子目录下文件名，默认为false。
   *                  listNum number 列出文件名数量。当设置0时，列出所有文件，默认为0。
   *                  filter Filter 文件过滤选项。当前仅支持后缀名匹配、文件名模糊查询、文件大小过滤、最近修改时间过滤。
   * @returns
   */
  static listFile(path: string, options?: ListFileOptions): Promise<string[]> {
    return fs.listFile(path, options);
  }

  /**
   * 列出文件夹下所有文件名，支持递归列出所有文件名（包含子目录下），支持文件过滤，以同步方法。
   * @param path string 文件夹的应用沙箱路径。
   * @param options 文件过滤选项。默认不进行过滤。
   *                  recursion boolean 是否递归子目录下文件名，默认为false。
   *                  listNum number 列出文件名数量。当设置0时，列出所有文件，默认为0。
   *                  filter Filter 文件过滤选项。当前仅支持后缀名匹配、文件名模糊查询、文件大小过滤、最近修改时间过滤。
   * @returns
   */
  static listFileSync(path: string, options?: ListFileOptions): string[] {
    return fs.listFileSync(path, options);
  }


  /**
   * 获取文件详细属性信息，使用Promise异步回调。
   * @param file string|number 文件应用沙箱路径path或已打开的文件描述符fd。
   */
  static stat(file: string | number): Promise<fs.Stat> {
    return fs.stat(file);
  }

  /**
   * 获取文件详细属性信息，以同步方法。
   * @param file string|number 文件应用沙箱路径path或已打开的文件描述符fd。
   * @returns
   */
  static statSync(file: string | number): fs.Stat {
    return fs.statSync(file);
  }


  /**
   * 拷贝文件或者目录，支持拷贝进度监听，使用Promise异步返回。
   * @param srcUri 待复制文件或目录的uri。
   * @param destUri 目标文件或目录的uri。
   * @param options options中提供拷贝进度回调：
   *           ProgressListener 拷贝进度监听。
   * @returns
   */
  static copy(srcUri: string, destUri: string, options?: fs.CopyOptions): Promise<void> {
    return fs.copy(srcUri, destUri, options);
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
   * 复制源文件夹至目标路径下，只能复制沙箱里的文件夹，使用Promise异步返回。
   * @param src 源文件夹的应用沙箱路径。
   * @param dest 目标文件夹的应用沙箱路径。
   * @param mode 复制模式:
   *    mode为0，文件级别抛异常。目标文件夹下存在与源文件夹名冲突的文件夹，若冲突文件夹下存在同名文件，则抛出异常。源文件夹下未冲突的文件全部移动至目标文件夹下，目标文件夹下未冲突文件将继续保留，且冲突文件信息将在抛出异常的data属性中以Array<ConflictFiles>形式提供。
   *    mode为1，文件级别强制覆盖。目标文件夹下存在与源文件夹名冲突的文件夹，若冲突文件夹下存在同名文件，则强制覆盖冲突文件夹下所有同名文件，未冲突文件将继续保留。
   * @returns
   */
  static copyDir(src: string, dest: string, mode: number = 1): Promise<void> {
    return fs.copyDir(src, dest, mode);
  }

  /**
   * 以同步方法复制源文件夹至目标路径下，只能复制沙箱里的文件夹。
   * @param src 源文件夹的应用沙箱路径。
   * @param dest 目标文件夹的应用沙箱路径。
   * @param mode 复制模式:
   *    mode为0，文件级别抛异常。目标文件夹下存在与源文件夹名冲突的文件夹，若冲突文件夹下存在同名文件，则抛出异常。源文件夹下未冲突的文件全部移动至目标文件夹下，目标文件夹下未冲突文件将继续保留，且冲突文件信息将在抛出异常的data属性中以Array<ConflictFiles>形式提供。
   *    mode为1，文件级别强制覆盖。目标文件夹下存在与源文件夹名冲突的文件夹，若冲突文件夹下存在同名文件，则强制覆盖冲突文件夹下所有同名文件，未冲突文件将继续保留。
   * @returns
   */
  static copyDirSync(src: string, dest: string, mode: number = 1) {
    fs.copyDirSync(src, dest, mode);
  }


  /**
   * 移动文件，使用Promise异步回调。
   * @param src string 源文件的应用沙箱路径。
   * @param dest string 目的文件的应用沙箱路径。
   * @param mode number 移动模式。若mode为0，移动位置存在同名文件时，强制移动覆盖。若mode为1，移动位置存在同名文件时，抛出异常。默认为0。
   * @returns
   */
  static moveFile(src: string, dest: string, mode: number = 0): Promise<void> {
    return fs.moveFile(src, dest, mode)
  }

  /**
   * 移动文件，以同步方法。
   * @param src string 源文件的应用沙箱路径。
   * @param dest string 目的文件的应用沙箱路径。
   * @param mode number 移动模式。若mode为0，移动位置存在同名文件时，强制移动覆盖。若mode为1，移动位置存在同名文件时，抛出异常。默认为0。
   * @returns
   */
  static moveFileSync(src: string, dest: string, mode: number = 0) {
    fs.moveFileSync(src, dest, mode)
  }

  /**
   * 移动源文件夹至目标路径下，使用Promise异步返回。
   * @param src 源文件夹的应用沙箱路径
   * @param dest 目标文件夹的应用沙箱路径
   * @param mode 移动模式:
   *   mode为0，文件夹级别抛异常。若目标文件夹下存在与源文件夹名冲突的非空文件夹，则抛出异常。
   *   mode为1，文件级别抛异常。目标文件夹下存在与源文件夹名冲突的文件夹，若冲突文件夹下存在同名文件，则抛出异常。源文件夹下未冲突的文件全部移动至目标文件夹下，目标文件夹下未冲突文件将继续保留，且冲突文件信息将在抛出异常的data属性中以Array<ConflictFiles>形式提供。
   *   mode为2，文件级别强制覆盖。目标文件夹下存在与源文件夹名冲突的文件夹，若冲突文件夹下存在同名文件，则强制覆盖冲突文件夹下所有同名文件，未冲突文件将继续保留。
   *   mode为3，文件夹级别强制覆盖。移动源文件夹至目标文件夹下，目标文件夹下移动的文件夹内容与源文件夹完全一致。若目标文件夹下存在与源文件夹名冲突的文件夹，该文件夹下所有原始文件将不会保留。
   * @returns
   */
  static moveDir(src: string, dest: string, mode: number = 3): Promise<void> {
    return fs.moveDir(src, dest, mode);
  }

  /**
   * 以同步方法移动源文件夹至目标路径下。
   * @param src 源文件夹的应用沙箱路径
   * @param dest 目标文件夹的应用沙箱路径
   * @param mode 移动模式:
   *   mode为0，文件夹级别抛异常。若目标文件夹下存在与源文件夹名冲突的非空文件夹，则抛出异常。
   *   mode为1，文件级别抛异常。目标文件夹下存在与源文件夹名冲突的文件夹，若冲突文件夹下存在同名文件，则抛出异常。源文件夹下未冲突的文件全部移动至目标文件夹下，目标文件夹下未冲突文件将继续保留，且冲突文件信息将在抛出异常的data属性中以Array<ConflictFiles>形式提供。
   *   mode为2，文件级别强制覆盖。目标文件夹下存在与源文件夹名冲突的文件夹，若冲突文件夹下存在同名文件，则强制覆盖冲突文件夹下所有同名文件，未冲突文件将继续保留。
   *   mode为3，文件夹级别强制覆盖。移动源文件夹至目标文件夹下，目标文件夹下移动的文件夹内容与源文件夹完全一致。若目标文件夹下存在与源文件夹名冲突的文件夹，该文件夹下所有原始文件将不会保留。
   * @returns
   */
  static moveDirSync(src: string, dest: string, mode: number = 3) {
    return fs.moveDirSync(src, dest, mode);
  }


  /**
   * 截断文件，使用Promise异步回调。
   * @param file string|number 文件的应用沙箱路径或已打开的文件描述符fd。
   * @param len number 文件截断后的长度，以字节为单位。默认为0。
   * @returns
   */
  static truncate(file: string | number, len: number = 0): Promise<void> {
    return fs.truncate(file, len)
  }

  /**
   * 截断文件，以同步方法。
   * @param file string|number 文件的应用沙箱路径或已打开的文件描述符fd。
   * @param len number 文件截断后的长度，以字节为单位。默认为0。
   * @returns
   */
  static truncateSync(file: string | number, len: number = 0) {
    fs.truncateSync(file, len)
  }


  /**
   * 获取链接文件信息，使用Promise异步回调。
   * @param path string 文件的应用沙箱路径。
   * @returns
   */
  static lstat(path: string): Promise<fs.Stat> {
    return fs.lstat(path);
  }

  /**
   * 获取链接文件信息，以同步方法。
   * @param path string 文件的应用沙箱路径。
   * @returns
   */
  static lstatSync(path: string): fs.Stat {
    return fs.lstatSync(path);
  }


  /**
   * 同步文件数据，使用Promise异步回调。
   * @param fd number 已打开的文件描述符。
   * @returns
   */
  static fsync(fd: number): Promise<void> {
    return fs.fsync(fd);
  }

  /**
   * 同步文件数据，以同步方法。
   * @param fd number 已打开的文件描述符。
   */
  static fsyncSync(fd: number) {
    fs.fsyncSync(fd);
  }


  /**
   * 实现文件内容数据同步，使用Promise异步回调。
   * @param fd number 已打开的文件描述符。
   * @returns
   */
  static fdatasync(fd: number): Promise<void> {
    return fs.fdatasync(fd);
  }

  /**
   * 实现文件内容数据同步，以同步方法。
   * @param fd number 已打开的文件描述符。
   */
  static fdatasyncSync(fd: number) {
    fs.fdatasyncSync(fd);
  }


  /**
   * 基于文件路径打开文件流，使用Promise异步回调。
   * @param path string 文件的应用沙箱路径。
   * @param mode string 文件打开类型
   *                    r：打开只读文件，该文件必须存在。
   *                    r+：打开可读写的文件，该文件必须存在。
   *                    w：打开只写文件，若文件存在则文件长度清0，即该文件内容会消失。若文件不存在则建立该文件。
   *                    w+：打开可读写文件，若文件存在则文件长度清0，即该文件内容会消失。若文件不存在则建立该文件。
   *                    a：以附加的方式打开只写文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾，即文件原先的内容会被保留。
   *                    a+：以附加方式打开可读写的文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾后，即文件原先的内容会被保留。
   * @returns
   */
  static createStream(path: string, mode: string = 'r'): Promise<fs.Stream> {
    return fs.createStream(path, mode)
  }

  /**
   * 基于文件路径打开文件流，以同步方法。
   * @param path string 文件的应用沙箱路径。
   * @param mode string 文件打开类型
   *                    r：打开只读文件，该文件必须存在。
   *                    r+：打开可读写的文件，该文件必须存在。
   *                    w：打开只写文件，若文件存在则文件长度清0，即该文件内容会消失。若文件不存在则建立该文件。
   *                    w+：打开可读写文件，若文件存在则文件长度清0，即该文件内容会消失。若文件不存在则建立该文件。
   *                    a：以附加的方式打开只写文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾，即文件原先的内容会被保留。
   *                    a+：以附加方式打开可读写的文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾后，即文件原先的内容会被保留。
   * @returns
   */
  static createStreamSync(path: string, mode: string = 'r'): fs.Stream {
    return fs.createStreamSync(path, mode);
  }

  /**
   * 基于文件描述符打开文件流，使用Promise异步回调。
   * @param fd number 已打开的文件描述符。
   * @param mode string 文件打开类型
   *                    r：打开只读文件，该文件必须存在。
   *                    r+：打开可读写的文件，该文件必须存在。
   *                    w：打开只写文件，若文件存在则文件长度清0，即该文件内容会消失。若文件不存在则建立该文件。
   *                    w+：打开可读写文件，若文件存在则文件长度清0，即该文件内容会消失。若文件不存在则建立该文件。
   *                    a：以附加的方式打开只写文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾，即文件原先的内容会被保留。
   *                    a+：以附加方式打开可读写的文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾后，即文件原先的内容会被保留。
   * @returns
   */
  static fdopenStream(fd: number, mode: string = 'r'): Promise<fs.Stream> {
    return fs.fdopenStream(fd, mode)
  }

  /**
   * 基于文件描述符打开文件流，以同步方法。
   * @param fd number 已打开的文件描述符。
   * @param mode string 文件打开类型
   *                    r：打开只读文件，该文件必须存在。
   *                    r+：打开可读写的文件，该文件必须存在。
   *                    w：打开只写文件，若文件存在则文件长度清0，即该文件内容会消失。若文件不存在则建立该文件。
   *                    w+：打开可读写文件，若文件存在则文件长度清0，即该文件内容会消失。若文件不存在则建立该文件。
   *                    a：以附加的方式打开只写文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾，即文件原先的内容会被保留。
   *                    a+：以附加方式打开可读写的文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾后，即文件原先的内容会被保留。
   * @returns
   */
  static fdopenStreamSync(fd: number, mode: string = 'r'): fs.Stream {
    return fs.fdopenStreamSync(fd, mode)
  }


  /**
   * 创建临时目录，使用Promise异步回调。
   * @param prefix string 用随机产生的字符串替换以“XXXXXX”结尾目录路径。
   * @returns
   */
  static mkdtemp(prefix: string): Promise<string> {
    return fs.mkdtemp(prefix);
  }

  /**
   * 创建临时目录，以同步的方法。
   * @param prefix string 用随机产生的字符串替换以“XXXXXX”结尾目录路径。
   * @returns
   */
  static mkdtempSync(prefix: string): string {
    return fs.mkdtempSync(prefix);
  }


  /**
   * 将文件描述符转化为File。
   * @param fd 文件描述符。
   * @returns
   */
  static dup(fd: number): fs.File {
    return fs.dup(fd);
  }


  /**
   * 修改文件最近访问时间属性。
   * path 文件的应用沙箱路径。
   * mtime 待更新的时间戳。自1970年1月1日起至目标时间的毫秒数。仅支持修改文件最近访问时间属性。
   * @returns
   */
  static utimes(path: string, mtime: number): void {
    fs.utimes(path, mtime);
  }


  /**
   * 格式化文件大小
   * @param bytes 文件大小（字节）
   * @param decimals 保留的小数位数，默认为 2
   * @returns 格式化后的文件大小字符串
   */
  static getFormatFileSize(bytes: number, decimals: number = 2): string {
    if (bytes === 0) return '0B';
    const K = 1024;
    const sizes = ['B', 'KB', 'MB', 'GB', 'TB'];
    const i = Math.floor(Math.log(bytes) / Math.log(K));
    const formatSize = parseFloat((bytes / Math.pow(K, i)).toFixed(decimals));
    return `${formatSize}${sizes[i]}`;
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
