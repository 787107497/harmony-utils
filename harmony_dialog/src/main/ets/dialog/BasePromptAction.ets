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

import { ComponentContent, promptAction, window } from '@kit.ArkUI';
import { BaseDialogOptions } from '../model/base/BaseDialogOptions';
import { PromptActionArg } from '../model/base/PromptActionArg';
import { BusinessError } from '@kit.BasicServicesKit';
import { CacheHelper } from '../utils/CacheHelper';
import { ToastOptions } from '../model/ToastOptions';


/**
 * TODO PromptAction基类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 1029219059
 */
export class BasePromptAction {
  private static instance: BasePromptAction;
  private caches: Array<PromptActionArg> = new Array<PromptActionArg>();


  private constructor() {

  }


  static getInstance(): BasePromptAction {
    if (!BasePromptAction.instance) {
      BasePromptAction.instance = new BasePromptAction();
    }
    return BasePromptAction.instance;
  }


  /**
   * 创建并弹出dialogContent对应的自定义弹窗
   * @param contentView 自定义弹窗中显示的组件内容。
   * @param options 弹窗样式。
   */
  showToast(options: ToastOptions) {
    const showToastOptions: promptAction.ShowToastOptions = {
      message: options.message ?? "",
      duration: options.duration, //默认值1500ms，取值区间：1500ms-10000ms。若小于1500ms则取默认值，若大于10000ms则取上限值10000ms。
      textColor: options.fontColor ?? Color.Black, // 文本提示框文本颜色。默认值：Color.Black
      bottom: options.bottom ?? "80vp", //设置弹窗底部边框距离导航条的高度。默认值：80vp。
      alignment: options.alignment, //对齐方式。默认值：undefined，默认底部偏上位置。
      offset: options.offset ?? { dx: 0, dy: 0 }, //在对齐方式上的偏移。默认值：{ dx: 0, dy: 0 }，默认没有偏移。说明： 只支持设置px类型的数值，如需设置vp，可以将vp改成px传入。
      backgroundColor: options.backgroundColor, //文本提示框背板颜色，建议八位色值前两位为透明度。默认值：Color.Transparent。
      backgroundBlurStyle: options.backgroundBlurStyle ?? BlurStyle.COMPONENT_ULTRA_THICK, //文本提示框背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK。
      shadow: options.shadow ?? ShadowStyle.OUTER_DEFAULT_MD, //文本提示框背板阴影。默认值：ShadowStyle.OUTER_DEFAULT_MD
      showMode: options.showMode, //设置弹窗是否显示在应用之上。默认值：ToastShowMode.DEFAULT，默认显示在应用内。
    }
    if (options.uiContext) {
      options.uiContext.getPromptAction().showToast(showToastOptions);
    } else {
      window.getLastWindow(getContext()).then((result: window.Window) => {
        result.getUIContext().getPromptAction().showToast(showToastOptions);
      })
    }
  }



  /**
   * 创建并弹出dialogContent对应的自定义弹窗
   * @param contentView 自定义弹窗中显示的组件内容。
   * @param options 弹窗样式。
   */
  openCustomDialog<T extends BaseDialogOptions>(contentView: WrappedBuilder<[T]>, options: T): string {
    if (!options.dialogId) {
      options.dialogId = this.generateDialogId();
    }
    if (options.uiContext) {
      this.openBaseCustomDialog(options.uiContext, contentView, options);
    } else {
      window.getLastWindow(getContext()).then((result: window.Window) => {
        this.openBaseCustomDialog(result.getUIContext(), contentView, options);
      })
    }
    return options.dialogId;
  }


  /**
   * 创建并弹出dialogContent对应的自定义弹窗
   * @param uiContext UIContext。
   * @param wrappedBuilder 自定义弹窗中显示的组件内容。
   * @param options 弹窗样式。
   */
  private openBaseCustomDialog<T extends BaseDialogOptions>(uiContext: UIContext, wrappedBuilder: WrappedBuilder<[T]>, options: T) {
    if (!this.exist(options.dialogId ?? "")) { //判断dialogId是否存在
      const componentContent = new ComponentContent(uiContext, wrappedBuilder, options);
      const option: promptAction.BaseDialogOptions = {
        alignment: options.alignment, //弹窗的对齐方式。
        offset: options.offset, //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0, dy: 0 }
        maskRect: options.maskRect, //弹窗遮蔽层区域，在遮蔽层区域内的事件不透传，在遮蔽层区域外的事件透传。
        maskColor: options.maskColor, //自定义蒙层颜色。默认值 0x33000000
        isModal: options.isModal, //弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层。默认值：true，此时弹窗有蒙层。
        showInSubWindow: options.showInSubWindow, //某弹框需要显示在主窗口之外时，是否在子窗口显示此弹窗。
        autoCancel: options.autoCancel, //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹窗。默认值：true
        keyboardAvoidMode: options.keyboardAvoidMode, //用于设置弹窗是否在拉起软键盘时进行自动避让。默认值：KeyboardAvoidMode.DEFAULT
        transition: options.transition, //设置弹窗显示和退出的过渡效果。
        onWillAppear: options.onWillAppear, //弹窗显示动效前的事件回调。
        onWillDisappear: options.onWillDisappear, //弹窗退出动效前的事件回调。
        onDidAppear: options.onDidAppear, //弹窗弹出时的事件回调。
        onDidDisappear: () => { //弹窗消失时的事件回调。
          this.removeArg(options.dialogId ?? ''); //弹窗关闭时，移除
          this.onDestroy(options.dialogId ?? '');
          if (options.onDidDisappear) {
            options.onDidDisappear();
          }
        },
         //交互式关闭回调函数。
        onWillDismiss: (action: DismissDialogAction) => {
          if (options.onWillDismiss) {
            options.onWillDismiss(action);
          }else {
            if (action.reason == DismissReason.PRESS_BACK && options.backCancel) {
              action.dismiss();
            } else if (action.reason == DismissReason.TOUCH_OUTSIDE && options.autoCancel) {
              action.dismiss();
            }
          }
        },
      }
      this.addArg(options.dialogId ?? "", uiContext, componentContent); //显示弹框时，添加
      const promptAction = uiContext.getPromptAction();
      promptAction.openCustomDialog(componentContent, option);
    } else {
      console.error(`该弹框已存在，dialogId：${options.dialogId}`);
    }
  }


  /**
   * 关闭已弹出的dialogContent对应的自定义弹窗
   * @param dialogId
   */
  closeCustomDialog(dialogId: string) {
    try {
      const promptActionArg = this.getArgById(dialogId);
      if (promptActionArg && promptActionArg.uiContext) {
        const promptAction = promptActionArg.uiContext.getPromptAction();
        const componentContent = promptActionArg.componentContent;
        if (componentContent) {
          promptAction.closeCustomDialog(componentContent).then(() => {
            componentContent.dispose(); //立即释放当前ComponentContent
          });
        }
      }
    } catch (e) {
      const error = e as BusinessError;
      console.info(`closeCustomDialog-Error ~ code: ${error.code} -·- message: ${error.message}`);
    }
  }


  /**
   * 刷新自定义弹窗
   */
  update<T extends BaseDialogOptions>(dialogId: string, params: T) {
    const promptActionArg: PromptActionArg | undefined = this.getArgById(dialogId);
    if (promptActionArg) {
      promptActionArg.componentContent.update(params);
    }
  }


  /**
   * 是否存在自定义弹窗
   */
  exist(dialogId: string): boolean {
    const arg = this.getArgById(dialogId);
    return arg != undefined;
  }


  /**
   * 获取生成弹框的ID
   * @returns
   */
  generateDialogId(): string {
    return `${new Date().getTime()}${Math.floor(Math.random() * (1000 - 100) + 100)}`;
  }


  /**
   * 根据dialogId获取PromptActionArg
   * @param dialogId
   * @returns
   */
  getArgById(dialogId: string): PromptActionArg | undefined {
    return this.caches.find(item => dialogId == item.dialogId);
  }


  /**
   * 添加
   * @param dialogId
   * @param componentContent
   */
  private addArg(dialogId: string, uiContext: UIContext, componentContent: ComponentContent<Object>) {
    const arg: PromptActionArg = { dialogId: dialogId, uiContext: uiContext, componentContent: componentContent }
    this.caches.unshift(arg);
  }


  /**
   * 移除
   * @param dialogId
   */
  private removeArg(dialogId: string) {
    const args = BasePromptAction.getInstance().caches;
    const index = args.findIndex((item) => item.dialogId == dialogId);
    if (index >= 0) {
      args.splice(index, 1);
    }
  }


  /**
   * 弹框关闭时清除缓存数据
   */
  onDestroy(dialogId?: string) {
    if (dialogId && dialogId.length > 0) {
      const key = `${CacheHelper.CACHE_LABEL}${dialogId}`;
      if (CacheHelper.has(key)) {
        CacheHelper.remove(key); //清除缓存
      }
    }
  }


}