import { webview } from '@kit.ArkWeb';
import { ArkWebClient } from './ArkWebClient';

/**
 * 默认的ArkWebClient */
export class BaseArkWebClient implements ArkWebClient {

  controller?: webview.WebviewController;


  setWebviewController(controller: webview.WebviewController): void {
    this.controller = controller;
  }


}