import { router } from '@kit.ArkUI';
import { ArkJsObject } from '@pura/harmony-web';
import { LogUtil } from '@pura/harmony-utils';


/**
 * JS交互 */
export class MyJsObject extends ArkJsObject {

  //关闭页面
  closePage(str?: string) {
    LogUtil.error(`closePage: ${str}`);
    router.back();
  }


}