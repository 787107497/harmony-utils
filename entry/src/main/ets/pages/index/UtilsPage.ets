import { JSONUtil, ResUtil } from '@pura/harmony-utils';
import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { DescribeBean } from '../../model/DescribeBean';
import { TitleView } from '../../component/TitleView';
import { CardLabel } from '../../component/CardLabel';

/**
 * 工具包主页面
 */
@Preview
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
    let jsonStr = ResUtil.getRawFileContentStrSync('data_utils.json');
    let arr = JSONUtil.jsonToArray<DescribeBean>(jsonStr);
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
    router.pushUrl({ url: url, params: describe })
  }


  build() {
    Column() {
      TitleView({ title: "鸿蒙指南" })
      Scroll(this.scroller) {
        Column() {
          ForEach(this.data, (item: DescribeBean) => {
            CardLabel({ describe: item })
              .onClick(() => {
                this.startPage(item)
              })
          }, (item: DescribeBean, index: number) => `${index}-${item.name}-${item.desc}`)
        }
        .margin({ top: 5, bottom: 5 })
      }.layoutWeight(1)
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.main_background'))
  }
}