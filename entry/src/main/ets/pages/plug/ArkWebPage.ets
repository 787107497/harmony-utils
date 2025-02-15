import { router } from '@kit.ArkUI';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';


@Entry
@ComponentV2
export struct ArkWebPage {

  @Local describe: DescribeBean = router.getParams() as DescribeBean;

  aboutToAppear(): void {

  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()


    }
  }



}