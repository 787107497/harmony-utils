/**
 * 日期工具类
 */

export class DateUtil {

  private constructor() {}


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
   * @param formatStr 格式化字符串
   * @returns
   */
  static getTodayStr(formatStr?: string): string {
    return DateUtil.getFormatDateStr(new Date(), formatStr)
  }

  /**
   * 获取格式化日期，将传入的日期格式化为Date
   * @param date
   * @returns
   */
  static getFormatDate(date: number | string | Date | undefined): Date {
    if (date == undefined || date == null) { //无参数
      date = new Date();
    } else if (typeof (date) == "string") { //字符串日期
      if (date.length == 0) {
        date = new Date();
      } else {
        let dateStr = date.replace("-", '/')
          .replace("年", '/').replace("月", '/').replace("日", ' ')
          .replace("时", ':').replace("分", ':').replace("秒", '')
        date = new Date(dateStr);
      }
    } else if (typeof (date) == "number") { //时间戳
      date = new Date(date);
    } else {
      date = new Date(date);
    }
    return date;
  }

  /**
   * 获取格式化日期，将传入的日期格式化为指定格式的字符串
   * @param date
   * @param formatStr 格式化字符串
   * @returns
   */
  static getFormatDateStr(date: number | string | Date, formatStr?: string): string {
    date = DateUtil.getFormatDate(date)
    if (formatStr === undefined || formatStr == '') {
      formatStr = "yyyy-MM-dd HH:mm:ss"; //yyyy-MM-dd HH:mm:ss.fff
    }
    const year = date.getFullYear();
    const month = DateUtil.padZero(date.getMonth() + 1);
    const day = DateUtil.padZero(date.getDate());
    const hours = DateUtil.padZero(date.getHours());
    const minutes = DateUtil.padZero(date.getMinutes());
    const seconds = DateUtil.padZero(date.getSeconds());
    let formattedDate = formatStr.replace("yyyy", year.toString());
    formattedDate = formattedDate.replace("MM", month);
    formattedDate = formattedDate.replace("dd", day);
    formattedDate = formattedDate.replace("HH", hours);
    formattedDate = formattedDate.replace("mm", minutes);
    formattedDate = formattedDate.replace("ss", seconds);
    return formattedDate;
  }

  /**
   * 格式化时间戳，获取提示性时间字符串
   * @param timeStamp
   *   时间戳：10位时间戳:表示从1970年1月1日00:00:00 GMT开始计算的秒数，精度为秒。
   *          13位时间戳:表示从1970年1月1日00:00:00 GMT开始计算的毫秒数，精度为毫秒。
   * @returns
   */
  static getTipDateStr(timeStamp: number): string {
    let timeMs = timeStamp;
    if (timeStamp.toString().length == 10) {
      timeMs = timeStamp * 1000 //如果是10位的时间戳转化为13位的
    }
    let dateNow = new Date();
    let dateUp = new Date(timeMs);
    if (dateNow.getTime() - timeMs < 60 * 1000) {
      return "刚刚";
    } else if (dateNow.getTime() - timeMs < 60 * 60 * 1000) {
      return ((dateNow.getTime() - timeMs) / (60 * 1000)).toFixed() + "分钟前";
    } else if (dateNow.getTime() - timeMs < 24 * 60 * 60 * 1000) {
      return ((dateNow.getTime() - timeMs) / (60 * 60 * 1000)).toFixed() + "小时前";
    } else if (dateNow.getTime() - timeMs < 360 * 24 * 60 * 60 * 1000) {
      return DateUtil.getFormatDateStr(dateUp, "MM月dd日");
    } else {
      return DateUtil.getFormatDateStr(dateUp, "yyyy-MM-dd");
    }
  }


  /**
   * 获取两个Date的日期差单位为天
   * @param startDate  开始日期
   * @param endDate  结束日期
   * @returns
   */
  static getDateDiff(startDate: number | string | Date, endDate: number | string | Date): number {
    const oneDay = 24 * 3600 * 1000; //一天的毫秒数
    let startDateTime = DateUtil.getFormatDate(startDate).getTime();
    let endDateTime = DateUtil.getFormatDate(endDate).getTime();
    const difference = Math.floor((endDateTime - startDateTime) / oneDay); //计算差值天数
    return difference;
  }


  /**
   * 判断传入字符串是否是日期字符串
   * @param value 待验证的字符串
   * @returns
   */
  static isDate(value: string): boolean {
    //需要循环常量中的时间格式看看是否符合，符合极为日期类型
    const dateTimeRegex = /^(?:(?:\d{4}(?:\/|-)\d{1,2}(?:\/|-)\d{1,2})|(?:\d{1,2}:\d{1,2}(:\d{1,2})?))(\s(?:\d{1,2}:\d{1,2}:\d{1,2}))?$/;
    return dateTimeRegex.test(value);
  }


  /**
   * 补零操作
   * @param num
   * @returns
   */
  private static padZero(num: number): string {
    return num.toString().padStart(2, "0");
  }

}