import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { KvUtil, RandomUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { distributedKVStore } from '@kit.ArkData';
import { Callback } from '@kit.BasicServicesKit';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * KvUtil，键值型数据库工具类 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State pStr: string = ''
  private callBack: Callback<distributedKVStore.ChangeNotification> = (change) => {
    this.pStr = JSON.stringify(change, null, 2);
  }

  @MockSetup
  mock() {
    this.describe = new DescribeBean("KvUtil", "键值型数据库工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("put()")
            .btnStyle()
            .onClick(async () => {
              KvUtil.put("name", "张三叁");
              KvUtil.put("id", 10018);
              KvUtil.put("sex", RandomUtil.getRandomBoolean());
              KvUtil.put("info", RandomUtil.getRandomUint8Array(8));
              ToastUtil.showToast("数据缓存成功");
            })
          Button("get()\ngetString()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let kv1 = await KvUtil.get("name");
              let kv2 = await KvUtil.getString('name');
              this.pStr = `获取缓存：\nkv1: ${kv1}\nkv2: ${kv2}`;
            })
          Button("getNumber()\ngetBoolean()")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let kv3 = await KvUtil.getNumber("id");
              let kv4 = await KvUtil.getBoolean('sex');
              this.pStr = `获取缓存：\nkv3: ${kv3}\nkv4: ${kv4}`;
            })
          Button("getUint8Array()")
            .btnStyle()
            .onClick(async () => {
              let kv5 = await KvUtil.getUint8Array('info');
              this.pStr = `获取缓存：\nkv5: ${kv5}`;
            })
          Button("delete()")
            .btnStyle()
            .onClick(async () => {
              KvUtil.delete("name");
              ToastUtil.showToast('删除缓存成功')
            })
          Button("onDataChange()")
            .btnStyle()
            .onClick(() => {
              KvUtil.onDataChange(distributedKVStore.SubscribeType.SUBSCRIBE_TYPE_ALL, this.callBack);
              ToastUtil.showToast('订阅指定类型的数据变更通知')
            })
          Button("offDataChange()")
            .btnStyle()
            .onClick(() => {
              KvUtil.offDataChange(this.callBack);
              ToastUtil.showToast('取消订阅数据变更通知')
            })

          Blank().layoutWeight(1)
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)

      Text(this.pStr)
        .visibility(StrUtil.isNotEmpty(this.pStr) ? Visibility.Visible : Visibility.None)
        .textStyle()
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
  .border({
    width: 1,
    color: Color.Grey,
    radius: 10,
    style: BorderStyle.Dashed
  })
}