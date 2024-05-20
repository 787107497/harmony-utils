import { ComposeTitleBar, router } from '@kit.ArkUI';
import { LogUtil, ObjectUtil, ToastUtil } from 'harmony_utils';
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
  @State user: User = new User();
  @State obj: String = new String("abcd@1234");
  @State obj1: String = new String();

  aboutToAppear(): void {

  }

  onBackPress(): boolean {
    return false;
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
          Button("isString()")
            .btnStyle()
            .onClick(() => {
              let bl1 = ObjectUtil.isString(this.user);
              let bl2 = ObjectUtil.isString(this.obj);
              LogUtil.error(`bls1: ${bl1}\nbls2: ${bl2}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("isNull()")
            .btnStyle()
            .onClick(() => {
              let bl1 = ObjectUtil.isNull(this.user);
              let bl2 = ObjectUtil.isNull(this.obj);
              let bl3 = ObjectUtil.isNull(this.obj1);
              LogUtil.error(`bl1: ${bl1}\nbl2: ${bl2}\nbl3: ${bl3}`)
              ToastUtil.showToast("请查看Log日志")
            })
          Button("deepCopy()")
            .btnStyle()
            .onClick(() => {
              this.user.user = new User();
              let obj = ObjectUtil.deepCopy(this.user)
              LogUtil.error(`${JSON.stringify(obj)}`)
              LogUtil.error(`${JSON.stringify(obj, null, 2)}`)
              ToastUtil.showToast("请查看Log日志")
            })

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