import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { DATE_FORMAT11, DATE_FORMAT16, DATE_FORMAT17, DateUtil, LogUtil, StrUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 日期工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State txtStr: string = '';

  @MockSetup
  mock() {
    this.describe = new DescribeBean("DateUtil", "日期工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("getFormatDate()")
            .btnStyle()
            .onClick(() => {
              let date1 = DateUtil.getFormatDate(1716181651533);
              let date2 = DateUtil.getFormatDate("2024-05-21");
              let date3 = DateUtil.getFormatDate("2024-05-20 13:07:45");
              let date4 = DateUtil.getFormatDate("2024年05月20日 13时07分45秒");
              let date5 = DateUtil.getFormatDate("2024年05月20日");
              let date6 = DateUtil.getFormatDate("2024/05/20");
              let date7 = DateUtil.getFormatDate(new Date());
              this.txtStr = `格式化日期:\n ${JSON.stringify(date1)}\n ${JSON.stringify(date2)}\n ${JSON.stringify(date3)}\n ${JSON.stringify(date4)}\n ${JSON.stringify(date5)}\n ${JSON.stringify(date6)}\n ${JSON.stringify(date7)}`;
              LogUtil.error(this.txtStr);
            })
          Button("getFormatDateStr()")
            .btnStyle()
            .onClick(() => {
              let todayStr1 = DateUtil.getFormatDateStr(1716181651533);
              let todayStr2 = DateUtil.getFormatDateStr(DateUtil.getTodayTime(), DATE_FORMAT11);
              let todayStr3 = DateUtil.getFormatDateStr("2024-05-20 13:07:45", DATE_FORMAT17);
              let todayStr4 = DateUtil.getFormatDateStr("2024年05月20日 13时07分45秒", DATE_FORMAT16);
              let todayStr5 = DateUtil.getFormatDateStr("2024年05月20日");
              let todayStr6 = DateUtil.getFormatDateStr("2024/05/20");
              let todayStr7 = DateUtil.getFormatDateStr(new Date());
              this.txtStr = `格式化日期字符串:\n${todayStr1}\n${todayStr2}\n${todayStr3}\n${todayStr4}\n${todayStr5}\n${todayStr6}\n${todayStr7}`;
              LogUtil.error(this.txtStr);
            })
          Button("getToday()")
            .btnStyle()
            .onClick(() => {
              let today = DateUtil.getToday();
              this.txtStr = `今天的日期:\n${JSON.stringify(today)}`;
              LogUtil.error(this.txtStr);
            })
          Button("getTodayTime()")
            .btnStyle()
            .onClick(() => {
              let todayTime = DateUtil.getTodayTime();
              this.txtStr = `今天的时间戳:\n${todayTime}`;
              LogUtil.error(this.txtStr);
            })
          Button("getTodayStr()")
            .btnStyle()
            .onClick(() => {
              let todayStr1 = DateUtil.getTodayStr();
              let todayStr2 = DateUtil.getTodayStr("yyyy-MM-dd HH:mm");
              let todayStr3 = DateUtil.getTodayStr("yyyy-MM-dd HH");
              let todayStr4 = DateUtil.getTodayStr("yyyy-MM-dd");
              let todayStr5 = DateUtil.getTodayStr("yyyy/MM/dd");
              let todayStr6 = DateUtil.getTodayStr("yyyy年MM月dd日");
              let todayStr7 = DateUtil.getTodayStr("yyyy年MM月dd日 HH时mm分ss秒");
              this.txtStr = `今天的日期:\n${todayStr1}\n${todayStr2}\n${todayStr3}\n${todayStr4}\n${todayStr5}\n${todayStr6}\n${todayStr7}`;
              LogUtil.error(this.txtStr);
            })
          Button("isToday()")
            .btnStyle()
            .onClick(() => {
              let today=DateUtil.getToday();
              let todayTime=1723983090245;
              let todayStr1="2024年8月18日";
              let todayStr2="2024年08月18日";
              let todayStr3="2024年09月18日";
              let b1 = DateUtil.isToday(today);
              let b2 = DateUtil.isToday(todayTime);
              let b3 = DateUtil.isToday(todayStr1);
              let b4 = DateUtil.isToday(todayStr2);
              let b5 = DateUtil.isToday(todayStr3);
              this.txtStr = `日期是否是今天:\n${b1}\n${b2}\n${b3}\n${b4}\n${b5}`;
              LogUtil.error(this.txtStr);
            })
          Button("getNowYear()\ngetNowMonth()\ngetNowDay()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let nowYear = DateUtil.getNowYear();
              let nowMonth = DateUtil.getNowMonth();
              let nowDay = DateUtil.getNowDay();
              this.txtStr = `当前年: ${nowYear}\n当前月: ${nowMonth}\n当前日: ${nowDay}`;
              LogUtil.error(this.txtStr);
            })
          Button("isLeapYear()")
            .btnStyle()
            .onClick(() => {
              let isLeapYear1 = DateUtil.isLeapYear();
              let isLeapYear2 = DateUtil.isLeapYear(1999);
              let isLeapYear3 = DateUtil.isLeapYear(2000);
              let isLeapYear4 = DateUtil.isLeapYear(2026);
              this.txtStr = `是否是闰年: ${isLeapYear1} - ${isLeapYear2} - ${isLeapYear3} - ${isLeapYear4}`;
              LogUtil.error(this.txtStr);
            })
          Button("getDaysByYear()\ngetDaysByMonth()")
            .labelStyle({ maxLines: 3 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let day1 = DateUtil.getDaysByYear(2024);
              let day2 = DateUtil.getDaysByMonth(2024, 8);
              this.txtStr = `指定年份的天数: ${day1}\n指定月份的天数: ${day2}`;
              LogUtil.error(this.txtStr);
            })
          Button("isSameYear()\nisSameMonth()\nisSameWeek()\nisSameDay()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let isSameYear = DateUtil.isSameYear("2024-8-18", DateUtil.getToday());
              let isSameMonth = DateUtil.isSameMonth("2024-8-1", "2024年08月18日");
              let isSameWeek = DateUtil.isSameWeek("2024-8-12", "2024/08/18");
              let isSameDay = DateUtil.isSameDay("2024-08-18", "2024年08月18日");
              this.txtStr = `是否是同一年: ${isSameYear}\n是否是同一月: ${isSameMonth}\n是否是同一周: ${isSameWeek}\n是否是同一天: ${isSameDay}`;
              LogUtil.error(this.txtStr);
            })
          Button("getCalendarField()")
            .btnStyle()
            .onClick(() => {
              let month = DateUtil.getCalendarField('month', "2024-08-02");
              let week_of_year = DateUtil.getCalendarField('week_of_year', DateUtil.getToday());
              let week_of_month = DateUtil.getCalendarField('week_of_month', DateUtil.getToday());
              let day_of_week = DateUtil.getCalendarField('day_of_week', DateUtil.getToday());
              this.txtStr = `获取日历对象中与field相关联的值:\nmonth: ${month}\nweek_of_year: ${week_of_year}\nweek_of_month: ${week_of_month}\nday_of_week: ${day_of_week}`;
              LogUtil.error(this.txtStr);
            })
          Button("getCalendarAdd()")
            .btnStyle()
            .onClick(() => {
              let date1 = DateUtil.getCalendarAdd("2024-08-18", "date", 2);
              let date2 = DateUtil.getCalendarAdd(DateUtil.getToday(), "month", 1);
              let date3 = DateUtil.getCalendarAdd(DateUtil.getToday(), "year", 3);
              let date4 = DateUtil.getCalendarAdd(DateUtil.getToday(), "day_of_week", 3);
              this.txtStr = `在日历的给定字段进行加减操作:\ndate1: ${DateUtil.getFormatDateStr(date1)}\ndate2: ${DateUtil.getFormatDateStr(date2)}\ndate3: ${DateUtil.getFormatDateStr(date3)}\ndate4: ${DateUtil.getFormatDateStr(date4)}`;
              LogUtil.error(this.txtStr);
            })
          Button("isWeekend()")
            .btnStyle()
            .onClick(() => {
              let b1 = DateUtil.isWeekend("2024-08-12");
              let b2 = DateUtil.isWeekend("2024-08-15");
              let b3 = DateUtil.isWeekend("2024-08-17");
              let b4 = DateUtil.isWeekend(DateUtil.getToday());
              this.txtStr = `判断指定的日期在日历中是否为周末:\nb1: ${b1}\nb2: ${b2}\nb3: ${b3}\nb4: ${b4}`;
              LogUtil.error(this.txtStr);
            })
          Button("compareDays()\ncompareDate()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let diff1 = DateUtil.compareDays("2024-8-08", DateUtil.getToday());
              let diff2 = DateUtil.compareDays("2024-8-21", "2024年08月18日");
              let diff3 = DateUtil.compareDate("2024-8-22", "2024/08/18");
              let diff4 = DateUtil.compareDate("2024-08-18", DateUtil.getToday());
              this.txtStr = `比较指定日期:\ndiff1: ${diff1}\ndiff2: ${diff2}\ndiff3: ${diff3}\ndiff4: ${diff4}`;
              LogUtil.error(this.txtStr);
            })
          Button("getAmountDay()\ngetAmountDayStr()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let date1 = DateUtil.getAmountDay(DateUtil.getToday(), 2);
              let date2 = DateUtil.getAmountDay("2024-8-08", -2);
              let date3 = DateUtil.getAmountDayStr("2024-8-8", 3);
              let date4 = DateUtil.getAmountDayStr(DateUtil.getToday(), -3);
              LogUtil.error("date2: "+date2);
              this.txtStr = `获取前几天日期或后几天日期:\ndate1: ${DateUtil.getFormatDateStr(date1)}\ndate2: ${DateUtil.getFormatDateStr(date2)}\ndate3: ${date3}\ndate4: ${date4}`;
              LogUtil.error(this.txtStr);
            })
          Button("getBeforeDay()\ngetBeforeDayStr()\ngetAfterDay()\ngetAfterDayStr()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let date1 = DateUtil.getBeforeDay(DateUtil.getToday());
              let date2 = DateUtil.getBeforeDayStr("2024-8-08");
              let date3 = DateUtil.getAfterDay(DateUtil.getToday());
              let date4 = DateUtil.getAfterDayStr("2024-8-8");
              this.txtStr = `获取前一天日期/后一天日期:\ndate1: ${DateUtil.getFormatDateStr(date1)}\ndate2: ${date2}\ndate3: ${DateUtil.getFormatDateStr(date3)}\ndate4: ${date4}`;
              LogUtil.error(this.txtStr);
            })
          Button("getWeekOfMonth()\ngetWeekDay()\ngetLastDayOfMonth()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let n1 = DateUtil.getWeekOfMonth(DateUtil.getToday());
              let n2 = DateUtil.getWeekDay("2024-8-08");
              let n3 = DateUtil.getLastDayOfMonth(2024, 8);
              this.txtStr = `给定日期是当月的第几周: ${n1}\n给定的日期是星期几: ${n2}\n给定年份和月份的最后一天是几号: ${n3}`;
              LogUtil.error(this.txtStr);
            })
          Button("getTipDateStr()")
            .btnStyle()
            .onClick(() => {
              let timeStamp = DateUtil.getTodayTime();
              let tip1 = DateUtil.getTipDateStr(timeStamp);
              let tip2 = DateUtil.getTipDateStr(timeStamp - 60000 * 5);
              let tip3 = DateUtil.getTipDateStr(timeStamp - 3600000 * 3);
              let tip4 = DateUtil.getTipDateStr(timeStamp - 3600000 * 24 * 2);
              let tip5 = DateUtil.getTipDateStr(timeStamp - 3600000 * 24 * 360 * 1);
              this.txtStr = `提示性时间字符串:\n${tip1}\n${tip2}\n${tip3}\n${tip4}\n${tip5}`;
              LogUtil.error(this.txtStr);
            })
          Button("getFormatTime()\ngetFormatRange()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let n1 = DateUtil.getFormatTime(DateUtil.getToday());
              let n2 = DateUtil.getFormatTime(DateUtil.getToday(), { dateStyle: "full", timeStyle: "medium", hourCycle: "h24" });
              let n3 = DateUtil.getFormatTime(DateUtil.getToday(), { dateStyle: "full", timeStyle: "medium", hourCycle: "h12" });
              let n4 = DateUtil.getFormatTime(DateUtil.getToday(), { weekday: "short" });
              let fr = DateUtil.getFormatRange(DateUtil.getAfterDay("2024-05-01"),DateUtil.getToday());
              this.txtStr = `格式化时间日期字符串（DateTimeFormat）: \n${n1}\n${n2}\n${n3}\n${n4}\n\n格式化时间日期段字符串（DateTimeFormat）: \n${fr}`;
              LogUtil.error(this.txtStr);
            })
          Button("getFormatRelativeTime()")
            .labelStyle({ maxLines: 4 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let frt1 = DateUtil.getFormatRelativeTime(2, 'year');
              let frt2 = DateUtil.getFormatRelativeTime(-1, 'year');
              let frt3 = DateUtil.getFormatRelativeTime(-1, 'quarter');
              let frt4 = DateUtil.getFormatRelativeTime(-2, 'month');
              let frt5 = DateUtil.getFormatRelativeTime(-3, 'week');
              let frt6 = DateUtil.getFormatRelativeTime(-6, 'day');
              let frt7 = DateUtil.getFormatRelativeTime(-6, 'hour');
              let frt8 = DateUtil.getFormatRelativeTime(-7, 'minute');
              let frt9 = DateUtil.getFormatRelativeTime(-8, 'second');
              this.txtStr = `格式化相对时间: \n${frt1} \n${frt2} \n${frt3} \n${frt4}\n${frt5} \n${frt6} \n${frt7} \n${frt8} \n${frt9}`;
              LogUtil.error(this.txtStr);
            })
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)

      Text(this.txtStr)
        .visibility(StrUtil.isNotEmpty(this.txtStr) ? Visibility.Visible : Visibility.None)
        .textStyle()
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor($r('app.color.main_background'))
  }
}


@Styles
function btnStyle() {
  .width('90%')
  .margin({ top: 10, bottom: 5 })
}

@Styles
function textStyle() {
  .width('95%')
  .padding(10)
  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  .margin({ top: 5, bottom: 10 })
  .backgroundColor(Color.White)
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}