import { LogUtil, ToastUtil } from '@pura/harmony-utils';

export class User {
  id: string = 'No_1060701';
  name: string = '张三';
  age: number = 20;
  addr?: string = '乌市天山区';
  work?: string = '工程师';
  state?: string = '';
  user?: User;
  url?: string;
  salary?: number;

  say(msg: string) {
    LogUtil.error(`${this.name}想吃：${msg}`);
    ToastUtil.showToast(`${this.name}想吃：${msg}`);
  }

  print() {
    LogUtil.error("我是User对象~~~~~~");
    ToastUtil.showToast("我是User对象~~~~~~");
  }
}