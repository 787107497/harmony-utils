import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { JSONUtil, LogUtil, ResUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { User } from '../../model/User';


/**
 * JSON工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  private readonly objStr: string = '{"id":"No_1060701","name":"张三","age":20,"addr":"乌市天山区","work":"工程师","salary":9223372036854775807.2512,"user":{"id":"No_1060701","name":"张三","age":20,"addr":"乌市天山区","work":"工程师"}}';
  private readonly mapStr: string = '{"id":"NO_10000011","name":"王五五","age":"30","addr":"乌市天山区","work":"攻城狮","salary":9223372036854775807.2512}';
  @State arrayStr: string = '';

  @MockSetup
  mock() {
    this.describe = new DescribeBean("JSONUtil", "JSON工具类");
  }

  aboutToAppear(): void {
    ResUtil.getRawFileContentStr('data_utils.json').then((result) => {
      this.arrayStr = result;
    })
  }

  onBackPress(): boolean {
    return false;
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("jsonToBean()")
            .btnStyle()
            .onClick(() => {
              let user = JSONUtil.jsonToBean(this.objStr, User);
              LogUtil.error(`${user instanceof User}`);
              LogUtil.error(`${user?.name} - ${user?.age} - ${user?.addr} - ${user?.work} - ${user?.salary} - ${user?.id}`)
              user?.say("麻辣豆腐！");
              ToastUtil.showToast("请查看Log日志");
            })
          Button("beanToJsonStr()")
            .btnStyle()
            .onClick(() => {
              let user: User = new User();
              let str = JSONUtil.beanToJsonStr(user);
              LogUtil.error(`JSON字符串： ${str}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("jsonToArray()")
            .btnStyle()
            .onClick(() => {
              ResUtil.getRawFileContentStrSync('data_utils.json')
              let array = JSONUtil.jsonToArray<DescribeBean>(this.arrayStr);
              array.forEach((item, index) => {
                LogUtil.error(`${index} - ${JSON.stringify(item)}`)
              })
              ToastUtil.showToast("请查看Log日志");
            })
          Button("jsonToMap()")
            .btnStyle()
            .onClick(() => {
              let map = JSONUtil.jsonToMap(this.mapStr);
              map.forEach((value, key) => {
                LogUtil.error(`${key} - ${value}`);
              })
              ToastUtil.showToast("请查看Log日志");
            })
          Button("mapToJsonStr()")
            .btnStyle()
            .onClick(() => {
              let map = JSONUtil.jsonToMap(this.mapStr);
              let JsonStr = JSONUtil.mapToJsonStr(map);
              LogUtil.error("JsonStr: " + JsonStr);
              ToastUtil.showToast("请查看Log日志");
            })

          Button("isJSONStr()")
            .btnStyle()
            .onClick(() => {
              let b1 = JSONUtil.isJSONStr(this.objStr);
              let b2 = JSONUtil.isJSONStr(this.arrayStr);
              let b3 = JSONUtil.isJSONStr(this.mapStr);
              let b4 = JSONUtil.isJSONStr("abcd1234");
              LogUtil.error(`b1: ${b1}\nb2: ${b2}\nb3: ${b3}\nb4: ${b4}`)
              ToastUtil.showToast("请查看Log日志")
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