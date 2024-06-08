import { ComposeTitleBar, router } from '@kit.ArkUI';
import { ActionUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 弹窗工具类（promptAction）
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;

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
              ActionUtil.showConfirmDialog({
                title: "温馨提示",
                message: '版式文件已保存',
                buttonText: "确定",
                callBack: () => {
                  ToastUtil.showToast("点击了”确定“按钮")
                }
              })
            })
          Button("showPrimaryDialog()")
            .btnStyle()
            .onClick(() => {
              ActionUtil.showPrimaryDialog({
                title: "温馨提示",
                message: "最新版本可提供更多的工具和功能，欢迎下载更新",
                cancelText: "取消",
                confirmText: "更新",
                callBack: (index) => {
                  ToastUtil.showToast(`点击了"${index == 0 ? '取消' : '更新'}"按钮`)
                }
              })
            })
          Button("showDialog()")
            .btnStyle()
            .onClick(() => {
              ActionUtil.showDialog({
                title: "温馨提示",
                message: "最新版本可提供更多的工具和功能，欢迎下载更新",
                buttons: [{
                  text: "按钮1",
                  action: () => {
                    ToastUtil.showToast(`点击了"按钮1"`)
                  }
                }, {
                  text: "按钮2",
                  action: () => {
                    ToastUtil.showToast(`点击了"按钮2"`)
                  }
                }, {
                  text: "按钮3",
                  action: () => {
                    ToastUtil.showToast(`点击了"按钮3"`)
                  }
                }, {
                  text: "按钮4",
                  action: () => {
                    ToastUtil.showToast(`点击了"按钮4"`)
                  }
                }]
              })
            })
          Button("showActionMenuEasy()")
            .btnStyle()
            .onClick(() => {
              ActionUtil.showActionMenuEasy({
                title: "请选择列表项",
                buttons: ["列表项选项一", "列表项选项二", "列表项选项三", "列表项选项四", "列表项选项五", "列表项选项六"],
                callBack: (index, data) => {
                  ToastUtil.showToast(`点击了 - ${index} - ${data}`)
                }
              })
            })
          Button("showActionMenu()")
            .btnStyle()
            .onClick(() => {
              ActionUtil.showActionMenu({
                title: "请选择列表项",
                buttons: [{
                  text: "列表项选项一",
                  action: () => {
                    ToastUtil.showToast(`点击了"列表项选项一"`)
                  }
                }, {
                  text: "列表项选项二",
                  action: () => {
                    ToastUtil.showToast(`点击了"列表项选项二"`)
                  }
                }, {
                  text: "列表项选项三",
                  action: () => {
                    ToastUtil.showToast(`点击了"列表项选项三"`)
                  }
                }, {
                  text: "列表项选项四",
                  action: () => {
                    ToastUtil.showToast(`点击了"列表项选项四"`)
                  }
                }, {
                  text: "列表项选项五",
                  action: () => {
                    ToastUtil.showToast(`点击了"列表项选项五"`)
                  }
                }, {
                  text: "列表项选项六",
                  action: () => {
                    ToastUtil.showToast(`点击了"列表项选项六"`)
                  }
                },]
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