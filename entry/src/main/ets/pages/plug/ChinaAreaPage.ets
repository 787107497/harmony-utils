import { router } from '@kit.ArkUI';
import { AreaEntity, AreaHelper } from '@nutpi/china_area';
import { JSONUtil, LogUtil, StrUtil } from '@pura/harmony-utils';
import { TitleBarView } from '../../component/TitleBarView';
import { DescribeBean } from '../../model/DescribeBean';
import { JSON } from '@kit.ArkTS';
import { DialogAction, DialogHelper } from '@pura/harmony-dialog';

/**
 * @nutpi/china_area，使用案例 */
@Entry
@ComponentV2
export struct ChinaAreaPage {
  private scroller: Scroller = new Scroller();
  @Local describe: DescribeBean = router.getParams() as DescribeBean;
  @Local txtStr: string = "";


  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("getAreaStr()")
            .btnStyle()
            .onClick(async () => {
              this.txtStr = await AreaHelper.getAreaStr();
              let data = JSONUtil.jsonToArray<AreaEntity>(this.txtStr);
              DialogHelper.showToast(`${data.length}`);
            })
          Button("getAreaStr()")
            .btnStyle()
            .onClick(async () => {
              let list = await AreaHelper.getArea();
              LogUtil.error(`长度：${list.length}`);
              this.txtStr = JSON.stringify(list,null,2);
            })
          Button("getCityByName()")
            .btnStyle()
            .onClick(async () => {
              let citys = await AreaHelper.getCityByName("安徽省");
              this.txtStr = JSON.stringify(citys, null, 2);
            })
          Button("getDistrictByNameSync()")
            .btnStyle()
            .onClick(() => {
              let list = AreaHelper.getDistrictByNameSync("合肥市");
              this.txtStr = JSON.stringify(list, null, 2);
            })
          Button("配合‘@pura/harmony-dialog’的\nshowTextPickerDialog()方法使用")
            .labelStyle({ maxLines: 3 })
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              this.txtStr = "";
              let data = AreaHelper.getAreaSync();
              DialogHelper.showTextPickerDialog({
                title: "请选择",
                range: data,
                onChange: (value: string | string[], index: number | number[]) => {
                  LogUtil.error(`value: ${value}\n\nindex: ${index}`);
                },
                onAction: (action: number, dialogId: string, value: string | string[]) => {
                  if (action === DialogAction.SURE) {
                    DialogHelper.showToast(`已选择：${value}`);
                  }
                }
              })
            })

          Blank().layoutWeight(1)

          Text(this.txtStr)
            .visibility(StrUtil.isNotEmpty(this.txtStr) ? Visibility.Visible : Visibility.None)
            .textStyle()

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