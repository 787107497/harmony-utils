import { DescribeBean } from '../entity/DescribeBean'
import { ComposeTitleBar } from '@kit.ArkUI'
import { WantUtil } from '@pura/harmony-utils'

@Component
export struct TitleBarView {
  @Prop describe: DescribeBean

  build() {
    ComposeTitleBar({
      title: this.describe.name,
      subtitle: this.describe.desc,
      menuItems: [{
        value: $r('app.media.icon_example'),
        isEnabled: true,
        action: () => {
          WantUtil.toWebBrowser(this.describe.example ?? "https://gitee.com/tongyuyan/harmony-utils")
        }
      }, {
        value: $r('app.media.icon_code'),
        isEnabled: true,
        action: () => {
          WantUtil.toWebBrowser(this.describe.code ?? "https://gitee.com/tongyuyan/harmony-utils")
        }
      }]
    })
  }
}