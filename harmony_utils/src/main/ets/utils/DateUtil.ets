import { i18n, intl } from '@kit.LocalizationKit';
import { NumberUtil } from './NumberUtil';

/**
 * TODO 日期工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class DateUtil {

  private constructor() {}

  /**
   * 获取格式化日期，将传入的日期格式化为Date
   * @param date
   * @returns
   */
  static getFormatDate(date: number | string | Date | undefined): Date {
    if (date && typeof date == 'string' && (date.toString().length == 10 || date.toString().length == 13)) {
      date = DateUtil.toNumber(date); //将字符串时间戳 转为 number
    }
    if (date == undefined || date == null) { //无参数
      date = new Date();
    } else if (typeof (date) == "string") { //字符串日期
      if (date.length == 0) {
        date = new Date();
      } else {
        let dateStr = date.replaceAll("-", '/')
          .replace("年", '/')
          .replace("月", '/')
          .replace("日", ' ')
          .replace("  ", ' ')
          .replace("时", ':')
          .replace("分", ':')
          .replace("秒", '')
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
   * @param format 格式化字符串,(yyyy-MM-dd HH:mm:ss)
   * @returns
   */
  static getFormatDateStr(date: number | string | Date, format?: string): string {
    date = DateUtil.getFormatDate(date)
    if (format === undefined || format == '') {
      format = "yyyy-MM-dd HH:mm:ss"; //yyyy-MM-dd HH:mm:ss.fff
    }
    const year = date.getFullYear();
    const month = DateUtil.padZero(date.getMonth() + 1);
    const day = DateUtil.padZero(date.getDate());
    const hours = DateUtil.padZero(date.getHours());
    const minutes = DateUtil.padZero(date.getMinutes());
    const seconds = DateUtil.padZero(date.getSeconds());
    let formattedDate = format.replace("yyyy", year.toString());
    formattedDate = formattedDate.replace("MM", month);
    formattedDate = formattedDate.replace("dd", day);
    formattedDate = formattedDate.replace("HH", hours);
    formattedDate = formattedDate.replace("mm", minutes);
    formattedDate = formattedDate.replace("ss", seconds);
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
    return DateUtil.getFormatDateStr(new Date(), format)
  }

  /**
   * 判断日期是否是今天
   */
  static isToday(date: number | string | Date) {
    let today = DateUtil.getTodayStr("yyyy-MM-dd");
    let day = DateUtil.getFormatDateStr(date, "yyyy-MM-dd")
    return today === day;
  }


  /**
   * 获取当前年
   */
  static getNowYear(): number {
    let date = new Date();
    return date.getFullYear();
  }

  /**
   * 获取当前月
   */
  static getNowMonth(): number {
    let date = new Date();
    return date.getMonth() + 1;
  }

  /**
   * 获取当前日
   */
  static getNowDay(): number {
    let date = new Date();
    return date.getDate();
  }


  /**
   * 判断是否是闰年
   * @param year 不传为当前年
   * @returns
   */
  static isLeapYear(year: number | Date = new Date()): boolean {
    year = year instanceof Date ? year.getFullYear() : year;
    return (year % 4 === 0 && year % 100 !== 0) || year % 400 === 0;
  }

  /**
   * 获取指定年份的天数
   */
  static getDaysByYear(year: number): number {
    if (DateUtil.isLeapYear(year)) {
      return 366;
    } else {
      return 365;
    }
  }

  /**
   * 获取指定月份的天数
   */
  static getDaysByMonth(year: number, month: number): number {
    if (month == 2) {
      if (DateUtil.isLeapYear(year)) {
        return 29;
      } else {
        return 28;
      }
    } else if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
      return 31;
    } else {
      return 30;
    }
  }


  /**
   * 判断两个日期是否是同一年
   */
  static isSameYear(date1: number | string | Date, date2: number | string | Date) {
    date1 = DateUtil.getFormatDate(date1);
    date2 = DateUtil.getFormatDate(date2);
    let blSameYear = date1.getFullYear() === date2.getFullYear();
    return blSameYear;
  }

  /**
   * 判断两个日期是否是同一月
   */
  static isSameMonth(date1: number | string | Date, date2: number | string | Date) {
    date1 = DateUtil.getFormatDate(date1);
    date2 = DateUtil.getFormatDate(date2);
    let blSameYear = date1.getFullYear() === date2.getFullYear();
    let blSameMonth = date1.getMonth() === date2.getMonth();
    return blSameYear && blSameMonth;
  }

  /**
   * 判断两个日期是否是同一周
   */
  static isSameWeek(date1: number | string | Date, date2: number | string | Date) {
    let oneDayTime = 1000 * 60 * 60 * 24;
    let dayCount1 = DateUtil.getFormatDate(date1).getTime() / oneDayTime;
    let dayCount2 = DateUtil.getFormatDate(date2).getTime() / oneDayTime;
    let i1 = NumberUtil.toInt(((dayCount1 + 4) / 7).toString())
    let i2 = NumberUtil.toInt(((dayCount2 + 4) / 7).toString())
    return i1 === i2;
  }

  /**
   * 判断是否是同一天
   */
  static isSameDay(date1: number | string | Date, date2: number | string | Date) {
    date1 = DateUtil.getFormatDate(date1);
    date2 = DateUtil.getFormatDate(date2);
    let blSameYear = date1.getFullYear() === date2.getFullYear();
    let blSameMonth = date1.getMonth() === date2.getMonth();
    let blSameDay = date1.getDate() === date2.getDate();
    return blSameYear && blSameMonth && blSameDay;
  }


  /**
   * 获取日历对象,并设置日历对象内部的时间日期
   * @param date
   * @param type 合法的日历类型，目前合法的类型有gregory,chinese,buddhist,coptic,ethiopic,hebrew,indian,slamic_civil,islamic_tbla,islamic_umalqura,japanese,persian。默认值：区域默认的日历类型。
   * @param locale 合法的locale值，例如zh-Hans,zh-Hans-CN
   * @returns
   */
  static getCalendar(date?: number | string | Date, type: string = "gregory", locale: string = "zh-Hans"): i18n.Calendar {
    date = DateUtil.getFormatDate(date);
    let calendar: i18n.Calendar = i18n.getCalendar(locale, type);
    calendar.setTime(date);
    return calendar;
  }


  /**
   * 获取日历对象中与field相关联的值。
   * @param date
   * @param field 通过field来获取日历对象相应的值。目前支持的field值有 era, year, month, week_of_year, week_of_month, date, day_of_year, day_of_week, day_of_week_in_month, hour, hour_of_day, minute, second, millisecond, zone_offset, dst_offset, year_woy, dow_local, extended_year, julian_day, milliseconds_in_day, is_leap_month。
   * @param type 合法的日历类型，目前合法的类型有gregory,chinese,buddhist,coptic,ethiopic,hebrew,indian,slamic_civil,islamic_tbla,islamic_umalqura,japanese,persian。默认值：区域默认的日历类型。
   * @param locale 合法的locale值，例如zh-Hans,zh-Hans-CN
   * @returns
   */
  static getCalendarField(field: string, date?: number | string | Date, type: string = "gregory", locale: string = "zh-Hans"): number {
    date = DateUtil.getFormatDate(date);
    let calendar: i18n.Calendar = i18n.getCalendar(locale, type);
    calendar.setTime(date);
    return calendar.get(field);
  }


  /**
   * 在日历的给定字段进行加减操作。
   * @param date
   * @param field 指定进行操作的日历字段，目前支持的field值有 year, month, week_of_year, week_of_month, date, day_of_year, day_of_week, day_of_week_in_month, hour, hour_of_day, minute, second, millisecond。
   * @param amount 进行加减操作的具体数值。
   * @param type 合法的日历类型，目前合法的类型有gregory,chinese,buddhist,coptic,ethiopic,hebrew,indian,slamic_civil,islamic_tbla,islamic_umalqura,japanese,persian。默认值：区域默认的日历类型。
   * @param locale 合法的locale值，例如zh-Hans,zh-Hans-CN
   * @returns
   */
  static getCalendarAdd(date: number | string | Date, field: string, amount: number, type: string = "gregory",
    locale: string = "zh-Hans"): Date {
    date = DateUtil.getFormatDate(date);
    let calendar: i18n.Calendar = i18n.getCalendar(locale, type);
    calendar.setTime(date);
    calendar.add(field, amount);
    return new Date(calendar.getTimeInMillis());
  }


  /**
   * 判断指定的日期在日历中是否为周末
   * @param date
   * @returns
   */
  static isWeekend(date?: number | string | Date) {
    date = DateUtil.getFormatDate(date);
    let calendar: i18n.Calendar = i18n.getCalendar("zh-Hans");
    calendar.setTime(date);
    return calendar.isWeekend(date);
  }


  /**
   * 比较日历和指定日期相差的天数（按毫秒级的精度，不足一天将按一天进行计算，正数代表日历时间更早，负数代表日历时间更晚）。
   * @param date1
   * @param date2
   * @returns
   */
  static compareDays(date1: number | string | Date, date2: number | string | Date): number {
    date1 = DateUtil.getFormatDate(date1);
    date2 = DateUtil.getFormatDate(date2);
    let calendar: i18n.Calendar = i18n.getCalendar("zh-Hans");
    calendar.setTime(date1);
    return calendar.compareDays(date2);
  }


  /**
   * 比较指定日期相差的毫秒数
   * @param date1
   * @param date2
   * @param floor
   */
  static compareDate(date1: number | string | Date, date2: number | string | Date, floor: boolean = false): number {
    let dateTime1: number = DateUtil.getFormatDate(date1).getTime();
    let dateTime2: number = DateUtil.getFormatDate(date2).getTime();
    let diff = dateTime2 - dateTime1;
    if (floor) {
      return Math.floor(diff); //计算差值
    }
    return diff;
  }


  /**
   * 获取前几天日期或后几天日期
   * @param date
   * @param amount 进行加减操作的具体数值。
   */
  static getAmountDay(date: number | string | Date, amount: number): Date {
    let dateTime = DateUtil.getFormatDate(date);
    return DateUtil.getCalendarAdd(dateTime, "date", amount);
  }

  /**
   * 获取前几天日期或后几天日期,返回字符串
   * @param date
   * @param amount 进行加减操作的具体数值。
   */
  static getAmountDayStr(date: number | string | Date, amount: number, format: string = "yyyy-MM-dd"): string {
    return DateUtil.getFormatDateStr(DateUtil.getAmountDay(date, amount), format);
  }

  /**
   * 获取前一天日期
   */
  static getBeforeDay(date: number | string | Date): Date {
    return DateUtil.getAmountDay(date, -1);
  }

  /**
   * 获取前一天日期,返回字符串
   */
  static getBeforeDayStr(date: number | string | Date, format: string = "yyyy-MM-dd"): string {
    return DateUtil.getAmountDayStr(date, -1, format);
  }

  /**
   * 获取后一天日期
   */
  static getAfterDay(date: number | string | Date): Date {
    return DateUtil.getAmountDay(date, 1);
  }

  /**
   * 获取后一天日期,返回字符串
   */
  static getAfterDayStr(date: number | string | Date, format: string = "yyyy-MM-dd"): string {
    return DateUtil.getAmountDayStr(date, 1, format);
  }


  /**
   * 获取给定日期是当月的第几周
   * @param date
   * @returns
   */
  static getWeekOfMonth(date: number | string | Date): number {
    date = DateUtil.getFormatDate(date);
    return DateUtil.getCalendarField('week_of_month', date); //一个月中的第几周，按照星期计算周;
  }

  /**
   * 获取给定的日期是星期几
   * @returns 周几
   */
  static getWeekDay(date: number | string | Date): number {
    return DateUtil.getFormatDate(date).getDay();
  }

  /**
   * 获取给定年份和月份的最后一天是几号
   * @param year 年
   * @param month 月
   * @returns
   */
  static getLastDayOfMonth(year: number, month: number): number {
    return new Date(year, month, 0).getDate();
  }


  /**
   * 格式化时间日期字符串（DateTimeFormat）
   * @param date 时间日期对象
   * @param options 时间日期格式化选项
   * @param locale 包含区域设置信息的字符串，包括语言以及可选的脚本和区域
   * @returns
   */
  static getFormatTime(date: Date, options: intl.DateTimeOptions = { dateStyle: "short", timeStyle: "short", hourCycle: "h24" },
    locale: string = "zh-CN"): string {
    const dateTimeFormat = new intl.DateTimeFormat(locale, options);
    return dateTimeFormat.format(date);
  }

  /**
   * 格式化时间日期段字符串（DateTimeFormat）
   * @param startDate 时间日期对象
   * @param endDate 时间日期对象
   * @param options 时间日期格式化选项
   * @param locale 包含区域设置信息的字符串，包括语言以及可选的脚本和区域
   * @returns
   */
  static getFormatRange(startDate: Date, endDate: Date,
    options: intl.DateTimeOptions = { dateStyle: "short", timeStyle: "short", hourCycle: "h24" },
    locale: string = "zh-CN"): string {
    const dateTimeFormat = new intl.DateTimeFormat(locale, options);
    return dateTimeFormat.formatRange(startDate, endDate);
  }

  /**
   * 格式化相对时间
   * @param value 相对时间格式化的数值
   * @param unit 相对时间格式化的单位，取值包括："year", "quarter", "month", "week", "day", "hour", "minute", "second"。
   * @param options  时间日期格式化选项
   * @param locale 包含区域设置信息的字符串，包括语言以及可选的脚本和区域
   * @returns
   */
  static getFormatRelativeTime(value: number, unit: string, options?: intl.RelativeTimeFormatInputOptions,
    locale: string = "zh-CN"): string {
    let relativeTimeFormat = new intl.RelativeTimeFormat(locale, options);
    return relativeTimeFormat.format(value, unit);
  }


  /**
   * 格式化时间戳，获取提示性时间字符串
   * @param date
   *   时间戳：10位时间戳:表示从1970年1月1日00:00:00 GMT开始计算的秒数，精度为秒。
   *          13位时间戳:表示从1970年1月1日00:00:00 GMT开始计算的毫秒数，精度为毫秒。
   * @returns
   */
  static getTipDateStr(date: number | string | Date): string {
    let timeMs = DateUtil.getFormatDate(date).getTime();
    if (timeMs.toString().length == 10) {
      timeMs = timeMs * 1000 //如果是10位的时间戳转化为13位的
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
  private static toNumber(value: string): number|string {
    try {
      const parsedValue = parseFloat(value);
      if (isNaN(parsedValue)) {
        return value;
      }
      return parsedValue;
    } catch (e) {
      return value
    }
  }


}