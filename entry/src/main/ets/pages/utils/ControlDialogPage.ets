import { ComposeTitleBar, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import {
  AlertControlDialog,
  ConfirmControlDialog,
  LoadingControlDialog,
  SelectControlDialog,
  TipControlDialog,
  ToastUtil
} from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 自定义弹框组件
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  private readonly array: string[] = ["黑龙江省", "哈尔滨市", "道里区", "砂山", "砀山", "高薪区"];
  @State selectIndex: number = 0;
  @State visible1: boolean = false;
  @State visible2: boolean = false;
  @State visible3: boolean = false;
  @State visible4: boolean = false;
  @State visible5: boolean = false;

  @MockSetup
  mock() {
    this.describe = new DescribeBean("ControlDialog", "自定义弹框组件");
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
          Button("AlertControlDialog")
            .btnStyle()
            .onClick(() => {
              this.visible1 = true;
            })
          Button("ConfirmControlDialog")
            .btnStyle()
            .onClick(() => {
              this.visible2 = true;
            })
          Button("LoadingControlDialog")
            .btnStyle()
            .onClick(() => {
              this.visible3 = true;
            })
          Button("SelectControlDialog")
            .btnStyle()
            .onClick(() => {
              this.visible4 = true;
            })
          Button("TipControlDialog")
            .btnStyle()
            .onClick(() => {
              this.visible5 = true;
            })

          AlertControlDialog({
            visible: this.visible1,
            options: {
              content: "操作确认类弹出框",
              primaryButton: {
                value: "取消",
                action: () => {
                  ToastUtil.showToast("取消了")
                }
              },
              secondaryButton: {
                value: "确认",
                action: () => {
                  ToastUtil.showToast("确认了")
                }
              },
              cancel: () => {
                this.visible1 = false;
              }
            }
          })

          ConfirmControlDialog({
            visible: this.visible2,
            options: {
              title: "温馨提示",
              content: "信息确认类弹出框",
              checkTips: "记住密码",
              primaryButton: {
                value: "取消",
                action: () => {
                  ToastUtil.showToast("取消了")
                }
              },
              secondaryButton: {
                value: "确认",
                action: () => {
                  ToastUtil.showToast("确认了")
                }
              },
              cancel: () => {
                this.visible2 = false;
              }
            }
          })

          LoadingControlDialog({
            visible: this.visible3,
            options: {
              content: "进度加载类弹出框",
              cancel: () => {
                this.visible3 = false;
              }
            }
          })

          SelectControlDialog({
            visible: this.visible4,
            options: {
              title: "温馨提示",
              content: "选择类弹出框",
              selectedIndex: this.selectIndex,
              radioText: this.array,
              callBack: (index) => {
                this.selectIndex = index;
                ToastUtil.showToast(`index: ${index}`)
              },
              confirm: {
                value: "取消",
                action: () => {
                  ToastUtil.showToast("取消了")
                }
              },
              cancel: () => {
                this.visible4 = false;
              }
            }
          })

          TipControlDialog({
            visible: this.visible5,
            options: {
              title: "温馨提示",
              content: "提示弹出框-弹出框",
              imageRes: $r('app.media.as3'),
              imageSize: { width: '100%' },
              checkTips: "记住密码",
              primaryButton: {
                value: "取消",
                action: () => {
                  ToastUtil.showToast("取消了")
                }
              },
              secondaryButton: {
                value: "确认",
                action: () => {
                  ToastUtil.showToast("确认了")
                }
              },
              cancel: () => {
                this.visible5 = false;
              }
            }
          })


          Text('').layoutWeight(1)
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)
    }

    .width
    ('100%'
    )
    .height
    ('100%'
    )
    .justifyContent
    (FlexAlign
      .Start
    )
    .backgroundColor
    ($r
    ('app.color.main_background'
    ))
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