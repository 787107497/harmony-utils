export interface DialogParams {
  title: string,
  content: string,
  leftText: string,
  rightText: string,
  leftClick?: () => void,
  rightClick?: () => void,
}