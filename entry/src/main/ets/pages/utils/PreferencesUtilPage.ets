import { router } from '@kit.ArkUI';
import { MockSetup } from '@ohos/hamock';
import { LogUtil, PreferencesUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { Callback } from '@kit.BasicServicesKit';
import { preferences } from '@kit.ArkData';
import { TitleBarView } from '../../component/TitleBarView';

/**
 * Preferences（用户首选项）工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State pStr: string = ''
  private callback: Callback<string> = (value) => {
    LogUtil.error("onChange: " + value);
  }
  private dataCallback = (data: Record<string, preferences.ValueType>) => {
    for (const keyValue of Object.entries(data)) {
      LogUtil.error("onDataChange: " + keyValue);
    }
  }

  @MockSetup
  mock() {
    this.describe = new DescribeBean("PreferencesUtil", "Preferences（用户首选项）工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column() {
          Button("put()\nputSync()\nget()\ngetSync")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              PreferencesUtil.put("id", 10000018);
              PreferencesUtil.putSync("name", "张三叁");
              ToastUtil.showToast("数据缓存成功");
              let id = await PreferencesUtil.get("id", "");
              let name = PreferencesUtil.getSync("name", "");
              this.pStr = `获取缓存：\nid: ${id}\nname: ${name}`;
            })
          Button("getNumber()\ngetNumberSync()\ngetString()\ngetStringSync")
            .labelStyle({ maxLines: 5 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let id1 = await PreferencesUtil.getNumber("id");
              let id2 = PreferencesUtil.getNumberSync('id');
              let name1 = await PreferencesUtil.getString("name");
              let name2 = PreferencesUtil.getStringSync('name');
              this.pStr = `获取缓存：\nid1: ${id1}\nid2: ${id2}\nname1: ${name1}\nname2: ${name2}`;
            })
          Button("getBoolean()\ngetBooleanSync()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              PreferencesUtil.put("bl_nut", true);
              PreferencesUtil.putSync("bl_nuv", false);
              let bl1 = await PreferencesUtil.getBoolean("bl_nut");
              let bl2 = PreferencesUtil.getBooleanSync('bl_nuv');
              this.pStr = `缓存·bl1：${bl1}\n缓存·bl2：${bl2}`;
            })
          Button("has()\nhasSync()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              let bl1 = await PreferencesUtil.has("id");
              let bl2 = PreferencesUtil.hasSync('name');
              this.pStr = `has~bl1：${bl1}\nhas~bl2：${bl2}`;
            })
          Button("delete()\ndeleteSync()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(async () => {
              PreferencesUtil.delete("id");
              PreferencesUtil.deleteSync("name");
              ToastUtil.showToast('删除缓存成功')
            })
          Button("clear()\nclearSync()")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              PreferencesUtil.clear();
              PreferencesUtil.clearSync();
              ToastUtil.showToast('清空缓存成功')
            })
          Button("putSync()，其他使用\ngetStringSync()，其他使用")
            .labelStyle({ maxLines: 2 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              PreferencesUtil.putSync("cache_desc",
                "Harmony_utils，一款高效的HarmonyOS工具包，封装了常用工具类，提供一系列简单易用的方法。帮助开发者快速构建鸿蒙应用。",
                "SP_PREFERENCES_MSG");
              let cacheDesc = PreferencesUtil.getStringSync("cache_desc", "", "SP_PREFERENCES_MSG");
              this.pStr = `缓存：\n${cacheDesc}`;
            })
          Button("deletePreferences()")
            .btnStyle()
            .onClick(() => {
              PreferencesUtil.deletePreferences(getContext(), "SP_PREFERENCES_MSG");
              ToastUtil.showToast('移出指定的Preferences实例，成功')
            })
          Button("onChange()")
            .btnStyle()
            .onClick(() => {
              PreferencesUtil.onChange(this.callback);
            })
          Button("offChange()")
            .btnStyle()
            .onClick(() => {
              PreferencesUtil.offChange(this.callback);
            })
          Button("onDataChange()")
            .btnStyle()
            .onClick(() => {
              PreferencesUtil.onDataChange(["id", "name"], this.dataCallback);
            })
          Button("offDataChange()")
            .btnStyle()
            .onClick(() => {
              PreferencesUtil.offDataChange(["id", "name"], this.dataCallback);
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