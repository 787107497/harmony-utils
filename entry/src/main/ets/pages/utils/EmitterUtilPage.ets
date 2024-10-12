import { ComposeTitleBar, router } from '@kit.ArkUI';
import { DescribeBean } from '../../entity/DescribeBean';
import { MockSetup } from '@ohos/hamock';
import { EmitterUtil, LogUtil, StrUtil } from '@pura/harmony-utils';
import { emitter } from '@kit.BasicServicesKit';


/**
 * TODO Emitter工具类（进行线程间通信）
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State txtStr: string = '';

  @MockSetup
  mock() {
    this.describe = new DescribeBean("EmitterUtil", "Emitter工具类（进行线程间通信）");
  }

  aboutToAppear(): void {
    EmitterUtil.onSubscribe<string>("S123456", (data) => {
      this.txtStr = `事件(string)：\t${data}`;
      LogUtil.error(this.txtStr);
    });
    EmitterUtil.onSubscribe<number>("N123456", (data) => {
      this.txtStr = `事件(number)：\t${data}`;
      LogUtil.error(this.txtStr);
    });
    EmitterUtil.onceSubscribe<boolean>("B123456", (data) => {
      this.txtStr = `事件(boolean)：\t${data}`;
      LogUtil.error(this.txtStr);
    });
    EmitterUtil.onSubscribe<Student>("O123456", (data) => {
      this.txtStr = `事件(对象)：\n${JSON.stringify(data, null, 2)}`;
      LogUtil.error(this.txtStr);
    });
  }

  aboutToDisappear(): void {
    EmitterUtil.unSubscribe("S123456"); //取消事件订阅
    EmitterUtil.unSubscribe("N123456"); //取消事件订阅
    EmitterUtil.unSubscribe("O123456"); //取消事件订阅
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
          Button("发送事件（string）")
            .btnStyle()
            .onClick(() => {
              EmitterUtil.post<string>("S123456", "哈哈哈哈哈哈哈哈哈哈",emitter.EventPriority.LOW);
            })
          Button("发送事件（number）")
            .btnStyle()
            .onClick(() => {
              EmitterUtil.post<number>("N123456", 90123456789);
            })
          Button("发送事件（boolean）")
            .btnStyle()
            .onClick(() => {
              EmitterUtil.post<boolean>("B123456", false);
            })
          Button("发送事件（对象）")
            .btnStyle()
            .onClick(() => {
              let student: Student = {
                id: "NO_1234567809",
                name: "小宝子",
                age: 18,
                sex: "男"
              }
              EmitterUtil.post<Student>("O123456", student);
            })
          Blank().layoutWeight(1)
          Text(this.txtStr)
            .visibility(StrUtil.isNotEmpty(this.txtStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
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


/**
 * 学生对象
 */
interface Student {
  id: string;
  name: string;
  age: number;
  sex: string;
}