import { router } from '@kit.ArkUI';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { webview } from '@kit.ArkWeb';
import { ArkWeb, ArkWebOptions } from '@pura/harmony-web';
import { MyWebClient } from '../../utils/MyWebClient';
import { MyJsObject } from '../../utils/MyJsObject';


@Entry
@ComponentV2
export struct ArkWebPage {
  @Local describe: DescribeBean = router.getParams() as DescribeBean;
  private controller: webview.WebviewController = new webview.WebviewController();
  @Local webUrl: ResourceStr = $rawfile('index.html');
  @Local title: string | undefined = undefined; //标题
  @Local options: ArkWebOptions = new ArkWebOptions(); //必选，ArkWeb参数
  @Local webClient: MyWebClient = new MyWebClient(); //可选，Web事件
  @Local jsObject: MyJsObject = new MyJsObject(); //可选，JS交互


  onBackPress(): boolean {
    if (this.controller?.accessBackward()) {
      this.controller?.backward();
      return true;
    }
    return false;
  }


  aboutToAppear(): void {

  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      ArkWeb({
        controller: this.controller,
        src: this.webUrl,
        options: this.options,
        webClient: this.webClient,
        arkJsObject: this.jsObject
      })
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }



}