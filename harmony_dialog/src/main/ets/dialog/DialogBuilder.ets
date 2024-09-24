/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-dialog https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { AlertDialog, ConfirmDialog, CustomContentDialog, SelectDialog, TipsDialog } from '@kit.ArkUI'
import TextInputDialogView from '../component/TextInputDialogView'
import TextAreaDialogView from '../component/TextAreaDialogView'
import LoadingProgressView from '../component/LoadingProgressView'
import LoadingView from '../component/LoadingView'
import { BaseContentOptions } from '../model/base/BaseContentOptions'
import { DialogOptions } from '../model/base/DialogOptions'
import { TextInputOptions } from '../model/TextInputOptions'
import { TextAreaOptions } from '../model/TextAreaOptions'
import { LoadingOptions } from '../model/LoadingOptions'
import { LoadingProgressOptions } from '../model/LoadingProgressOptions'
import { ToastOptions } from '../model/ToastOptions'
import { ToastTipOptions } from '../model/ToastTipOptions'
import { BottomSheetOptions } from '../model/BottomSheetOptions'
import BottomSheetDialogView from '../component/BottomSheetDialogView'
import ActionSheetDialogView from '../component/ActionSheetDialogView'


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
export function CustomContentDialogBuilder(options: BaseContentOptions) {
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
 * TextInputDialog
 * @param options
 */
@Builder
export function TextInputDialogBuilder(options: TextInputOptions) {
  TextInputDialogView({ options: options });
}


/**
 * TextAreaDialog
 * @param options
 */
@Builder
export function TextAreaDialogBuilder(options: TextAreaOptions) {
  TextAreaDialogView({ options: options });
}


/**
 * BottomSheetDialog
 * @param options
 */
@Builder
export function BottomSheetDialogBuilder(options: BottomSheetOptions) {
  BottomSheetDialogView({ options: options });
}


/**
 * ActionSheetDialog
 * @param options
 */
@Builder
export function ActionSheetDialogBuilder(options: BottomSheetOptions) {
  ActionSheetDialogView({ options: options });
}


/**
 * LoadingDialog
 */
@Builder
export function LoadingBuilder(options: LoadingOptions) {
  LoadingView({ options: options });
}


/**
 * LoadingProgress
 */
@Builder
export function LoadingProgressBuilder(options: LoadingProgressOptions) {
  LoadingProgressView({ options: options });
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
  .shadow(ShadowStyle.OUTER_DEFAULT_SM)
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
  .shadow(ShadowStyle.OUTER_DEFAULT_SM)
}