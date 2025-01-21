import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, ObjectUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../entity/DescribeBean';
import { User } from '../../entity/User';
import { JSON } from '@kit.ArkTS';

/**
 * 日志工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("LogUtil", "日志工具类");
  }


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("init()")
            .btnStyle()
            .onClick(() => {
              LogUtil.init(0x1010, 'Pura', true)
            })
          Button("setDomain()")
            .btnStyle()
            .onClick(() => {
              LogUtil.setDomain(0x0010)
            })
          Button("setTag()")
            .btnStyle()
            .onClick(() => {
              LogUtil.setTag("pura")
            })
          Button("debug()")
            .btnStyle()
            .onClick(() => {
              LogUtil.debug("日志工具类-debug\t", "我是一个日志-·#￥%……&*—+我是一个日志。")
            })
          Button("info()")
            .btnStyle()
            .onClick(() => {
              LogUtil.info("我是一个日志-·#￥%……&*—+我是一个日志。")
            })
          Button("warn()")
            .btnStyle()
            .onClick(() => {
              LogUtil.warn("日志工具类-warn\t", "我是一个日志-·#￥%……&*—+我是一个日志。")
            })
          Button("error()")
            .btnStyle()
            .onClick(() => {
              LogUtil.error("日志工具类-error\t", "我是一个日志-·#￥%……&*—+我是一个日志。")
            })
          Button("fatal()")
            .btnStyle()
            .onClick(() => {
              LogUtil.fatal("日志工具类-fatal\t", "我是一个日志-·#￥%……&*—+我是一个日志。")
            })
          Button("print()")
            .btnStyle()
            .onClick(() => {
              let user = new User();
              user.user = new User();
              LogUtil.print(user);   //过滤Tag为 JSAPP
            })

          Blank().layoutWeight(1)
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