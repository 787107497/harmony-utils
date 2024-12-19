import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { DialogAction } from '@pura/harmony-dialog';
import { DateUtil, DialogUtil, LogUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 弹窗工具类（AlertDialog）
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  private readonly array: string[] = ["黑龙江省", "哈尔滨市", "道里区", "砂山", "砀山", "高薪区"];
  @State selectValue: string = '';

  @MockSetup
  mock() {
    this.describe = new DescribeBean("DialogUtil", "弹窗工具类（AlertDialog）");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("设置默认样式(上)")
            .btnStyle()
            .onClick(() => {
              DialogUtil.setDefaultConfig((config) => {
                config.subtitle = "弹窗副标题"
                config.alignment = DialogAlignment.Top
                config.backgroundColor = '#00FF00'
                config.borderWidth = 2
                config.autoCancel = true
              });
              ToastUtil.showLong("样式设置成功");
            })
          Button("设置默认样式(中)")
            .btnStyle()
            .onClick(() => {
              DialogUtil.setDefaultConfig((config) => {
                config.alignment = DialogAlignment.Center
                config.backgroundColor = Color.Transparent
                config.borderWidth = 0
                config.autoCancel = false
              });
              ToastUtil.showLong("样式设置成功");
            })
          Button("设置默认样式(下)")
            .btnStyle()
            .onClick(() => {
              DialogUtil.setDefaultConfig((config) => {
                config.alignment = DialogAlignment.Bottom
                config.backgroundColor = Color.Brown
                config.borderColor = Color.Blue
              });
              ToastUtil.showLong("样式设置成功");
            })
          Button("showConfirmDialog()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showConfirmDialog({
                title: "温馨提示",
                message: 'APP已更新最新版本！',
                confirm: "确定",
                onAction: () => {
                  ToastUtil.showToast("点击了“确定”按钮")
                }
              })
            })
          Button("showConfirmDialog()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showConfirmDialog({
                title: "温馨提示",
                message: 'APP已更新最新版本！',
                confirm: {
                  value: "确定",
                  action: () => {
                    ToastUtil.showToast("点击了“确定”按钮")
                  }
                }
              })
            })
          Button("showPrimaryDialog()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showPrimaryDialog({
                message: '最新版本可提供更多的工具和功能，欢迎下载更新！！！',
                // primaryButton: "取消",
                // secondaryButton: "更新",
                onAction: (action) => {
                  if (action == DialogAction.ONE) {
                    ToastUtil.showToast("点击了“取消”按钮")
                  } else if (action == DialogAction.TWO) {
                    ToastUtil.showToast("点击了“更新”按钮")
                  }
                }
              })
            })
          Button("showPrimaryDialog()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showPrimaryDialog({
                title: "温馨提示",
                message: '最新版本可提供更多的工具和功能，欢迎下载更新！',
                primaryButton: {
                  value: "取消",
                  action: () => {
                    ToastUtil.showToast("点击了“取消”按钮")
                  }
                },
                secondaryButton: {
                  value: "更新",
                  fontColor: Color.Red,
                  action: () => {
                    ToastUtil.showToast("点击了“更新”按钮")
                  }
                },
                onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
                  LogUtil.error("showPrimaryDialog-onWillDismiss: " + JSON.stringify(dismissDialogAction))
                }
              })
            })
          Button("showDialog()")
            .btnStyle()
            .onClick(() => {
              let buttons = ["取消", "稍后", "更新", "升级"];
              DialogUtil.showDialog({
                title: "温馨提示",
                message: "最新版本可提供更多的工具和功能",
                buttons: buttons,
                onAction: (action) => {
                  ToastUtil.showToast(`点击了：${buttons[Math.abs(action)-1]}`);
                }
              })
            })
          Button("showDialog()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showDialog({
                title: "温馨提示",
                message: "最新版本可提供更多的工具和功能",
                buttonDirection: DialogButtonDirection.HORIZONTAL,
                buttons: [{
                  value: "取消",
                  fontColor: Color.Yellow,
                  action: () => {
                    ToastUtil.showToast(`点击了"取消"`)
                  }
                }, {
                  value: "稍后",
                  fontColor: Color.Green,
                  action: () => {
                    ToastUtil.showToast(`点击了"稍后"`)
                  }
                }, {
                  value: "更新",
                  fontColor: Color.Red,
                  action: () => {
                    ToastUtil.showToast(`点击了"更新"`)
                  }
                }]
              })
            })
          Button("showActionSheet()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showActionSheet({
                message: "请选择",
                sheets: ["功能菜单一", "功能菜单二", "功能菜单三", "功能菜单四", "功能菜单五"],
                onAction: (index) => {
                  ToastUtil.showToast("index: " + index);
                }
              })
            })
          Button("showCalendarPicker()")
            .btnStyle()
            .onClick(() => {
              let date = DateUtil.getToday()
              DialogUtil.showCalendarPicker({
                selected: date,
                onAccept: (value) => {
                  LogUtil.error(`选择了： ${JSON.stringify(value)}}`)
                  ToastUtil.showToast(DateUtil.getFormatDateStr(value, "yyyy年MM月dd日"))
                },
                onCancel: () => {
                  ToastUtil.showToast(`取消了`)
                }
              })
            })
          Button("showDatePicker()")
            .btnStyle()
            .onClick(() => {
              let date = DateUtil.getToday();
              DialogUtil.showDatePicker({
                selected: date,
                showTime: true,
                onDateAccept: (value) => {
                  LogUtil.error(`选择了： ${JSON.stringify(value)}}`)
                  ToastUtil.showToast(DateUtil.getFormatDateStr(value, "yyyy年MM月dd日 HH:mm"))
                },
                onCancel: () => {
                  ToastUtil.showToast(`取消了`)
                }
              })
            })
          Button("showTimePicker()")
            .btnStyle()
            .onClick(() => {
              let date = DateUtil.getToday();
              DialogUtil.showTimePicker({
                selected: date,
                format: TimePickerFormat.HOUR_MINUTE,
                useMilitaryTime: true,
                onAccept: (value) => {
                  LogUtil.error(`选择了： ${JSON.stringify(value)}}`)
                  ToastUtil.showToast(`${value.hour}时${value.minute}分`)
                },
                onCancel: () => {
                  ToastUtil.showToast(`取消了`)
                }
              })
            })
          Button("showTextPicker()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showTextPicker({
                range: this.array,
                value: this.selectValue,
                onAccept: (result) => {
                  LogUtil.error(`选择了： ${JSON.stringify(result)}}`);
                  this.selectValue = result.value as string;
                  ToastUtil.showToast(`${this.selectValue}`)
                },
                onCancel: () => {
                  ToastUtil.showToast(`取消了`)
                }
              })
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
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}