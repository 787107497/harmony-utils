import { AreaEntity, AreaHelper } from '@nutpi/china_area';
import { DialogHelper } from '@pura/harmony-dialog';
import { Utils } from '@pura/harmony-dialog/src/main/ets/utils/Utils';
import { LogUtil } from '@pura/harmony-utils';

@Preview
@Component
export struct OtherPage {
  private scroller: Scroller = new Scroller();
  @State areas: Array<AreaEntity> = []
  private apfruits: string[] = ['apple1', 'apple2', 'apple3', 'apple4']
  private orfruits: string[] = ['orange1', 'orange2', 'orange3', 'orange4']
  private pefruits: string[] = ['peach1', 'peach2', 'peach3', 'peach4']
  private demos: string[] = ['demo1', 'demo2', 'demo3', 'demo4']
  private demos4: string[] = []
  private multi: string[][] = [this.apfruits, this.orfruits, this.pefruits,this.demos,this.apfruits]

  onCreateSub(): void {
    this.areas = AreaHelper.getAreaSync();
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