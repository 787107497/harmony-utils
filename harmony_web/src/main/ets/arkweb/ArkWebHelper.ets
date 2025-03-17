import { webview } from '@kit.ArkWeb';

/**
 * ArkWeb工具类 */
export class ArkWebHelper {

  /**
   * 初始化
   * @param debug
   */
  static init(debug?: boolean) {
    webview.WebviewController.initializeWebEngine();
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


}