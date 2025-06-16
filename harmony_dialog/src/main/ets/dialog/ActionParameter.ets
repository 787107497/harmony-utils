/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-dialog
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


import { DialogHelper } from './DialogHelper';
import { DialogOptions } from '../model/base/DialogOptions';
import { TipsOptions } from '../model/TipsOptions';
import { DialogConfig } from '../model/DialogConfig';
import { AlertOptions } from '../model/AlertOptions';
import { CustomContentOptions } from '../model/CustomContentOptions';
import { BaseDialogOptions } from '../model/base/BaseDialogOptions';
import { LoadingOptions } from '../model/LoadingOptions';
import { ToastOptions } from '../model/ToastOptions';
import { ToastTipOptions } from '../model/ToastTipOptions';
import { SelectOptions } from '../model/SelectOptions';
import { BaseInputOptions } from '../model/base/BaseInputOptions';
import { HmDialogOptions } from '../model/base/HmDialogOptions';
import { BottomSheetOptions } from '../model/BottomSheetOptions';
import { ActionSheetOptions } from '../model/ActionSheetOptions';
import { DialogAction } from '../utils/constraint';
import { promptAction } from '@kit.ArkUI';
import { BasePickerOptions } from '../model/base/BasePickerOptions';
import { CacheHelper } from '../utils/CacheHelper';
import { ButtonOptions } from '../model/ButtonOptions';
import { BaseSheetOptions } from '../model/base/BaseSheetOptions';
import { Helper } from '../utils/Helper';


/**
 * TODO 参数初始化
 * author: 桃花镇童长老ᥫ᭡
 * since: 2025/06/16
 */
export class ActionParameter {

  public static config: DialogConfig = new DialogConfig(); //默认样式


  /**
   * 初始化BaseDialogOptions参数
   * @param options
   */
  static initBaseDefault(options: BaseDialogOptions) {
    options.uiContext = options.uiContext ?? DialogHelper.getMainUIContext();
    options.isModal = options.isModal ?? ActionParameter.config.isModal; //弹窗是否为模态窗口。
    options.showInSubWindow = options.showInSubWindow ?? ActionParameter.config.showInSubWindow; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
    options.autoCancel = options.autoCancel ?? ActionParameter.config.autoCancel; //点击遮障层时，是否关闭弹窗。
    options.backCancel = options.backCancel ?? ActionParameter.config.backCancel; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
    if (options.alignment || ActionParameter.config.alignment) {
      options.alignment = options.alignment ?? ActionParameter.config.alignment; //弹窗的对齐方式。
    }
    if (options.offset || ActionParameter.config.offset) {
      options.offset = options.offset ?? ActionParameter.config.offset; //弹窗相对alignment所在位置的偏移量。
    }
    if (options.maskRect || ActionParameter.config.maskRect) {
      options.maskRect = options.maskRect ?? ActionParameter.config.maskRect; //弹窗遮蔽层区域。
    }
    if (options.maskColor || ActionParameter.config.maskColor) {
      options.maskColor = options.maskColor ?? ActionParameter.config.maskColor; //弹框自定义蒙层颜色。
    }
    if (options.transition || ActionParameter.config.transition) {
      options.transition = options.transition ?? ActionParameter.config.transition; //设置弹窗显示和退出的过渡效果。
    }
    if (options.onWillDismiss || ActionParameter.config.onWillDismiss) {
      options.onWillDismiss = options.onWillDismiss ?? ActionParameter.config.onWillDismiss; //交互式关闭回调函数。
    }
    if (options.onDidDisappear || ActionParameter.config.onDidDisappear) {
      options.onDidDisappear = options.onDidDisappear ?? ActionParameter.config.onDidDisappear; //弹窗消失时的事件回调。
    }
    options.enableHoverMode = options.enableHoverMode ?? ActionParameter.config.enableHoverMode; //是否响应悬停态。默认值：false，默认不响应。<API14+>
    options.hoverModeArea = options.hoverModeArea ?? ActionParameter.config.hoverModeArea; //设置悬停态下弹窗的默认展示区域。默认值：HoverModeAreaType.BOTTOM_SCREEN。<API14+>
    options.levelMode = options.levelMode ?? ActionParameter.config.levelMode; //设置弹窗显示层级。默认值：LevelMode.OVERLAY。当且仅当showInSubWindow属性设置为false时生效。<API15+>
    options.immersiveMode = options.immersiveMode ?? ActionParameter.config.immersiveMode; //设置页面内弹窗蒙层效果。默认值：ImmersiveMode.DEFAULT。当且仅当levelMode属性设置为LevelMode.EMBEDDED时生效。<API15+>
  }


  /**
   * 初始化DialogOptions参数
   * @param options
   */
  static initDialogDefault(options: DialogOptions) {
    options.actionCancel = options.actionCancel ?? ActionParameter.config.actionCancel; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。默认值：true。
    if (options.title || ActionParameter.config.title) {
      options.title = options.title ?? ActionParameter.config.title; //弹框标题。
    }
    if (options.width || ActionParameter.config.width) {
      options.width = options.width ?? ActionParameter.config.width; //设置弹窗的宽度。
    }
    if (options.maxWidth || ActionParameter.config.maxWidth) {
      options.maxWidth = options.maxWidth ?? ActionParameter.config.maxWidth; //弹窗的高度最大宽度。
    }
    if (options.cornerRadius || ActionParameter.config.cornerRadius) {
      options.cornerRadius = options.cornerRadius ?? ActionParameter.config.cornerRadius; //弹框圆角半径。
    }
    if (options.borderWidth || ActionParameter.config.borderWidth) {
      options.borderWidth = options.borderWidth ?? ActionParameter.config.borderWidth; //弹框4个边框宽度。
    }
    if (options.borderColor || ActionParameter.config.borderColor) {
      options.borderColor = options.borderColor ?? ActionParameter.config.borderColor; //弹框边框颜色。
    }
    if (options.borderStyle || ActionParameter.config.borderStyle) {
      options.borderStyle = options.borderStyle ?? ActionParameter.config.borderStyle; //弹框背板的边框样式。
    }
    if (options.backgroundColor || ActionParameter.config.backgroundColor) {
      options.backgroundColor = options.backgroundColor ?? ActionParameter.config.backgroundColor; //弹窗背板颜色。
    }
    if (options.backgroundBlurStyle || ActionParameter.config.backgroundBlurStyle) {
      options.backgroundBlurStyle = options.backgroundBlurStyle ?? ActionParameter.config.backgroundBlurStyle; //弹窗背板模糊材质。
    }
    if (options.theme || ActionParameter.config.theme) {
      options.theme = options.theme ?? ActionParameter.config.theme; //主题信息。
    }
    if (options.themeColorMode || ActionParameter.config.themeColorMode) {
      options.themeColorMode = options.themeColorMode ?? ActionParameter.config.themeColorMode; //设置深色浅色，默认跟随系统。
    }
  }


  /**
   * 初始化BottomSheetOptions参数
   * @param options
   */
  static initBottomSheetDefault(options: BottomSheetOptions, fullWidth: boolean) {
    options.alignment = DialogAlignment.Bottom; //弹窗的对齐方式。
    options.offset = { dx: 0, dy: 0 }; //弹窗相对alignment所在位置的偏移量。
    options.cancelValue = options.cancelValue ?? ActionParameter.config.primaryButton;
    options.actionCancel = options.actionCancel ?? ActionParameter.config.actionCancel; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。默认值：true。
    if (options.width || ActionParameter.config.width) {
      if (fullWidth) {
        options.width = options.width ?? "100%"; //设置弹窗的宽度。
      } else {
        options.width = options.width ?? ActionParameter.config.width; //设置弹窗的宽度。
      }
    }
    if (options.maxWidth || ActionParameter.config.maxWidth) {
      if (fullWidth) {
        options.maxWidth = options.maxWidth ?? Helper.getMaxWidth(ActionParameter.config.maxWidth); //弹窗的高度最大宽度。
      }else {
        options.maxWidth = options.maxWidth ?? ActionParameter.config.maxWidth; //弹窗的高度最大宽度。
      }
    }
    if (options.backgroundColor || ActionParameter.config.backgroundColor) {
      options.backgroundColor = options.backgroundColor ?? ActionParameter.config.backgroundColor; //弹窗背板颜色。
    }
    if (options.backgroundBlurStyle || ActionParameter.config.backgroundBlurStyle) {
      options.backgroundBlurStyle = options.backgroundBlurStyle ?? ActionParameter.config.backgroundBlurStyle; //弹窗背板模糊材质。
    }
    if (options.cornerRadius || ActionParameter.config.cornerRadius) {
      options.cornerRadius = options.cornerRadius ?? 15; //弹框圆角半径，默认15。
    }
    if (options.sheets && options.sheets.length > 0) {
      if (Helper.isResourceStr(options.sheets[0])) {
        let sheets = new Array<ActionSheetOptions>();
        for (let index = 0; index < options.sheets.length; index++) {
          let sheet: ActionSheetOptions = { value: options.sheets[index] as ResourceStr };
          sheets.push(sheet);
        }
        options.sheets = sheets;
      }
    }
  }


  /**
   * TextPicker弹框默认值
   * @param options
   */
  static initTextPickerDefault(options: BasePickerOptions) {
    options.alignment = DialogAlignment.Bottom; //弹窗的对齐方式。
    options.offset = { dx: 0, dy: 0 }; //弹窗相对alignment所在位置的偏移量。
    options.actionCancel = options.actionCancel ?? ActionParameter.config.actionCancel; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。默认值：true。
    options.width = options.width ?? "100%"; //设置弹窗的宽度。
    if (options.maxWidth || ActionParameter.config.maxWidth) {
      options.maxWidth = options.maxWidth ?? Helper.getMaxWidth(ActionParameter.config.maxWidth); //弹窗的高度最大宽度。
    }
    if (options.backgroundColor || ActionParameter.config.backgroundColor) {
      options.backgroundColor = options.backgroundColor ?? ActionParameter.config.backgroundColor; //弹窗背板颜色。
    }
    if (options.backgroundBlurStyle || ActionParameter.config.backgroundBlurStyle) {
      options.backgroundBlurStyle = options.backgroundBlurStyle ?? ActionParameter.config.backgroundBlurStyle; //弹窗背板模糊材质。
    }
    if (options.cornerRadius || ActionParameter.config.cornerRadius) {
      options.cornerRadius = options.cornerRadius ?? 15; //弹框圆角半径，默认15。
    }
    if (options.textStyle || ActionParameter.config.picker_textStyle) {
      options.textStyle = options.textStyle ?? ActionParameter.config.picker_textStyle; //设置所有选项中除了最上、最下及选中项以外的文本颜色、字号、字体粗细。
    }
    if (options.selectedTextStyle || ActionParameter.config.picker_selectedTextStyle) {
      options.selectedTextStyle = options.selectedTextStyle ?? ActionParameter.config.picker_selectedTextStyle; //设置选中项的文本颜色、字号、字体粗细。
    }
    if (options.disappearTextStyle || ActionParameter.config.picker_disappearTextStyle) {
      options.disappearTextStyle = options.disappearTextStyle ?? ActionParameter.config.picker_disappearTextStyle; //设置所有选项中最上和最下两个选项的文本颜色、字号、字体粗细。
    }
    if (options.divider || ActionParameter.config.picker_divider) {
      options.divider = options.divider ?? ActionParameter.config.picker_divider; //设置所有选项中最上和最下两个选项的文本颜色、字号、字体粗细。
    }
    options.canLoop = options.canLoop ?? ActionParameter.config.picker_canLoop; //设置是否可循环滚动
    if (!options.primaryButton && !options.secondaryButton) {
      options.primaryButton = ActionParameter.config.primaryButton
      options.secondaryButton = ActionParameter.config.secondaryButton
    }
    if (options.primaryButton) { //取消按钮
      if (Helper.isResourceStr(options.primaryButton)) {
        let primaryButton = new ButtonOptions();
        primaryButton.value = options.primaryButton as ResourceStr;
        primaryButton.fontColor = ActionParameter.config.picker_buttonFontColor;
        primaryButton.buttonStyle = ButtonStyleMode.TEXTUAL;
        primaryButton.role = ButtonRole.NORMAL;
        primaryButton.background = Color.Transparent
        options.primaryButton = primaryButton;
      } else {
        let primaryButton = options.primaryButton as ButtonOptions;
        if (!primaryButton.fontColor) {
          primaryButton.fontColor = ActionParameter.config.picker_buttonFontColor;
        }
        if (!primaryButton.buttonStyle) {
          primaryButton.buttonStyle = ButtonStyleMode.TEXTUAL;
        }
        if (!primaryButton.role) {
          primaryButton.role = ButtonRole.NORMAL;
        }
        if (!primaryButton.background) {
          primaryButton.background = Color.Transparent;
        }
      }
    }
    if (options.secondaryButton) { //确定按钮
      if (Helper.isResourceStr(options.secondaryButton)) {
        let secondaryButton = new ButtonOptions();
        secondaryButton.value = options.secondaryButton as ResourceStr;
        secondaryButton.fontColor = ActionParameter.config.picker_buttonFontColor;
        secondaryButton.buttonStyle = ButtonStyleMode.TEXTUAL;
        secondaryButton.role = ButtonRole.NORMAL;
        secondaryButton.background = Color.Transparent
        options.secondaryButton = secondaryButton;
      } else {
        let secondaryButton = options.secondaryButton as ButtonOptions;
        if (!secondaryButton.fontColor) {
          secondaryButton.fontColor = ActionParameter.config.picker_buttonFontColor;
        }
        if (!secondaryButton.buttonStyle) {
          secondaryButton.buttonStyle = ButtonStyleMode.TEXTUAL;
        }
        if (!secondaryButton.role) {
          secondaryButton.role = ButtonRole.NORMAL;
        }
        if (!secondaryButton.background) {
          secondaryButton.background = Color.Transparent;
        }
      }
    }
    if (!options.titleFontColor) {
      options.titleFontColor = ActionParameter.config.picker_titleFontColor;
    }
    if (!options.titleBackground) {
      options.titleBackground = ActionParameter.config.picker_titleBackground;
    }
  }


  /**
   * Alert标题,初始化参数
   * @param options
   */
  static initAlertTitle(options: AlertOptions | CustomContentOptions | BaseInputOptions) {
    if (options.primaryTitle || options.title) {
      options.primaryTitle = options.primaryTitle ?? options.title; //弹框一级标题。
    }
  }


  /**
   * 自定义弹框，按钮，初始化参数
   */
  static initButtons(options: CustomContentOptions | BaseInputOptions, blInput: boolean) {
    if (!options.buttons) {
      options.buttons = [ActionParameter.config.primaryButton, ActionParameter.config.secondaryButton]
    }
    if (options.buttons && options.buttons.length > 0) {
      let buttons = new Array<ButtonOptions>();
      for (let index = 0; index < options.buttons.length; index++) {
        if (Helper.isResourceStr(options.buttons[index])) {
          let button: ButtonOptions = {
            value: options.buttons[index] as ResourceStr,
            action: () => {
              if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
                DialogHelper.closeDialog(options.dialogId ?? "");
              }
              if (options.onAction) {
                if (blInput) {
                  let text = CacheHelper.get<string>(`${CacheHelper.CACHE_LABEL}${options.dialogId ?? ""}`);
                  options.onAction(ActionParameter.getDialogAction(index), options.dialogId ?? "", text);
                } else {
                  options.onAction(ActionParameter.getDialogAction(index), options.dialogId ?? "", "");
                }
              }
            }
          };
          buttons.push(button);
        } else {
          let btn = options.buttons[index] as ButtonOptions;
          const btnAction = btn.action;
          btn.action = () => {
            if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
              DialogHelper.closeDialog(options.dialogId ?? "");
            }
            if (btnAction) {
              btnAction();
            }
            if (options.onAction) {
              if (blInput) {
                let text = CacheHelper.get<string>(`${CacheHelper.CACHE_LABEL}${options.dialogId ?? ""}`);
                options.onAction(ActionParameter.getDialogAction(index), options.dialogId ?? "", text);
              } else {
                options.onAction(ActionParameter.getDialogAction(index), options.dialogId ?? "", "");
              }
            }
          };
          buttons.push(btn);
        }
      }
      options.buttons = buttons;
    }
  }


  /**
   * 左侧按钮，右侧按钮，初始化参数
   * @param options
   */
  static initPrimarySecondaryButton(options: HmDialogOptions) {
    //当PrimaryButton和SecondaryButton同时为空时，使用默认按钮
    if (!options.primaryButton && !options.secondaryButton) {
      options.primaryButton = ActionParameter.config.primaryButton
      options.secondaryButton = ActionParameter.config.secondaryButton
    }
    if (options.primaryButton) {
      if (Helper.isResourceStr(options.primaryButton)) {
        options.primaryButton = {
          value: options.primaryButton as ResourceStr,
          action: () => {
            if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
              DialogHelper.closeDialog(options.dialogId ?? "");
            }
            if (options.onAction) {
              options.onAction(DialogAction.ONE, options.dialogId ?? "");
            }
          }
        }
      } else {
        let primaryButton = options.primaryButton as ButtonOptions;
        let primaryAction = primaryButton.action;
        primaryButton.action = () => {
          if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
            DialogHelper.closeDialog(options.dialogId ?? "");
          }
          if (primaryAction) {
            primaryAction();
          }
          if (options.onAction) {
            options.onAction(DialogAction.ONE, options.dialogId ?? "");
          }
        }
      }
    }
    if (options.secondaryButton) {
      if (Helper.isResourceStr(options.secondaryButton)) {
        options.secondaryButton = {
          value: options.secondaryButton as ResourceStr,
          action: () => {
            if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
              DialogHelper.closeDialog(options.dialogId ?? "");
            }
            if (options.onAction) {
              options.onAction(DialogAction.TWO, options.dialogId ?? "");
            }
          }
        }
      } else {
        let secondaryButton = options.secondaryButton as ButtonOptions;
        let secondaryAction = secondaryButton.action;
        secondaryButton.action = () => {
          if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
            DialogHelper.closeDialog(options.dialogId ?? "");
          }
          if (secondaryAction) {
            secondaryAction();
          }
          if (options.onAction) {
            options.onAction(DialogAction.TWO, options.dialogId ?? "");
          }
        }
      }
    }
  }


  /**
   * Tips，图片参数
   */
  static initImageResSize(options: TipsOptions) {
    if (options.imageRes || ActionParameter.config.imageRes) {
      options.imageRes = options.imageRes ?? ActionParameter.config.imageRes; //展示的图片。
      options.imageSize = options.imageSize ?? ActionParameter.config.imageSize; //自定义图片尺寸。默认值：64*64vp.
    }
  }


  /**
   * 选择类弹出框,参数
   * @param options
   */
  static initSelect(options: SelectOptions) {
    if (options.radioContent && options.radioContent.length > 0) {
      CacheHelper.put(`${CacheHelper.CACHE_LABEL}${options.dialogId ?? ""}`, "");
      if (Helper.isResourceStr(options.radioContent[0])) {
        let sheetInfos = new Array<SheetInfo>()
        for (let index = 0; index < options.radioContent.length; index++) {
          let sheetInfo: SheetInfo = {
            title: options.radioContent[index] as ResourceStr,
            action: () => {
              CacheHelper.put(`${CacheHelper.CACHE_LABEL}${options.dialogId ?? ""}`, index.toString());
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
            CacheHelper.put(`${CacheHelper.CACHE_LABEL}${options.dialogId ?? ""}`, index.toString());
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
      options.confirm = ActionParameter.config.primaryButton
    }
    if (options.confirm) {
      if (Helper.isResourceStr(options.confirm)) {
        options.confirm = {
          value: options.confirm as ResourceStr,
          action: () => {
            if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
              DialogHelper.closeDialog(options.dialogId ?? "");
            }
            if (options.onAction) {
              const indexStr = CacheHelper.get<string>(`${CacheHelper.CACHE_LABEL}${options.dialogId ?? ""}`);
              options.onAction(DialogAction.ONE, options.dialogId ?? "", indexStr);
            }
          }
        }
      } else {
        let confirmButton = options.confirm as ButtonOptions;
        let confirmAction = confirmButton.action;
        confirmButton.action = () => {
          if (options.actionCancel) { //点击操作按钮时，是否关闭弹窗。
            DialogHelper.closeDialog(options.dialogId ?? "");
          }
          if (options.onAction) {
            const indexStr = CacheHelper.get<string>(`${CacheHelper.CACHE_LABEL}${options.dialogId ?? ""}`);
            options.onAction(DialogAction.ONE, options.dialogId ?? "", indexStr);
          }
          if (confirmAction) {
            confirmAction();
          }
        }
      }
    }
  }


  /**
   * 初始化LoadingDialogOptions参数
   * @param options
   */
  static initLoadingDefault(options: LoadingOptions) {
    options.uiContext = options.uiContext ?? DialogHelper.getMainUIContext();
    options.alignment = DialogAlignment.Center; //弹窗的对齐方式。
    options.isModal = options.isModal ?? ActionParameter.config.isModal; //弹窗是否为模态窗口。
    options.showInSubWindow = options.showInSubWindow ?? ActionParameter.config.showInSubWindow; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
    options.autoCancel = options.autoCancel ?? ActionParameter.config.autoCancel; //点击遮障层时，是否关闭弹窗。
    options.backCancel = options.backCancel ?? ActionParameter.config.backCancel; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
    if (options.maskRect || ActionParameter.config.maskRect) {
      options.maskRect = options.maskRect ?? ActionParameter.config.maskRect; //弹窗遮蔽层区域。
    }
    if (options.maskColor || ActionParameter.config.maskColor) {
      options.maskColor = options.maskColor ?? ActionParameter.config.maskColor; //弹框自定义蒙层颜色。
    }
    if (options.onWillDismiss || ActionParameter.config.onWillDismiss) {
      options.onWillDismiss = options.onWillDismiss ?? ActionParameter.config.onWillDismiss; //交互式关闭回调函数。
    }
    if (options.onDidDisappear || ActionParameter.config.onDidDisappear) {
      options.onDidDisappear = options.onDidDisappear ?? ActionParameter.config.onDidDisappear; //弹窗消失时的事件回调。
    }
    if (options.loadType || ActionParameter.config.loading_loadType) {
      options.loadType = options.loadType ?? ActionParameter.config.loading_loadType; //加载动画的类型。
    }
    if (options.loadSize || ActionParameter.config.loading_loadSize) {
      options.loadSize = options.loadSize ?? ActionParameter.config.loading_loadSize; //加载动画的大小。
    }
    if (options.loadColor || ActionParameter.config.loading_loadColor) {
      options.loadColor = options.loadColor ?? ActionParameter.config.loading_loadColor; //加载动画的颜色。
    }
    if (options.content || ActionParameter.config.loading_content) {
      options.content = options.content ?? ActionParameter.config.loading_content; //加载动画的提示文字。
    }
    if (options.fontSize || ActionParameter.config.loading_fontSize) {
      options.fontSize = options.fontSize ?? ActionParameter.config.loading_fontSize; //提示文字大小。
    }
    if (options.fontColor || ActionParameter.config.loading_fontColor) {
      options.fontColor = options.fontColor ?? ActionParameter.config.loading_fontColor; //加载动画的文字颜色。
    }
    if (options.backgroundColor || ActionParameter.config.loading_backgroundColor) {
      options.backgroundColor = options.backgroundColor ?? ActionParameter.config.loading_backgroundColor; //加载动画背景颜色。
    }
    if (options.borderRadius || ActionParameter.config.loading_borderRadius) {
      options.borderRadius = options.borderRadius ?? ActionParameter.config.loading_borderRadius; //加载动画背景圆角。
    }
    if (options.marginTop || ActionParameter.config.loading_marginTop) {
      options.marginTop = options.marginTop ?? ActionParameter.config.loading_marginTop; //文字与动画的间距。
    }
    if (options.padding || ActionParameter.config.loading_padding) {
      options.padding = options.padding ?? ActionParameter.config.loading_padding; //padding。
    }
    options.shadow = options.shadow ?? ShadowStyle.OUTER_DEFAULT_SM;
  }


  /**
   * 初始化BaseSheetOptions参数
   * @param options
   */
  static initBindSheetDefault(options: BaseSheetOptions) {
    options.uiContext = options.uiContext ?? DialogHelper.getMainUIContext();
    if (options.title) { //有标题，默认显示关闭图标
      options.showClose = options.showClose ?? true; //是否显示关闭图标，默认显示。
    } else { //有标题，默认不显示关闭图标
      options.showClose = options.showClose ?? false; //是否显示关闭图标，默认显示。
    }
    //半模态高度，默认是FIT_CONTENT。MEDIUM-指定半模态高度为屏幕高度一半。LARGE-指定半模态高度几乎为屏幕高度。FIT_CONTENT-指定半模态高度为适应内容的高度。
    options.height = options.height ?? SheetSize.FIT_CONTENT;
    //设置半模态页面的宽度。百分比参数方式：以父元素宽的百分比来设置半模态页面的宽度。
    options.width = options.width ?? '100%';
    //设置半模态页面的显示层级。默认值：SheetMode.OVERLAY。
    options.mode = options.mode ?? SheetMode.OVERLAY;
    //半模态页面的样式。BOTTOM-底部弹窗。CENTER-居中弹窗。POPUP-跟手弹窗。跟手弹窗面板不支持跟手滑动，下滑面板不关闭。
    options.preferType = options.preferType ?? SheetType.BOTTOM;
    //是否显示控制条。半模态面板的detents属性设置多个不同高度并且设置生效时，默认显示控制条。否则不显示控制条。
    options.dragBar = options.dragBar ?? true;
    //半模态所在页面是否允许交互。设置为true时允许交互，不显示蒙层；设置为false时不允许交互，显示蒙层；若不进行设置，默认底部弹窗与居中弹窗不允许交互，跟手弹窗允许交互。当设置为true时，maskColor设置无效。
    options.enableOutsideInteractive = options.enableOutsideInteractive ?? false;
    //设置半模态面板滑动时，内容区域刷新时机。默认值：ScrollSizeMode.FOLLOW_DETENT。
    options.scrollSizeMode = options.scrollSizeMode ?? ScrollSizeMode.FOLLOW_DETENT;
    //半模态面板的模糊背景。默认无模糊背景。
    options.blurStyle = options.blurStyle ?? ActionParameter.config.backgroundBlurStyle;
    //半模态页面的背景蒙层颜色。
    options.maskColor = options.maskColor ?? ActionParameter.config.maskColor;
    //设置半模态页面的边框宽度。可分别设置4个边框宽度。默认值：0。百分比参数方式：以父元素半模态页面宽的百分比来设置半模态页面的边框宽度。当半模态页面左边框和右边框大于半模态页面宽度，半模态页面上边框和下边框大于半模态页面高度，显示可能不符合预期。
    options.borderWidth = options.borderWidth ?? 0;
    //设置半模态页面的边框颜色。默认值：Color.Black。如果使用borderColor属性，需要和borderWidth属性一起使用。说明：底部弹窗时，底部边框颜色设置无效。
    options.borderColor = options.borderColor ?? Color.Black;
    //设置半模态页面的边框样式。默认值：BorderStyle.Solid。如果使用borderStyle属性，需要和borderWidth属性一起使用。说明：底部弹窗时，底部边框样式设置无效。
    options.borderStyle = options.borderStyle ?? BorderStyle.Solid;
  }


  /**
   * 初始化ToastTipOptions参数
   * @param options
   */
  static initToastTipDefault(options: ToastTipOptions) {
    options.uiContext = options.uiContext ?? DialogHelper.getMainUIContext();
    options.maskColor = Color.Transparent; //弹框自定义蒙层颜色。
    options.autoCancel = false; //点击遮障层时，是否关闭弹窗。
    options.isModal = false; //弹窗是否为模态窗口。
    options.backCancel = options.backCancel ?? ActionParameter.config.backCancel; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
    options.orientation = options.orientation ?? ActionParameter.config.toast_orientation; //吐司的布局方向。
    options.imageSize = options.imageSize ?? ActionParameter.config.toast_imageSize;
    options.duration = options.duration ?? ActionParameter.config.toast_duration;
    if (options.alignment || ActionParameter.config.alignment) {
      options.alignment = options.alignment ?? ActionParameter.config.alignment; //吐司的对齐方式。
    }
    let dy = options.offset?.dy; //dy-垂直方向上
    if (options.alignment == DialogAlignment.Top || options.alignment == DialogAlignment.TopStart ||
      options.alignment == DialogAlignment.TopEnd) {
      options.alignment = DialogAlignment.Top;
      options.offset = { dx: 0, dy: dy ?? 60 };
    } else if (options.alignment == DialogAlignment.Bottom || options.alignment == DialogAlignment.BottomStart ||
      options.alignment == DialogAlignment.BottomEnd) {
      options.alignment = DialogAlignment.Bottom;
      options.offset = { dx: 0, dy: dy ?? -60 };
    } else {
      options.alignment = DialogAlignment.Center;
      options.offset = { dx: 0, dy: dy ?? 0 };
    }
    options.showInSubWindow = options.showInSubWindow ?? ActionParameter.config.showInSubWindow; //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
    if (options.fontSize || ActionParameter.config.toast_fontSize) {
      options.fontSize = options.fontSize ?? ActionParameter.config.toast_fontSize; //文字大小。
    }
    if (options.fontColor || ActionParameter.config.toast_fontColor) {
      options.fontColor = options.fontColor ?? ActionParameter.config.toast_fontColor; //文字颜色。
    }
    if (options.backgroundColor || ActionParameter.config.toast_backgroundColor) {
      options.backgroundColor = options.backgroundColor ?? ActionParameter.config.toast_backgroundColor; //背景颜色，建议八位色值前两位为透明度。
    }
    if (options.borderRadius || ActionParameter.config.toast_borderRadius) {
      options.borderRadius = options.borderRadius ?? ActionParameter.config.toast_borderRadius; //背景圆角。
    }
    if (options.padding || ActionParameter.config.toast_padding) {
      options.padding = options.padding ?? ActionParameter.config.toast_padding; //Padding。
    }
  }


  /**
   * 初始化ToastOptions参数
   * @param options
   */
  static initToastDefault(options: ToastOptions, type: number = 0) {
    if (type == 2) {
      options.duration = options.duration ?? ActionParameter.config.toast_durationLong;
    } else if (type == 1) {
      options.duration = options.duration ?? ActionParameter.config.toast_durationShort;
    } else {
      options.duration = options.duration ?? ActionParameter.config.toast_duration;
    }
    options.uiContext = options.uiContext ?? DialogHelper.getMainUIContext();
    options.fontColor = options.fontColor ?? ActionParameter.config.toast_fontColor; //文字颜色。
    options.backgroundColor = options.backgroundColor ?? ActionParameter.config.toast_backgroundColor; //背景颜色，建议八位色值前两位为透明度。
    options.backgroundBlurStyle = options.backgroundBlurStyle ?? ActionParameter.config.toast_backgroundBlurStyle; //文本提示框背板模糊材质。默认值：BlurStyle.NON。说明：设置为BlurStyle.NONE即可关闭背景虚化。当设置了backgroundBlurStyle为非NONE值时，则不要设置backgroundColor，否则颜色显示将不符合预期效果。。
    options.shadow = options.shadow ?? ShadowStyle.OUTER_DEFAULT_MD; //文本提示框背板阴影。默认值：ShadowStyle.OUTER_DEFAULT_MD
    options.showMode = options.showMode ?? promptAction.ToastShowMode.DEFAULT; //设置弹窗是否显示在应用之上。默认值：ToastShowMode.DEFAULT，默认显示在应用内。
    options.bottom = options.bottom ?? "80vp"; //设置弹窗底部边框距离导航条的高度，ToastShowMode.TOP_MOST模式下，软键盘拉起时，如果bottom值过小，toast要被软键盘遮挡时，会自动避让至距离软键盘80vp处。ToastShowMode.DEFAULT模式下，软键盘拉起时，会上移软键盘的高度。默认值：80vp。说明：当底部没有导航条时，bottom为设置弹窗底部边框距离窗口底部的高度。设置对齐方式alignment后，bottom不生效。
    options.offset = options.offset ?? { dx: 0, dy: 0 }; //在对齐方式上的偏移。默认值：{ dx: 0, dy: 0 }，默认没有偏移。说明： 只支持设置px类型的数值，如需设置vp，可以将vp改成px传入。
    if (ActionParameter.config.toast_alignment) {
      options.alignment = options.alignment ?? ActionParameter.config.toast_alignment; //对齐方式。
    } else {
      options.alignment = options.alignment ?? Helper.getAlignment(ActionParameter.config.alignment); //对齐方式。默认值：undefined，默认底部偏上位置。
    }
    options.enableHoverMode = options.enableHoverMode ?? ActionParameter.config.enableHoverMode; //是否响应悬停态。默认值：false，默认不响应。<API14+>
    options.hoverModeArea = options.hoverModeArea ?? ActionParameter.config.hoverModeArea; //设置悬停态下弹窗的默认展示区域。默认值：HoverModeAreaType.BOTTOM_SCREEN。<API14+>
  }


  /**
   * 获取DialogAction
   */
  private static getDialogAction(action: number) {
    if (action == 0) {
      return DialogAction.ONE;
    } else if (action == 1) {
      return DialogAction.TWO;
    } else if (action == 2) {
      return DialogAction.THREE;
    } else if (action == 3) {
      return DialogAction.FOUR;
    } else if (action == 4) {
      return DialogAction.FIVE;
    } else {
      return DialogAction.SIX;
    }
  }


}