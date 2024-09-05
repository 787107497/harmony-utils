import { ComponentContent } from '@kit.ArkUI';
import { AnimationUtils, BaseDialogOptions, DialogHelper } from '@pura/harmony-dialog';


@Preview
@Component
export struct DialogPage {
  private scroller: Scroller = new Scroller();
  @State contentNode?: ComponentContent<string> = undefined;

  aboutToAppear(): void {

  }

  build() {
    Column() {
      Text("弹框")
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("测试1")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showCustomContentDialog({
                primaryTitle: "大标题",
                secondaryTitle: "哈哈哈哈",
                buttons: ["取消", "提交"],
                contentBuilder: () => {
                  this.CustomContentBuilder("11111111111")
                }
              })


            })
          Button("测试2")
            .btnStyle()
            .onClick(() => {
              let dialogId = DialogHelper.showTipsDialog({
                content: "呵呵呵呵，嘿嘿-xxxx",
                alignment: DialogAlignment.Bottom,
                offset: { dx: 0, dy: -35 },
                onAction: (index) => {
                  console.error("点击了-Index: " + index);
                  DialogHelper.closeDialog(dialogId);
                },
                transition: AnimationUtils.getBottom(200)
              });

            })
          Button("测试3")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showConfirmDialog({
                content: "这是一个确认弹框？",
                checkTips: "是否记住密码",
                onCheckedChange: (value) => {
                  console.error("点击了-value: " + value);
                },
                onAction: (action) => {
                  console.error("点击了-action: " + action);
                }
              })
            })
          Button("测试4")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showAlertDialog({
                primaryTitle: "大标题",
                secondaryTitle: "哈哈哈哈",
                content: "这是一个确认弹框？",
                onAction: (action) => {
                  console.error("点击了-action: " + action);
                }
              })
            })
          Button("测试5")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showCustomDialog(wrapBuilder(CustomBuilder), {});
            })
          Button("测试6")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showLoading({ content: "数据加载中" });
              setTimeout(() => {
                DialogHelper.closeLoading();
              }, 5000)
            })
          Button("测试7")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showToast("这是一个Toast，哈哈哈哈1",{alignment:DialogAlignment.Top,borderRadius:30});
            })
          Button("测试8")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showToastTip({
                imageRes: $r("app.media.icon_tip_info"),
                message: "保存成功",
              })
            })
          Button("测试9")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showToastLong("女人什么年龄是最好？任何年龄都可以。因为每个年龄段都有不一样的美。看XX的穿搭你就会发现成熟女性的魅力，反而会更加的吸引人。难道这就是传说中的可爱在性感面前真的不值得一提吗？");
            })
          Button("测试10")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showSelectDialog({
                content: "请选择数据",
                actionCancel: false,
                radioContent: ["111", "222", "333", "444"],
                onCheckedChanged: (index) => {
                  console.error("index: " + index);
                }
              })
            })

          Blank().layoutWeight(1)
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
  }

  @Builder
  CustomContentBuilder(params: string) {
    Text(params)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
  }
}


//自定义组件的内容
@Builder
function CustomBuilder(params: BaseDialogOptions) {
  Row() {
    Column() {
      Text("1111111111111111")
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 36 })
    }
  }
  .width('100%')
  .backgroundColor(Color.Pink)
  .transition(TransitionEffect.OPACITY.animation({ duration: 800 })
    .combine(TransitionEffect.translate({ y: 1000 })))
}


@Styles
function btnStyle() {
  .width('90%')
  .margin({ top: 10, bottom: 5 })
}