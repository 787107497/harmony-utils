import { BaseSheetOptions } from '@pura/harmony-dialog';
import { MenuBean } from './MenuBean';

//自定义半模态
export interface MenuSheetOptions extends BaseSheetOptions {

  menus: Array<MenuBean>;
  onItemClick: Callback<MenuBean>;

}