/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-dialog
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
import { TextInputDialogView } from '../component/TextInputDialogView'
import { TextAreaDialogView } from '../component/TextAreaDialogView'
import { BottomSheetDialogView } from '../component/BottomSheetDialogView'
import { ActionSheetDialogView } from '../component/ActionSheetDialogView'
import { TextPickerDialogView } from '../component/TextPickerDialogView'
import { DatePickerDialogView } from '../component/DatePickerDialogView'
import { LoadingProgressView } from '../component/LoadingProgressView'
import { LoadingView } from '../component/LoadingView'
import { ToastTipView } from '../component/ToastTipView'
import { BaseContentOptions } from '../model/base/BaseContentOptions'
import { DialogOptions } from '../model/base/DialogOptions'
import { TextInputOptions } from '../model/TextInputOptions'
import { TextAreaOptions } from '../model/TextAreaOptions'
import { BottomSheetOptions } from '../model/BottomSheetOptions'
import { TextPickerOptions } from '../model/TextPickerOptions'
import { DateTimePickerOptions } from '../model/DateTimePickerOptions'
import { LoadingOptions } from '../model/LoadingOptions'
import { LoadingProgressOptions } from '../model/LoadingProgressOptions'
import { ToastTipOptions } from '../model/ToastTipOptions'


/**
 * AlertDialog
 */
@Builder
export function AlertDialogBuilder(options: DialogOptions) {
  AlertDialog(options)
    .height(options.height)
    .width(options.width)
    .constraintSize({ maxWidth: options.maxWidth, maxHeight: options.maxHeight })
    .backgroundColor(options.backgroundColor)
    .backgroundBlurStyle(options.backgroundBlurStyle)
    .borderRadius(options.cornerRadius)
    .borderWidth(options.borderWidth)
    .borderColor(options.borderColor)
    .borderStyle(options.borderStyle)
    .clip(true)
}


/**
 * ConfirmDialog
 */
@Builder
export function ConfirmDialogBuilder(options: DialogOptions) {
  ConfirmDialog(options)
    .height(options.height)
    .width(options.width)
    .constraintSize({ maxWidth: options.maxWidth, maxHeight: options.maxHeight })
    .backgroundColor(options.backgroundColor)
    .backgroundBlurStyle(options.backgroundBlurStyle)
    .borderRadius(options.cornerRadius)
    .borderWidth(options.borderWidth)
    .borderColor(options.borderColor)
    .borderStyle(options.borderStyle)
    .clip(true)
}


/**
 * TipsDialog
 */
@Builder
export function TipsDialogBuilder(options: DialogOptions) {
  TipsDialog(options)
    .height(options.height)
    .width(options.width)
    .constraintSize({ maxWidth: options.maxWidth, maxHeight: options.maxHeight })
    .backgroundColor(options.backgroundColor)
    .backgroundBlurStyle(options.backgroundBlurStyle)
    .borderRadius(options.cornerRadius)
    .borderWidth(options.borderWidth)
    .borderColor(options.borderColor)
    .borderStyle(options.borderStyle)
    .clip(true)
}


/**
 * SelectDialog
 */
@Builder
export function SelectDialogBuilder(options: DialogOptions) {
  SelectDialog(options)
    .height(options.height)
    .width(options.width)
    .constraintSize({ maxWidth: options.maxWidth, maxHeight: options.maxHeight })
    .backgroundColor(options.backgroundColor)
    .backgroundBlurStyle(options.backgroundBlurStyle)
    .borderRadius(options.cornerRadius)
    .borderWidth(options.borderWidth)
    .borderColor(options.borderColor)
    .borderStyle(options.borderStyle)
    .clip(true)
}


/**
 * CustomContentDialog
 */
@Builder
export function CustomContentDialogBuilder(options: BaseContentOptions) {
  CustomContentDialog(options)
    .height(options.height)
    .width(options.width)
    .constraintSize({ maxWidth: options.maxWidth, maxHeight: options.maxHeight })
    .backgroundColor(options.backgroundColor)
    .backgroundBlurStyle(options.backgroundBlurStyle)
    .borderRadius(options.cornerRadius)
    .borderWidth(options.borderWidth)
    .borderColor(options.borderColor)
    .borderStyle(options.borderStyle)
    .clip(true)
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
 * TextPickerDialog
 * @param options
 */
@Builder
export function TextPickerDialogBuilder(options: TextPickerOptions) {
  TextPickerDialogView({ options: options })
}


/**
 * DatePickerDialog
 * @param options
 */
@Builder
export function DatePickerDialogBuilder(options: DateTimePickerOptions) {
  DatePickerDialogView({ options: options });
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
 * ToastTip
 */
@Builder
export function ToastTipBuilder(options: ToastTipOptions) {
  ToastTipView({ options: options });
}