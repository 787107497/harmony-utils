import { common } from '@kit.AbilityKit';
import { ComponentContent, promptAction, window } from '@kit.ArkUI';

export class DialogHelper {

  private static context: common.UIAbilityContext; //common.UIAbilityContext，上下文
  private static windowStage: window.WindowStage;
  private static uiContext: UIContext; //UIContext


  /**
   * 初始化方法,缓存全局变量，在UIAbility的onWindowStageCreate方法中初始化该方法。
   * @param windowStage 窗口管理器
   */
  static init(context: common.UIAbilityContext, windowStage: window.WindowStage) {
    DialogHelper.context = context;
    DialogHelper.windowStage = windowStage;
    DialogHelper.uiContext = DialogHelper.windowStage.getMainWindowSync().getUIContext();
  }

  /**
   * 获取UIContext
   * @returns
   */
  static getUIContext(): UIContext {
    DialogHelper.context.windowStage.getMainWindowSync().getUIContext()
    return DialogHelper.uiContext;
  }


  static show<T extends object>(builder: WrappedBuilder<[T]>, args: T, options?: promptAction.BaseDialogOptions){
    let promptAction = DialogHelper.uiContext.getPromptAction();
    let componentContent = new ComponentContent(DialogHelper.uiContext,builder, args);
    promptAction.openCustomDialog(componentContent, {
      onWillDismiss: (action: DismissDialogAction) => {
        // LogUtil.error(`点击返回：${JSON.stringify(action)}`);

      }
    });
  }



}