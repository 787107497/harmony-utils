import { ComposeTitleBar, display, router } from '@kit.ArkUI';
import { DisplayUtil, StrUtil, ToastUtil } from 'harmony_utils';
import { DescribeBean } from '../../entity/DescribeBean';

/**
 * 屏幕相关工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State displayStr: string = ''
  @State cutoutInfoStr: string = ''
  @State foldStatusStr: string = ''

  aboutToAppear(): void {

  }

  onBackPress(): boolean {
    return false;
  }

  build() {
    Column() {
      ComposeTitleBar({
        title: this.describe.name,
        subtitle: this.describe.desc,
      })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("getDefaultDisplaySync()")
            .btnStyle()
            .onClick(() => {
              let display = DisplayUtil.getDefaultDisplaySync();
              this.displayStr = JSON.stringify(display, null, 2)
            })
          Text(this.displayStr)
            .visibility(StrUtil.isNotEmpty(this.displayStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getWidth()")
            .btnStyle()
            .onClick(() => {
              let width = DisplayUtil.getWidth();
              ToastUtil.showToast(`当前屏幕宽度为：${width}px`)
            })
          Button("getHeight()")
            .btnStyle()
            .onClick(() => {
              let height = DisplayUtil.getHeight();
              ToastUtil.showToast(`当前屏幕宽高度：${height}px`)
            })
          Button("getOrientation()")
            .btnStyle()
            .onClick(() => {
              let orientation = DisplayUtil.getOrientation();
              ToastUtil.showToast(`设备当前显示的方向：${orientation}`)
            })
          Button("getDisplayState()")
            .btnStyle()
            .onClick(() => {
              let state = DisplayUtil.getDisplayState()
              ToastUtil.showToast(`当前设备的状态：${state}`)
            })
          Button("getCutoutRect()")
            .btnStyle()
            .onClick(async () => {
              let rect = await DisplayUtil.getCutoutRect()
              this.cutoutInfoStr = JSON.stringify(rect, null, 2)
            })
          Text(this.cutoutInfoStr)
            .visibility(StrUtil.isNotEmpty(this.cutoutInfoStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("getCutoutHeight()")
            .btnStyle()
            .onClick(async () => {
              let h = await DisplayUtil.getCutoutHeight()
              ToastUtil.showToast(`挖孔屏、刘海屏等不可用屏幕区域的高度：${h}`)
            })
          Button("isFoldable()")
            .btnStyle()
            .onClick(() => {
              let bl = DisplayUtil.isFoldable()
              ToastUtil.showToast(`设备是否可折叠：${bl}`)
            })
          Button("getFoldStatus()")
            .btnStyle()
            .onClick(() => {
              let status = DisplayUtil.getFoldStatus()
              ToastUtil.showToast(`折叠设备的当前折叠状态：${status}`)
            })
          Button("getFoldDisplayMode()")
            .btnStyle()
            .onClick(() => {
              let mode = DisplayUtil.getFoldDisplayMode()
              ToastUtil.showToast(`可折叠设备的显示模式：${mode}`)
            })
          Button("onFoldStatusChange()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("开启折叠设备折叠状态变化的监听")
              DisplayUtil.onFoldStatusChange((foldStatus: display.FoldStatus) => {
                this.foldStatusStr = JSON.stringify(foldStatus, null, 2);
              })
            })
          Text(this.foldStatusStr)
            .visibility(StrUtil.isNotEmpty(this.foldStatusStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("offFoldStatusChange()")
            .btnStyle()
            .onClick(() => {
              DisplayUtil.offFoldStatusChange((foldStatus: display.FoldStatus) => {
                this.foldStatusStr = JSON.stringify(foldStatus, null, 2);
              })
            })

          Text('').layoutWeight(1)
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor($r('app.color.main_background'))
  }
}


@Styles
function btnStyle() {
  .width('90%')
  .margin({ top: 10, bottom: 5 })
}

@Styles
function textStyle() {
  .width('95%')
  .padding(10)
  .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  .margin({ top: 5, bottom: 10 })
  .backgroundColor(Color.White)
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}