import { display, router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { DisplayUtil, LogUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { Utils } from '../../utils/Utils';

/**
 * 屏幕相关工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State foldStatusStr: string = ''

  @MockSetup
  mock() {
    this.describe = new DescribeBean("DisplayUtil", "屏幕相关工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("getDefaultDisplaySync()")
            .btnStyle()
            .onClick(() => {
              let display = DisplayUtil.getDefaultDisplaySync();
              let displayStr = JSON.stringify(display, null, 2);
              Utils.showSheetText(displayStr)
            })
          Button("getPrimaryDisplaySync()")
            .btnStyle()
            .onClick(() => {
              let display = DisplayUtil.getPrimaryDisplaySync();
              let displayStr = JSON.stringify(display, null, 2);
              Utils.showSheetText(displayStr)
            })
          Button("getAllDisplays()")
            .btnStyle()
            .onClick(async () => {
              let allDisplay = await DisplayUtil.getAllDisplays();
              let displayStr = JSON.stringify(allDisplay, null, 2);
              Utils.showSheetText(displayStr)
            })
          Button("getWidth()")
            .btnStyle()
            .onClick(() => {
              let width = DisplayUtil.getWidth();
              ToastUtil.showToast(`当前屏幕宽度为：${width}px`);
            })
          Button("getHeight()")
            .btnStyle()
            .onClick(() => {
              let height = DisplayUtil.getHeight();
              ToastUtil.showToast(`当前屏幕宽高度：${height}px`);
            })
          Button("getOrientation()")
            .btnStyle()
            .onClick(() => {
              let orientation = DisplayUtil.getOrientation();
              ToastUtil.showToast(`设备当前显示的方向：${orientation}`);
            })
          Button("getDisplayState()")
            .btnStyle()
            .onClick(() => {
              let state = DisplayUtil.getDisplayState();
              ToastUtil.showToast(`当前设备的状态：${state}`);
            })
          Button("getCutoutRect()")
            .btnStyle()
            .onClick(async () => {
              let rect = await DisplayUtil.getCutoutRect();
              let cutoutInfoStr = JSON.stringify(rect, null, 2);
              Utils.showSheetText(cutoutInfoStr);
            })
          Button("getCutoutHeight()")
            .btnStyle()
            .onClick(async () => {
              let h = await DisplayUtil.getCutoutHeight();
              ToastUtil.showToast(`挖孔屏、刘海屏等不可用屏幕区域的高度：${h}`);
            })
          Button("isFoldable()")
            .btnStyle()
            .onClick(() => {
              let bl = DisplayUtil.isFoldable();
              ToastUtil.showToast(`设备是否可折叠：${bl}`);
            })
          Button("getFoldStatus()")
            .btnStyle()
            .onClick(() => {
              let status = DisplayUtil.getFoldStatus();
              ToastUtil.showToast(`折叠设备的当前折叠状态：${status}`);
            })
          Button("getFoldDisplayMode()")
            .btnStyle()
            .onClick(() => {
              let mode = DisplayUtil.getFoldDisplayMode();
              ToastUtil.showToast(`可折叠设备的显示模式：${mode}`);
            })
          Button("onFoldStatusChange()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("开启折叠设备折叠状态变化的监听");
              DisplayUtil.onFoldStatusChange((foldStatus: display.FoldStatus) => {
                this.foldStatusStr = JSON.stringify(foldStatus, null, 2);
              });
            })
          Button("offFoldStatusChange()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("关闭折叠设备折叠状态变化的监听");
              DisplayUtil.offFoldStatusChange();
            })
          Text(this.foldStatusStr)
            .visibility(StrUtil.isNotEmpty(this.foldStatusStr) ? Visibility.Visible : Visibility.None)
            .textStyle()
          Button("onFoldAngleChange()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("开启折叠设备折叠角度变化的监听");
              DisplayUtil.onFoldAngleChange((angles: Array<number>) => {
                LogUtil.info(`折叠角度变化的监听：${angles}`);
                ToastUtil.showLong(`折叠角度变化的监听：${angles}`);
              });
            })
          Button("offFoldAngleChange()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("关闭折叠设备折叠角度变化的监听");
              DisplayUtil.offFoldAngleChange();
            })
          Button("isCaptured()")
            .btnStyle()
            .onClick(() => {
              let isCaptured = DisplayUtil.isCaptured();
              ToastUtil.showToast(`设备是否正在截屏、投屏、录屏：${isCaptured}`);
            })
          Button("onCaptureStatusChange()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("开启屏幕截屏、投屏、录屏状态变化的监听");
              DisplayUtil.onCaptureStatusChange((captureStatus: boolean) => {
                LogUtil.info(`屏幕截屏、投屏、录屏状态：${captureStatus}`);
                ToastUtil.showLong(`屏幕截屏、投屏、录屏状态：${captureStatus}`);
              });
            })
          Button("offFoldAngleChange()")
            .btnStyle()
            .onClick(() => {
              ToastUtil.showToast("关闭屏幕截屏、投屏、录屏状态变化的监听");
              DisplayUtil.offCaptureStatusChange();
            })
          Blank().layoutWeight(1)
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
  .border({ width: 1, color: Color.Grey, radius: 10, style: BorderStyle.Dashed })
}