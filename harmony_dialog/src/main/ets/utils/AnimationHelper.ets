/**
 * TODO 动画工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export class AnimationHelper {
  /**
   * InUp动画
   * @param duration 动画时间
   * @returns
   */
  static transitionInUp(duration: number = 300) {
    return TransitionEffect.asymmetric(
      TransitionEffect.OPACITY.animation({ duration: duration }).combine(
        TransitionEffect.translate({ y: -1000 }).animation({ duration: duration })),
      TransitionEffect.OPACITY.animation({ delay: duration, duration: duration }).combine(
        TransitionEffect.translate({ y: -1000 }).animation({ duration: duration }))
    )
  }

  /**
   * InDown动画
   * @param duration 动画时间
   * @returns
   */
  static transitionInDown(duration: number = 300) {
    return TransitionEffect.asymmetric(
      TransitionEffect.OPACITY.animation({ duration: duration }).combine(
        TransitionEffect.translate({ y: 1000 }).animation({ duration: duration })),
      TransitionEffect.OPACITY.animation({ delay: duration, duration: duration }).combine(
        TransitionEffect.translate({ y: 1000 }).animation({ duration: duration }))
    )
  }

  /**
   * InLeft动画
   * @param duration 动画时间
   * @returns
   */
  static transitionInLeft(duration: number = 300) {
    return TransitionEffect.asymmetric(
      TransitionEffect.OPACITY.animation({ duration: duration }).combine(
        TransitionEffect.translate({ x: -1000 }).animation({ duration: duration })),
      TransitionEffect.OPACITY.animation({ delay: duration, duration: duration }).combine(
        TransitionEffect.translate({ x: -1000 }).animation({ duration: duration }))
    )
  }


  /**
   * InRight动画
   * @param duration 动画时间
   * @returns
   */
  static transitionInRight(duration: number = 300) {
    return TransitionEffect.asymmetric(
      TransitionEffect.OPACITY.animation({ duration: duration }).combine(
        TransitionEffect.translate({ x: 1000 }).animation({ duration: duration })),
      TransitionEffect.OPACITY.animation({ delay: duration, duration: duration }).combine(
        TransitionEffect.translate({ x: 1000 }).animation({ duration: duration }))
    )
  }
}