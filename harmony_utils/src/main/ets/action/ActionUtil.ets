import promptAction from '@ohos.promptAction';
import { Button } from '@system.prompt';

const DIALOG_TITLE: string = '温馨提示'; //标题
const DIALOG_CONFIRM: string = '确定'; //确定文字
const DIALOG_CANCEL: string = '取消'; //取消文字
const DIALOG_BUTTON_COLOR: string = '#666666' //按钮颜色

/**
 * 弹窗工具类（promptAction）
 */
export class ActionUtil {

  private constructor() {}


  /**
   * 显示弹窗（一个按钮）
   * @param options
   */
  static showConfirmDialog(options: ConfirmDialogOptions) {
    if (options.title == undefined) {
      options.title = DIALOG_TITLE;
    }
    if (!options.maskRect) {
      options.maskRect = { x: 0, y: 0, width: '100%', height: '100%' };
    }
    if (!options.alignment) {
      options.alignment = DialogAlignment.Bottom;
    }
    if (!options.offset) {
      if (options.alignment == DialogAlignment.Bottom || options.alignment == DialogAlignment.BottomStart || options.alignment == DialogAlignment.BottomEnd) {
        options.offset = { dx: 0, dy: -20 };
      } else if (options.alignment == DialogAlignment.Top || options.alignment == DialogAlignment.TopStart || options.alignment == DialogAlignment.TopEnd) {
        options.offset = { dx: 0, dy: 20 };
      } else {
        options.offset = { dx: 0, dy: 0 };
      }
    }
    if (!options.showInSubWindow) {
      options.showInSubWindow = false;
    }
    if (!options.isModal) {
      options.isModal = true;
    }

    let dialogBtn = new Array<Button>()
    if (!options.buttonText) {
      options.buttonText = DIALOG_CONFIRM;
    }
    dialogBtn.push({
      text: options.buttonText,
      color: DIALOG_BUTTON_COLOR
    })
    promptAction.showDialog({
      title: options.title,
      message: options.message,
      maskRect: options.maskRect,
      alignment: options.alignment,
      offset: options.offset,
      showInSubWindow: options.showInSubWindow,
      isModal: options.isModal,
      buttons: dialogBtn,
    }).then((data) => {
      if (options.callBack) {
        options.callBack()
      }
    })
  }


  /**
   * 显示弹窗（两个按钮）
   */
  static showPrimaryDialog(options: PrimaryDialogOptions) {
    if (options.title == undefined) {
      options.title = DIALOG_TITLE;
    }
    if (!options.maskRect) {
      options.maskRect = { x: 0, y: 0, width: '100%', height: '100%' };
    }
    if (!options.alignment) {
      options.alignment = DialogAlignment.Bottom;
    }
    if (!options.offset) {
      if (options.alignment == DialogAlignment.Bottom || options.alignment == DialogAlignment.BottomStart || options.alignment == DialogAlignment.BottomEnd) {
        options.offset = { dx: 0, dy: -20 };
      } else if (options.alignment == DialogAlignment.Top || options.alignment == DialogAlignment.TopStart || options.alignment == DialogAlignment.TopEnd) {
        options.offset = { dx: 0, dy: 20 };
      } else {
        options.offset = { dx: 0, dy: 0 };
      }
    }
    if (options.showInSubWindow == undefined) {
      options.showInSubWindow = false;
    }
    if (options.isModal == undefined) {
      options.isModal = true;
    }
    let dialogBtn = new Array<Button>()
    if (!options.cancelText) {
      options.cancelText = DIALOG_CANCEL;
    }
    dialogBtn.push({
      text: options.cancelText,
      color: DIALOG_BUTTON_COLOR
    })
    if (!options.confirmText) {
      options.confirmText = DIALOG_CONFIRM;
    }
    dialogBtn.push({
      text: options.confirmText,
      color: DIALOG_BUTTON_COLOR
    })
    promptAction.showDialog({
      title: options.title,
      message: options.message,
      maskRect: options.maskRect,
      alignment: options.alignment,
      offset: options.offset,
      showInSubWindow: options.showInSubWindow,
      isModal: options.isModal,
      buttons: dialogBtn,
    }).then((data) => {
      if (options.callBack) {
        options.callBack(data.index)
      }
    })
  }


  /**
   * 显示弹窗（多个按钮）
   * @param options
   */
  static showDialog(options: DialogOptions) {
    if (options.title == undefined) {
      options.title = DIALOG_TITLE;
    }
    if (!options.maskRect) {
      options.maskRect = { x: 0, y: 0, width: '100%', height: '100%' };
    }
    if (!options.alignment) {
      options.alignment = DialogAlignment.Bottom;
    }
    if (!options.offset) {
      if (options.alignment == DialogAlignment.Bottom || options.alignment == DialogAlignment.BottomStart || options.alignment == DialogAlignment.BottomEnd) {
        options.offset = { dx: 0, dy: -20 };
      } else if (options.alignment == DialogAlignment.Top || options.alignment == DialogAlignment.TopStart || options.alignment == DialogAlignment.TopEnd) {
        options.offset = { dx: 0, dy: 20 };
      } else {
        options.offset = { dx: 0, dy: 0 };
      }
    }
    if (options.showInSubWindow == undefined) {
      options.showInSubWindow = false;
    }
    if (options.isModal == undefined) {
      options.isModal = true;
    }
    let dialogBtn = new Array<Button>()
    if (options.buttons) {
      options.buttons.forEach(item => {
        dialogBtn.push({
          text: item.text,
          color: item.color ? item.color : DIALOG_BUTTON_COLOR
        })
      })
    }
    promptAction.showDialog({
      title: options.title,
      message: options.message,
      maskRect: options.maskRect,
      alignment: options.alignment,
      offset: options.offset,
      showInSubWindow: options.showInSubWindow,
      isModal: options.isModal,
      buttons: dialogBtn,
    }, (err, data) => {
      if (err) {
        return;
      }
      if (options.buttons) {
        let btn = options.buttons[data.index]
        if (btn.action) {
          btn.action()
        }
      }
    })
  }


  /**
   * 显示操作菜单（简单易用）
   * @param options
   */
  static showActionMenuEasy(options: EasyActionOptions) {
    if (options.showInSubWindow == undefined) {
      options.showInSubWindow = false;
    }
    if (options.isModal == undefined) {
      options.isModal = true;
    }
    if (options.buttons && options.buttons.length > 0) {
      let select = options.selected;
      if (!select) {
        select = { position: 0, color: DIALOG_BUTTON_COLOR }
      }
      const menus: [Button, Button?, Button?, Button?, Button?, Button?] = [
        { text: options.buttons[0], color: (select && select.position == 0) ? select.color : DIALOG_BUTTON_COLOR }
      ];
      if (options.buttons) {
        options.buttons.forEach((item, index) => {
          if (index > 0 && index < 6) {
            menus[index] = {
              text: item,
              color: (select && select.position == index) ? select.color : DIALOG_BUTTON_COLOR
            }
          }
        })
      }
      let action = promptAction.showActionMenu({
        title: options.title,
        buttons:menus,
        showInSubWindow:options.showInSubWindow,
        isModal:options.isModal,
      });
      action.then(data => {
        if (options.callBack) {
          options.callBack(data.index,options.buttons[data.index]);
        }
      })
    }
  }

  /**
   * 显示操作菜单
   * @param options
   */
  static showActionMenu(options: ActionOptions) {
    if (options.showInSubWindow == undefined) {
      options.showInSubWindow = false;
    }
    if (options.isModal == undefined) {
      options.isModal = true;
    }
    if (options.buttons && options.buttons.length > 0) {
      let btn0= options.buttons[0];
      const menus: [Button, Button?, Button?, Button?, Button?, Button?] = [
        { text: btn0.text, color: btn0.color ? btn0.color : DIALOG_BUTTON_COLOR }
      ];
      if (options.buttons) {
        options.buttons.forEach((item, index) => {
          if (index > 0 && index < 6)  {
            menus[index]={
              text: item.text,
              color: item.color ? item.color : DIALOG_BUTTON_COLOR
            }
          }
        })
      }
      let action = promptAction.showActionMenu({
        title: options.title,
        buttons: menus,
        showInSubWindow: options.showInSubWindow,
        isModal: options.isModal,
      });
      action.then(data => {
        let button = options.buttons[data.index]
        if (button && button.action) {
          button.action()
        }
      })
    }
  }

}


/**
 * Action基本参数类
 */
export class ActionParam {
  maskRect?: Rectangle; //弹窗遮蔽层区域，在遮蔽层区域内的事件不透传，在遮蔽层区域外的事件透传。默认值：{ x: 0, y: 0, width: ‘100%’, height: ‘100%’ }
  alignment?: DialogAlignment; //弹窗的对齐方式
  offset?: Offset; //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0 , dy: 0 }
  showInSubWindow?: boolean; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
  isModal?: boolean; //弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层。
}

/**
 * ConfirmDialog弹框参数类
 */
export class ConfirmDialogOptions extends ActionParam {
  title?: string | Resource; //标题文本
  message: string | Resource = ''; //内容文本
  buttonText?: string; //按钮文本
  callBack?: () => void //按钮的回调事件
}


/**
 * PrimaryDialog弹框参数类
 */
export class PrimaryDialogOptions extends ActionParam {
  title?: string | Resource; //标题文本
  message: string | Resource = ''; //内容文本
  cancelText?: string; //按钮文本
  confirmText?: string; //按钮文本
  callBack?: (index: number) => void
}


/**
 * Dialog弹框参数类
 */
export class DialogOptions extends ActionParam {
  title?: string | Resource; //标题文本
  message: string | Resource = ''; //内容文本
  buttons?: Array<DialogButton>; //按钮数组
}


/**
 * 简易的actionMenu入参对象
 */
export class EasyActionOptions {
  title: string | Resource = ''; //标题文本
  buttons: Array<string> = []; //支持1-6个按钮。按钮数量大于6个时，仅显示前6个按钮，之后的按钮不显示。
  selected?: MenuSelected; //选中参数
  showInSubWindow?: boolean;
  isModal?: boolean;
  callBack?: (index: number, data: string) => void; //回调事件
}


/**
 * actionMenu入参对象
 */
export class ActionOptions {
  title:  string | Resource='';
  buttons: Array<DialogButton> = []; //支持1-6个按钮。按钮数量大于6个时，仅显示前6个按钮，之后的按钮不显示。
  showInSubWindow?: boolean;
  isModal?: boolean;
}


/**
 * actionMenu选中项参数类
 */
export class MenuSelected {
  position: number = 0; //选中位置
  color: string = DIALOG_BUTTON_COLOR; //按钮前景色
}


/**
 * 弹窗按钮参数类
 */
export class DialogButton {
  text: string = ''; //按钮值
  color?: string; //按钮前景色
  action?: () => void; //按钮事件
}