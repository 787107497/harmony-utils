import { DialogHelper } from '@pura/harmony-dialog';
import { AppUtil, LogUtil } from '@pura/harmony-utils';

@Preview
@Component
export struct OtherPage {
  private scroller: Scroller = new Scroller();

  onCreateSub(): void {
    AppUtil.getStatusBarHeight()

  }

  build() {
    Column() {
      Text("我的")
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column() {
          Blank().layoutWeight(1)

          Text("更多组件向您赶来...")
            .fontSize(24)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .onClick(()=>{
              // let height = Utils.getNavigationIndicatorHeight(AppUtil.getContext());
              // LogUtil.error("height: " + height);
              DialogHelper.showTextPickerDialog({
                primaryButton: "取消",
                secondaryButton: {
                  value: "确定"
                },
                backgroundColor: "#FFFFFF",
                range: ["111", "222", "333", "444", "555", "666", "777", "888", "999"],
                onChange: (value: string | string[], index: number | number[]) => {
                  LogUtil.error("value: " + value);
                  LogUtil.error("index: " + index);
                }
              })

            })

          Blank().layoutWeight(1)

        }
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width("100%")
    .height("100%")
    .onAppear(() => {
      this.onCreateSub()
    })
  }
}