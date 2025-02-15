import { JSONUtil, ResUtil } from '@pura/harmony-utils';
import { CardFlow } from '../../component/CardFlow';
import { TitleView } from '../../component/TitleView';
import { DescribeBean } from '../../model/DescribeBean';
import { router } from '@kit.ArkUI';

@ComponentV2
export struct PlugPage {
  private scroller: Scroller = new Scroller();
  @Local data: Array<DescribeBean> = [];

  async aboutToAppear(): Promise<void> {
    this.getData();
  }

  getData() {
    let jsonStr = ResUtil.getRawFileContentStrSync('data_plug.json');
    this.data = JSONUtil.jsonToArray<DescribeBean>(jsonStr);
  }

  build() {
    Column() {
      TitleView({ title: "我的插件" })
      WaterFlow({ scroller: this.scroller }) {
        ForEach(this.data, (value: DescribeBean, index: number) => {
          FlowItem() {
            CardFlow({ describe: value })
              .onClick(() => {
                router.pushUrl({ url: value.url, params: value });
              })
          }
        }, (item: DescribeBean, index: number) => `${index}-${item.name}-${item.desc}`)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(0)
      .rowsGap(0)
      .padding({ top: 1, bottom: 1 })
      .margin({ left: 5, right: 5 })
      .layoutWeight(1)
    }
    .width('100%')
  }

}