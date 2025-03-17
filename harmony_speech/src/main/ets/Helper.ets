import { fileUri } from "@kit.CoreFileKit";
import fs, { ListFileOptions, ReadOptions, ReadTextOptions, WriteOptions } from '@ohos.file.fs';

/**
 * 工具类 */
export class Helper {
  static readonly separator: string = '/';

  /**
   * 判断字符串是否为空(undefined、null)
   * @param str 被检测的字符串
   * @returns 是否为空
   */
  static isNull(str: string | undefined | null): boolean {
    return str === undefined || str === null;
  }

  /**
   * 判断字符串是否为非空。true为非空空，否则false
   * @param str
   * @returns
   */
  static isNotNull(str: string | undefined | null): boolean {
    return false === Helper.isNull(str);
  }

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
    return false === Helper.isEmpty(str);
  }

  /**
   * 判断字符串是否以给定的字符串开头
   * @param string 要检索的字符串
   * @param target 要检索字符
   * @param position 检索的位置
   * @returns
   */
  static startsWith(string: string = '', target: string, position: number = 0): boolean {
    return string.startsWith(target, position);
  }


  /**
   * 获取格式化日期，将传入的日期格式化为Date
   * @param date
   * @returns
   */
  static getFormatDate(date?: number | string | Date): Date {
    if (date == undefined || date == null) { //无参数
      date = new Date();
    } else if (typeof date == "string") { //字符串日期
      if (date.length == 0) {
        date = new Date();
      } else {
        if (date.toString().length == 10 || date.toString().length == 13) {
          date = Helper.parseTimestamp(date); //将字符串时间戳 转为 number
          if (typeof date == 'number') {
            date = new Date(date);
            return date;
          }
        }
        let dateStr = date.replaceAll("-", '/')
          .replace("年", '/')
          .replace("月", '/')
          .replace("日", ' ')
          .replace('  ', ' ')
          .replace("时", ':')
          .replace("分", ':')
          .replace("秒", '')
        if (dateStr.endsWith('/') || dateStr.endsWith(':') || dateStr.endsWith(' ')) {
          dateStr = dateStr.substring(0, dateStr.length - 1);
        }
        if (dateStr.length == 13 && dateStr.includes(' ')) {
          dateStr = dateStr + ':00'; //yyyy-MM-dd HH，需要补齐分钟。
        }
        date = new Date(dateStr);
      }
    } else if (typeof date == "number") { //时间戳
      if (date.toString().length == 10) {
        date = date * 1000; //如果是10位时间戳转为13位
      }
      date = new Date(date);
    } else {
      date = new Date(date);
    }
    return date;
  }


  /**
   * 获取格式化日期，将传入的日期格式化为指定格式的字符串
   * @param date
   * @param format 格式化字符串,(yyyy-MM-dd HH:mm:ss)
   * @returns
   */
  static getFormatDateStr(date: number | string | Date, format?: string): string {
    date = Helper.getFormatDate(date)
    if (format === undefined || format.length <= 0) {
      format = 'yyyy-MM-dd HH:mm:ss'; //yyyy-MM-dd HH:mm:ss
    }
    let year = date.getFullYear(); //年份，例如 2024
    let month = Helper.padZero(date.getMonth() + 1); //月份，0-11，0 表示一月，11 表示十二月
    let day = Helper.padZero(date.getDate()); //日期，1-31
    let hours = Helper.padZero(date.getHours()); //小时，0-23
    let minutes = Helper.padZero(date.getMinutes()); //分钟，0-59
    let seconds = Helper.padZero(date.getSeconds()); //秒数，0-59
    let millisecond = date.getMilliseconds(); //毫秒数，0-999
    let formattedDate = format.replace("yyyy", year.toString());
    formattedDate = formattedDate.replace("MM", month);
    formattedDate = formattedDate.replace("dd", day);
    formattedDate = formattedDate.replace("HH", hours);
    formattedDate = formattedDate.replace("mm", minutes);
    formattedDate = formattedDate.replace("ss", seconds);
    formattedDate = formattedDate.replace("fff", millisecond.toString());
    return formattedDate;
  }


  /**
   * 获取今天的日期
   * @returns
   */
  static getToday(): Date {
    return new Date();
  }

  /**
   * 获取今天的时间戳
   * @returns
   */
  static getTodayTime(): number {
    return new Date().getTime();
  }

  /**
   * 获取今天的时间，字符串类型
   * @param format 格式化字符串,(yyyy-MM-dd HH:mm:ss)
   * @returns
   */
  static getTodayStr(format?: string): string {
    return Helper.getFormatDateStr(new Date(), format)
  }



  /**
   * 获取文件目录下的文件夹路径或文件路径。
   * @param dirPath 文件路径；支持完整路径和相对路径（download/wps/doc）；dirPath传空字符串表示根目录
   * @param fileName 文件名（test.text）；fileName传空字符串表示文件夹路径
   * @param blHap true：HAP级别文件路径、 false：App级别文件路径
   * @returns
   */
  static getFilesDirPath(dirPath: string = "", fileName: string = "", blHap: boolean = true): string {
    let filePath = blHap ? getContext().filesDir : getContext().getApplicationContext().filesDir; //根目录
    if (Helper.isNotEmpty(dirPath)) {
      if (Helper.startsWith(dirPath, filePath)) { //路径中包含根目录，是完整路径。
        filePath = dirPath;
      } else { //路径中不包含根目录，拼接成完整路径。
        filePath = filePath + Helper.separator + dirPath;
      }
      if (!Helper.accessSync(filePath)) {
        Helper.mkdirSync(filePath) //如果文件夹不存在就创建
      }
    }
    if (Helper.isNotEmpty(fileName)) {
      filePath = filePath + Helper.separator + fileName;
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
    if (Helper.isNotEmpty(dirPath)) {
      if (Helper.hasDirPath(dirPath)) { //路径中包含根目录，是完整路径。
        filePath = dirPath;
      } else { //路径中不包含根目录，拼接成完整路径。
        filePath = filePath + Helper.separator + dirPath;
      }
      if (!Helper.accessSync(filePath)) {
        Helper.mkdirSync(filePath) //如果文件夹不存在就创建
      }
    }
    if (Helper.isNotEmpty(fileName)) {
      filePath = filePath + Helper.separator + fileName;
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
    if (Helper.isNotEmpty(dirPath)) {
      if (Helper.hasDirPath(dirPath)) { //路径中包含根目录，是完整路径。
        filePath = dirPath;
      } else { //路径中不包含根目录，拼接成完整路径。
        filePath = filePath + Helper.separator + dirPath;
      }
      if (!Helper.accessSync(filePath)) {
        Helper.mkdirSync(filePath) //如果文件夹不存在就创建
      }
    }
    if (Helper.isNotEmpty(fileName)) {
      filePath = filePath + Helper.separator + fileName;
    }
    return filePath;
  }


  /**
   * 判断是否是完整路径
   * @param path 文件路径
   */
  static hasDirPath(path: string): boolean {
    return Helper.startsWith(path, "/data/storage/") || Helper.startsWith(path, "/storage/");
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
    return Helper.getFileUri(uriOrPath).name;
  }

  /**
   * 通过URI或路径，获取文件路径
   * @param uriOrPath URI或路径
   * @returns
   */
  static getFilePath(uriOrPath: string): string {
    return Helper.getFileUri(uriOrPath).path;
  }

  /**
   * 通过URI或路径，获取对应文件父目录的URI。
   * @param uriOrPath URI或路径
   */
  static getParentUri(uriOrPath: string): string {
    return Helper.getFileUri(uriOrPath).getFullDirectoryUri();
  }

  /**
   * 通过URI或路径，获取对应文件父目录的路径名。
   * @param uriOrPath URI或路径
   */
  static getParentPath(uriOrPath: string): string {
    const parentUri = Helper.getParentUri(uriOrPath);
    return Helper.getFilePath(parentUri)
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
    if (Helper.isNotEmpty(fileName) && fileName.includes(".")) {
      return fileName.substring(fileName.lastIndexOf(".") + 1);
    }
    return '';
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
   * 打开文件，支持使用URI打开文件。以同步方法。
   * @param path string 文件的应用沙箱路径或URI。
   * @param mode number 打开文件的选项，必须指定如下选项中的一个，默认以只读方式打开。
   * @returns
   */
  static openSync(path: string, mode: number = fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE): fs.File {
    return fs.openSync(path, mode);
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
   * 补零操作
   * @param num
   * @returns
   */
  private static padZero(num: number): string {
    return num.toString().padStart(2, "0");
  }


  /**
   * 格式化字符串时间戳。
   * @param value
   * @param defaultValue
   * @returns
   */
  private static parseTimestamp(value: string): number | string {
    try {
      let parsedValue = parseFloat(value);
      if (isNaN(parsedValue)) {
        return value;
      }
      if (parsedValue.toString().length != value.length) {
        return value;
      }
      if (parsedValue.toString().length == 10) {
        parsedValue = parsedValue * 1000; //如果是10位时间戳转为13位
      }
      return parsedValue;
    } catch (e) {
      return value //不是时间戳，直接返回
    }
  }


}