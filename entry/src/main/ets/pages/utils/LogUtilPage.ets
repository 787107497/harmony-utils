import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { FileUtil, LogUtil, ResUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { User } from '../../model/User';
import { DialogHelper } from '@pura/harmony-dialog';

/**
 * 日志工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State isHilog: boolean = true;

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
              LogUtil.init(0x1010, 'Pura', true, true);  //该方法建议在Ability里调用
              DialogHelper.showToast('日志输出，设置成功！');
            })
          Button("setShowLog()")
            .btnStyle()
            .onClick(() => {
              LogUtil.setShowLog(true);  //该方法建议在Ability里调用
              DialogHelper.showToast('日志输出，设置成功！');
            })
          Button("setDomain()")
            .btnStyle()
            .onClick(() => {
              LogUtil.setDomain(0x0010);  //该方法建议在Ability里调用
              DialogHelper.showToast('日志输出，设置成功！');
            })
          Button("setTag()")
            .btnStyle()
            .onClick(() => {
              LogUtil.setTag("童长老"); //该方法建议在Ability里调用
              DialogHelper.showToast('日志输出，设置成功！');
            })
          Button("setHilog()")
            .btnStyle()
            .onClick(() => {
              LogUtil.setHilog(this.isHilog);  //该方法建议在Ability里调用
              this.isHilog = !this.isHilog;
              DialogHelper.showToast('日志输出，设置成功！');
            })
          Button("debug()")
            .btnStyle()
            .onClick(() => {
              LogUtil.debug("我是一个debug日志-日志工具类-*…^·^…*-哈哈哈哈哈哈!");
              DialogHelper.showToast('请查看日志输出！');
            })
          Button("info()")
            .btnStyle()
            .onClick(() => {
              LogUtil.info("我是一个info日志-*￥…^·^…￥*—我是一个日志。");
              let user = new User();
              user.user = new User();
              LogUtil.info(user);
              DialogHelper.showToast('请查看日志输出！');
            })
          Button("warn()")
            .btnStyle()
            .onClick(() => {
              LogUtil.warn("我是一个warn日志\t", "日志工具类^·^…￥…&!。");
              let jsonStr = ResUtil.getRawFileContentStrSync('data_utils.json');
              LogUtil.warn(jsonStr);
              DialogHelper.showToast('请查看日志输出！');
            })
          Button("error()")
            .btnStyle()
            .onClick(() => {
              LogUtil.error("我是一个error日志\t", "我是一个日志工具类-·-。", "你是谁？", "我在哪？", "嘿嘿嘿嘿嘿嘿嘿嘿！");
              let user = new User();
              LogUtil.error(user);
              DialogHelper.showToast('请查看日志输出！');
            })
          Button("fatal()")
            .btnStyle()
            .onClick(() => {
              LogUtil.fatal("我是一个fatal日志^·^\t", "我是一个日志工具类^·^。");
              DialogHelper.showToast('请查看日志输出！');
            })
          Button("print()")
            .btnStyle()
            .onClick(() => {
              let user = new User();
              LogUtil.print(user);
              DialogHelper.showToast('请查看日志输出！');
            })
          Button("打印Error")
            .btnStyle()
            .onClick(() => {
              try {
                let path = 'null';
                FileUtil.openSync(path)
              } catch (err) {
                LogUtil.error(err); //打印error
              }
              try {
                throw new Error('除数不能为 0');
              } catch (err) {
                LogUtil.warn(err); //打印error
              }
              DialogHelper.showToast('请查看日志输出！');
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