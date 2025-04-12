import { BaseSheetOptions } from '@pura/harmony-dialog';

//文本展示半模态
export interface TextSheetOptions extends BaseSheetOptions {
  content: string;
}