import { LoadingOptions } from './LoadingOptions';


/**
 * TODO 进度加载框，参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export interface LoadingProgressOptions extends LoadingOptions {

  progress: number //设置当前进度值。设置小于0的数值时置为0，设置大于total的数值时置为total。非法数值不生效。

}
