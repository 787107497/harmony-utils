/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-dialog
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

import { DateType } from './constraint';
import { BusinessError } from '@kit.BasicServicesKit';


/**
 * TODO 日期工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059 */
export class DateHelper {


  /**
   * 判断是否是闰年
   */
  static isLeapYear(year: number): boolean {
    return (year % 4 === 0 && year % 100 !== 0) || year % 400 === 0;
  }


  /**
   * 获取指定月份的天数
   */
  static getDaysByMonth(year: number, month: number): number {
    if (month == 2) {
      if (DateHelper.isLeapYear(year)) {
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
   * 补零操作
   * @param num
   * @returns
   */
  static padZero(num: number): string {
    return num.toString().padStart(2, "0");
  }


  /**
   * 是否包含年
   */
  static containsYear(type: DateType): boolean {
    return type == DateType.YmdHms || type == DateType.YmdHm
      || type == DateType.YmdH || type == DateType.Ymd
      || type == DateType.Ym || type == DateType.Y;
  }

  /**
   * 是否包含月
   */
  static containsMonth(type: DateType): boolean {
    return type == DateType.YmdHms || type == DateType.YmdHm
      || type == DateType.YmdH || type == DateType.Ymd || type == DateType.Ym;
  }

  /**
   * 是否包含日
   */
  static containsDay(type: DateType): boolean {
    return type == DateType.YmdHms || type == DateType.YmdHm
      || type == DateType.YmdH || type == DateType.Ymd;
  }

  /**
   * 是否包含时
   */
  static containsHour(type: DateType): boolean {
    return type == DateType.YmdHms || type == DateType.YmdHm
      || type == DateType.YmdH || type == DateType.Hms || type == DateType.Hm;
  }

  /**
   * 是否包含分
   */
  static containsMinute(type: DateType): boolean {
    return type == DateType.YmdHms || type == DateType.YmdHm
      || type == DateType.Hms || type == DateType.Hm || type == DateType.Ms;
  }

  /**
   * 是否包含秒
   */
  static containsSecond(type: DateType): boolean {
    return type == DateType.YmdHms || type == DateType.Hms || type == DateType.Ms;
  }


  /**
   * 是否是同一年
   */
  static isSameYear(selectDate: Date, date: Date) {
    return selectDate.getFullYear() === date.getFullYear();
  }

  /**
   * 是否是同一月
   */
  static isSameMonth(selectDate: Date, date: Date): boolean {
    return DateHelper.isSameYear(selectDate, date) && selectDate.getMonth() == date.getMonth();
  }

  /**
   * 是否是同一日
   */
  static isSameDay(selectDate: Date, date: Date): boolean {
    return DateHelper.isSameMonth(selectDate, date) && selectDate.getDate() == date.getDate();
  }

  /**
   * 是否是同一时
   */
  static isSameHour(selectDate: Date, date: Date): boolean {
    return DateHelper.isSameDay(selectDate, date) && selectDate.getHours() == date.getHours();
  }

  /**
   * 是否是同一分
   */
  static isSameMinute(selectDate: Date, date: Date): boolean {
    return DateHelper.isSameHour(selectDate, date) && selectDate.getMinutes() == date.getMinutes();
  }

  /**
   * 是否是同一秒
   */
  static isSameSecond(selectDate: Date, date: Date): boolean {
    return DateHelper.isSameMinute(selectDate, date) && selectDate.getSeconds() == date.getSeconds();
  }


  /**
   * 获取年月日时分秒的可选范围
   * @param containType 是否包含
   * @param type 1-年、2-月、3-日、4-时、5-分、6-秒。
   * @param startDate 开始日期
   * @param endDate 结束日期
   * @param selectDate 选中日期
   * @returns
   */
  static getRanges(containType: boolean, type: number, startDate: Date, endDate: Date, selectDate: Date): string[] {
    let ranges: string[] = [];
    if (containType) {
      if (type == 1) { //年
        let startYear = startDate.getFullYear();
        let endYear = endDate.getFullYear();
        for (let y = startYear; y <= endYear; y++) {
          ranges.push(`${y}年`);
        }
      } else if (type == 2) { //月
        let startMonth = 1;
        let endMonth = 12;
        if (DateHelper.isSameYear(selectDate, startDate)) {
          startMonth = startDate.getMonth() + 1; //月份，0-11，0 表示一月，11 表示十二月
        }
        if (DateHelper.isSameYear(selectDate, endDate)) {
          endMonth = endDate.getMonth() + 1; //月份，0-11，0 表示一月，11 表示十二月
        }
        for (let m = startMonth; m <= endMonth; m++) {
          ranges.push(`${DateHelper.padZero(m)}月`);
        }
      } else if (type == 3) { //日
        let startDay = 1;
        let endDay = DateHelper.getDaysByMonth(selectDate.getFullYear(), selectDate.getMonth() + 1);
        if (DateHelper.isSameMonth(selectDate, startDate)) {
          startDay = startDate.getDate();
        }
        if (DateHelper.isSameMonth(selectDate, endDate)) {
          endDay = endDate.getDate();
        }
        for (let d = startDay; d <= endDay; d++) {
          ranges.push(`${DateHelper.padZero(d)}日`);
        }
      } else if (type == 4) { //时
        let startHour = 0;
        let endHour = 23;
        if (DateHelper.isSameDay(selectDate, startDate)) {
          startHour = startDate.getHours();
        }
        if (DateHelper.isSameDay(selectDate, endDate)) {
          endHour = endDate.getHours();
        }
        for (let h = startHour; h <= endHour; h++) {
          ranges.push(`${DateHelper.padZero(h)}时`);
        }
      } else if (type == 5) { //分
        let startMinute = 0;
        let endMinute = 59;
        if (DateHelper.isSameHour(selectDate, startDate)) {
          startMinute = startDate.getMinutes();
        }
        if (DateHelper.isSameHour(selectDate, endDate)) {
          endMinute = endDate.getMinutes();
        }
        for (let m = startMinute; m <= endMinute; m++) {
          ranges.push(`${DateHelper.padZero(m)}分`);
        }
      } else if (type == 6) { //秒
        let startSecond = 0;
        let endSecond = 59;
        if (DateHelper.isSameMinute(selectDate, startDate)) {
          startSecond = startDate.getSeconds();
        }
        if (DateHelper.isSameMinute(selectDate, endDate)) {
          endSecond = endDate.getSeconds();
        }
        for (let s = startSecond; s <= endSecond; s++) {
          ranges.push(`${DateHelper.padZero(s)}秒`);
        }
      }
    }
    return ranges;
  }


  /**
   * 获取已选日期的年月日时分秒
   * @param containType 是否包含
   * @param type 1-年、2-月、3-日、4-时、5-分、6-秒。
   * @param selectDate 选中日期
   * @returns
   */
  static getSelectStr(containType: boolean, type: number, selectDate: Date): string {
    let selectStr: string = '';
    if (containType) {
      if (type == 1) { //年
        selectStr = `${selectDate.getFullYear()}年`;
      } else if (type == 2) { //月
        selectStr = `${DateHelper.padZero(selectDate.getMonth() + 1)}月`;
      } else if (type == 3) { //日
        selectStr = `${DateHelper.padZero(selectDate.getDate())}日`;
      } else if (type == 4) { //时
        selectStr = `${DateHelper.padZero(selectDate.getHours())}时`;
      } else if (type == 5) { //分
        selectStr = `${DateHelper.padZero(selectDate.getMinutes())}分`;
      } else if (type == 6) { //秒
        selectStr = `${DateHelper.padZero(selectDate.getSeconds())}秒`;
      }
    }
    return selectStr;
  }


  /**
   * 处理一些特殊情况下的日期
   */
  static getResetDay(yearStr: string, monthStr: string, dayStr: string): string {
    try {
      let year = parseInt(yearStr.replace('年', ''));
      let month = parseInt(monthStr.replace('月', ''));
      let day = DateHelper.getDaysByMonth(year, month);
      let selectDay = parseInt(dayStr.replace('日', ''));
      if (isNaN(selectDay)) {
        return dayStr;
      }
      if (selectDay > day) {
        return `${day}日`; //当选中天超过可选范围时，取当月最后一天
      }
    } catch (err) {
      let error = err as BusinessError;
      console.log(`getResetDay-Error ~ code: ${error.code} -·- message: ${error.message}`);
    }
    return dayStr;
  }


  /**
   * 获取选中的年月日时分秒
   */
  static getSelectValue(ranges: string[], value: string): string {
    if (ranges.includes(value)) {
      return value;
    }
    return ranges[0]; //不在范围内，默认选中第一个
  }


  /**
   * 将年月日时分秒字符串转为Date
   * @param date
   * @returns
   */
  static getDateByStr(containYear: boolean, containMonth: boolean, containDay: boolean,
    containHour: boolean, containMinute: boolean, containSecond: boolean,
    year: string, month: string, day: string, hour: string, minute: string, second: string,): Date {
    let dateStr = '';
    let currentDate = new Date();
    if (containYear) {
      dateStr = dateStr + year;
      dateStr = dateStr.replace("年", '/');
    } else {
      if (containMinute) {
        dateStr = dateStr + `${currentDate.getFullYear()}/`;
      }
    }
    if (containMonth) {
      dateStr = dateStr + month;
      dateStr = dateStr.replace("月", '/');
    } else {
      if (containMinute) {
        dateStr = dateStr + `${DateHelper.padZero(currentDate.getMonth() + 1)}/`;
      }
    }
    if (containDay) {
      dateStr = dateStr + day;
      dateStr = dateStr.replace("日", ' ');
    } else {
      if (containMinute) {
        dateStr = dateStr + `${DateHelper.padZero(currentDate.getDate())} `;
      }
    }
    if (containHour) {
      dateStr = dateStr + hour;
      dateStr = dateStr.replace("时", ':');
    } else {
      if (containMinute) {
        dateStr = dateStr + `${DateHelper.padZero(currentDate.getDate())}:`
      }
    }
    if (containMinute) {
      dateStr = dateStr + minute;
      dateStr = dateStr.replace("分", ':')
    } else {
      if (containHour) {
        dateStr = dateStr + `00:`;
      }
    }
    if (containSecond) {
      dateStr = dateStr + second;
      dateStr = dateStr.replace("秒", '');
    }
    if (dateStr.endsWith("/") || dateStr.endsWith(":") || dateStr.endsWith(' ')) {
      dateStr = dateStr.substring(0, dateStr.length - 1);
    }
    return new Date(dateStr);
  }


}