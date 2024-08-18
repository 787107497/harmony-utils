import { DialogConfig } from '../entity/DialogConfig';
import { ButtonOptions,
  ConfirmDialogOptions,
  EasyDialogOptions,
  EasySheetOptions,
  OptionDialogOptions,
  PrimaryDialogOptions} from '../entity/DialogOptions';


/**
 * TODO 弹窗工具类（AlertDialog）
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class DialogUtil {

  private constructor() {}

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
    if (options.message == undefined) {
      options.title = '';
    }
    if (!options.confirm) {
      options.confirm = new ButtonOptions()
    }
    AlertDialog.show({
      title: options.title ?? DialogUtil.defaultConfig.title,
      subtitle: options.subtitle ?? DialogUtil.defaultConfig.subtitle,
      message: options.message,
      autoCancel: options.autoCancel ?? DialogUtil.defaultConfig.autoCancel,
      alignment: options.alignment ?? DialogUtil.defaultConfig.alignment,
      offset: options.offset ?? DialogUtil.defaultConfig.offset,
      gridCount: options.gridCount ?? DialogUtil.defaultConfig.gridCount,
      maskRect: options.maskRect ?? DialogUtil.defaultConfig.maskRect,
      showInSubWindow: options.showInSubWindow ?? DialogUtil.defaultConfig.showInSubWindow,
      isModal: options.isModal ?? DialogUtil.defaultConfig.isModal,
      backgroundColor: options.backgroundColor ?? DialogUtil.defaultConfig.backgroundColor,
      backgroundBlurStyle: options.backgroundBlurStyle ?? DialogUtil.defaultConfig.backgroundBlurStyle,
      onWillDismiss: options.onWillDismiss ?? DialogUtil.defaultConfig.onWillDismiss,
      cornerRadius: options.cornerRadius ?? DialogUtil.defaultConfig.cornerRadius,
      transition: options.transition ?? DialogUtil.defaultConfig.transition,
      width: options.width ?? DialogUtil.defaultConfig.width,
      height: options.height ?? DialogUtil.defaultConfig.height,
      borderWidth: options.borderWidth ?? DialogUtil.defaultConfig.borderWidth,
      borderColor: options.borderColor ?? DialogUtil.defaultConfig.borderColor,
      borderStyle: options.borderStyle ?? DialogUtil.defaultConfig.borderStyle,
      shadow: options.shadow ?? DialogUtil.defaultConfig.shadow,
      textStyle: options.textStyle ?? DialogUtil.defaultConfig.textStyle,
      confirm: options.confirm,
      cancel: () => {
        if (options.cancel) {
          options.cancel()
        }
      }
    })
  }


  /**
   * 两个按钮的AlertDialog（AlertDialogParamWithButtons）
   * @param options
   */
  static showPrimaryDialog(options: PrimaryDialogOptions) {
    if (options.message == undefined) {
      options.title = '';
    }
    if (!options.primaryButton) {
      options.primaryButton = new ButtonOptions()
    }
    if(!options.secondaryButton){
      options.secondaryButton = new ButtonOptions()
    }
    AlertDialog.show({
      title: options.title ?? DialogUtil.defaultConfig.title,
      subtitle: options.subtitle ?? DialogUtil.defaultConfig.subtitle,
      message: options.message,
      autoCancel: options.autoCancel ?? DialogUtil.defaultConfig.autoCancel,
      alignment: options.alignment ?? DialogUtil.defaultConfig.alignment,
      offset: options.offset ?? DialogUtil.defaultConfig.offset,
      gridCount: options.gridCount ?? DialogUtil.defaultConfig.gridCount,
      maskRect: options.maskRect ?? DialogUtil.defaultConfig.maskRect,
      showInSubWindow: options.showInSubWindow ?? DialogUtil.defaultConfig.showInSubWindow,
      isModal: options.isModal ?? DialogUtil.defaultConfig.isModal,
      backgroundColor: options.backgroundColor ?? DialogUtil.defaultConfig.backgroundColor,
      backgroundBlurStyle: options.backgroundBlurStyle ?? DialogUtil.defaultConfig.backgroundBlurStyle,
      onWillDismiss: options.onWillDismiss ?? DialogUtil.defaultConfig.onWillDismiss,
      cornerRadius: options.cornerRadius ?? DialogUtil.defaultConfig.cornerRadius,
      transition: options.transition ?? DialogUtil.defaultConfig.transition,
      width: options.width ?? DialogUtil.defaultConfig.width,
      height: options.height ?? DialogUtil.defaultConfig.height,
      borderWidth: options.borderWidth ?? DialogUtil.defaultConfig.borderWidth,
      borderColor: options.borderColor ?? DialogUtil.defaultConfig.borderColor,
      borderStyle: options.borderStyle ?? DialogUtil.defaultConfig.borderStyle,
      shadow: options.shadow ?? DialogUtil.defaultConfig.shadow,
      textStyle: options.textStyle ?? DialogUtil.defaultConfig.textStyle,
      primaryButton:options.primaryButton,
      secondaryButton:options.secondaryButton,
      cancel: () => {
        if (options.cancel) {
          options.cancel()
        }
      }
    })
  }

  /**
   * 多个按钮的AlertDialog（AlertDialogParamWithOptions）
   * @param options
   */
  static showDialog(options: OptionDialogOptions) {
    if (options.message == undefined) {
      options.title = '';
    }
    let btns = new Array<AlertDialogButtonOptions>()
    if (options.buttons && options.buttons.length > 0) {
      options.buttons.forEach(item => {
        btns.push({
          enabled: item.enabled,
          defaultFocus: item.defaultFocus,
          style: item.style,
          value: item.value,
          fontColor: item.fontColor,
          backgroundColor: item.backgroundColor,
          action: item.action
        })
      })
    }
    AlertDialog.show({
      title: options.title ?? DialogUtil.defaultConfig.title,
      subtitle: options.subtitle ?? DialogUtil.defaultConfig.subtitle,
      message: options.message,
      autoCancel: options.autoCancel ?? DialogUtil.defaultConfig.autoCancel,
      alignment: options.alignment ?? DialogUtil.defaultConfig.alignment,
      offset: options.offset ?? DialogUtil.defaultConfig.offset,
      gridCount: options.gridCount ?? DialogUtil.defaultConfig.gridCount,
      maskRect: options.maskRect ?? DialogUtil.defaultConfig.maskRect,
      showInSubWindow: options.showInSubWindow ?? DialogUtil.defaultConfig.showInSubWindow,
      isModal: options.isModal ?? DialogUtil.defaultConfig.isModal,
      backgroundColor: options.backgroundColor ?? DialogUtil.defaultConfig.backgroundColor,
      backgroundBlurStyle: options.backgroundBlurStyle ?? DialogUtil.defaultConfig.backgroundBlurStyle,
      onWillDismiss: options.onWillDismiss ?? DialogUtil.defaultConfig.onWillDismiss,
      cornerRadius: options.cornerRadius ?? DialogUtil.defaultConfig.cornerRadius,
      transition: options.transition ?? DialogUtil.defaultConfig.transition,
      width: options.width ?? DialogUtil.defaultConfig.width,
      height: options.height ?? DialogUtil.defaultConfig.height,
      borderWidth: options.borderWidth ?? DialogUtil.defaultConfig.borderWidth,
      borderColor: options.borderColor ?? DialogUtil.defaultConfig.borderColor,
      borderStyle: options.borderStyle ?? DialogUtil.defaultConfig.borderStyle,
      shadow: options.shadow ?? DialogUtil.defaultConfig.shadow,
      textStyle: options.textStyle ?? DialogUtil.defaultConfig.textStyle,
      buttons: btns,
      cancel: () => {
        if (options.cancel) {
          options.cancel()
        }
      }
    })
  }

  /**
   * 多个按钮的AlertDialog（AlertDialogParamWithOptions）
   * @param options
   */
  static showDialogEasy(options: EasyDialogOptions) {
    if (options.message == undefined) {
      options.title = '';
    }
    let btns = new Array<AlertDialogButtonOptions>()
    if (options.buttons && options.buttons.length > 0) {
      options.buttons.forEach((item, index) => {
        btns.push({
          value: item,
          action: () => {
            if (options.callBack) {
              options.callBack(index)
            }
          }
        })
      })
    }
    AlertDialog.show({
      title: options.title ?? DialogUtil.defaultConfig.title,
      subtitle: options.subtitle ?? DialogUtil.defaultConfig.subtitle,
      message: options.message,
      autoCancel: options.autoCancel ?? DialogUtil.defaultConfig.autoCancel,
      alignment: options.alignment ?? DialogUtil.defaultConfig.alignment,
      offset: options.offset ?? DialogUtil.defaultConfig.offset,
      gridCount: options.gridCount ?? DialogUtil.defaultConfig.gridCount,
      maskRect: options.maskRect ?? DialogUtil.defaultConfig.maskRect,
      showInSubWindow: options.showInSubWindow ?? DialogUtil.defaultConfig.showInSubWindow,
      isModal: options.isModal ?? DialogUtil.defaultConfig.isModal,
      backgroundColor: options.backgroundColor ?? DialogUtil.defaultConfig.backgroundColor,
      backgroundBlurStyle: options.backgroundBlurStyle ?? DialogUtil.defaultConfig.backgroundBlurStyle,
      onWillDismiss: options.onWillDismiss ?? DialogUtil.defaultConfig.onWillDismiss,
      cornerRadius: options.cornerRadius ?? DialogUtil.defaultConfig.cornerRadius,
      transition: options.transition ?? DialogUtil.defaultConfig.transition,
      width: options.width ?? DialogUtil.defaultConfig.width,
      height: options.height ?? DialogUtil.defaultConfig.height,
      borderWidth: options.borderWidth ?? DialogUtil.defaultConfig.borderWidth,
      borderColor: options.borderColor ?? DialogUtil.defaultConfig.borderColor,
      borderStyle: options.borderStyle ?? DialogUtil.defaultConfig.borderStyle,
      shadow: options.shadow ?? DialogUtil.defaultConfig.shadow,
      textStyle: options.textStyle ?? DialogUtil.defaultConfig.textStyle,
      buttons: btns,
      cancel: () => {
        if (options.cancel) {
          options.cancel()
        }
      }
    })
  }


  /**
   * 列表选择弹窗 (ActionSheet)
   * @param options
   */
  static showActionSheet(options: ActionSheetOptions) {
    if (options.message == undefined) {
      options.title = '';
    }
    let sheets = new Array<SheetInfo>()
    if (options.sheets && options.sheets.length > 0) {
      options.sheets.forEach(item => {
        sheets.push(item)
      })
    }
    ActionSheet.show({
      title: options.title ?? DialogUtil.defaultConfig.title,
      subtitle: options.subtitle ?? DialogUtil.defaultConfig.subtitle,
      message: options.message,
      autoCancel: options.autoCancel ?? DialogUtil.defaultConfig.autoCancel,
      alignment: options.alignment ?? DialogUtil.defaultConfig.alignment,
      offset: options.offset ?? DialogUtil.defaultConfig.offset,
      maskRect: options.maskRect ?? DialogUtil.defaultConfig.maskRect,
      showInSubWindow: options.showInSubWindow ?? DialogUtil.defaultConfig.showInSubWindow,
      isModal: options.isModal ?? DialogUtil.defaultConfig.isModal,
      backgroundColor: options.backgroundColor ?? DialogUtil.defaultConfig.backgroundColor,
      backgroundBlurStyle: options.backgroundBlurStyle ?? DialogUtil.defaultConfig.backgroundBlurStyle,
      onWillDismiss: options.onWillDismiss ?? DialogUtil.defaultConfig.onWillDismiss,
      cornerRadius: options.cornerRadius ?? DialogUtil.defaultConfig.cornerRadius,
      transition: options.transition ?? DialogUtil.defaultConfig.transition,
      width: options.width ?? DialogUtil.defaultConfig.width,
      height: options.height ?? DialogUtil.defaultConfig.height,
      borderWidth: options.borderWidth ?? DialogUtil.defaultConfig.borderWidth,
      borderColor: options.borderColor ?? DialogUtil.defaultConfig.borderColor,
      borderStyle: options.borderStyle ?? DialogUtil.defaultConfig.borderStyle,
      shadow: options.shadow ?? DialogUtil.defaultConfig.shadow,
      sheets: sheets,
      confirm: options.confirm,
      cancel: () => {
        if (options.cancel) {
          options.cancel()
        }
      }
    })
  }


/**
 * 简单易用的列表选择弹窗 (ActionSheet)
 * @param options
 */
  static showActionSheetEasy(options: EasySheetOptions) {
    if (options.message == undefined) {
      options.title = '';
    }
    let sheets = new Array<SheetInfo>()
    if (options.sheets && options.sheets.length > 0) {
      if (options.select) {
        let select = options.select
        options.sheets.forEach((item, index) => {
          sheets.push({
            title: item,
            icon: index == select.position ? select.selectIcon : select.defaultIcon,
            action: () => {
              if (options.callBack) {
                options.callBack(index)
              }
            }
          })
        })
      }else {
        options.sheets.forEach((item, index) => {
          sheets.push({
            title: item,
            action: () => {
              if (options.callBack) {
                options.callBack(index)
              }
            }
          })
        })
      }
    }
    ActionSheet.show({
      title: options.title ?? DialogUtil.defaultConfig.title,
      subtitle: options.subtitle ?? DialogUtil.defaultConfig.subtitle,
      message: options.message,
      autoCancel: options.autoCancel ?? DialogUtil.defaultConfig.autoCancel,
      alignment: options.alignment ?? DialogUtil.defaultConfig.alignment,
      offset: options.offset ?? DialogUtil.defaultConfig.offset,
      maskRect: options.maskRect ?? DialogUtil.defaultConfig.maskRect,
      showInSubWindow: options.showInSubWindow ?? DialogUtil.defaultConfig.showInSubWindow,
      isModal: options.isModal ?? DialogUtil.defaultConfig.isModal,
      backgroundColor: options.backgroundColor ?? DialogUtil.defaultConfig.backgroundColor,
      backgroundBlurStyle: options.backgroundBlurStyle ?? DialogUtil.defaultConfig.backgroundBlurStyle,
      onWillDismiss: options.onWillDismiss ?? DialogUtil.defaultConfig.onWillDismiss,
      cornerRadius: options.cornerRadius ?? DialogUtil.defaultConfig.cornerRadius,
      transition: options.transition ?? DialogUtil.defaultConfig.transition,
      width: options.width ?? DialogUtil.defaultConfig.width,
      height: options.height ?? DialogUtil.defaultConfig.height,
      borderWidth: options.borderWidth ?? DialogUtil.defaultConfig.borderWidth,
      borderColor: options.borderColor ?? DialogUtil.defaultConfig.borderColor,
      borderStyle: options.borderStyle ?? DialogUtil.defaultConfig.borderStyle,
      shadow: options.shadow ?? DialogUtil.defaultConfig.shadow,
      sheets: sheets,
      confirm: options.confirm,
      cancel: () => {
        if (options.cancel) {
          options.cancel()
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
    if (!options.backgroundColor) {
      options.backgroundColor = DialogUtil.defaultConfig.backgroundColor;
    }
    if (!options.backgroundBlurStyle) {
      options.backgroundBlurStyle = DialogUtil.defaultConfig.backgroundBlurStyle;
    }
    if (!options.shadow) {
      options.shadow = DialogUtil.defaultConfig.shadow;
    }
    CalendarPickerDialog.show(options)
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
   *  onDateChange:(value: Date) => void	滑动弹窗中的滑动选择器使当前选中项改变时触发该回调。
   *  onDateAccept:(value: Date) => void	点击弹窗中的“确定”按钮时触发该回调。
   *  onCancel:() => void	点击弹窗中的“取消”按钮时触发该回调。
   */
  static showDatePicker(options: DatePickerDialogOptions) {
    if (!options.alignment) {
      options.alignment = DialogUtil.defaultConfig.alignment;
    }
    if (!options.offset) {
      options.offset = DialogUtil.defaultConfig.offset;
    }
    if (!options.maskRect) {
      options.maskRect = DialogUtil.defaultConfig.maskRect;
    }
    if (!options.backgroundColor) {
      options.backgroundColor = DialogUtil.defaultConfig.backgroundColor;
    }
    if (!options.backgroundBlurStyle) {
      options.backgroundBlurStyle = DialogUtil.defaultConfig.backgroundBlurStyle;
    }
    if (!options.shadow) {
      options.shadow = DialogUtil.defaultConfig.shadow;
    }
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
    if (!options.alignment) {
      options.alignment = DialogUtil.defaultConfig.alignment;
    }
    if (!options.offset) {
      options.offset = DialogUtil.defaultConfig.offset;
    }
    if (!options.maskRect) {
      options.maskRect = DialogUtil.defaultConfig.maskRect;
    }
    if (!options.backgroundColor) {
      options.backgroundColor = DialogUtil.defaultConfig.backgroundColor;
    }
    if (!options.backgroundBlurStyle) {
      options.backgroundBlurStyle = DialogUtil.defaultConfig.backgroundBlurStyle;
    }
    if (!options.shadow) {
      options.shadow = DialogUtil.defaultConfig.shadow;
    }
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
    if (!options.alignment) {
      options.alignment = DialogUtil.defaultConfig.alignment;
    }
    if (!options.offset) {
      options.offset = DialogUtil.defaultConfig.offset;
    }
    if (!options.maskRect) {
      options.maskRect = DialogUtil.defaultConfig.maskRect;
    }
    if (!options.backgroundColor) {
      options.backgroundColor = DialogUtil.defaultConfig.backgroundColor;
    }
    if (!options.backgroundBlurStyle) {
      options.backgroundBlurStyle = DialogUtil.defaultConfig.backgroundBlurStyle;
    }
    if (!options.shadow) {
      options.shadow = DialogUtil.defaultConfig.shadow;
    }
    TextPickerDialog.show(options);
  }


}