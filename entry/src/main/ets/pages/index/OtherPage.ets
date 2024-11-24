import { BusinessError, commonEventManager } from '@kit.BasicServicesKit';
import { LogUtil } from '@pura/harmony-utils';

@Preview
@Component
export struct OtherPage {
  private scroller: Scroller = new Scroller();


  // 用于保存创建成功的订阅者对象，后续使用其完成订阅及退订的动作
  private subscriber: commonEventManager.CommonEventSubscriber | null = null;
  // 订阅者信息，其中的event字段需要替换为实际的事件名称。
  private subscribeInfo: commonEventManager.CommonEventSubscribeInfo = {
    events: ['usual.event.LOCALE_CHANGED','testEvent'], // 订阅灭屏公共事件
  };

  onCreateSub(): void {
    // 创建订阅者回调
    commonEventManager.createSubscriber(this.subscribeInfo, (err: BusinessError, data: commonEventManager.CommonEventSubscriber) => {
        if (err) {
          LogUtil.error(`Failed to create subscriber. Code is ${err.code}, message is ${err.message}`);
          return;
        }
        LogUtil.error('Succeeded in creating subscriber.');
        this.subscriber = data;
        // 订阅公共事件回调
        commonEventManager.subscribe(this.subscriber, (err: BusinessError, data: commonEventManager.CommonEventData) => {
            if (err) {
              LogUtil.error(`Failed to subscribe common event. Code is ${err.code}, message is ${err.message}`);
              return;
            }
          LogUtil.error('订阅事件回调: \n' + JSON.stringify(data, null, 2));
          })
        LogUtil.error('Succeeded in creating subscribe.222222222222');
      })
  }

  build() {
    Column() {
      Text("我的")
        .height(50)
        .width('100%')
        .backgroundColor(Color.White)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
      Divider()
      Scroll(this.scroller) {
        Column() {
          Blank().layoutWeight(1)

          Text("更多组件向您赶来...")
            .fontSize(24)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .onClick(()=>{

            })

          Blank().layoutWeight(1)

        }
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width("100%")
    .height("100%")
    .onAppear(() => {
      this.onCreateSub()
    })
  }
}