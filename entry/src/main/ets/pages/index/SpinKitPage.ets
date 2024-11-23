import { router } from '@kit.ArkUI';
import { DialogHelper, SpinType } from '@pura/harmony-dialog';
import { ClickUtil, ToastUtil } from '@pura/harmony-utils';

@Component
export struct SpinKitPage {
  private scroller: Scroller = new Scroller();

  build() {
    Column() {
      Text("SpinKit动画")
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
              router.pushUrl({ url: 'pages/spinkit/SpinKit1' })
            })
          Button('SpinKit')
            .width('100%')
            .onClick(() => {
              router.pushUrl({ url: 'pages/spinkit/SpinKit2' })
            })
          Button('加载框样式配置1')
            .width('100%')
            .grayscale(0.5)
            .onClick(() => {
              DialogHelper.setDefaultConfig((config) => {
                config.loading_loadType = SpinType.spinZ; //动画类型
                config.loading_loadSize = 60; //加载动画或进度条的大小
                config.loading_loadColor = "#0A51E0"; //加载动画或进度条的颜色
                config.loading_content = ''; //加载动画的提示文字
                config.loading_fontSize = 16; //文字大小
                config.loading_fontColor = Color.White; //文字颜色
                config.loading_backgroundColor = '#CC000000'; //背景颜色，八位色值前两位为透明度
                config.loading_borderRadius = 10; //背景圆角
                config.loading_marginTop = 20; //文字与动画的间距
                config.loading_padding = 30; //padding
              })
              ToastUtil.showToast("样式配置成功！");
            })
          Button('加载框样式配置2')
            .width('100%')
            .grayscale(0.5)
            .onClick(() => {
              DialogHelper.setDefaultConfig((config) => {
                config.loading_loadType = SpinType.spinH; //动画类型
                config.loading_loadSize = 70; //加载动画或进度条的大小
                config.loading_loadColor = Color.Brown; //加载动画或进度条的颜色
                config.loading_content = '努力加载中'; //加载动画的提示文字
                config.loading_fontSize = 16; //文字大小
                config.loading_fontColor = Color.White; //文字颜色
                config.loading_backgroundColor = '#EE000000'; //背景颜色，八位色值前两位为透明度
                config.loading_borderRadius = 12; //背景圆角
                config.loading_marginTop = 20; //文字与动画的间距
                config.loading_padding = { top: 35, right: 45, bottom: 30, left: 45 }; //padding
              })
              ToastUtil.showToast("样式配置成功！");
            })
          Button('加载框，样式一')
            .width('100%')
            .grayscale(1)
            .onClick(() => {
              ClickUtil.throttle(() => {
                DialogHelper.showLoadingDialog({ autoCancel: false })
                let timeoutID = setTimeout(() => {
                  DialogHelper.closeLoading();
                  clearTimeout(timeoutID);
                }, 15000)
              })
            })
          Button('加载框，样式二')
            .width('100%')
            .grayscale(1)
            .onClick(() => {
              ClickUtil.throttle(() => {
                DialogHelper.showLoadingDialog({
                  loadType: SpinType.spinH,
                  autoCancel: false,
                  onDidDisappear: () => {
                    ToastUtil.showToast("加载框关闭了")
                  }
                })
                let timeoutID = setTimeout(() => {
                  DialogHelper.closeLoading();
                  clearTimeout(timeoutID);
                }, 15000)
              })
            })
          Button('加载框，样式三')
            .width('100%')
            .grayscale(1)
            .onClick(() => {
              ClickUtil.throttle(() => {
                DialogHelper.showLoadingDialog({
                  loadType: SpinType.spinK,
                  loadColor: '#0A66F9',
                  backgroundColor: '#CC000000',
                  maskColor: '#10000000'
                })
              })
            })
          Button('加载框，样式四')
            .width('100%')
            .grayscale(1)
            .onClick(() => {
              ClickUtil.throttle(() => {
                DialogHelper.showLoadingDialog({
                  loadType: SpinType.spinB,
                  loadColor: Color.White,
                  autoCancel: true
                })
              })
            })
          Button('加载框，样式五')
            .width('100%')
            .grayscale(1)
            .onClick(() => {
              ClickUtil.throttle(() => {
                DialogHelper.showLoadingDialog({
                  loadType: SpinType.spinP,
                  loadColor: Color.White,
                  loadSize: 70,
                  content: '加载中...',
                  fontSize: 18,
                  fontColor: Color.White,
                  backgroundColor: '#BB000000',
                  maskColor: '#33000000',
                  padding: { top: 30, right: 50, bottom: 30, left: 50 },
                  marginTop: 20,
                  autoCancel: true
                })
              })
            })
          Blank().layoutWeight(1)
        }
        .padding({ left: 15, right: 15 })
      }
      .layoutWeight(1)
      .width('100%')
    }
  }
}