import { AlertDialog,ConfirmDialog, CustomContentDialog, SelectDialog, TipsDialog } from '@kit.ArkUI'
import LoadingView from '../component/LoadingView'
import { BaseCustomContentOptions } from '../model/base/BaseCustomContentOptions'
import { DialogOptions } from '../model/base/DialogOptions'
import { LoadingOptions } from '../model/LoadingOptions'
import { ToastOptions } from '../model/ToastOptions'
import { ToastTipOptions } from '../model/ToastTipOptions'


/**
 * AlertDialog
 */
@Builder
export function AlertDialogBuilder(options: DialogOptions) {
  AlertDialog(options)
    .height(options.height)
    .width(options.width)
    .backgroundColor(options.backgroundColor)
    .backgroundBlurStyle(options.backgroundBlurStyle)
    .borderRadius(options.cornerRadius)
    .borderWidth(options.borderWidth)
    .borderColor(options.borderColor)
    .borderStyle(options.borderStyle)
}


/**
 * ConfirmDialog
 */
@Builder
export function ConfirmDialogBuilder(options: DialogOptions) {
  ConfirmDialog(options)
    .height(options.height)
    .width(options.width)
    .backgroundColor(options.backgroundColor)
    .backgroundBlurStyle(options.backgroundBlurStyle)
    .borderRadius(options.cornerRadius)
    .borderWidth(options.borderWidth)
    .borderColor(options.borderColor)
    .borderStyle(options.borderStyle)
}


/**
 * TipsDialog
 */
@Builder
export function TipsDialogBuilder(options: DialogOptions) {
  TipsDialog(options)
    .height(options.height)
    .width(options.width)
    .backgroundColor(options.backgroundColor)
    .backgroundBlurStyle(options.backgroundBlurStyle)
    .borderRadius(options.cornerRadius)
    .borderWidth(options.borderWidth)
    .borderColor(options.borderColor)
    .borderStyle(options.borderStyle)
}


/**
 * SelectDialog
 */
@Builder
export function SelectDialogBuilder(options: DialogOptions) {
  SelectDialog(options)
    .height(options.height)
    .width(options.width)
    .backgroundColor(options.backgroundColor)
    .backgroundBlurStyle(options.backgroundBlurStyle)
    .borderRadius(options.cornerRadius)
    .borderWidth(options.borderWidth)
    .borderColor(options.borderColor)
    .borderStyle(options.borderStyle)
}


/**
 * CustomContentDialog
 */
@Builder
export function CustomContentDialogBuilder(options: BaseCustomContentOptions) {
  CustomContentDialog(options)
    .height(options.height)
    .width(options.width)
    .backgroundColor(options.backgroundColor)
    .backgroundBlurStyle(options.backgroundBlurStyle)
    .borderRadius(options.cornerRadius)
    .borderWidth(options.borderWidth)
    .borderColor(options.borderColor)
    .borderStyle(options.borderStyle)
}


/**
 * LoadingDialog
 */
@Builder
export function LoadingBuilder(options: LoadingOptions) {
  LoadingView({ options: options })
}

/**
 * LoadingProgress
 */
@Builder
export function LoadingProgressBuilder(options: LoadingOptions) {
  LoadingView({ options: options })
}


/**
 * Toast
 */
@Builder
export function ToastBuilder(options: ToastOptions) {
  Column() {
    Text(options.message)
      .fontColor(options.fontColor)
      .fontSize(options.fontSize)
  }
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
  .align(Alignment.Center)
  .alignSelf(ItemAlign.Center)
  .constraintSize({ minWidth: 90 })
  .margin({ left: 15, right: 15 })
  .padding(options.padding)
  .backgroundColor(options.backgroundColor)
  .borderRadius(options.borderRadius)
}


/**
 * ToastTip
 */
@Builder
export function ToastTipBuilder(options: ToastTipOptions) {
  Column({ space: 10 }) {
    Image(options.imageRes)
      .size(options.imageSize)
      .fillColor(options.fontColor)
      .margin(5)
    Text(options.message)
      .fontColor(options.fontColor)
      .fontSize(options.fontSize)
  }
  .margin(12)
  .padding(20)
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
  .align(Alignment.Center)
  .alignSelf(ItemAlign.Center)
  .constraintSize({ minWidth: 120 })
  .backgroundColor(options.backgroundColor)
  .borderRadius(options.borderRadius)
}