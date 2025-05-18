import { webview } from '@kit.ArkWeb';
import { common } from '@kit.AbilityKit';
import { Utils } from '../utils/Utils';

/**
 * ArkWeb工具类
 */
export class ArkWebHelper {

  /**
   * 初始化
   * @param debug
   */
  static init(context: common.UIAbilityContext, debug?: boolean) {
    webview.WebviewController.initializeWebEngine();
    webview.WebviewController.setWebDebuggingAccess(debug);
    Utils.onAbilityLifecycle(context);
  }

static configCookieSync(){
  webview.WebCookieManager.configCookieSync('https://www.example.com', 'value=test');
  
}



  /**
   * 预连接url，在加载url之前调用此API。
   * @param url 预连接的url。
   * @param preconnectable 是否进行预连接。如果preconnectable为true，则对url进行dns解析，socket建链预连接；如果preconnectable为false，则不做任何预连接操作。
   * @param numSockets 要预连接的socket数。socket数目连接需要大于0，最多允许6个连接。
   */
  static prepareForPageLoad(url: string | string[], preconnectable: boolean = true, numSockets: number = 2) {
    if (Array.isArray(url)) {
      url.forEach((item) => webview.WebviewController.prepareForPageLoad(item, preconnectable, numSockets))
    } else {
      webview.WebviewController.prepareForPageLoad(url, preconnectable, numSockets);
    }
  }


  /**
   * 异步执行JavaScript脚本，并通过Promise方式返回脚本执行的结果。runJavaScript需要在loadUrl完成后，比如onPageEnd中调用。
   * @param webController
   * @param script JavaScript脚本
   * @returns
   */
  static async runJavaScript(webController: webview.WebviewController, script: string): Promise<string> {
    return webController.runJavaScript(script);
  }

  /**
   * 异步执行JavaScript脚本，并通过Promise方式返回脚本执行的结果。runJavaScriptExt需要在loadUrl完成后，比如onPageEnd中调用。
   * @param webController
   * @param script JavaScript脚本。
   * @returns
   */
  static async runJavaScriptExt(webController: webview.WebviewController, script: string | ArrayBuffer): Promise<webview.JsMessageExt> {
    return webController.runJavaScriptExt(script);
  }

  /**
   * 异步执行JavaScript方法
   * @param webController
   * @param funName 方法名
   * @param param 方法参数
   * @returns
   */
  static async runJavaScriptFun(webController: webview.WebviewController, funName: string, param?: string): Promise<string> {
    if (param) {
      return ArkWebHelper.runJavaScript(webController, `${funName}(${param})`);
    } else {
      return ArkWebHelper.runJavaScript(webController, `${funName}()`);
    }
  }





}