import { ComposeTitleBar, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { DateUtil, LogUtil, StrUtil } from '@pura/harmony-utils';
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
      ComposeTitleBar({
        title: this.describe.name,
        subtitle: this.describe.desc,
      })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("getToday()")
            .btnStyle()
            .onClick(() => {
              let today = DateUtil.getToday();
              LogUtil.error(`today: ${JSON.stringify(today)}`);
              this.txtStr = `今天的日期:\n${JSON.stringify(today)}`;
            })
          Button("getTodayTime()")
            .btnStyle()
            .onClick(() => {
              let todayTime = DateUtil.getTodayTime();
              LogUtil.error(`todayTime: ${todayTime}`);
              this.txtStr = `今天的时间戳:\n${todayTime}`;
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
              LogUtil.error(`todayTime: \n${todayStr1}\n${todayStr2}\n${todayStr3}\n${todayStr4}\n${todayStr5}\n${todayStr6}\n${todayStr7}`);
              this.txtStr = `今天的日期:\n${todayStr1}\n${todayStr2}\n${todayStr3}\n${todayStr4}\n${todayStr5}\n${todayStr6}\n${todayStr7}`;
            })
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
              LogUtil.error(`getFormatDate: \n ${JSON.stringify(date1)}\n ${JSON.stringify(date2)}\n ${JSON.stringify(date3)}\n ${JSON.stringify(date4)}\n ${JSON.stringify(date5)}\n ${JSON.stringify(date6)}\n ${JSON.stringify(date7)}`);
              this.txtStr = `格式化日期:\n ${JSON.stringify(date1)}\n ${JSON.stringify(date2)}\n ${JSON.stringify(date3)}\n ${JSON.stringify(date4)}\n ${JSON.stringify(date5)}\n ${JSON.stringify(date6)}\n ${JSON.stringify(date7)}`;
            })
          Button("getFormatDateStr()")
            .btnStyle()
            .onClick(() => {
              let todayStr1 = DateUtil.getFormatDateStr(1716181651533);
              let todayStr2 = DateUtil.getFormatDateStr("2024-05-21");
              let todayStr3 = DateUtil.getFormatDateStr("2024-05-20 13:07:45");
              let todayStr4 = DateUtil.getFormatDateStr("2024年05月20日 13时07分45秒");
              let todayStr5 = DateUtil.getFormatDateStr("2024年05月20日");
              let todayStr6 = DateUtil.getFormatDateStr("2024/05/20");
              let todayStr7 = DateUtil.getFormatDateStr(new Date());
              LogUtil.error(`getFormatDateStr: \n${todayStr1}\n${todayStr2}\n${todayStr3}\n${todayStr4}\n${todayStr5}\n${todayStr6}\n${todayStr7}`);
              this.txtStr = `格式化日期字符串:\n${todayStr1}\n${todayStr2}\n${todayStr3}\n${todayStr4}\n${todayStr5}\n${todayStr6}\n${todayStr7}`;
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
              LogUtil.error(`getTipDateStr: \n${tip1}\n${tip2}\n${tip3}\n${tip4}\n${tip5}`);
              this.txtStr = `提示性时间字符串:\n${tip1}\n${tip2}\n${tip3}\n${tip4}\n${tip5}`;
            })
          Button("getDateDiff()")
            .btnStyle()
            .onClick(() => {
              let d1 = DateUtil.getDateDiff("2024-05-21", "2024-05-27")
              let d2 = DateUtil.getDateDiff("2024-05-20", DateUtil.getToday())
              let d3 = DateUtil.getDateDiff("2024-05-20", DateUtil.getTodayTime())
              LogUtil.error(`getDateDiff: \n${d1}\n${d2}\n${d3}`);
              this.txtStr = `日期差单位为天:\n${d1}\n${d2}\n${d3}`;
            })
          Text(this.txtStr)
            .visibility(StrUtil.isNotEmpty(this.txtStr) ? Visibility.Visible : Visibility.None)
            .textStyle()

          Text('').layoutWeight(1)
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)
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