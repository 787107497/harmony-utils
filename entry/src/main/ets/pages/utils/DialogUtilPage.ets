import { ComposeTitleBar, router } from '@kit.ArkUI';
import { DateUtil, DialogUtil, LogUtil, ToastUtil } from 'harmony_utils';
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
          Button("showConfirmDialog()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showConfirmDialog({
                title: "温馨提示",
                message: 'APP已更新最新版本！',
                confirm: {
                  value: "确定",
                  action: () => {
                    ToastUtil.showToast("点击了”确定“按钮")
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
                    ToastUtil.showToast("点击了”取消“按钮")
                  }
                },
                secondaryButton: {
                  value: "更新",
                  action: () => {
                    ToastUtil.showToast("点击了”更新“按钮")
                  }
                }
              })
            })
          Button("showDialog()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showDialog({
                title: "温馨提示",
                message: "最新版本可提供更多的工具和功能",
                buttons: [{
                  value: "按钮1",
                  action: () => {
                    ToastUtil.showToast(`点击了"按钮1"`)
                  }
                }, {
                  value: "按钮2",
                  action: () => {
                    ToastUtil.showToast(`点击了"按钮2"`)
                  }
                }, {
                  value: "按钮3",
                  action: () => {
                    ToastUtil.showToast(`点击了"按钮3"`)
                  }
                }, {
                  value: "按钮4",
                  action: () => {
                    ToastUtil.showToast(`点击了"按钮4"`)
                  }
                }]
              })
            })
          Button("showDialogEasy()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showDialogEasy({
                title: "温馨提示",
                message: "最新版本可提供更多的工具和功能",
                buttons: ["按钮1", "按钮2", "按钮3", "按钮4"],
                callBack: (index) => {
                  ToastUtil.showToast(`点击了"按钮${(index + 1)}"`)
                }
              })
            })
          Button("showActionSheet()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showActionSheet({
                title: "温馨提示",
                message: "最新版本可提供更多的工具和功能",
                sheets: [{
                  title: "功能菜单一",
                  action: () => {
                    ToastUtil.showToast(`点击了"功能菜单一"`)
                  }
                }, {
                  title: "功能菜单二",
                  action: () => {
                    ToastUtil.showToast(`点击了"功能菜单二"`)
                  }
                }, {
                  title: "功能菜单三",
                  action: () => {
                    ToastUtil.showToast(`点击了"功能菜单三"`)
                  }
                }, {
                  title: "功能菜单四",
                  action: () => {
                    ToastUtil.showToast(`点击了"功能菜单四"`)
                  }
                }, {
                  title: "功能菜单五",
                  action: () => {
                    ToastUtil.showToast(`点击了"功能菜单五"`)
                  }
                }],
                confirm: {
                  value: "确认",
                  action: () => {
                    ToastUtil.showToast(`点击了"确认"`)
                  }
                },
                cancel: () => {
                  ToastUtil.showToast(`取消了`)
                }
              })
            })
          Button("showActionSheetEasy()")
            .btnStyle()
            .onClick(() => {
              DialogUtil.showActionSheetEasy({
                title: "温馨提示",
                message: "最新版本可提供更多的工具和功能",
                sheets: ["功能菜单一", "功能菜单二", "功能菜单三", "功能菜单四", "功能菜单五"],
                callBack: (index) => {
                  ToastUtil.showToast(`点击了"${index}"`)
                },
                cancel: () => {
                  ToastUtil.showToast(`取消了`)
                }
              });
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