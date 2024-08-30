import { ComponentContent, promptAction, window } from '@kit.ArkUI';
import { PromptActionArg } from '../model/PromptActionArg';

/**
 * TODO PromptAction基类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * QQ交流群: 569512366
 */
export class BasePromptAction {
  private static instance: BasePromptAction;
  private uiContext?: UIContext;
  private caches: PromptActionArg[] = new Array<PromptActionArg>();

  private constructor() {

  }

  static getInstance(): BasePromptAction {
    if (!BasePromptAction.instance) {
      BasePromptAction.instance = new BasePromptAction();
    }
    return BasePromptAction.instance;
  }


  openCustomDialog<T extends Object>(contentView: WrappedBuilder<[T]>, args: T,
    options?: promptAction.BaseDialogOptions) {
    if (this.uiContext) {
      this.openDialog(this.uiContext, contentView, args, options);
    } else {
      window.getLastWindow(getContext()).then((result: window.Window) => {
        this.uiContext = result.getUIContext();
        this.openDialog(this.uiContext, contentView, args, options);
      })
    }
  }


  private openDialog<T extends Object>(uiContext: UIContext, wrappedBuilder: WrappedBuilder<[T]>, args: T,
    options?: promptAction.BaseDialogOptions) {
    let componentContent = new ComponentContent(uiContext, wrappedBuilder, args);

    let promptAction = uiContext.getPromptAction();
    promptAction.openCustomDialog(componentContent);
  }


  /**
   * 关闭弹框
   * @param dialogId
   */
  closeCustomDialog(dialogId: string) {
    if (this.uiContext) {
      let promptActionArg: PromptActionArg | undefined = this.getArgById(dialogId);
      if (promptActionArg) {
        let promptAction = this.uiContext.getPromptAction();
        promptAction.closeCustomDialog(promptActionArg.componentContent);
      }
    }
  }


  /**
   * 刷新自定义弹窗
   */
  update<T extends Object>(dialogId: string, params: T) {
    let promptActionArg: PromptActionArg | undefined = this.getArgById(dialogId);
    if (promptActionArg) {
      promptActionArg.componentContent.update(params)
    }
  }


  /**
   * 是否存在自定义弹窗
   */
   isShowing(dialogId: string): boolean {
    let arg = this.getArgById(dialogId);
    return arg != undefined
  }


  /**
   * 获取生成弹框的ID
   * @returns
   */
  getDialogId(): string {
    return `${new Date().getTime()}${Math.floor(Math.random() * (1000 - 100) + 100)}`;
  }

  /**
   * 根据dialogId获取PromptActionArg
   * @param dialogId
   * @returns
   */
  getArgById(dialogId: string): PromptActionArg | undefined {
    return this.caches.find(item => dialogId == item.dialogId)
  }


  private addArg(dialogId: string, componentContent: ComponentContent<Object>) {
    let args = BasePromptAction.getInstance().caches;
    let arg: PromptActionArg = {
      dialogId: dialogId,
      componentContent: componentContent
    }
    args.unshift(arg);
  }


  private removeArg(dialogId: string) {
    let args = BasePromptAction.getInstance().caches;
    let index = args.findIndex((item) => item.dialogId == dialogId);
    if (index >= 0) {
      args.splice(index, 1)
    } else {
      args.shift()
    }
  }



}