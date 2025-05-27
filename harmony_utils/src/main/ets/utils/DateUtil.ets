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

import { i18n, intl } from '@kit.LocalizationKit';
import { DATE_FORMAT1, DATE_FORMAT4 } from '../entity/constraint';
import { NumberUtil } from './NumberUtil';

/**
 * TODO 日期工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class DateUtil {


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
          date = DateUtil.parseTimestamp(date); //将字符串时间戳 转为 number
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
    date = DateUtil.getFormatDate(date)
    if (format === undefined || format.length <= 0) {
      format = DATE_FORMAT1; //yyyy-MM-dd HH:mm:ss
    }
    let year = date.getFullYear(); //年份，例如 2024
    let month = DateUtil.padZero(date.getMonth() + 1); //月份，0-11，0 表示一月，11 表示十二月
    let day = DateUtil.padZero(date.getDate()); //日期，1-31
    let hours = DateUtil.padZero(date.getHours()); //小时，0-23
    let minutes = DateUtil.padZero(date.getMinutes()); //分钟，0-59
    let seconds = DateUtil.padZero(date.getSeconds()); //秒数，0-59
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
    return DateUtil.getFormatDateStr(new Date(), format)
  }

  /**
   * 判断日期是否是今天
   */
  static isToday(date: number | string | Date) {
    let today = DateUtil.getTodayStr(DATE_FORMAT4);
    let day = DateUtil.getFormatDateStr(date, DATE_FORMAT4)
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
    let relativeDate = DateUtil.getFormatDate(date);
    relativeDate.setDate(relativeDate.getDate() + amount);
    return relativeDate;
  }

  /**
   * 获取前几天日期或后几天日期,返回字符串
   * @param date
   * @param amount 进行加减操作的具体数值。
   */
  static getAmountDayStr(date: number | string | Date, amount: number, format: string = DATE_FORMAT4): string {
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
  static getBeforeDayStr(date: number | string | Date, format: string = DATE_FORMAT4): string {
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
  static getAfterDayStr(date: number | string | Date, format: string = DATE_FORMAT4): string {
    return DateUtil.getAmountDayStr(date, 1, format);
  }


  /**
   * 获取给定日期是当月的第几周
   * @param date
   * @returns
   */
  static getWeekOfMonth(date: number | string | Date): number {
    let currentDate = DateUtil.getFormatDate(date);
    let firstDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1); //获取该月的第一天
    let firstDayOfWeek = firstDayOfMonth.getDay(); //获取该月的第一天是星期几
    let weekNumber = Math.ceil((currentDate.getDate() + firstDayOfWeek) / 7); //计算当前日期是该月的第几周
    return weekNumber;
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