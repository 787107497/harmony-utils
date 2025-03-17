//number类型Callback
export declare type NumberCalBack = (index: number) => void;


//string类型Callback
export declare type StringCalBack = (content: string) => void;


/**
 * 弹框操作按钮Callback
 * action：
 * 1、当action小于0时，对应弹框操作按钮的Action，类型为DialogAction。
 * 2、当action大于等于0时，对选的是选项索引值。
 * dialogId: 对应弹框的id。
 * value: string 弹框内容回调，如输入框的输入内容。
 * value: string | string[] picker选中值
 * date: Date 选中日期 */
export declare type ActionCallBack = (action: number, dialogId: string) => void;
export declare type ActionStrCallBack = (action: number, dialogId: string, value: string) => void;
export declare type ActionValueCallBack = (action: number, dialogId: string, value: string | string[]) => void;
export declare type ActionDateCallBack = (action: number, dialogId: string, date: Date) => void;

//多行文本输入弹框Align
export enum TextAlignment { Top, Center, Bottom }


//弹框按钮的Action类型（从左往右，最多四个按钮）
export enum DialogAction {
  ONE = -1, //第一个按钮 - 取消。
  TWO = -2, //第二个按钮 - 确定。
  THREE = -3, //第三个按钮。
  FOUR = -4, //第四个按钮。
  FIVE = -5, //第五个按钮。
  SIX = -6, //第六个按钮。
  CANCEL = ONE, //第一个按钮 - 取消。
  SURE = TWO, //第二个按钮 - 确定。
}

//选择日期类型
export enum DateType {
  YmdHms, //年月日时分秒
  YmdHm, //年月日时分
  YmdH, //年月日时
  Ymd, //年月日
  Ym, //年月
  Y, //年
  Hms, //时分秒
  Hm, //时分
  Ms //分秒
}

export enum Orientation {
  VERTICAL, //垂直
  HORIZONTAL //水平
}

//系统深浅色模式切换监听
export const DialogThemeColorMode: string = "harmony-dialog_ThemeColorMode";