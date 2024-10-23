import { JSONUtil, ResUtil } from '@pura/harmony-utils';
import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 工具包主页面
 */
@Component
export struct UtilsPage {
  private scroller: Scroller = new Scroller();
  @State data: Array<DescribeBean> = [];

  @MockSetup
  mock() {
    this.getData();
  }

  async aboutToAppear(): Promise<void> {
    this.getData();
  }

  getData() {
    let jsonStr = ResUtil.getRawFileContentStrSync('data.json');
    let arr = JSONUtil.jsonToArray(DescribeBean, jsonStr);
    if (arr && arr.length > 0) {
      this.data = arr;
    }
  }


  onBackPress(): boolean {
    return false;
  }

  /**
   * 跳转到详情页
   * @param describe
   */
  startPage(describe: DescribeBean) {
    let url = `pages/${describe.name}Page`;
    if (describe.type == 1) {
      url = `pages/utils/${describe.name}Page`;
    } else if (describe.type == 2) {
      url = `pages/crypto/${describe.name}Page`;
    }
    router.pushUrl({
      url: url,
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
    .padding({
      left: 18,
      top: 15,
      right: 18,
      bottom: 15
    })
    .backgroundColor(Color.White)
    .border({
      width: 1,
      color: $r('app.color.color_line'),
      radius: 6,
      style: BorderStyle.Solid
    })
    .shadow(ShadowStyle.OUTER_DEFAULT_SM)
    .margin({
      left: 15,
      top: 10,
      right: 15,
      bottom: 10
    })
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
          }, (item: DescribeBean, index: number) => `${index}-${item.name}-${item.desc}`)
        }
        .margin({ top: 5, bottom: 5 })
      }.layoutWeight(1)
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.main_background'))
  }
}