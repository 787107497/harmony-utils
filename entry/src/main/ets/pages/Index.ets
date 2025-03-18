import { UtilsPage } from './index/UtilsPage';
import { DialogPage } from './index/DialogPage';
import { PlugPage } from './index/PlugPage';
import { MyPage } from './index/MyPage';
import { TabItemView } from '../component/TabItemView';

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
        PlugPage()
      }
      .tabBar(this.tabBuilder(2, $r("app.media.icon_tab_plug"), "插件"))

      TabContent() {
        MyPage()
      }
      .tabBar(this.tabBuilder(3, $r("app.media.icon_tab_my"), "我的"))
    }
    .divider({ strokeWidth: 1, color: $r('app.color.color_line') })
    .backgroundColor($r('app.color.main_background'))
    .barBackgroundColor($r('app.color.bar_background'))
    .barMode(BarMode.Fixed)
    .vertical(false)
    .fadingEdge(false)
    .barOverlap(false)
    .width('100%')
    .height('100%')
    .onChange((index: number) => { //页面切换回调
      this.index = index;
    })
  }

  /**
   * Tab菜单
   */
  @Builder
  tabBuilder(index: number, icon: string | Resource, text: string | Resource) {
    TabItemView({ text: text, icon: icon, check: index === this.index })
  }


}