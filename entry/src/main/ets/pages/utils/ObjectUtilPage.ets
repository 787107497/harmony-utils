import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { DialogHelper } from '@pura/harmony-dialog';
import { FileUtil, ObjectUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { User } from '../../model/User';
import { Utils } from '../../utils/Utils';
import { BusinessError } from '@kit.BasicServicesKit';


/**
 * 对象工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State user: User = new User();
  @State obj: String = new String("abcd@1234");
  @State obj1: String = new String();
  readonly userJsonStr = '{"id":"No_1060700","name":"李四","age":23}';

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
              let str = `hash1: ${hash1}\n\nhash2: ${hash2}`;
              Utils.showSheetText(str);
            })
          Button("getClassName()")
            .btnStyle()
            .onClick(() => {
              let name1 = ObjectUtil.getClassName(this.user);
              let name2 = ObjectUtil.getClassName(this.describe);
              let str = `name1: ${name1}\n\nname2: ${name2}`
              Utils.showSheetText(str);
            })
          Button("getMethodsNames()")
            .btnStyle()
            .onClick(() => {
              let methodsNames1 = ObjectUtil.getMethodsNames(this.user);
              let methodsNames2 = ObjectUtil.getMethodsNames(this.describe);
              let str = `User方法名: \n${methodsNames1}\n\nDescribe方法名: \n${methodsNames2}`
              Utils.showSheetText(str);
            })
          Button("isString()")
            .btnStyle()
            .onClick(() => {
              let bl1 = ObjectUtil.isString(this.user);
              let bl2 = ObjectUtil.isString(this.obj);
              let str = `bls1: ${bl1}\nbls2: ${bl2}`
              Utils.showSheetText(str);
            })
          Button("isNull()")
            .btnStyle()
            .onClick(() => {
              let bl1 = ObjectUtil.isNull(this.user);
              let bl2 = ObjectUtil.isNull(this.obj);
              let bl3 = ObjectUtil.isNull(this.obj1);
              let str = `bl1: ${bl1}\nbl2: ${bl2}\nbl3: ${bl3}`
              Utils.showSheetText(str);
            })
          Button("isEmpty()")
            .btnStyle()
            .onClick(() => {
              let bl1 = ObjectUtil.isEmpty(this.user);
              let bl2 = ObjectUtil.isEmpty(this.obj);
              let bl3 = ObjectUtil.isEmpty(this.obj1);
              let str = `bl1: ${bl1}\nbl2: ${bl2}\nbl3: ${bl3}`
              Utils.showSheetText(str);
            })
          Button("shallowCopy()")
            .btnStyle()
            .onClick(() => {
              let user: User = JSON.parse(this.userJsonStr);
              this.user.user = user;
              let user1 = ObjectUtil.shallowCopy(this.user);
              user.name = "苟富贵"; //浅拷贝，会打印出“苟富贵”
              let str = `user:\n${JSON.stringify(this.user)}\n\nuser1:\n${JSON.stringify(user1)}`
              Utils.showSheetText(str);
            })
          Button("deepCopy()")
            .btnStyle()
            .onClick(() => {
              let user: User = JSON.parse(this.userJsonStr);
              this.user.user = user;
              let user2: User = ObjectUtil.deepCopy(this.user);
              user.name = "李旺财";  //深拷贝，不会打印出“李旺财”
              let str = `user:\n${JSON.stringify(this.user)}\n\nuser2:\n${JSON.stringify(user2)}`
              Utils.showSheetText(str);
            })
          Button("assign()")
            .btnStyle()
            .onClick(() => {
              let user: User = JSON.parse(this.userJsonStr);
              let obj1: Record<string, Object> = { "xx_age": 20, "xx_name": "张呵呵" };
              let obj2: Record<string, Object> = { "my_age": 20, "my_name": "张叁三" };
              let user3 = ObjectUtil.assign(obj1, obj2, user);
              let str = `user:\n${JSON.stringify(user)}\n\nuser3:\n${JSON.stringify(user3)}`
              Utils.showSheetText(str);
            })
          Button("objToClass()")
            .btnStyle()
            .onClick(() => {
              let user: User = JSON.parse(this.userJsonStr);
              let user4 = ObjectUtil.objToClass(User, user);
              let str = `user:\n${JSON.stringify(user)}\n\nuser4:\n${JSON.stringify(user4)}`
              user4.say("烤包子......");
              Utils.showSheetText(str);
            })
          Button("deleteRecord()")
            .btnStyle()
            .onClick(() => {
              let record: Record<string, Object> = { "name": "张若楠", "age": 18, "work": "演员", "addr": "上海市" };
              let recordStr = JSON.stringify(record);
              ObjectUtil.deleteRecord(record,"work");
              let str = `record:\n${recordStr}\n\n删除work后:\n${JSON.stringify(record)}`;
              Utils.showSheetText(str);
            })
          Button("getValue()")
            .btnStyle()
            .onClick(() => {
              let name = ObjectUtil.getValue<string>(this.user, "name");
              DialogHelper.showToast(`对象 name：${name}`);
            })
          Button("setValue()")
            .btnStyle()
            .onClick(() => {
              let userStr = JSON.stringify(this.user);
              ObjectUtil.setValue(this.user, "name", "张若楠");
              ObjectUtil.setValue(this.user, "work", "演员");
              ObjectUtil.setValue(this.user, "job", "表演");
              let str = `user:\n${userStr}\n\n赋值后:\n${JSON.stringify(this.user)}`;
              Utils.showSheetText(str);
            })
          Button("getErrorStr()")
            .btnStyle()
            .onClick(() => {
              let error = new Error("未知异常！");
              let errorStr = ObjectUtil.getErrorStr(error as BusinessError);
              try {
                let path = 'null';
                FileUtil.openSync(path);
              } catch (err) {
                let errStr = ObjectUtil.getErrorStr(err);
                Utils.showSheetText(`${errorStr}\n\n${errStr}`);
              }
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