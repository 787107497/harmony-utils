
@Component
export struct LabelButton {
  @Prop label: string;
  @Prop content: string = "";
  @Prop num: number = 4;
  @Prop buttons: string[] = ["案例一", "案例二", "案例三", "案例四"];
  onClickAction?: (index: number) => void;

  aboutToAppear(): void {
    const n = this.buttons?.length ?? 0;
    if (this.num > n) {
      this.num = n;
    }
  }

  build() {
    Column() {
      Text(this.label)
        .fontColor($r('app.color.color_main'))
        .fontWeight(FontWeight.Bold)
        .fontSize(this.label.length < 12 ? 24 : 21)
        .fontFamily('MyFont')
        .margin({ top: 10, left: 10, right: 10 })
      Text(this.content ?? "")
        .fontColor($r('app.color.card_label'))
        .fontSize(16)
        .fontFamily('MyFont')
        .margin({ top: 5, bottom: 16, left: 10, right: 10 })
      Row() {
        Blank().layoutWeight(1)
        Button(this.buttons[0])
          .type(ButtonType.Capsule)
          .fontFamily('MyFont')
          .grayscale(0.1)
          .onClick(() => {
            if (this.onClickAction) {
              this.onClickAction(0);
            }
          })
        Blank().layoutWeight(1)
        Button(this.buttons[1])
          .type(ButtonType.Capsule)
          .fontFamily('MyFont')
          .opacity(0.9)
          .onClick(() => {
            if (this.onClickAction) {
              this.onClickAction(1);
            }
          })
        Blank().layoutWeight(1)
        Button(this.buttons[2])
          .type(ButtonType.Capsule)
          .fontFamily('MyFont')
          .opacity(0.9)
          .grayscale(0.1)
          .onClick(() => {
            if (this.onClickAction) {
              this.onClickAction(2);
            }
          })
          .visibility(this.num >= 3 ? Visibility.Visible : Visibility.None)
        Blank().layoutWeight(1)
          .visibility(this.num >= 3 ? Visibility.Visible : Visibility.None)
        Button(this.buttons[3])
          .type(ButtonType.Capsule)
          .fontFamily('MyFont')
          .onClick(() => {
            if (this.onClickAction) {
              this.onClickAction(3);
            }
          })
          .visibility(this.num >= 4 ? Visibility.Visible : Visibility.None)
        Blank().layoutWeight(1)
          .visibility(this.num >= 4 ? Visibility.Visible : Visibility.None)
      }
      .width('100%')
    }
    .width('95%')
    .backgroundColor($r('app.color.card_background'))
    .border({ width: 2, color: $r('app.color.color_line') })
    .shadow(ShadowStyle.OUTER_DEFAULT_SM)
    .margin({ top: 12 })
    .borderRadius(6)
    .padding({ top: 10, bottom: 12, left: 2, right: 2 })
  }
}