import { JSONUtil, ResUtil } from '@pura/harmony-utils';
import { CardFlow } from '../../component/CardFlow';
import { TitleView } from '../../component/TitleView';
import { DescribeBean } from '../../entity/DescribeBean';

@ComponentV2
export struct PlugPage {
  private scroller: Scroller = new Scroller();
  @Local data: Array<DescribeBean> = [];

  async aboutToAppear(): Promise<void> {
    this.getData();
  }

  getData() {
    let jsonStr = ResUtil.getRawFileContentStrSync('data.json');
    let arr = JSONUtil.jsonToArray<DescribeBean>(jsonStr);
    if (arr && arr.length > 0) {
      this.data = arr;
    }
  }

  build() {
    Column() {
      TitleView({ title: "我的插件" })
      WaterFlow({ scroller: this.scroller }) {
        ForEach(this.data, (value: DescribeBean, index: number) => {
          FlowItem() {
            CardFlow({ describe: value })
          }
        }, (item: DescribeBean, index: number) => `${index}-${item.name}-${item.desc}`)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(0)
      .padding({ top: 3, bottom: 3, left: 10, right: 10 })
      .layoutWeight(1)
      .width('100%')
    }
  }
}