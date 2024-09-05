import { LoadingOptions } from '../model/LoadingOptions';

/**
 * TODO Loading组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
@Component
export default struct LoadingView {
  @State options: LoadingOptions = {};
  @State content: string = '';

  aboutToAppear(): void {
    if (this.options.content) {
      if (typeof this.options.content === 'string') {
        this.content = this.options.content;
      } else {
        this.content = getContext().resourceManager.getStringSync(this.options.content.id);
      }
    }
  }

  build() {
    Column() {
      LoadingProgress()
        .height(this.options.spinSize)
        .width(this.options.spinSize)
        .color(this.options.spinColor)
      Text(this.options.content)
        .textAlign(TextAlign.Center)
        .margin({ top: 5 })
        .fontSize(this.options.fontSize)
        .fontColor(this.options.fontColor)
        .visibility(this.content.length > 0 ? Visibility.Visible : Visibility.None)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .margin(12)
    .constraintSize({ minWidth: 100, minHeight: 100 })
    .padding(20)
    .backgroundColor(this.options.backgroundColor)
    .borderRadius(this.options.borderRadius)
  }
}