/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-dialog
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 */


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
  static transitionInUp(duration: number = 300): TransitionEffect {
    return TransitionEffect.asymmetric(
      TransitionEffect.OPACITY.animation({ duration: duration }).combine(
        TransitionEffect.move(TransitionEdge.TOP).animation({ duration: duration })),
      TransitionEffect.OPACITY.animation({ delay: duration, duration: duration }).combine(
        TransitionEffect.move(TransitionEdge.TOP).animation({ duration: duration }))
    )
  }

  /**
   * InDown动画
   * @param duration 动画时间
   * @returns
   */
  static transitionInDown(duration: number = 300): TransitionEffect {
    return TransitionEffect.asymmetric(
      TransitionEffect.OPACITY.animation({ duration: duration }).combine(
        TransitionEffect.move(TransitionEdge.BOTTOM).animation({ duration: duration })),
      TransitionEffect.OPACITY.animation({ delay: duration, duration: duration }).combine(
        TransitionEffect.move(TransitionEdge.BOTTOM).animation({ duration: duration }))
    )
  }

  /**
   * InLeft动画
   * @param duration 动画时间
   * @returns
   */
  static transitionInLeft(duration: number = 300): TransitionEffect {
    return TransitionEffect.asymmetric(
      TransitionEffect.OPACITY.animation({ duration: duration }).combine(
        TransitionEffect.move(TransitionEdge.START).animation({ duration: duration })),
      TransitionEffect.OPACITY.animation({ delay: duration, duration: duration }).combine(
        TransitionEffect.move(TransitionEdge.START).animation({ duration: duration }))
    )
  }


  /**
   * InRight动画
   * @param duration 动画时间
   * @returns
   */
  static transitionInRight(duration: number = 300): TransitionEffect {
    return TransitionEffect.asymmetric(
      TransitionEffect.OPACITY.animation({ duration: duration }).combine(
        TransitionEffect.move(TransitionEdge.END).animation({ duration: duration })),
      TransitionEffect.OPACITY.animation({ delay: duration, duration: duration }).combine(
        TransitionEffect.move(TransitionEdge.END).animation({ duration: duration }))
    )
  }


}