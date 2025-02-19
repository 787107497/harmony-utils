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

import { DateTimePickerOptions } from '../model/DateTimePickerOptions';
import { ButtonOptions } from '../model/ButtonOptions';
import { DateType, DialogAction, DialogHelper, DialogThemeColorMode } from '../../../../Index';
import { DateHelper } from '../utils/DateHelper';
import { Helper } from '../utils/Helper';


/**
 * TODO DatePickerDialog组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 1029219059
 */
@Preview
@Component
export struct DatePickerDialogView {
  @Prop options: DateTimePickerOptions;
  @State dateType: DateType = DateType.YmdHm; //选择的日期类型
  @State startDate: Date = new Date("1900-01-01 00:00:00"); //开始日期（1900-01-01 00:00:00）
  @State endDate: Date = new Date("2199-12-31 23:59:59"); //结束日期（2199-12-31 23:59:59）
  @State selectDate: Date = new Date(); // 选中日期
  @State containYear: boolean = true; //是否包含年
  @State containMonth: boolean = true; //是否包含月
  @State containDay: boolean = true; //是否包含日
  @State containHour: boolean = true; //是否包含时
  @State containMinute: boolean = true; //是否包含秒
  @State containSecond: boolean = true; //是否包含年
  @State year: string = ""; //选中日期的年
  @State month: string = ""; //选中日期的月
  @State day: string = ""; //选中日期的日
  @State hour: string = ""; //选中日期的时
  @State minute: string = ""; //选中日期的分
  @State second: string = ""; //选中日期的秒
  @State years: string[] = []; //年的可选范围
  @State months: string[] = []; //月的可选范围
  @State days: string[] = []; //日的可选范围
  @State hours: string[] = []; //时的可选范围
  @State minutes: string[] = []; //分的可选范围
  @State seconds: string[] = []; //秒的可选范围
  @State title: string = ""; //标题
  @State primaryButton?: ButtonOptions = undefined; //弹框左侧按钮。
  @State secondaryButton?: ButtonOptions = undefined; //弹框右侧按钮。
  @State largeScreen: boolean = false; //是否是大屏手机，例如Pad和展开的折叠屏；默认正常手机
  @StorageProp(DialogThemeColorMode) themeColorMode: ThemeColorMode =
    this.options.themeColorMode ?? ThemeColorMode.SYSTEM; //设置深色浅色，默认跟随系统。

  aboutToAppear(): void {
    this.largeScreen = Helper.isLargeScreen();
    if (this.options.title) {
      this.title = Helper.getResourceStr(this.options.title) ?? "";
    }
    this.primaryButton = this.options.primaryButton as ButtonOptions;
    this.secondaryButton = this.options.secondaryButton as ButtonOptions;
    this.initPickerData();
   }


  /**
   * 初始化选择器参数
   */
  initPickerData() {
    this.dateType = this.options.dateType;
    this.selectDate = this.options.selected ?? new Date();
    this.startDate = this.options.start ?? new Date('1900-01-01 00:00:00');
    this.endDate = this.options.end ?? new Date('2199-12-31 23:59:59');
    if (this.startDate.getTime() > this.endDate.getTime()) {
      throw new Error('end 必须是 start 之后的日期！');
    }
    if (this.startDate.getTime() > this.selectDate.getTime()) {
      this.selectDate = this.startDate; //选中日期小于开始日期时，选中日期为开始日期。
    }
    if (this.endDate.getTime() < this.selectDate.getTime()) {
      this.selectDate = this.endDate; //选中日期大于结束日期时，选中日期为结束日期。
    }
    this.containYear = DateHelper.containsYear(this.dateType);
    this.containMonth = DateHelper.containsMonth(this.dateType);
    this.containDay = DateHelper.containsDay(this.dateType);
    this.containHour = DateHelper.containsHour(this.dateType);
    this.containMinute = DateHelper.containsMinute(this.dateType);
    this.containSecond = DateHelper.containsSecond(this.dateType);
    this.years = DateHelper.getRanges(this.containYear, 1, this.startDate, this.endDate, this.selectDate);
    this.months = DateHelper.getRanges(this.containMonth, 2, this.startDate, this.endDate, this.selectDate);
    this.days = DateHelper.getRanges(this.containDay, 3, this.startDate, this.endDate, this.selectDate);
    this.hours = DateHelper.getRanges(this.containHour, 4, this.startDate, this.endDate, this.selectDate);
    this.minutes = DateHelper.getRanges(this.containMinute, 5, this.startDate, this.endDate, this.selectDate);
    this.seconds = DateHelper.getRanges(this.containSecond, 6, this.startDate, this.endDate, this.selectDate);
    this.year = DateHelper.getSelectStr(this.containYear, 1, this.selectDate);
    this.month = DateHelper.getSelectStr(this.containMonth, 2, this.selectDate);
    this.day = DateHelper.getSelectStr(this.containDay, 3, this.selectDate);
    this.hour = DateHelper.getSelectStr(this.containHour, 4, this.selectDate);
    this.minute = DateHelper.getSelectStr(this.containMinute, 5, this.selectDate);
    this.second = DateHelper.getSelectStr(this.containSecond, 6, this.selectDate);
  }


  /**
   * 更新数据源
   * @param type 1-年、2-月、3-日、4-时、5-分、6-秒
   */
  onChangeData(type: number) {
    this.selectDate = DateHelper.getDateByStr(this.containYear, this.containMonth, this.containDay, this.containHour,
      this.containMinute, this.containSecond, this.year, this.month, this.day, this.hour, this.minute, this.second);
    if (type <= 1 && this.containYear) {
      this.months = DateHelper.getRanges(this.containMonth, 2, this.startDate, this.endDate, this.selectDate);
      this.month = DateHelper.getSelectValue(this.months, this.month);
    }
    if (type <= 2 && this.containMonth) {
      this.day = DateHelper.getResetDay(this.year, this.month, this.day);
      this.selectDate = DateHelper.getDateByStr(this.containYear, this.containMonth, this.containDay, this.containHour,
        this.containMinute, this.containSecond, this.year, this.month, this.day, this.hour, this.minute, this.second);
      this.days = DateHelper.getRanges(this.containDay, 3, this.startDate, this.endDate, this.selectDate);
      this.day = DateHelper.getSelectValue(this.days, this.day);
    }
    if (type <= 3 && this.containDay) {
      this.hours = DateHelper.getRanges(this.containHour, 4, this.startDate, this.endDate, this.selectDate);
      this.hour = DateHelper.getSelectValue(this.hours, this.hour);
    }
    if (type <= 4 && this.containHour) {
      this.minutes = DateHelper.getRanges(this.containMinute, 5, this.startDate, this.endDate, this.selectDate);
      this.minute = DateHelper.getSelectValue(this.minutes, this.minute);
    }
    if (type <= 5 && this.containMinute) {
      this.seconds = DateHelper.getRanges(this.containSecond, 6, this.startDate, this.endDate, this.selectDate);
      this.second = DateHelper.getSelectValue(this.seconds, this.second);
    }
  }

  build() {
    WithTheme({ colorMode: this.themeColorMode }) {
      Column() {
        Row() {
          Button(this.primaryButton?.value)
            .buttonStyle(this.primaryButton?.buttonStyle ?? ButtonStyleMode.TEXTUAL)
            .role(this.primaryButton?.role ?? ButtonRole.NORMAL)
            .type(ButtonType.Capsule)
            .fontColor(this.primaryButton?.fontColor)
            .backgroundColor(this.primaryButton?.background ?? Color.Transparent)
            .margin({ top: 10, bottom: 10, left: 10 })
            .alignSelf(ItemAlign.Center)
            .align(Alignment.Center)
            .onClick(() => {
              if (this.options.actionCancel) {
                DialogHelper.closeDialog(this.options.dialogId ?? "");
              }
              if (this.options.onAction) {
                this.selectDate =
                  DateHelper.getDateByStr(this.containYear, this.containMonth, this.containDay, this.containHour,
                    this.containMinute, this.containSecond, this.year, this.month, this.day, this.hour, this.minute,
                    this.second);
                this.options.onAction(DialogAction.ONE, this.options.dialogId ?? "", this.selectDate);
              }
            })
          Text(this.title)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .fontColor(this.options.titleFontColor)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .ellipsisMode(EllipsisMode.END)
            .maxLines(1)
            .layoutWeight(1)
            .margin(5)
          Button(this.secondaryButton?.value)
            .buttonStyle(this.secondaryButton?.buttonStyle ?? ButtonStyleMode.TEXTUAL)
            .role(this.secondaryButton?.role ?? ButtonRole.NORMAL)
            .fontColor(this.secondaryButton?.fontColor)
            .backgroundColor(this.secondaryButton?.background ?? Color.Transparent)
            .type(ButtonType.Capsule)
            .margin({ top: 10, bottom: 10, right: 10 })
            .alignSelf(ItemAlign.Center)
            .align(Alignment.Center)
            .onClick(() => {
              if (this.options.actionCancel) {
                DialogHelper.closeDialog(this.options.dialogId ?? "");
              }
              if (this.options.onAction) {
                this.selectDate =
                  DateHelper.getDateByStr(this.containYear, this.containMonth, this.containDay, this.containHour,
                    this.containMinute, this.containSecond, this.year, this.month, this.day, this.hour, this.minute,
                    this.second);
                this.options.onAction(DialogAction.TWO, this.options.dialogId ?? "", this.selectDate);
              }
            })
        }
        .backgroundColor(this.options.titleBackground)
        .width('100%')

        Row() {
          TextPicker({ range: this.years, value: this.year })
            .TextPickerStyle(this.options, this.containYear, 10)
            .onChange((value) => {
              this.year = value as string;
              this.onChangeData(1);
            })
          TextPicker({ range: this.months, value: this.month })
            .TextPickerStyle(this.options, this.containMonth, 9)
            .onChange((value) => {
              this.month = value as string;
              this.onChangeData(2);
            })
          TextPicker({ range: this.days, value: this.day })
            .TextPickerStyle(this.options, this.containDay, 9)
            .onChange((value) => {
              this.day = value as string;
              this.onChangeData(3);
            })
          TextPicker({ range: this.hours, value: this.hour })
            .TextPickerStyle(this.options, this.containHour, 9)
            .onChange((value) => {
              this.hour = value as string;
              this.onChangeData(4);
            })
          TextPicker({ range: this.minutes, value: this.minute })
            .TextPickerStyle(this.options, this.containMinute, 9)
            .onChange((value) => {
              this.minute = value as string;
              this.onChangeData(5);
            })
          TextPicker({ range: this.seconds, value: this.second })
            .TextPickerStyle(this.options, this.containSecond, 9)
            .onChange((value) => {
              this.second = value as string;
              this.onChangeData(6);
            })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .margin({ top: 20, bottom: 20 })
        .width('100%')
      }
      .backgroundColor(this.options.backgroundColor)
      .backgroundBlurStyle(this.options.backgroundBlurStyle)
      .borderRadius(this.options.cornerRadius)
      .clip(true)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .width(this.options.width)
      .constraintSize({ maxWidth: this.options.maxWidth })
      .padding({ bottom: this.largeScreen ? 0 : 25 })
      .margin({ bottom: this.largeScreen ? 30 : 0 })
    }
  }
}


//TextPicker统一样式
@Extend(TextPicker)
function TextPickerStyle(options: DateTimePickerOptions, contain: boolean, layoutWeight: number) {
  .visibility(contain ? Visibility.Visible : Visibility.None)
  .layoutWeight(layoutWeight)
  .textStyle(options.textStyle)
  .selectedTextStyle(options.selectedTextStyle)
  .disappearTextStyle(options.disappearTextStyle)
  .divider(options.divider)
  .canLoop(options.canLoop)
}
