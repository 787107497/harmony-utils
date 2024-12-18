import { JSONUtil, LogUtil, ResUtil, WantUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../entity/DescribeBean';

@Preview
@Component
export struct OtherPage {
  private scroller: Scroller = new Scroller();
  @State data: Array<DescribeBean> = [];

  onCreateSub(): void {
    let jsonStr = ResUtil.getRawFileContentStrSync('user.json');
    let arr = JSONUtil.jsonToArray(DescribeBean, jsonStr);
    if (arr && arr.length > 0) {
      this.data = arr;
    }
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
          Row() {
            Image($r('app.media.icon_user'))
              .size({ width: 90, height: 90 })
              .borderRadius(6)

            Column({ space: 10 }) {
              Text("桃花镇童长老")
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
                .fontSize(26)
              Text("༺工程师༻")
                .fontColor(Color.Brown)
                .fontWeight(FontWeight.Lighter)
                .fontStyle(FontStyle.Italic)
                .fontSize(16)
              Text("QQ交流群：569512366")
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Regular)
                .fontStyle(FontStyle.Italic)
                .fontSize(12)
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 12 })

          }
          .padding(20)
          .width("100%")
          .backgroundColor(Color.White)
          .margin({ bottom: 15 })

          ForEach(this.data, (item: DescribeBean, index: number) => {
            this.itemView(item, index)
          }, (item: DescribeBean, index: number) => `${index}-${item.name}-${item.url}`)
        }
        .width('100%')
      }
      .width('100%')
    }
    .backgroundColor($r('app.color.main_background'))
    .width("100%")
    .height("100%")
    .onAppear(() => {
      this.onCreateSub()
    })
  }

  @Builder
  itemView(item: DescribeBean, index: number) {
    Column() {
      Divider().visibility(index == 0 ? Visibility.None : Visibility.Visible)
      Row() {
        Text(item.name)
          .fontSize(20)
          .fontColor($r('app.color.color_33'))
          .layoutWeight(1)
          .margin(5)
        Image($r('app.media.icon_right'))
          .fillColor($r('app.color.color_cc'))
          .size({ width: 20, height: 20 })
      }
      .width('100%')
      .padding(15)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Color.White)
      .onClick(() => {
        WantUtil.toWebBrowser(item.url); //跳转系统浏览器
      })
    }

  }
}