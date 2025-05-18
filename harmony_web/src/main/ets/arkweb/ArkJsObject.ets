import { webview } from '@kit.ArkWeb';
import { StrUtil } from '../utils/StrUtil';
import { ArkWebHelper } from './ArkWebHelper';

export class ArkJsObject {
  private name: string = "JsBridge"; //	注册对象的名称，与window中调用的对象名一致。默认为JsBridge。
  controller?: webview.WebviewController;


  constructor(name?: string) {
    if (StrUtil.isNotEmpty(name)) {
      this.name = name ?? "JsBridge";
    }
  }

  /**
   * 接口注册用到
   */
  getName(): string {
    return this.name;
  }

  /**
   * 该方法内部功能实现用到，使用时，无需调用该方法。
   */
  setWebviewController(controller: webview.WebviewController) {
    this.controller = controller;
  }


  /**
   * 异步执行JavaScript脚本，并通过Promise方式返回脚本执行的结果。runJavaScript需要在loadUrl完成后，比如onPageEnd中调用。
   * @param script JavaScript脚本
   * @returns
   */
  async runJavaScript(script: string): Promise<string> {
    if (this.controller) {
      return ArkWebHelper.runJavaScript(this.controller, script);
    }
    return '';
  }

  /**
   * 异步执行JavaScript脚本，并通过Promise方式返回脚本执行的结果。runJavaScriptExt需要在loadUrl完成后，比如onPageEnd中调用。
   * @param script JavaScript脚本。
   * @returns
   */
  async runJavaScriptExt(script: string | ArrayBuffer): Promise<webview.JsMessageExt> {
    if (this.controller) {
      return ArkWebHelper.runJavaScriptExt(this.controller, script);
    }
    return new webview.JsMessageExt();
  }

  /**
   * 异步执行JavaScript方法
   * @param funName 方法名
   * @param param 方法参数
   * @returns
   */
  async runJavaScriptFun(funName: string, param?: string): Promise<string> {
    if (this.controller) {
      return ArkWebHelper.runJavaScriptFun(this.controller, funName, param);
    }
    return '';
  }


}