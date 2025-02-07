import { webview } from '@kit.ArkWeb';
import { StrUtil } from '../utils/StrUtil';

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


  async runJavaScript(funName: string, param?: string): Promise<string> {
    if (param) {
      const result = await this.controller?.runJavaScript(`${funName}('${param}')`);
      return result ?? '';
    } else {
      const result = await this.controller?.runJavaScript(`${funName}()`);
      return result ?? '';
    }
  }


}