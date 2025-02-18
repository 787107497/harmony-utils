/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-utils
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

import { DialogAction } from '../entity/constraint';
import { DialogConfig } from '../entity/DialogConfig';
import {
  ActionSheetOptions,
  ButtonOptions,
  ConfirmDialogOptions,
  DialogOptions,
  OptionDialogOptions,
  PrimaryDialogOptions,
  SheetConfirm
} from '../entity/DialogOptions';
import { ResUtil } from '../utils/ResUtil';


/**
 * TODO 弹窗工具类（AlertDialog）
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059
 */
export class DialogUtil {

  private static defaultConfig: DialogConfig = new DialogConfig(); //默认样式


  /**
   * 设置默认统一样式
   * @param configs
   */
  static setDefaultConfig(configs: (config: DialogConfig) => void): void {
    configs(DialogUtil.defaultConfig);
  }


  /**
   * 显示弹框（一个按钮的）
   * @param options
   */
  static showConfirmDialog(options: ConfirmDialogOptions) {
    DialogUtil.initDialogDefault(options);
    DialogUtil.initConfirmButton(options);
    AlertDialog.show({
      title: options.title,
      subtitle: options.subtitle,
      message: options.message,
      alignment: options.alignment,
      offset: options.offset,
      gridCount: options.gridCount,
      maskRect: options.maskRect,
      showInSubWindow: options.showInSubWindow,
      isModal: options.isModal,
      backgroundColor: options.backgroundColor,
      backgroundBlurStyle: options.backgroundBlurStyle,
      cornerRadius: options.cornerRadius,
      borderWidth: options.borderWidth,
      borderColor: options.borderColor,
      borderStyle: options.borderStyle,
      shadow: options.shadow,
      textStyle: options.textStyle,
      transition: options.transition,
      width: options.width,
      height: options.height,
      confirm: options.confirm as ButtonOptions,
      autoCancel: options.autoCancel,
      cancel: () => {
        if (options.cancel) {
          options.cancel()
        }
      },
      onWillDismiss: (action: DismissDialogAction) => {
        if (options.onWillDismiss) {
          options.onWillDismiss(action);
        } else {
          if (action.reason == DismissReason.PRESS_BACK && options.backCancel) {
            action.dismiss()
          } else if (action.reason == DismissReason.TOUCH_OUTSIDE && options.autoCancel) {
            action.dismiss()
          }
        }
      }
    })
  }


  /**
   * 两个按钮的AlertDialog（AlertDialogParamWithButtons）
   * @param options
   */
  static showPrimaryDialog(options: PrimaryDialogOptions) {
    DialogUtil.initDialogDefault(options);
    DialogUtil.initPrimaryButton(options);
    AlertDialog.show({
      title: options.title,
      subtitle: options.subtitle,
      message: options.message,
      alignment: options.alignment,
      offset: options.offset,
      gridCount: options.gridCount,
      maskRect: options.maskRect,
      showInSubWindow: options.showInSubWindow,
      isModal: options.isModal,
      backgroundColor: options.backgroundColor,
      backgroundBlurStyle: options.backgroundBlurStyle,
      cornerRadius: options.cornerRadius,
      borderWidth: options.borderWidth,
      borderColor: options.borderColor,
      borderStyle: options.borderStyle,
      shadow: options.shadow,
      textStyle: options.textStyle,
      transition: options.transition,
      width: options.width,
      height: options.height,
      primaryButton: options.primaryButton as ButtonOptions,
      secondaryButton: options.secondaryButton as ButtonOptions,
      autoCancel: options.autoCancel,
      cancel: () => {
        if (options.cancel) {
          options.cancel()
        }
      },
      onWillDismiss: (action: DismissDialogAction) => {
        if (options.onWillDismiss) {
          options.onWillDismiss(action);
        } else {
          if (action.reason == DismissReason.PRESS_BACK && options.backCancel) {
            action.dismiss()
          } else if (action.reason == DismissReason.TOUCH_OUTSIDE && options.autoCancel) {
            action.dismiss()
          }
        }
      }
    })
  }


  /**
   * 多个按钮的AlertDialog（AlertDialogParamWithOptions）
   * @param options
   */
  static showDialog(options: OptionDialogOptions) {
    DialogUtil.initDialogDefault(options);
    DialogUtil.initDialogButton(options);
    AlertDialog.show({
      title: options.title,
      subtitle: options.subtitle,
      message: options.message,
      alignment: options.alignment,
      offset: options.offset,
      gridCount: options.gridCount,
      maskRect: options.maskRect,
      showInSubWindow: options.showInSubWindow,
      isModal: options.isModal,
      backgroundColor: options.backgroundColor,
      backgroundBlurStyle: options.backgroundBlurStyle,
      cornerRadius: options.cornerRadius,
      borderWidth: options.borderWidth,
      borderColor: options.borderColor,
      borderStyle: options.borderStyle,
      shadow: options.shadow,
      textStyle: options.textStyle,
      transition: options.transition,
      width: options.width,
      height: options.height,
      buttons: options.buttons as Array<ButtonOptions>,
      autoCancel: options.autoCancel,
      cancel: () => {
        if (options.cancel) {
          options.cancel()
        }
      },
      onWillDismiss: (action: DismissDialogAction) => {
        if (options.onWillDismiss) {
          options.onWillDismiss(action);
        } else {
          if (action.reason == DismissReason.PRESS_BACK && options.backCancel) {
            action.dismiss()
          } else if (action.reason == DismissReason.TOUCH_OUTSIDE && options.autoCancel) {
            action.dismiss()
          }
        }
      }
    })
  }


  /**
   * 列表选择弹窗 (ActionSheet)
   * @param options
   */
  static showActionSheet(options: ActionSheetOptions) {
    DialogUtil.initDialogDefault(options);
    DialogUtil.initSheetOptions(options);
    ActionSheet.show({
      title: options.title,
      subtitle: options.subtitle,
      message: options.message,
      alignment: options.alignment,
      offset: options.offset,
      maskRect: options.maskRect,
      showInSubWindow: options.showInSubWindow,
      isModal: options.isModal,
      backgroundColor: options.backgroundColor,
      backgroundBlurStyle: options.backgroundBlurStyle,
      cornerRadius: options.cornerRadius,
      borderWidth: options.borderWidth,
      borderColor: options.borderColor,
      borderStyle: options.borderStyle,
      shadow: options.shadow,
      transition: options.transition,
      width: options.width,
      height: options.height,
      sheets: options.sheets as Array<SheetInfo>,
      confirm: options.confirm as SheetConfirm,
      autoCancel: options.autoCancel,
      cancel: () => {
        if (options.cancel) {
          options.cancel()
        }
      },
      onWillDismiss: (action: DismissDialogAction) => {
        if (options.onWillDismiss) {
          options.onWillDismiss(action);
        } else {
          if (action.reason == DismissReason.PRESS_BACK && DialogUtil.defaultConfig.backCancel) {
            action.dismiss()
          } else if (action.reason == DismissReason.TOUCH_OUTSIDE && options.autoCancel) {
            action.dismiss()
          }
        }
      }
    })
  }


  /**
   * 日历选择器弹窗
   * @param options
   *   selected 设置选中项的日期。
   *   options 描述日期选中态底板样式。 默认值：底板样式为圆形。
   *   hintRadius 为0，底板样式为直角矩形。hintRadius为0 ~ 16，底板样式为圆角矩形。hintRadius>=16，底板样式为圆形
   *   onChange:(value: Date) => void 选择弹窗中日期使当前选中项改变时触发该回调。value：选中的日期值。
   *   onAccept:(value: Date) => void 点击弹窗中的“确定”按钮时触发该回调。value：选中的日期值。
   *   onCancel:() => void 点击弹窗中的“取消”按钮时触发该回调。
   */
  static showCalendarPicker(options: CalendarDialogOptions) {
    options.backgroundColor = options.backgroundColor ?? DialogUtil.defaultConfig.backgroundColor;
    options.backgroundBlurStyle = options.backgroundBlurStyle ?? DialogUtil.defaultConfig.backgroundBlurStyle;
    options.shadow = options.shadow ?? DialogUtil.defaultConfig.shadow;
    CalendarPickerDialog.show(options);
  }


  /**
   * 日期滑动选择器弹窗 (DatePickerDialog)
   *  start 指定选择器的起始日期。 默认值：Date(‘1970-1-1’)
   *  end 指定选择器的结束日期。 默认值：Date(‘2100-12-31’)
   *  selected 设置选中项的日期。默认值：当前系统日期。从API version 10开始，该参数支持$$双向绑定变量
   *  lunar 日期是否显示为农历，true表示显示农历，false表示不显示农历。默认值：false
   *  showTime 是否展示时间项，true表示显示时间，false表示不显示时间。默认值：false
   *  useMilitaryTime 展示时间是否为24小时制，true表示显示24小时制，false表示显示12小时制。默认值：false。说明：当展示时间为12小时制时，上下午与小时无联动关系。
   *  lunarSwitch 是否展示切换农历的开关，true表示展示开关，false表示不展示开关。默认值：false
   *  onDateChange:(value: Date) => void  滑动弹窗中的滑动选择器使当前选中项改变时触发该回调。
   *  onDateAccept:(value: Date) => void  点击弹窗中的“确定”按钮时触发该回调。
   *  onCancel:() => void  点击弹窗中的“取消”按钮时触发该回调。
   */
  static showDatePicker(options: DatePickerDialogOptions) {
    options.alignment = options.alignment ?? DialogUtil.defaultConfig.alignment;
    options.offset = options.offset ?? DialogUtil.defaultConfig.offset;
    options.maskRect = options.maskRect ?? DialogUtil.defaultConfig.maskRect;
    options.backgroundColor = options.backgroundColor ?? DialogUtil.defaultConfig.backgroundColor;
    options.backgroundBlurStyle = options.backgroundBlurStyle ?? DialogUtil.defaultConfig.backgroundBlurStyle;
    options.shadow = options.shadow ?? DialogUtil.defaultConfig.shadow;
    DatePickerDialog.show(options);
  }


  /**
   * 时间滑动选择器弹窗 (TimePickerDialog)
   * @param options
   *  selected 设置选中项的时间。 默认值：当前系统时间。从API version 10开始，该参数支持$$双向绑定变量。
   *  format 指定需要显示的TimePicker的格式。 默认值：TimePickerFormat.HOUR_MINUTE（HOUR_MINUTE-按照小时和分显示、HOUR_MINUTE_SECOND-按照小时、分钟和秒显示。）
   *  useMilitaryTime 展示时间是否为24小时制，默认为12小时制。默认值：false。说明：当展示时间为12小时制时，上下午与小时无联动关系。
   *  onChange:(value: Date) => void 选择弹窗中日期使当前选中项改变时触发该回调。value：选中的日期值。
   *  onAccept:(value: Date) => void 点击弹窗中的“确定”按钮时触发该回调。value：选中的日期值。
   *  onCancel:() => void 点击弹窗中的“取消”按钮时触发该回调。
   */
  static showTimePicker(options: TimePickerDialogOptions) {
    options.alignment = options.alignment ?? DialogUtil.defaultConfig.alignment;
    options.offset = options.offset ?? DialogUtil.defaultConfig.offset;
    options.maskRect = options.maskRect ?? DialogUtil.defaultConfig.maskRect;
    options.backgroundColor = options.backgroundColor ?? DialogUtil.defaultConfig.backgroundColor;
    options.backgroundBlurStyle = options.backgroundBlurStyle ?? DialogUtil.defaultConfig.backgroundBlurStyle;
    options.shadow = options.shadow ?? DialogUtil.defaultConfig.shadow;
    TimePickerDialog.show(options);
  }


  /**
   * 文本滑动选择器弹窗 (TextPickerDialog)
   * @param options
   *  range 选择器的数据选择列表。不可设置为空数组，若设置为空数组，则不显示；若动态变化为空数组，则保持当前正常值显示。
   *        说明：单列数据选择器使用string[]，Resource，TextPickerRangeContent[]类型。
   *             多列数据选择器使用string[][]类型。多列联动数据选择器使用TextCascadePickerRangeContent[]类型。Resource类型只支持strarray.json。
   *  selected 设置默认选中项在数组中的索引值。默认值：0
   *           说明：单列数据选择器使用number类型。
   *                多列、多列联动数据选择器使用number[]类型。从API version 10开始，该参数支持$$双向绑定变量。
   *  value 设置默认选中项的值，优先级低于selected。默认值：第一个元素值
   *        说明：只有显示文本列表时该值有效。显示图片或图片加文本的列表时，该值无效。
   *             单列数据选择器使用string类型。多列、多列联动数据选择器使用string[]类型。从API version 10开始，该参数支持$$双向绑定变量。
   *  canLoop 设置是否可循环滚动，true：可循环，false：不可循环，默认值：true。
   *  onChange:(value: Date) => void 选择弹窗中日期使当前选中项改变时触发该回调。value：选中的日期值。
   *  onAccept:(value: Date) => void 点击弹窗中的“确定”按钮时触发该回调。value：选中的日期值。
   *  onCancel:() => void 点击弹窗中的“取消”按钮时触发该回调。
   */
  static showTextPicker(options: TextPickerDialogOptions) {
    options.alignment = options.alignment ?? DialogUtil.defaultConfig.alignment;
    options.offset = options.offset ?? DialogUtil.defaultConfig.offset;
    options.maskRect = options.maskRect ?? DialogUtil.defaultConfig.maskRect;
    options.backgroundColor = options.backgroundColor ?? DialogUtil.defaultConfig.backgroundColor;
    options.backgroundBlurStyle = options.backgroundBlurStyle ?? DialogUtil.defaultConfig.backgroundBlurStyle;
    options.shadow = options.shadow ?? DialogUtil.defaultConfig.shadow;
    TextPickerDialog.show(options);
  }


  /**
   * 初始化DialogOptions参数
   * @param options
   */
  private static initDialogDefault(options: DialogOptions) {
    options.title = options.title ?? DialogUtil.defaultConfig.title;
    options.subtitle = options.subtitle ?? DialogUtil.defaultConfig.subtitle;
    options.alignment = options.alignment ?? DialogUtil.defaultConfig.alignment;
    options.offset = options.offset ?? DialogUtil.defaultConfig.offset;
    options.gridCount = options.gridCount ?? DialogUtil.defaultConfig.gridCount;
    options.maskRect = options.maskRect ?? DialogUtil.defaultConfig.maskRect;
    options.showInSubWindow = options.showInSubWindow ?? DialogUtil.defaultConfig.showInSubWindow;
    options.isModal = options.isModal ?? DialogUtil.defaultConfig.isModal;
    options.backgroundColor = options.backgroundColor ?? DialogUtil.defaultConfig.backgroundColor;
    options.backgroundBlurStyle = options.backgroundBlurStyle ?? DialogUtil.defaultConfig.backgroundBlurStyle;
    options.cornerRadius = options.cornerRadius ?? DialogUtil.defaultConfig.cornerRadius;
    options.borderWidth = options.borderWidth ?? DialogUtil.defaultConfig.borderWidth;
    options.borderColor = options.borderColor ?? DialogUtil.defaultConfig.borderColor;
    options.borderStyle = options.borderStyle ?? DialogUtil.defaultConfig.borderStyle;
    options.shadow = options.shadow ?? DialogUtil.defaultConfig.shadow;
    options.textStyle = options.textStyle ?? DialogUtil.defaultConfig.textStyle;
    options.transition = options.transition ?? DialogUtil.defaultConfig.transition;
    options.width = options.width ?? DialogUtil.defaultConfig.width;
    options.height = options.height ?? DialogUtil.defaultConfig.height;
    options.autoCancel = options.autoCancel ?? DialogUtil.defaultConfig.autoCancel; //点击遮障层时，是否关闭弹窗。
    options.backCancel = options.backCancel ?? DialogUtil.defaultConfig.backCancel; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
  }


  /**
   * 一个按钮，初始化参数
   * @param options
   */
  private static initConfirmButton(options: ConfirmDialogOptions) {
    options.confirm = options.confirm ?? DialogUtil.defaultConfig.secondaryButton;
    let confirmValue = DialogUtil.getResourceStr(options.confirm);
    if (confirmValue) {
      options.confirm = {
        value: confirmValue,
        action: () => {
          if (options.onAction) {
            options.onAction(DialogAction.ONE);
          }
        }
      }
    } else {
      let confirmButton = options.confirm as ButtonOptions;
      let confirmAction = confirmButton.action;
      confirmButton.action = () => {
        if (options.onAction) {
          options.onAction(DialogAction.ONE);
        }
        if (confirmAction) {
          confirmAction();
        }
      }
    }
  }


  /**
   * 两个按钮，初始化参数
   * @param options
   */
  private static initPrimaryButton(options: PrimaryDialogOptions) {
    //当PrimaryButton和SecondaryButton同时为空时，使用默认按钮
    if (!options.primaryButton && !options.secondaryButton) {
      options.primaryButton = DialogUtil.defaultConfig.primaryButton
      options.secondaryButton = DialogUtil.defaultConfig.secondaryButton
    }
    if (options.primaryButton) {
      let primaryValue = DialogUtil.getResourceStr(options.primaryButton);
      if (primaryValue) {
        options.primaryButton = {
          value: primaryValue,
          action: () => {
            if (options.onAction) {
              options.onAction(DialogAction.ONE);
            }
          }
        }
      } else {
        let primaryButton = options.primaryButton as ButtonOptions;
        let primaryAction = primaryButton.action;
        primaryButton.action = () => {
          if (options.onAction) {
            options.onAction(DialogAction.ONE);
          }
          if (primaryAction) {
            primaryAction();
          }
        }
      }
    }
    if (options.secondaryButton) {
      let secondaryValue = DialogUtil.getResourceStr(options.secondaryButton);
      if (secondaryValue) {
        options.secondaryButton = {
          value: secondaryValue,
          action: () => {
            if (options.onAction) {
              options.onAction(DialogAction.TWO);
            }
          }
        }
      } else {
        let secondaryButton = options.secondaryButton as ButtonOptions;
        let secondaryAction = secondaryButton.action;
        secondaryButton.action = () => {
          if (options.onAction) {
            options.onAction(DialogAction.TWO);
          }
          if (secondaryAction) {
            secondaryAction();
          }
        }
      }
    }
  }


  /**
   * 多个按钮，初始化参数
   * @param options
   */
  private static initDialogButton(options: OptionDialogOptions) {
    if (!options.buttons) {
      options.buttons = [DialogUtil.defaultConfig.primaryButton, DialogUtil.defaultConfig.secondaryButton]
    }
    if (options.buttons && options.buttons.length > 0) {
      let button = DialogUtil.getResourceStr(options.buttons[0]);
      if (button) {
        let buttons = new Array<ButtonOptions>();
        for (let index = 0; index < options.buttons.length; index++) {
          let button: ButtonOptions = {
            value: options.buttons[index] as ResourceStr,
            action: () => {
              if (options.onAction) {
                options.onAction(DialogUtil.getDialogAction(index));
              }
            }
          }
          buttons.push(button);
        }
        options.buttons = buttons;
      } else {
        for (let index = 0; index < options.buttons.length; index++) {
          let btn = options.buttons[index] as ButtonOptions;
          let btnAction = btn.action;
          btn.action = () => {
            if (options.onAction) {
              options.onAction(DialogUtil.getDialogAction(index));
            }
            if (btnAction) {
              btnAction();
            }
          }
        }
      }
    }
  }


  /**
   * 选择类弹出框,参数
   * @param options
   */
  private static initSheetOptions(options: ActionSheetOptions) {
    if (options.sheets && options.sheets.length > 0) {
      let radioItem = DialogUtil.getResourceStr(options.sheets[0]);
      if (radioItem) {
        let sheetInfos = new Array<SheetInfo>()
        for (let index = 0; index < options.sheets.length; index++) {
          let sheetInfo: SheetInfo = {
            title: options.sheets[index] as ResourceStr,
            action: () => {
              if (options.onAction) {
                options.onAction(index);
              }
            }
          }
          sheetInfos.push(sheetInfo);
        }
        options.sheets = sheetInfos;
      } else {
        for (let index = 0; index < options.sheets.length; index++) {
          let btn = options.sheets[index] as SheetInfo;
          let btnAction = btn.action;
          btn.action = () => {
            if (options.onAction) {
              options.onAction(index);
            }
            if (btnAction) {
              btnAction();
            }
          }
        }
      }
    }
    if (!options.confirm) { //选择弹出框底部按钮。
      options.confirm = DialogUtil.defaultConfig.primaryButton
    }
    let confirmValue = DialogUtil.getResourceStr(options.confirm);
    if (confirmValue) {
      options.confirm = {
        value: confirmValue,
        action: () => {
          if (options.onAction) {
            options.onAction(DialogAction.ONE);
          }
        }
      }
    } else {
      let confirmButton = options.confirm as SheetConfirm;
      let confirmAction = confirmButton.action;
      confirmButton.action = () => {
        if (options.onAction) {
          options.onAction(DialogAction.ONE);
        }
        if (confirmAction) {
          confirmAction();
        }
      }
    }
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


  /**
   * 获取按钮的字符串
   * @param resource
   * @returns
   */
  private static getResourceStr(resource: ResourceStr | ButtonOptions | SheetInfo): string | undefined {
    try {
      if (typeof resource === 'string') {
        return resource;
      } else {
        return ResUtil.getStringSync((resource as Resource).id);
      }
    } catch (e) {
      return undefined;
    }
  }


}