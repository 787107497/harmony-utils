import { BaseDialogOptions } from '@pura/harmony-dialog';

//自定义弹框
export interface MyCustomOptions extends BaseDialogOptions {
  height: number; //高度
  msg: string;
}