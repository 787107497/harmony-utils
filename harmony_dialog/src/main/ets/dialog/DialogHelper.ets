import {
  AlertDialogBuilder,
  ConfirmDialogBuilder,
  CustomContentDialogBuilder,
  LoadingBuilder,
  LoadingProgressBuilder,
  SelectDialogBuilder,
  TipsDialogBuilder,
  ToastBuilder,
  ToastTipBuilder
} from './DialogBuilder';
import { BasePromptAction } from './BasePromptAction';
import { DialogOptions } from '../model/base/DialogOptions';
import { TipsOptions } from '../model/TipsOptions';
import { DialogConfig } from '../model/DialogConfig';
import { ConfirmOptions } from '../model/ConfirmOptions';
import { AlertOptions } from '../model/AlertOptions';
import { HmDialogOptions } from '../model/base/HmDialogOptions';
import { CustomContentOptions } from '../model/CustomContentOptions';
import { ButtonOptions } from '../model/ButtonOptions';
import { BaseDialogOptions } from '../model/base/BaseDialogOptions';
import { LoadingOptions } from '../model/LoadingOptions';
import { ToastOptions } from '../model/ToastOptions';
import { ToastTipOptions } from '../model/ToastTipOptions';
import { SelectOptions } from '../model/SelectOptions';
import { LoadingProgressOptions } from '../model/LoadingProgressOptions';


/**
 * TODO Dialog帮助工具类（全局自定义弹框，不依赖UI组件）
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
export class DialogHelper {
  private static config: DialogConfig = new DialogConfig(); //默认样式
  private static loadingDialogId: string = "harmony_dialog_LoadingDialog_id"; //加载弹框id


  /**
   * 设置默认统一样式
   * @param configs
   */
  static setDefaultConfig(configs: (config: DialogConfig) => void): void {
    configs(DialogHelper.config);
  }


  /**
   * 显示，操作确认类弹出框
   * @param options
   */
  static showAlertDialog(options: AlertOptions): string {
    DialogHelper.initBaseDefault(options);
    DialogHelper.initDialogDefault(options);
    DialogHelper.initAlertTitle(options);
    DialogHelper.initPrimarySecondaryButton(options);
    let dialogId = BasePromptAction.getInstance().openCustomDialog(wrapBuilder(AlertDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示，信息确认类弹出框
   * @param options
   */
  static showConfirmDialog(options: ConfirmOptions): string {
    DialogHelper.initBaseDefault(options);
    DialogHelper.initDialogDefault(options);
    DialogHelper.initPrimarySecondaryButton(options);
    let dialogId = BasePromptAction.getInstance().openCustomDialog(wrapBuilder(ConfirmDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示，显示提示弹出框，即为带图形确认框
   * @param options
   */
  static showTipsDialog(options: TipsOptions): string {
    DialogHelper.initBaseDefault(options);
    DialogHelper.initDialogDefault(options);
    DialogHelper.initPrimarySecondaryButton(options);
    DialogHelper.initImageResSize(options);
    let dialogId = BasePromptAction.getInstance().openCustomDialog(wrapBuilder(TipsDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示，选择类弹出框
   * @param options
   */
  static showSelectDialog(options: SelectOptions): string {
    DialogHelper.initBaseDefault(options);
    DialogHelper.initDialogDefault(options);
    DialogHelper.initSelect(options);
    let dialogId = BasePromptAction.getInstance().openCustomDialog(wrapBuilder(SelectDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示，自定义内容区弹出框，同时支持定义操作区按钮样式。
   */
  static showCustomContentDialog(options: CustomContentOptions): string {
    DialogHelper.initBaseDefault(options);
    DialogHelper.initDialogDefault(options);
    DialogHelper.initAlertTitle(options);
    DialogHelper.initButtons(options);
    let dialogId = BasePromptAction.getInstance().openCustomDialog(wrapBuilder(CustomContentDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示，自定义弹窗
   * @param builder 自定义弹窗中显示的组件内容
   * @param options
   */
  static showCustomDialog<T extends BaseDialogOptions>(builder: WrappedBuilder<[T]>, options: T): string {
    DialogHelper.initBaseDefault(options);
    let dialogId = BasePromptAction.getInstance().openCustomDialog(builder, options);
    return dialogId;
  }


  /**
   * 关闭，弹框
   * @param dialogId 目前弹框id
   */
  static closeDialog(dialogId: string) {
    BasePromptAction.getInstance().closeCustomDialog(dialogId);
  }


  /**
   * 显示，加载弹框
   */
  static showLoading(options?: LoadingOptions) {
    options = options ?? {};
    DialogHelper.initLoadingDefault(options);
    BasePromptAction.getInstance().openCustomDialog(wrapBuilder(LoadingBuilder), options);
  }


  /**
   * 显示，进度加载弹框
   */
  static showLoadingProgress(options: LoadingProgressOptions) {
    options = options ?? {};
    DialogHelper.initLoadingDefault(options);
    BasePromptAction.getInstance().openCustomDialog(wrapBuilder(LoadingProgressBuilder), options);
  }


  /**
   * 关闭加载弹框
   */
  static closeLoading() {
    DialogHelper.closeDialog(DialogHelper.loadingDialogId);
  }


  /**
   * 显示吐司
   * @param message 吐司内容
   * @param options
   */
  static showToast(message: string | Resource, options?: ToastOptions) {
    options = options ?? {};
    options.message = message;
    DialogHelper.initToastDefault(options);
    options.duration = options.duration ?? DialogHelper.config.toast_duration;
    let dialogId = BasePromptAction.getInstance().openCustomDialog(wrapBuilder(ToastBuilder), options);
    let timeID = setTimeout(() => {
      DialogHelper.closeDialog(dialogId);
      clearTimeout(timeID);
    }, options.duration);
  }

  /**
   * 显示长吐司
   * @param message 吐司内容
   * @param options
   */
  static showToastLong(message: string | Resource, options?: ToastOptions) {
    options = options ?? {};
    options.message = message;
    DialogHelper.initToastDefault(options);
    options.duration = options.duration ?? DialogHelper.config.toast_durationLong;
    let dialogId = BasePromptAction.getInstance().openCustomDialog(wrapBuilder(ToastBuilder), options);
    let timeID = setTimeout(() => {
      DialogHelper.closeDialog(dialogId);
      clearTimeout(timeID);
    }, options.duration);
  }


  /**
   * 显示带图形吐司
   * @param options
   */
  static showToastTip(options: ToastTipOptions) {
    DialogHelper.initToastDefault(options);
    options.imageSize = options.imageSize ?? DialogHelper.config.toast_imageSize;
    options.duration = options.duration ?? DialogHelper.config.toast_duration;
    let dialogId = BasePromptAction.getInstance().openCustomDialog(wrapBuilder(ToastTipBuilder), options);
    let timeID = setTimeout(() => {
      DialogHelper.closeDialog(dialogId);
      clearTimeout(timeID);
    }, options.duration);
  }


  /**
   * 生成弹框id
   */
  static generateId() {
    return BasePromptAction.getInstance().generateDialogId();
  }


  /**
   * 初始化DialogOptions参数
   * @param options
   */
  private static initDialogDefault(options: DialogOptions) {
    options.actionCancel =
      options.actionCancel ?? DialogHelper.config.actionCancel; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。默认值：true。
    if (options.title || DialogHelper.config.title) {
      options.title = options.title ?? DialogHelper.config.title; //弹框标题。
    }
    if (options.width || DialogHelper.config.width) {
      options.width = options.width ?? DialogHelper.config.width; //设置弹窗的宽度。
    }
    if (options.height || DialogHelper.config.height) {
      options.height = options.height ?? DialogHelper.config.height; //弹窗的高度。
    }
    if (options.backgroundColor || DialogHelper.config.backgroundColor) {
      options.backgroundColor = options.backgroundColor ?? DialogHelper.config.backgroundColor; //弹窗背板颜色。
    }
    if (options.backgroundBlurStyle || DialogHelper.config.backgroundBlurStyle) {
      options.backgroundBlurStyle = options.backgroundBlurStyle ?? DialogHelper.config.backgroundBlurStyle; //弹窗背板模糊材质。
    }
    if (options.cornerRadius || DialogHelper.config.cornerRadius) {
      options.cornerRadius = options.cornerRadius ?? DialogHelper.config.cornerRadius; //弹框圆角半径。
    }
    if (options.borderWidth || DialogHelper.config.borderWidth) {
      options.borderWidth = options.borderWidth ?? DialogHelper.config.borderWidth; //弹框4个边框宽度。
    }
    if (options.borderColor || DialogHelper.config.borderColor) {
      options.borderColor = options.borderColor ?? DialogHelper.config.borderColor; //弹框边框颜色。
    }
    if (options.borderStyle || DialogHelper.config.borderStyle) {
      options.borderStyle = options.borderStyle ?? DialogHelper.config.borderStyle; //弹框背板的边框样式。
    }
  }

  /**
   * 初始化BaseDialogOptions参数
   * @param options
   */
  private static initBaseDefault(options: BaseDialogOptions) {
    options.isModal = options.isModal ?? DialogHelper.config.isModal; //弹窗是否为模态窗口。
    options.showInSubWindow =
      options.showInSubWindow ?? DialogHelper.config.showInSubWindow; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
    options.autoCancel = options.autoCancel ?? DialogHelper.config.autoCancel; //点击遮障层时，是否关闭弹窗。
    options.backCancel =
      options.backCancel ?? DialogHelper.config.backCancel; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
    if (options.alignment || DialogHelper.config.alignment) {
      options.alignment = options.alignment ?? DialogHelper.config.alignment; //弹窗的对齐方式。
    }
    if (options.offset || DialogHelper.config.offset) {
      options.offset = options.offset ?? DialogHelper.config.offset; //弹窗相对alignment所在位置的偏移量。
    }
    if (options.maskRect || DialogHelper.config.maskRect) {
      options.maskRect = options.maskRect ?? DialogHelper.config.maskRect; //弹窗遮蔽层区域。
    }
    if (options.maskColor || DialogHelper.config.maskColor) {
      options.maskColor = options.maskColor ?? DialogHelper.config.maskColor; //弹框自定义蒙层颜色。
    }
    if (options.transition || DialogHelper.config.transition) {
      options.transition = options.transition ?? DialogHelper.config.transition; //设置弹窗显示和退出的过渡效果。
    }
    if (options.onWillDismiss || DialogHelper.config.onWillDismiss) {
      options.onWillDismiss = options.onWillDismiss ?? DialogHelper.config.onWillDismiss; //交互式关闭回调函数。
    }
    if (options.onDidDisappear || DialogHelper.config.onDidDisappear) {
      options.onDidDisappear = options.onDidDisappear ?? DialogHelper.config.onDidDisappear; //弹窗消失时的事件回调。
    }
  }


  /**
   * Alert标题,初始化参数
   * @param options
   */
  private static initAlertTitle(options: AlertOptions | CustomContentOptions) {
    if (options.primaryTitle || DialogHelper.config.title) {
      options.primaryTitle = options.primaryTitle ?? DialogHelper.config.title; //弹框标题。
    }
  }


  /**
   * 自定义弹框，按钮，初始化参数
   */
  private static initButtons(options: CustomContentOptions) {
    if (!options.buttons) {
      options.buttons = [DialogHelper.config.primaryButton, DialogHelper.config.secondaryButton]
    }
    if (options.buttons && options.buttons.length > 0) {
      if (options.buttons[0] instanceof ButtonOptions) {
        for (let index = 0; index < options.buttons.length; index++) {
          let btn = options.buttons[index] as ButtonOptions;
          let btnAction = btn.action;
          btn.action = () => {
            if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
              DialogHelper.closeDialog(options.dialogId ?? "");
            }
            if (btnAction) {
              btnAction();
            }
            if (options.onAction) {
              options.onAction(index + 1, options.dialogId ?? "");
            }
          }
        }
      } else {
        let buttons = new Array<ButtonOptions>()
        for (let index = 0; index < options.buttons.length; index++) {
          let button: ButtonOptions = {
            value: options.buttons[index] as ResourceStr,
            action: () => {
              if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
                DialogHelper.closeDialog(options.dialogId ?? "");
              }
              if (options.onAction) {
                options.onAction(index + 1, options.dialogId ?? "");
              }
            }
          }
          buttons.push(button);
        }
        options.buttons = buttons;
      }
    }
  }


  /**
   * 左侧按钮，右侧按钮，初始化参数
   * @param options
   */
  private static initPrimarySecondaryButton(options: HmDialogOptions) {
    //当PrimaryButton和SecondaryButton同时为空时，使用默认按钮
    if (!options.primaryButton && !options.secondaryButton) {
      options.primaryButton = DialogHelper.config.primaryButton
      options.secondaryButton = DialogHelper.config.secondaryButton
    }
    if (options.primaryButton) {
      if (options.primaryButton instanceof ButtonOptions) {
        let primaryButton = options.primaryButton;
        let primaryAction = primaryButton.action;
        primaryButton.action = () => {
          if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
            DialogHelper.closeDialog(options.dialogId ?? "");
          }
          if (primaryAction) {
            primaryAction();
          }
          if (options.onAction) {
            options.onAction(1, options.dialogId ?? "");
          }
        }
      } else {
        options.primaryButton = {
          value: options.primaryButton,
          action: () => {
            if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
              DialogHelper.closeDialog(options.dialogId ?? "");
            }
            if (options.onAction) {
              options.onAction(1, options.dialogId ?? "");
            }
          }
        }
      }
    }
    if (options.secondaryButton) {
      if (options.secondaryButton instanceof ButtonOptions) {
        let secondaryButton = options.secondaryButton;
        let secondaryAction = secondaryButton.action;
        secondaryButton.action = () => {
          if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
            DialogHelper.closeDialog(options.dialogId ?? "");
          }
          if (secondaryAction) {
            secondaryAction();
          }
          if (options.onAction) {
            options.onAction(2, options.dialogId ?? "");
          }
        }
      } else {
        options.secondaryButton = {
          value: options.secondaryButton,
          action: () => {
            if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
              DialogHelper.closeDialog(options.dialogId ?? "");
            }
            if (options.onAction) {
              options.onAction(2, options.dialogId ?? "");
            }
          }
        }
      }
    }
  }


  /**
   * Tips，图片参数
   */
  private static initImageResSize(options: TipsOptions) {
    if (options.imageRes || DialogHelper.config.imageRes) {
      options.imageRes = options.imageRes ?? DialogHelper.config.imageRes; //展示的图片。
      options.imageSize = options.imageSize ?? DialogHelper.config.imageSize; //自定义图片尺寸。默认值：64*64vp.
    }
  }


  /**
   * 选择类弹出框,参数
   * @param options
   */
  private static initSelect(options: SelectOptions) {
    if (options.radioContent && options.radioContent.length > 0) {
      if (typeof options.radioContent[0] === 'string') {
        let sheetInfos = new Array<SheetInfo>()
        for (let index = 0; index < options.radioContent.length; index++) {
          let sheetInfo: SheetInfo = {
            title: options.radioContent[index] as ResourceStr,
            action: () => {
              if (options.onCheckedChanged) {
                options.onCheckedChanged(index);
              }
            }
          }
          sheetInfos.push(sheetInfo);
        }
        options.radioContent = sheetInfos;
      } else {
        for (let index = 0; index < options.radioContent.length; index++) {
          let btn = options.radioContent[index] as SheetInfo;
          let btnAction = btn.action;
          btn.action = () => {
            if (options.onCheckedChanged) {
              options.onCheckedChanged(index);
            }
            if (btnAction) {
              btnAction();
            }
          }
        }
      }
    }

    if (!options.confirm) { //选择弹出框底部按钮。
      options.confirm = DialogHelper.config.primaryButton
    }
    if (options.confirm) {
      if (options.confirm instanceof ButtonOptions) {
        let confirmButton = options.confirm;
        let confirmAction = confirmButton.action;
        confirmButton.action = () => {
          if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
            DialogHelper.closeDialog(options.dialogId ?? "");
          }
          if (options.onAction) {
            options.onAction(1, options.dialogId ?? "");
          }
          if (confirmAction) {
            confirmAction();
          }
        }
      } else {
        options.confirm = {
          value: options.confirm,
          action: () => {
            if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
              DialogHelper.closeDialog(options.dialogId ?? "");
            }
            if (options.onAction) {
              options.onAction(1, options.dialogId ?? "");
            }
          }
        }
      }
    }
  }


  /**
   * 初始化LoadingDialogOptions参数
   * @param options
   */
  private static initLoadingDefault(options: LoadingOptions) {
    options.dialogId = DialogHelper.loadingDialogId; //加载框id
    options.alignment = DialogAlignment.Center; //弹窗的对齐方式。
    options.isModal = options.isModal ?? DialogHelper.config.isModal; //弹窗是否为模态窗口。
    options.showInSubWindow =
      options.showInSubWindow ?? DialogHelper.config.showInSubWindow; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
    options.autoCancel = options.autoCancel ?? DialogHelper.config.autoCancel; //点击遮障层时，是否关闭弹窗。
    options.backCancel =
      options.backCancel ?? DialogHelper.config.backCancel; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
    if (options.maskRect || DialogHelper.config.maskRect) {
      options.maskRect = options.maskRect ?? DialogHelper.config.maskRect; //弹窗遮蔽层区域。
    }
    if (options.maskColor || DialogHelper.config.maskColor) {
      options.maskColor = options.maskColor ?? DialogHelper.config.maskColor; //弹框自定义蒙层颜色。
    }
    if (options.onWillDismiss || DialogHelper.config.onWillDismiss) {
      options.onWillDismiss = options.onWillDismiss ?? DialogHelper.config.onWillDismiss; //交互式关闭回调函数。
    }
    if (options.onDidDisappear || DialogHelper.config.onDidDisappear) {
      options.onDidDisappear = options.onDidDisappear ?? DialogHelper.config.onDidDisappear; //弹窗消失时的事件回调。
    }

    if (options.spinSize || DialogHelper.config.loading_spinSize) {
      options.spinSize = options.spinSize ?? DialogHelper.config.loading_spinSize; //加载动画的大小。
    }
    if (options.spinColor || DialogHelper.config.loading_spinColor) {
      options.spinColor = options.spinColor ?? DialogHelper.config.loading_spinColor; //加载动画的颜色。
    }
    if (options.content || DialogHelper.config.loading_content) {
      options.content = options.content ?? DialogHelper.config.loading_content; //加载动画的提示文字。
    }
    if (options.fontSize || DialogHelper.config.loading_fontSize) {
      options.fontSize = options.fontSize ?? DialogHelper.config.loading_fontSize; //提示文字大小。
    }
    if (options.fontColor || DialogHelper.config.loading_fontColor) {
      options.fontColor = options.fontColor ?? DialogHelper.config.loading_fontColor; //加载动画的文字颜色。
    }
    if (options.backgroundColor || DialogHelper.config.loading_backgroundColor) {
      options.backgroundColor = options.backgroundColor ?? DialogHelper.config.loading_backgroundColor; //加载动画背景颜色。
    }
    if (options.borderRadius || DialogHelper.config.loading_borderRadius) {
      options.borderRadius = options.borderRadius ?? DialogHelper.config.loading_borderRadius; //加载动画背景圆角。
    }
  }


  /**
   * 初始化ToastOptions参数
   * @param options
   */
  private static initToastDefault(options: ToastOptions) {
    options.maskColor = Color.Transparent; //弹框自定义蒙层颜色。
    options.autoCancel = false; //点击遮障层时，是否关闭弹窗。
    options.isModal = false; //弹窗是否为模态窗口。
    options.backCancel = false; //点击返回键或手势返回时，是否关闭弹窗。
    if (options.alignment || DialogHelper.config.alignment) {
      options.alignment = options.alignment ?? DialogHelper.config.alignment; //弹窗的对齐方式。
    }
    if (options.alignment == DialogAlignment.Top || options.alignment == DialogAlignment.TopStart ||
      options.alignment == DialogAlignment.TopEnd) {
      options.alignment = DialogAlignment.Top;
      options.offset = { dx: 0, dy: 60 };
    } else if (options.alignment == DialogAlignment.Bottom || options.alignment == DialogAlignment.BottomStart ||
      options.alignment == DialogAlignment.BottomEnd) {
      options.alignment = DialogAlignment.Bottom;
      options.offset = { dx: 0, dy: -60 };
    } else {
      options.alignment = DialogAlignment.Center;
      options.offset = { dx: 0, dy: 0 };
    }
    options.showInSubWindow =
      options.showInSubWindow ?? DialogHelper.config.showInSubWindow; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
    if (options.fontSize || DialogHelper.config.toast_fontSize) {
      options.fontSize = options.fontSize ?? DialogHelper.config.toast_fontSize; //文字大小。
    }
    if (options.fontColor || DialogHelper.config.toast_fontColor) {
      options.fontColor = options.fontColor ?? DialogHelper.config.toast_fontColor; //文字颜色。
    }
    if (options.backgroundColor || DialogHelper.config.toast_backgroundColor) {
      options.backgroundColor =
        options.backgroundColor ?? DialogHelper.config.toast_backgroundColor; //背景颜色，建议八位色值前两位为透明度。
    }
    if (options.borderRadius || DialogHelper.config.toast_borderRadius) {
      options.borderRadius = options.borderRadius ?? DialogHelper.config.toast_borderRadius; //背景圆角。
    }
    if (options.padding || DialogHelper.config.toast_padding) {
      options.padding = options.padding ?? DialogHelper.config.toast_padding; //Padding。
    }
  }
}