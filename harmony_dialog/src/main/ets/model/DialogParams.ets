import { NumberCallback } from '../utils/CallBack';

export interface DialogParams {
  title: string,
  content: string,
  leftText: string,
  rightText: string,
  leftClick?: VoidCallback,
  rightClick?: () => void,
  action?: NumberCallback;
}

