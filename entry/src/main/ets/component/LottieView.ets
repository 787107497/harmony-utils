import lottie from '@ohos/lottie';
import { Helper } from '@pura/harmony-dialog/src/main/ets/utils/Helper';
import { LoadOptions } from '../model/LoadOptions';


//Lottie加载动画
@Builder
export function LottieBuilder(options: LoadOptions) {
  LottieView({ options: options })
}


/**
 * 加载动画自定义组件
 */
@Preview
@ComponentV2
export struct LottieView {
  @Require @Param options: LoadOptions;
  @Local content: string = '';
  private canvasRenderingContext: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(new RenderingContextSettings(true));

  aboutToAppear(): void {
    if (this.options.content) {
      this.content = Helper.getResourceStr(this.options.content) ?? "";
    }
  }

  aboutToDisappear(): void {
    lottie.destroy('lottie_loading');
  }

  build() {
    Column() {
      Canvas(this.canvasRenderingContext)
        .size({ width: 60, height: 60 })
        .backgroundColor(Color.Transparent)
        .onReady(() => {
          //抗锯齿的设置
          this.canvasRenderingContext.imageSmoothingEnabled = true;
          this.canvasRenderingContext.imageSmoothingQuality = 'medium'
          lottie.loadAnimation({
            container: this.canvasRenderingContext, //渲染上下文
            renderer: 'canvas', //渲染方式
            loop: true, //是否循环播放,默认true
            autoplay: true, //是否自动播放，默认true
            name: 'lottie_loading', //动画名称
            contentMode: 'Contain', //填充的模式
            path: 'common/lottie_sun.json', //json路径
          })
        })
      Text(this.options.content)
        .textAlign(TextAlign.Center)
        .margin({ top: this.options.marginTop })
        .fontSize(this.options.fontSize)
        .fontColor(this.options.fontColor)
        .visibility(this.content.length > 0 ? Visibility.Visible : Visibility.None)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .margin(10)
    .constraintSize({ minWidth: 90, minHeight: 90 })
    .padding(this.options.padding)
    .backgroundColor(this.options.backgroundColor)
    .borderRadius(8)
    .shadow(ShadowStyle.OUTER_DEFAULT_SM)
  }

}