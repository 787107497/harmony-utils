import { BaseSheetOptions } from '@pura/harmony-dialog';

//文本/文本展示半模态
export interface TISheetOptions extends BaseSheetOptions {
  content: string | PixelMap | Resource;
}