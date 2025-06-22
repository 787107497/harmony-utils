import { router } from '@kit.ArkUI';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { EventBus } from '@nutpi/eventbus';
import { ToastUtil } from '@pura/harmony-utils';
import { DialogHelper } from '@pura/harmony-dialog';

/**
 * @nutpi/eventbus，使用案例
 */
@Entry
@ComponentV2
export struct EventBusPage {
  private scroller: Scroller = new Scroller();
  @Local describe: DescribeBean = router.getParams() as DescribeBean;
  @Local txtStr: string = "";

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("on()")
            .btnStyle()
            .onClick(() => {
              //注册事件监听
              EventBus.on('id', (id: string) => {
                DialogHelper.showAlertDialog({
                  autoCancel: false,
                  backCancel: false,
                  content: `ID: ${id}`,
                  primaryButton: '已收到',
                  onAction: (action, id) => {
                    DialogHelper.closeDialog(id);
                  }
                });
              });
              ToastUtil.showToast(`注册事件监听成功！`);
            })
          Button("once()")
            .btnStyle()
            .onClick(() => {
              //注册单次事件监听
              EventBus.once('id', (id: string) => {
                DialogHelper.showAlertDialog({
                  autoCancel: false,
                  backCancel: false,
                  content: `单次ID: ${id}`,
                  primaryButton: '已收到',
                  onAction: (action, id) => {
                    DialogHelper.closeDialog(id);
                  }
                });
              });
              ToastUtil.showToast(`注册单次事件监听成功！`);
            })
          Button("post()")
            .btnStyle()
            .onClick(() => {
              EventBus.post('id', '100001200');
              ToastUtil.showToast(`发布普通消息！`);
            })
          Button("postSticky()")
            .btnStyle()
            .onClick(() => {
              EventBus.postSticky('id', '100001201');
              ToastUtil.showToast(`发布粘性消息！`);
            })
          Button("getSticky()")
            .btnStyle()
            .onClick(() => {
              let sticky = EventBus.getSticky('id');
              ToastUtil.showToast(`粘性事件数据：${sticky}`);
            })
          Button("removeSticky()")
            .btnStyle()
            .onClick(() => {
              EventBus.removeSticky('id');
              ToastUtil.showToast(`移除粘性事件成功！`);
            })
          Button("postApp()")
            .btnStyle()
            .onClick(() => {
              EventBus.postApp('id', '100001202');
              ToastUtil.showToast(`发布跨App消息！`);
            })
          Button("off()")
            .btnStyle()
            .onClick(() => {
              //注销事件监听
              EventBus.off('id');
              ToastUtil.showToast(`注销事件监听！`);
            })
          Button("offAll()")
            .btnStyle()
            .onClick(() => {
              //注销所有事件监听
              EventBus.offAll();
              ToastUtil.showToast(`注销所有事件监听！`);
            })

          Blank().layoutWeight(1)
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.main_background'))
  }
}


@Styles
function btnStyle() {
  .width('90%')
  .margin({ top: 10, bottom: 5 })
}