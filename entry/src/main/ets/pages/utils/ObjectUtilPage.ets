import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, ObjectUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
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
  readonly userJsonStr = '{"id":"No_1060700","name":"张叁三","age":23}';

  @MockSetup
  mock() {
    this.describe = new DescribeBean("ObjectUtil", "对象工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("getHash()")
            .btnStyle()
            .onClick(() => {
              let hash1 = ObjectUtil.getHash(this.user);
              let hash2 = ObjectUtil.getHash(this.describe);
              this.resultStr = `hash1: ${hash1}\n\nhash2: ${hash2}`;
              LogUtil.error(this.resultStr);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("getClassName()")
            .btnStyle()
            .onClick(() => {
              let name1 = ObjectUtil.getClassName(this.user);
              let name2 = ObjectUtil.getClassName(this.describe);
              this.resultStr = `name1: ${name1}\n\nname2: ${name2}`
              LogUtil.error(this.resultStr)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("getMethodsNames()")
            .btnStyle()
            .onClick(() => {
              let methodsNames1 = ObjectUtil.getMethodsNames(this.user);
              let methodsNames2 = ObjectUtil.getMethodsNames(this.describe);
              this.resultStr = `User方法名: ${methodsNames1}\n\nDescribe方法名: ${methodsNames2}`
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
          Button("shallowCopy()")
            .btnStyle()
            .onClick(() => {
              let user: User = JSON.parse(this.userJsonStr);
              this.user.user = user;
              let user0 = ObjectUtil.shallowCopy(this.user);
              user.name = "苟富贵"; //浅拷贝，会打印出“苟富贵”
              this.resultStr = `user:\n${JSON.stringify(this.user)}\n\nuser1:\n${JSON.stringify(user0)}`
              LogUtil.error(this.resultStr);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("deepCopy()")
            .btnStyle()
            .onClick(() => {
              let user: User = JSON.parse(this.userJsonStr);
              this.user.user = user;
              let user2: User = ObjectUtil.deepCopy(this.user);
              user.name = "李旺财";  //深拷贝，不会打印出“李旺财”
              this.resultStr = `user:\n${JSON.stringify(this.user)}\n\nuser2:\n${JSON.stringify(user2)}`
              LogUtil.error(this.resultStr);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("assign()")
            .btnStyle()
            .onClick(() => {
              let user: User = JSON.parse(this.userJsonStr);
              let obj1: Record<string, Object> = { "xx_age": 20, "xx_name": "张呵呵" };
              let obj2: Record<string, Object> = { "my_age": 20, "my_name": "张叁三" };
              let user3 = ObjectUtil.assign(obj1, obj2, user);
              this.resultStr = `user:\n${JSON.stringify(user)}\n\nuser3:\n${JSON.stringify(user3)}`
              LogUtil.error(this.resultStr);
              ToastUtil.showToast("请查看Log日志");
            })
          Button("objToClass()")
            .btnStyle()
            .onClick(() => {
              let user: User = JSON.parse(this.userJsonStr);
              let user4 = ObjectUtil.objToClass(User, user);
              this.resultStr = `user:\n${JSON.stringify(user)}\n\nuser4:\n${JSON.stringify(user4)}`
              LogUtil.error(this.resultStr);
              user4.say("烤包子......");
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