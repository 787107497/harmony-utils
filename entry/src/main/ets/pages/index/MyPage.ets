import { JSONUtil, ResUtil, WantUtil } from '@pura/harmony-utils';
import { TitleView } from '../../component/TitleView';
import { DescribeBean } from '../../entity/DescribeBean';

@Preview
@Component
export struct MyPage {
  private scroller: Scroller = new Scroller();
  @State data: Array<DescribeBean> = [];

  onCreateSub(): void {
    let jsonStr = ResUtil.getRawFileContentStrSync('user.json');
    let arr = JSONUtil.jsonToArray<DescribeBean>(jsonStr);
    if (arr && arr.length > 0) {
      this.data = arr;
    }
  }

  build() {
    Column() {
      TitleView({ title: "我的" })
      Scroll(this.scroller) {
        Column() {
          Row() {
            Image($r('app.media.icon_user'))
              .size({ width: 90, height: 90 })
              .borderRadius(6)

            Column({ space: 0 }) {
              Text("桃花镇童长老")
                .fontFamily('MyFont')
                .fontWeight(FontWeight.Bold)
                .fontSize(26)
              Text("༺工程师༻")
                .fontFamily('MyFont')
                .fontColor($r('app.color.color_main'))
                .fontWeight(FontWeight.Lighter)
                .fontStyle(FontStyle.Italic)
                .fontSize(16)
                .margin({ top: 6 })
              Text("QQ交流群：569512366")
                .fontFamily('MyFont')
                .fontWeight(FontWeight.Regular)
                .fontStyle(FontStyle.Italic)
                .fontSize(18)
                .margin({ top: 12 })
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 12 })
          }
          .padding(20)
          .width("100%")
          .backgroundColor($r('app.color.card_background'))
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
      Divider()
        .backgroundColor($r('app.color.color_line'))
        .visibility(index == 0 ? Visibility.None : Visibility.Visible)
      Row() {
        Text(item.name)
          .fontFamily('MyFont')
          .fontSize(20)
          .fontColor($r('app.color.card_label'))
          .layoutWeight(1)
          .margin(5)
        Image($r('app.media.icon_right'))
          .fillColor($r('app.color.card_right'))
          .size({ width: 16, height: 16 })
      }
      .width('100%')
      .padding(15)
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))
      .onClick(() => {
        WantUtil.toWebBrowser(item.url); //跳转系统浏览器
      })
    }

  }
}