import { TextInputOptions } from '../model/TextInputOptions';
import { CustomContentDialog } from '@kit.ArkUI';
import { BaseContentOptions } from '../model/base/BaseContentOptions';
import { CustomContentOptions } from '../model/CustomContentOptions';
import { CacheUtil } from '../utils/CacheUtil';


/**
 * TODO TextInputDialog组件
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
@Component
export default struct TextInputDialogView {
  private controller: TextInputController = new TextInputController()
  @Prop options: TextInputOptions;
  @State content: CustomContentOptions | null = null;


  aboutToAppear(): void {
    CacheUtil.put<string>(this.options.dialogId ?? "", this.options.text);
    this.content = {
      primaryTitle: this.options.primaryTitle,
      secondaryTitle: this.options.secondaryTitle,
      localizedContentAreaPadding: this.options.localizedContentAreaPadding,
      contentAreaPadding: this.options.contentAreaPadding,
      contentBuilder: () => {
        this.InputBuilder()
      }
    }
    this.content.buttons = this.options.buttons;
  }


  build() {
    CustomContentDialog(this.content as BaseContentOptions)
      .height(this.options.height)
      .width(this.options.width)
      .backgroundColor(this.options.backgroundColor)
      .backgroundBlurStyle(this.options.backgroundBlurStyle)
      .borderRadius(this.options.cornerRadius)
      .borderWidth(this.options.borderWidth)
      .borderColor(this.options.borderColor)
      .borderStyle(this.options.borderStyle)
  }

  @Builder
  InputBuilder() {
    TextInput({
      controller: this.controller,
      text: this.options.text,
      placeholder: this.options.placeholder ?? '请输入'
    })
      .type(this.options.inputType ?? InputType.Normal)
      .fontSize(this.options.fontSize)
      .fontColor(this.options.fontColor)
      .fontSize(this.options.fontSize)
      .placeholderColor(this.options.placeholderColor)
      .height(this.options.inputHeight)
      .backgroundColor(this.options.inputBackgroundColor)
      .border(this.options.inputBorder)
      .onChange((value: string, previewText?: PreviewText) => {
        CacheUtil.put<string>(this.options.dialogId ?? "", value ?? "")
        if (this.options.onChange) {
          this.options.onChange(value);
        }
      })
  }


}