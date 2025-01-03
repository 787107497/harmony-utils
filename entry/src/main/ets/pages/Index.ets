import { UtilsPage } from './index/UtilsPage';
import { DialogPage } from './index/DialogPage';
import { SpinKitPage } from './index/SpinKitPage';
import { OtherPage } from './index/OtherPage';

/**
 * 主页面
 */
@Entry
@Component
struct Index {
  private tabsController: TabsController = new TabsController();
  @State index: number = 0;

  onBackPress(): boolean {
    return false;
  }

  build() {
    Tabs({ barPosition: BarPosition.End, index: this.index, controller: this.tabsController }) {
      TabContent() {
        UtilsPage()
      }
      .tabBar(this.tabBuilder(0, $r('app.media.icon_tab_utils'), "工具"))

      TabContent() {
        DialogPage()
      }
      .tabBar(this.tabBuilder(1, $r('app.media.icon_tab_dialog'), "弹框"))

      TabContent() {
        SpinKitPage()
      }
      .tabBar(this.tabBuilder(2, $r("app.media.icon_tab_spin"), "动画"))

      TabContent() {
        OtherPage()
      }
      .tabBar(this.tabBuilder(3, $r('app.media.icon_tab_mine'), "我的"))
    }
    .divider({ strokeWidth: 1, color: $r('app.color.color_line') })
    .vertical(false)
    .barMode(BarMode.Fixed)
    .backgroundColor($r('app.color.main_background'))
    .fadingEdge(false)
    .barOverlap(false)
    .barBackgroundColor(Color.White)
    .width('100%')
    .height('100%')
    .onChange((index: number) => { //页面切换回调
      this.index = index;
    })
  }

  /**
   *
   * @param index
   * @param icon
   * @param text
   */
  @Builder
  tabBuilder(index: number, icon: string | Resource, text: string | Resource) {
    Column() {
      Image(icon)
        .width(26)
        .height(26)
        .objectFit(ImageFit.Auto)
        .fillColor(index == this.index ? Color.Brown : Color.Gray)
      Text(text)
        .fontSize(15)
        .fontColor(index == this.index ? Color.Brown : Color.Gray)
        .fontStyle(FontStyle.Normal)
        .margin({ top: 5 })
        .fontFamily('MyFont')
    }
    .backgroundColor(Color.Transparent)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .alignSelf(ItemAlign.Center)
  }
}