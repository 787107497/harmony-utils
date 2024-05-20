import { FileUtil, JSONUtil } from 'harmony_utils';
import { DescribeBean } from '../entity/DescribeBean';
import { router } from '@kit.ArkUI';


@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State data: Array<DescribeBean> = [];

  async aboutToAppear(): Promise<void> {
    this.getData()
    this.startPage(this.data[31]);
  }

  onPageHide(): void {

  }

  onBackPress(): boolean {
    return false;
  }

  getData() {
    let jsonStr = FileUtil.getRawFileContentStrSync('data.json');
    let arr = JSONUtil.jsonToArray(DescribeBean, jsonStr);
    this.data = arr;
  }

  /**
   * 跳转到详情页
   * @param describe
   */
  startPage(describe: DescribeBean) {
    router.pushUrl({
      url: `pages/utils/${describe.name}Page`,
      params: describe
    })
  }

  @Builder
  itemBuilder(describe: DescribeBean) {
    Column() {
      Text(describe.name)
        .width('100%')
        .fontSize(26)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
      Text(describe.desc)
        .width('100%')
        .fontSize(16)
        .fontColor(Color.Brown)
        .fontStyle(FontStyle.Italic)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 18, top: 15, right: 18, bottom: 15 })
    .backgroundColor(Color.White)
    .border({ width: 1, color: $r('app.color.color_line'), radius: 6, style: BorderStyle.Solid })
    .shadow(ShadowStyle.OUTER_DEFAULT_SM)
    .margin({ left: 15, top: 10, right: 15, bottom: 10 })
    .onClick(() => {
      this.startPage(describe)
    })
  }

  build() {
    Column() {
      Text("鸿蒙工具包")
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column() {
          ForEach(this.data, (item: DescribeBean) => {
            this.itemBuilder(item)
          }, (item: DescribeBean) => item.name)
        }
        .margin({ top: 5, bottom: 5 })
      }.layoutWeight(1)
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.main_background'))
  }
}