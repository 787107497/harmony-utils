import { Decimal } from '@kit.ArkTS';


export const DATE_FORMAT1: string = "yyyy-MM-dd HH:mm:ss"; //2025-01-05 14:06:55

export const DATE_FORMAT2: string = "yyyy-MM-dd HH:mm"; //2025-01-05 14:06

export const DATE_FORMAT3: string = "yyyy-MM-dd HH"; //2025-01-05 14

export const DATE_FORMAT4: string = "yyyy-MM-dd"; //2025-01-05

export const DATE_FORMAT5: string = "HH:mm:ss"; //14:06:55

export const DATE_FORMAT6: string = "HH:mm"; //14:06

export const DATE_FORMAT7: string = "yyyy/MM/dd HH:mm:ss"; //2025/01/05 14:06:55

export const DATE_FORMAT8: string = "yyyy/MM/dd HH:mm"; //2025/01/05 14:06

export const DATE_FORMAT9: string = "yyyy/MM/dd HH"; //2025/01/05 14

export const DATE_FORMAT10: string = "yyyy/MM/dd"; //2025/01/05

export const DATE_FORMAT11: string = "yyyy年MM月dd日 HH时mm分ss秒fff毫秒"; //2025年01月05日 14时06分55秒135毫秒

export const DATE_FORMAT12: string = "yyyy年MM月dd日 HH时mm分ss秒"; //2025年01月05日 14时06分55秒

export const DATE_FORMAT13: string = "yyyy年MM月dd日 HH时mm分"; //2025年01月05日 14时06分

export const DATE_FORMAT14: string = "yyyy年MM月dd日 HH时"; //2025年01月05日 14时

export const DATE_FORMAT15: string = "yyyy年MM月dd日"; //2025年01月05日

export const DATE_FORMAT16: string = "HH时mm分ss秒"; //14时06分55秒

export const DATE_FORMAT17: string = "HH时mm分"; //14时06分


export const DEVICE_ID_KEY: string = "device_id_cache_harmony_key"; //设备ID的Key

export const DEFAULT_PREFERENCE_NAME: string = "SP_HARMONY_UTILS_PREFERENCES"; //Preferences实例的名称。


/**
 * 弹框操作按钮Callback
 * action：
 * 1、当action小于0时，对应弹框操作按钮的Action，类型为DialogAction。
 * 2、当action大于等于0时，对选的是选项索引值。
 */
export declare type ActionCallBack = (action: number) => void;

//KeyboardUtil回调
export declare type KeyboardCallBack = (show: boolean, height: number) => void;



export type Any = number | string | boolean | object | undefined | null;

export type Value = string | number | Decimal;



//弹框按钮的Action类型（从左往右，最多四个按钮）
export enum DialogAction {
  ONE = -1, //第一个按钮 - 取消。
  TWO = -2, //第二个按钮 - 确定。
  THREE = -3, //第三个按钮。
  FOUR = -4, //第四个按钮。
  FIVE = -5, //第五个按钮。
  SIX = -6 //第六个按钮。
}


//网络类型。
export enum NetworkType {
  NETWORK_TYPE_UNKNOWN = 0,
  NETWORK_TYPE_WIFI = 1,
  NETWORK_TYPE_2G = 2,
  NETWORK_TYPE_3G = 3,
  NETWORK_TYPE_4G = 4,
  NETWORK_TYPE_5G = 5
}

