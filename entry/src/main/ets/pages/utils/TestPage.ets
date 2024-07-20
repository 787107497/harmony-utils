import { ComposeTitleBar, router } from '@kit.ArkUI';
import { AppUtil, DateUtil, DialogUtil, LogUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { MockSetup } from '@ohos/hamock';

/**
 * 测试页面
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State str: string = "name";
  @State res: Resource = $r(`app.string.lib_${this.str}`);


  @MockSetup
  mock() {
    this.describe = new DescribeBean("Test", "测试页面");
  }

  aboutToAppear(): void {
    $r(`app.string.lib_${this.str}`)
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
          Button("测试1")
            .btnStyle()
            .onClick(() => {
              let str1 = DateUtil.getFormatDateStr("");
              LogUtil.error("str1: " + str1);
            })
          Button("测试2")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showDatePicker({
                onDateChange: (value: Date) => {
                  LogUtil.error("TimePickerResult1: " + value)
                },
                onDateAccept: (value: Date) => {
                  LogUtil.error("TimePickerResult2: " + DateUtil.getFormatDateStr(value))
                }
              })
            })
          Button("测试3")
            .btnStyle()
            .onClick(() => {
              AppUtil.setStatusBar()
            })
          Button("测试4")
            .btnStyle()
            .onClick(() => {
              AppUtil.setStatusBar(false, true, "#FF6666", {
                statusBarContentColor: '#FFFFFF',
              })
            })
          Button("测试5")
            .btnStyle()
            .onClick(() => {
              AppUtil.setStatusBar(false, true, '#FFFFFF', {
                statusBarContentColor: '#FF6666',
              })
            })
          Button("测试6")
            .btnStyle()
            .onClick(async () => {
              let name = await AppUtil.getBundleName();
              let versionCode = await AppUtil.getVersionCode();
              let versionName = await AppUtil.getVersionName();
              LogUtil.error("versionName: " + versionName + "\n\nversionCode: " + versionCode + "\n\nname: " + name);

            })
          Text(this.res).layoutWeight(1)
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
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}