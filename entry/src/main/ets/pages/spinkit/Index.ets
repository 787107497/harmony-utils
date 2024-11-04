import router from '@ohos.router';
import { SpinType } from '@pura/spinkit';



@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();

  build() {
    Column() {
      Text($r('app.string.app_name'))
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column({ space: 15 }) {
          Button('SpinKit')
            .width('100%')
            .margin({ top: 15 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/SpinKit1' })
            })
          Button('SpinKit')
            .width('100%')
            .onClick(() => {
              router.pushUrl({ url: 'pages/SpinKit2' })
            })
          Button('加载框，样式一')
            .width('100%')
            .onClick(() => {
              // SpinKitHelper.showLoading()
              // let timeoutID = setTimeout(() => {
              //   SpinKitHelper.hide();
              //   clearTimeout(timeoutID);
              // }, 15000)
            })
          Button('加载框，样式二')
            .width('100%')
            .onClick(() => {
              // SpinKitHelper.showLoading({
              //   uiContext: this.getUIContext(),
              //   spinType: SpinType.spinK,
              //   onDidDisappear: () => {
              //     console.error("加载框关闭了")
              //   }
              // })
              // let timeoutID = setTimeout(() => {
              //   SpinKitHelper.hide();
              //   clearTimeout(timeoutID);
              // }, 10000)
            })
          Button('加载框，样式三')
            .width('100%')
            .onClick(() => {
              // SpinKitHelper.showLoading({
              //   spinType: SpinType.spinH,
              //   spinColor: '#0A66F9',
              //   spinSize: 60,
              //   backgroundColor: '#CC000000',
              //   maskColor: Color.Transparent
              // })
            })
          Button('加载框，样式四')
            .width('100%')
            .onClick(() => {
              // SpinKitHelper.showLoading({
              //   spinType: SpinType.spinB,
              //   spinColor: Color.White,
              //   autoCancel: true
              // })
            })
          Button('加载框，样式五')
            .width('100%')
            .onClick(() => {
              // SpinKitHelper.showLoading({
              //   spinType: SpinType.spinP,
              //   spinColor: Color.White,
              //   spinSize: 70,
              //   content: '加载中...',
              //   fontSize: 18,
              //   fontColor: Color.White,
              //   backgroundColor: '#BB000000',
              //   maskColor: Color.Transparent,
              //   padding: { top: 30, right: 50, bottom: 30, left: 50 },
              //   marginTop: 20,
              //   autoCancel: true
              // })
            })
        }
        .padding({ left: 15, right: 15 })
        .width('100%')
        .height('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
