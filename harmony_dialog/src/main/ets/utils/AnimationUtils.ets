
/**
 * 动画工具类
 */
export class AnimationUtils{
  static getBottom(duration: number = 500) {
    return TransitionEffect.asymmetric(
      TransitionEffect.OPACITY.animation({ duration: duration }).combine(
        TransitionEffect.translate({ y: 1000 }).animation({ duration: duration })),
      TransitionEffect.OPACITY.animation({ delay: duration, duration: duration }).combine(
        TransitionEffect.translate({ y: 1000 }).animation({ duration: duration }))
    )
  }

}