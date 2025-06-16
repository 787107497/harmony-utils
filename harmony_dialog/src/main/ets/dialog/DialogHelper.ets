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

import {
  ActionSheetDialogBuilder,
  AlertDialogBuilder,
  BottomSheetDialogBuilder,
  ConfirmDialogBuilder,
  CustomContentDialogBuilder,
  DatePickerDialogBuilder,
  LoadingBuilder,
  LoadingProgressBuilder,
  SelectDialogBuilder,
  TextAreaDialogBuilder,
  TextInputDialogBuilder,
  TextPickerDialogBuilder,
  TipsDialogBuilder,
  ToastTipBuilder
} from './DialogBuilder';
import { ActionBaseCore } from './ActionBaseCore';
import { TipsOptions } from '../model/TipsOptions';
import { DialogConfig } from '../model/DialogConfig';
import { ConfirmOptions } from '../model/ConfirmOptions';
import { AlertOptions } from '../model/AlertOptions';
import { CustomContentOptions } from '../model/CustomContentOptions';
import { BaseDialogOptions } from '../model/base/BaseDialogOptions';
import { LoadingOptions } from '../model/LoadingOptions';
import { ToastOptions } from '../model/ToastOptions';
import { ToastTipOptions } from '../model/ToastTipOptions';
import { SelectOptions } from '../model/SelectOptions';
import { LoadingProgressOptions } from '../model/LoadingProgressOptions';
import { TextInputOptions as TextInputOptions } from '../model/TextInputOptions';
import { TextAreaOptions } from '../model/TextAreaOptions';
import { BottomSheetOptions } from '../model/BottomSheetOptions';
import { UIContext, window } from '@kit.ArkUI';
import { TextPickerOptions } from '../model/TextPickerOptions';
import { DateTimePickerOptions } from '../model/DateTimePickerOptions';
import { CacheHelper } from '../utils/CacheHelper';
import { BaseSheetOptions } from '../model/base/BaseSheetOptions';
import { common } from '@kit.AbilityKit';
import { ActionParameter } from './ActionParameter';

/**
 * TODO Dialog帮助工具类（全局自定义弹框，不依赖UI组件）
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 */
export class DialogHelper {

  private static mainUIContext: UIContext | undefined; //MainWindow的UIContext


  /**
   * 设置默认统一样式
   * @param configs
   */
  static setDefaultConfig(configs: (config: DialogConfig) => void): void {
    configs(ActionParameter.config);
  }


  /**
   * 获取UIAbilityContext
   * @returns
   */
  static getUIAbilityContext(): common.UIAbilityContext {
    if (ActionParameter.config?.uiAbilityContext) {
      return ActionParameter.config?.uiAbilityContext;
    }
    return getContext() as common.UIAbilityContext; //兜底
  }


  /**
   * 获取MainWindow的UIContext
   * @returns
   */
  static getMainUIContext(): UIContext | undefined {
    if (DialogHelper.mainUIContext) {
      return DialogHelper.mainUIContext;
    }
    const uiContext = DialogHelper.getUIAbilityContext().windowStage.getMainWindowSync().getUIContext();
    if (uiContext) {
      DialogHelper.mainUIContext = uiContext;
    }
    return DialogHelper.mainUIContext;
  }


  /**
   * 获取当前应用内最上层的子窗口的UIContext
   * @returns
   */
  static async getLastUIContext(): Promise<UIContext> {
    const lastWindow = await window.getLastWindow(DialogHelper.getUIAbilityContext());
    return lastWindow.getUIContext();
  }


  /**
   * 生成弹框id
   */
  static generateId() {
    return ActionBaseCore.getInstance().generateDialogId();
  }


  /**
   * 显示操作确认类弹出框
   * @param options
   */
  static showAlertDialog(options: AlertOptions): string {
    ActionParameter.initBaseDefault(options);
    ActionParameter.initDialogDefault(options);
    ActionParameter.initAlertTitle(options);
    ActionParameter.initPrimarySecondaryButton(options);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(AlertDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示信息确认类弹出框
   * @param options
   */
  static showConfirmDialog(options: ConfirmOptions): string {
    ActionParameter.initBaseDefault(options);
    ActionParameter.initDialogDefault(options);
    ActionParameter.initPrimarySecondaryButton(options);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(ConfirmDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示提示弹出框，即为带图形确认框
   * @param options
   */
  static showTipsDialog(options: TipsOptions): string {
    ActionParameter.initBaseDefault(options);
    ActionParameter.initDialogDefault(options);
    ActionParameter.initPrimarySecondaryButton(options);
    ActionParameter.initImageResSize(options);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(TipsDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示选择类弹出框
   * @param options
   */
  static showSelectDialog(options: SelectOptions): string {
    ActionParameter.initBaseDefault(options);
    ActionParameter.initDialogDefault(options);
    ActionParameter.initSelect(options);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(SelectDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示单行文本输入弹框
   * @param options
   * @returns
   */
  static showTextInputDialog(options: TextInputOptions): string {
    ActionParameter.initBaseDefault(options);
    ActionParameter.initDialogDefault(options);
    ActionParameter.initAlertTitle(options);
    ActionParameter.initButtons(options, true);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(TextInputDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示多行文本输入弹框
   * @param options
   * @returns
   */
  static showTextAreaDialog(options: TextAreaOptions): string {
    ActionParameter.initBaseDefault(options);
    ActionParameter.initDialogDefault(options);
    ActionParameter.initAlertTitle(options);
    ActionParameter.initButtons(options, true);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(TextAreaDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示自定义内容区弹出框，同时支持定义操作区按钮样式。
   */
  static showCustomContentDialog(options: CustomContentOptions): string {
    ActionParameter.initBaseDefault(options);
    ActionParameter.initDialogDefault(options);
    ActionParameter.initAlertTitle(options);
    ActionParameter.initButtons(options, false);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(CustomContentDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示动作面板
   */
  static showBottomSheetDialog(options: BottomSheetOptions): string {
    ActionParameter.initBaseDefault(options);
    ActionParameter.initBottomSheetDefault(options, true);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(BottomSheetDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示动作面板（IOS风格）
   */
  static showActionSheetDialog(options: BottomSheetOptions): string {
    ActionParameter.initBaseDefault(options);
    ActionParameter.initBottomSheetDefault(options, false);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(ActionSheetDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示选择器弹框；入参参考TextPicker组件
   * @param options
   * @returns
   */
  static showTextPickerDialog(options: TextPickerOptions): string {
    ActionParameter.initBaseDefault(options);
    ActionParameter.initTextPickerDefault(options);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(TextPickerDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示日期选择器弹框
   * @param options
   * @returns
   */
  static showDatePickerDialog(options: DateTimePickerOptions): string {
    ActionParameter.initBaseDefault(options);
    ActionParameter.initTextPickerDefault(options);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(DatePickerDialogBuilder), options);
    return dialogId;
  }


  /**
   * 显示自定义弹窗
   * @param builder 自定义弹窗中显示的组件内容
   * @param options
   */
  static showCustomDialog<T extends BaseDialogOptions>(builder: WrappedBuilder<[T]>, options: T): string {
    ActionParameter.initBaseDefault(options);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(builder, options);
    return dialogId;
  }


  /**
   * 刷新自定义弹窗
   */
  static update<T extends BaseDialogOptions>(dialogId: string, options: T) {
    ActionBaseCore.getInstance().update(dialogId, options);
  }


  /**
   * 当前弹窗是否显示
   * @param dialogId 目前弹框id
   */
  static isShowing(dialogId: string): boolean {
    return ActionBaseCore.getInstance().exist(dialogId);
  }


  /**
   * 关闭弹框
   * @param dialogId 目前弹框id
   */
  static closeDialog(dialogId: string) {
    ActionBaseCore.getInstance().closeCustomDialog(dialogId);
  }


  /**
   * 显示进度加载类弹出框
   */
  static showLoadingDialog(options?: LoadingOptions) {
    options = options ?? {};
    ActionParameter.initLoadingDefault(options);
    let dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(LoadingBuilder), options);
    CacheHelper.put(`${CacheHelper.CACHE_LABEL}${dialogId}`, options); //缓存加载框options
    return dialogId;
  }


  /**
   * 显示进度条加载弹框
   */
  static showLoadingProgress(options: LoadingProgressOptions): string {
    ActionParameter.initLoadingDefault(options);
    const dialogId = ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(LoadingProgressBuilder), options);
    CacheHelper.put(`${CacheHelper.CACHE_LABEL}${dialogId}`, options); //缓存加载框options
    return dialogId;
  }


  /**
   * 刷新加载弹框
   */
  static updateLoading(dialogId: string, content?: string, progress?: number) {
    if (DialogHelper.isShowing(dialogId)) {
      let cacheOptions = CacheHelper.get<LoadingProgressOptions>(`${CacheHelper.CACHE_LABEL}${dialogId}`);
      if (cacheOptions) {
        if (content && content.length >= 0) {
          cacheOptions.content = content;
        }
        if (progress && progress >= 0) {
          cacheOptions.progress = progress;
        }
        DialogHelper.update(dialogId, cacheOptions);
      }
    }
  }


  /**
   * 显示自定义半模态
   * @param wrappedBuilder 自定义半模态中显示的组件内容
   * @param options
   * @returns
   */
  static showBindSheet<T extends BaseSheetOptions>(wrappedBuilder: WrappedBuilder<[T]>, options: T): string {
    ActionParameter.initBindSheetDefault(options);
    const dialogId = ActionBaseCore.getInstance().openBindSheet(wrappedBuilder, options);
    return dialogId;
  }


  /**
   * 刷新自定义半模态
   */
  static updateBindSheet<T extends BaseSheetOptions>(dialogId: string, options: T, partialUpdate: boolean = false) {
    ActionBaseCore.getInstance().updateBindSheet(dialogId, options, partialUpdate);
  }


  /**
   * 关闭半模态
   * @param dialogId 目前半模态id
   */
  static closeBindSheet(dialogId: string) {
    ActionBaseCore.getInstance().closeBindSheet(dialogId);
  }


  /**
   * 显示吐司
   * @param message 吐司内容
   * @param options
   */
  static showToast(message: string | Resource, options?: ToastOptions) {
    options = options ?? {};
    options.message = message;
    ActionParameter.initToastDefault(options);
    ActionBaseCore.getInstance().showToast(options);
  }


  /**
   * 显示长吐司
   * @param message 吐司内容
   * @param options
   */
  static showToastLong(message: string | Resource, options?: ToastOptions) {
    options = options ?? {};
    options.message = message;
    ActionParameter.initToastDefault(options, 2);
    ActionBaseCore.getInstance().showToast(options);
  }


  /**
   * 显示长吐司
   * @param message 吐司内容
   * @param options
   */
  static showToastShort(message: string | Resource, options?: ToastOptions) {
    options = options ?? {};
    options.message = message;
    ActionParameter.initToastDefault(options, 1);
    ActionBaseCore.getInstance().showToast(options);
  }


  /**
   * 显示带图形吐司
   * @param options
   */
  static showToastTip(options: ToastTipOptions) {
    ActionParameter.initToastTipDefault(options);
    options.dialogId = DialogHelper.generateId();
    ActionBaseCore.getInstance().openCustomDialog(wrapBuilder(ToastTipBuilder), options);
    let timeID = setTimeout(() => {
      DialogHelper.closeDialog(options.dialogId ?? "");
      clearTimeout(timeID);
    }, options.duration);
  }



}