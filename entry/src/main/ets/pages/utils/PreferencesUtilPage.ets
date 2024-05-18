import { ComposeTitleBar, router } from '@kit.ArkUI';
import { PreferencesUtil, RandomUtil, StrUtil, ToastUtil } from 'harmony_utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * Preferences（用户首选项）工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State pStr: string = ''

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
          Button("put()")
            .btnStyle()
            .onClick(() => {
              PreferencesUtil.put("id", RandomUtil.generateUUID36());
              ToastUtil.showToast("数据缓存成功")
            })
          Button("get()")
            .btnStyle()
            .onClick(async () => {
              let id = await PreferencesUtil.get("id", "") as number
              this.pStr = `缓存-id：\n${id}`
            })
          Button("getNumber()")
            .btnStyle()
            .onClick(async () => {
              let id = await PreferencesUtil.getNumber("id")
              this.pStr = `缓存·id：\n${id}`
            })
          Button("getString()")
            .btnStyle()
            .onClick(async () => {
              let id = await PreferencesUtil.getString("id")
              this.pStr = `缓存_id：\n${id}`
            })
          Button("has()")
            .btnStyle()
            .onClick(async () => {
              let has = await PreferencesUtil.has("id");
              ToastUtil.showToast(`缓存值是否存在：${has}`)
            })
          Button("delete()")
            .btnStyle()
            .onClick(() => {
              PreferencesUtil.delete("id");
              ToastUtil.showToast('删除缓存成功')
            })
          Button("clear()")
            .btnStyle()
            .onClick(() => {
              PreferencesUtil.clear();
              ToastUtil.showToast('清空缓存成功')
            })

          Text(this.pStr)
            .visibility(StrUtil.isNotEmpty(this.pStr) ? Visibility.Visible : Visibility.None)
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