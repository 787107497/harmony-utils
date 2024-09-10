import { BaseDialogOptions } from '@pura/harmony-dialog';

//自定义弹框
export interface DrawerOptions extends BaseDialogOptions {
  width: number; //宽度
  msg: string;
}