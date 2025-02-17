import lottie, { AnimationItem } from "@ohos/lottie";

/**
 * 自定义组件
 */
@Preview
@ComponentV2
export struct ComLayout {
  private canvasRenderingContext: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(new RenderingContextSettings(true));
  private animationItem?: AnimationItem;


  aboutToDisappear(): void {
    lottie.destroy('lottie_loading');
  }

  build() {
    Column() {

      Canvas(this.canvasRenderingContext)
        .size({ width: 30, height: 30 })
        .backgroundColor(Color.Transparent)
        .onReady(() => {
          //抗锯齿的设置
          this.canvasRenderingContext.imageSmoothingEnabled = true;
          this.canvasRenderingContext.imageSmoothingQuality = 'medium'
          this.animationItem = lottie.loadAnimation({
            container: this.canvasRenderingContext, //渲染上下文
            renderer: 'canvas', //渲染方式
            loop: true, //是否循环播放,默认true
            autoplay: true, //是否自动播放，默认true
            name: 'lottie_loading', //动画名称
            contentMode: 'Contain', //填充的模式
            path: 'common/lottie_sun.json', //json路径
          })
        })

      Text("提交成功")
        .fontColor($r('app.color.color15'))
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .align(Alignment.TopStart)
        .margin({ top: 6 })

    }
    .width('100%')
    .backgroundColor($r('app.color.main_background'))
    .borderRadius(15)
  }
}