import { ActionCallBack, BaseDialogOptions } from '@pura/harmony-dialog';

//自定义Tip弹框
export interface TipOptions extends BaseDialogOptions {
  backgroundColor?: ResourceColor; //弹窗背板颜色。默认值：Color.Transparent
  backgroundBlurStyle?: BlurStyle; //弹窗背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK

  title: string;
  content: string;
  onAction?: ActionCallBack; //按钮的CallBack事件。

}