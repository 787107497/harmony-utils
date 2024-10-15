import { ComposeTitleBar, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, ObjectUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';
import { User } from '../../entity/User';

/**
 * 对象工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State resultStr: string = ""
  @State user: User = new User();
  @State obj: String = new String("abcd@1234");
  @State obj1: String = new String();
  readonly userJsonStr = '{"id":"No_1060701","name":"张三","age":20}';

  @MockSetup
  mock() {
    this.describe = new DescribeBean("ObjectUtil", "对象工具类");
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
          Button("getHash()")
            .btnStyle()
            .onClick(() => {
              let hash1 = ObjectUtil.getHash(this.user);
              let hash2 = ObjectUtil.getHash(this.describe);
              this.resultStr = `hash1: ${hash1}\n\nhash2: ${hash2}`
              LogUtil.error(this.resultStr)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("isString()")
            .btnStyle()
            .onClick(() => {
              let bl1 = ObjectUtil.isString(this.user);
              let bl2 = ObjectUtil.isString(this.obj);
              this.resultStr = `bls1: ${bl1}\nbls2: ${bl2}`
              LogUtil.error(this.resultStr)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("isNull()")
            .btnStyle()
            .onClick(() => {
              let bl1 = ObjectUtil.isNull(this.user);
              let bl2 = ObjectUtil.isNull(this.obj);
              let bl3 = ObjectUtil.isNull(this.obj1);
              this.resultStr = `bl1: ${bl1}\nbl2: ${bl2}\nbl3: ${bl3}`
              LogUtil.error(this.resultStr)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("isEmpty()")
            .btnStyle()
            .onClick(() => {
              let bl1 = ObjectUtil.isEmpty(this.user);
              let bl2 = ObjectUtil.isEmpty(this.obj);
              let bl3 = ObjectUtil.isEmpty(this.obj1);
              this.resultStr = `bl1: ${bl1}\nbl2: ${bl2}\nbl3: ${bl3}`
              LogUtil.error(this.resultStr)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("deepCopy()")
            .btnStyle()
            .onClick(() => {
              let user: User = JSON.parse(this.userJsonStr);
              let user2: User = ObjectUtil.deepCopy(user);
              this.resultStr = `user1:\n${JSON.stringify(user)}\n\nuser2:\n${JSON.stringify(user2)}`
              LogUtil.error(this.resultStr);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("objToClass()")
            .btnStyle()
            .onClick(() => {
              let user: User = JSON.parse(this.userJsonStr);
              let user4 = ObjectUtil.objToClass(User, user);
              this.resultStr = `user3:\n${JSON.stringify(user)}\n\nuser4:\n${JSON.stringify(user4)}`
              LogUtil.error(this.resultStr);
              user4.say("小日子......");
              ToastUtil.showToast("请查看Log日志");
            })

          Text(this.resultStr)
            .visibility(StrUtil.isNotEmpty(this.resultStr) ? Visibility.Visible : Visibility.None)
            .textStyle()

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
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}