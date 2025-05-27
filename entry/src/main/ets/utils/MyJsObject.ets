import { router } from '@kit.ArkUI';
import { ArkJsObject } from '@pura/harmony-web';
import { JSONUtil, LogUtil } from '@pura/harmony-utils';
import { User } from '../model/User';


/**
 * JS交互 */
export class MyJsObject extends ArkJsObject {

  //关闭页面
  closePage(str?: string) {
    LogUtil.error(`closePage: ${str}`);
    router.back();
  }

  async onDemo() {
    let user: User = new User();
    let str: string = JSONUtil.beanToJsonStr(user);

    this.runJavaScriptFun("onH5Demo", str ).then((data)=>{
      LogUtil.error(`网页回传值：${data}`);
    });
  }


}