import { SelectDialog } from '@kit.ArkUI';
import hilog from '@ohos.hilog';

/**
 * SelectDialog 选择类弹出框，弹框中以列表或网格的形式提供可选的的内容。
 */
@Component
export struct SelectControlDialog {

  //监听visible变量，visible值发生变化时触发onChange回调函数
  @Watch("onChange") @Link visible: boolean;
  @Prop options: SelectOptions;
  private dialogController: CustomDialogController = new CustomDialogController({
    builder: SelectDialog({
      title: (this.options && this.options.title) ? this.options.title : "",
      content: (this.options && this.options.content) ? this.options.content : undefined,
      selectedIndex: (this.options && this.options.selectedIndex) ? this.options.selectedIndex : -1,
      radioContent: this.getRadioContent(),
      confirm: (this.options && this.options.confirm) ? {
        value: this.options.confirm.value,
        action: () => {
          if (this.options.confirm) {
            this.options.confirm.action
          }
          this.visible = false;
        },
        fontColor: this.options.confirm.fontColor,
        background: this.options.confirm.background
      } : undefined
    }),
    autoCancel: (this.options && this.options.autoCancel) ? this.options.autoCancel : false,
    cancel: () => {
      if (this.options) {
        this.options.cancel
      }
      this.visible = false;
    },
    alignment: (this.options && this.options.alignment) ? this.options.alignment : DialogAlignment.Bottom,
    offset: this.getOffset(),
    customStyle: (this.options && this.options.customStyle) ? this.options.customStyle : false,
    gridCount: (this.options && this.options.gridCount) ? this.options.gridCount : undefined,
    maskRect: (this.options && this.options.maskRect) ? this.options.maskRect : { x: 0, y: 0, width: '100%', height: '100%' },
    maskColor: (this.options && this.options.maskColor) ? this.options.maskColor : undefined,
    openAnimation:  (this.options && this.options.openAnimation) ? this.options.openAnimation : undefined,
    closeAnimation:  (this.options && this.options.closeAnimation) ? this.options.closeAnimation : undefined,
    showInSubWindow: (this.options && this.options.showInSubWindow) ? this.options.showInSubWindow : false,
    isModal: (this.options && this.options.isModal) ? this.options.isModal : true
  })

  //visible值发生变化时触发，若visible值为true通过弹窗控制器打开弹窗，否则关闭弹窗
  onChange() {
    if (this.options) {
      if (this.visible) {
        this.dialogController.open();
      } else {
        this.dialogController.close();
      }
    } else {
      this.visible = false;
      hilog.error(0x0000, "HarmonyLogUtil", '%{public}s', "SelectControlDialog的SelectOptions不存在，请添加options参数")
    }
  }


  getRadioContent():Array<SheetInfo>{
    let sheets = new Array<SheetInfo>();
    if (this.options && this.options.radioText) {
      this.options.radioText.forEach((value, index) => {
        sheets.push({
          title: value,
          icon: index == this.options.selectedIndex ? this.options.selectIcon : this.options.defaultIcon,
          action: () => {
            if (this.options.callBack) {
              this.options.callBack(index)
            }
            this.visible = false;
          }
        })
      })
      return sheets;
    }
    return []
  }

  getOffset(): Offset {
    if (this.options && this.options.alignment) {
      let alignment = this.options.alignment;
      if (alignment == DialogAlignment.Bottom || alignment == DialogAlignment.BottomStart || alignment == DialogAlignment.BottomEnd) {
        return { dx: 0, dy: -20 };
      } else if (alignment == DialogAlignment.Top || alignment == DialogAlignment.TopStart || alignment == DialogAlignment.TopEnd) {
        return { dx: 0, dy: 20 };
      } else {
        return { dx: 0, dy: 0 };
      }
    } else {
      return { dx: 0, dy: -20 }
    }
  }

  build() {

  }

}


/**
 * CustomDialog基本参数类
 */
export class CustomDialogParam {
  autoCancel?: boolean; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹窗。默认值：true
  cancel?: () => void; //点击遮障层关闭dialog时的回调。
  alignment?: DialogAlignment; //弹窗的对齐方式。
  offset?: Offset; //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0 , dy: 0 }
  customStyle?: boolean; //弹窗容器样式是否自定义。默认值：false，弹窗容器的宽度根据栅格系统自适应，不跟随子节点；高度自适应子节点，最大为窗口高度的90%；圆角为24vp。设置为true时，宽度跟随子节点自适应，圆角为0，弹窗背景色为透明色。
  gridCount?: number; //弹窗宽度占栅格宽度的个数。默认为按照窗口大小自适应，异常值按默认值处理，最大栅格数为系统最大栅格数。
  maskColor?: ResourceColor //自定义蒙层颜色。 默认值: 0x33000000
  maskRect?: Rectangle; //弹窗遮蔽层区域，在遮蔽层区域内的事件不透传，在遮蔽层区域外的事件透传。
  openAnimation?: AnimateParam; //自定义设置弹窗弹出的动画效果相关参数。tempo默认值为1，当设置小于0的值时按默认值处理。iterations默认值为1，默认播放一次，设置为其他数值时按默认值处理。playMode控制动画播放模式，默认值为PlayMode.Normal，设置为其他数值时按照默认值处理。
  closeAnimation?: AnimateParam; //自定义设置弹窗关闭的动画效果相关参数。tempo默认值为1，当设置小于0的值时按默认值处理。iterations默认值为1，默认播放一次，设置为其他数值时按默认值处理。playMode控制动画播放模式，默认值为PlayMode.Normal，设置为其他数值时按照默认值处理。页面转场切换时，建议使用默认关闭动效。
  showInSubWindow?: boolean; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
  isModal?: boolean; //弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层。默认值：true，此时弹窗有蒙层。
  backgroundColor?: ResourceColor; //弹窗背板颜色。默认值：Color.Transparent
}


/**
 * SelectControlDialog参数类
 */
export class SelectOptions extends CustomDialogParam {
  title: ResourceStr = ''; //提示弹出框标题。
  content?: ResourceStr; //提示弹出框内容。
  selectedIndex?: number; //选择弹出框的选中项。默认值：-1。
  defaultIcon?: ResourceStr; //默认显示的图标
  selectIcon?: ResourceStr; //选中显示的图标
  radioText: Array<string> = []; //选择弹出框的子项内容列表，每个选择项支持设置文本和选中的回调事件。
  confirm?: ButtonOptions; //选择弹出框底部按钮。
  callBack?: (index: number) => void; //回调事件
}


/**
 * AlertDialog按钮参数类
 */
export class ButtonOptions {
  value: ResourceStr = ''; //Button的文本内容，若值为null，则该按钮不显示。
  action: () => void = () => {}; //Button选中时的回调。
  fontColor?: ResourceColor; //Button的文本内容，若值为null，则该按钮不显示。
  background?: ResourceColor; //Button背景颜色。
}