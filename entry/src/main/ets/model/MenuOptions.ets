import { BaseDialogOptions } from '@pura/harmony-dialog';
import { MenuBean } from './MenuBean';

//自定义底部弹框
export interface MenuOptions extends BaseDialogOptions {
  backgroundColor?: ResourceColor; //弹窗背板颜色。默认值：Color.Transparent
  backgroundBlurStyle?: BlurStyle; //弹窗背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK

  title: string;
  menus: Array<MenuBean>;
  onItemClick: Callback<MenuBean>;
}