/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-utils
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
 */

import { CacheUtil } from './CacheUtil';
import { DateUtil } from './DateUtil';

/**
 * TODO 节流、防抖 工具类（用于点击事件，防止按钮被重复点击）
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class ClickUtil {

  private static throttleTimeoutID: number; //节流timeoutID
  private static flag: boolean = false; //节流flag,true=已经进入执行状态了
  private static defaultId: string = DateUtil.getTodayTime().toString(); //防抖Id


  /**
   * 节流：在一定时间内，只触发一次
   * @param func 要执行的回调函数
   * @param wait = 1500 延时的时间 毫秒
   * @param immediate = true 是否立即执行
   */
  static throttle(func: () => void, wait: number = 1000, immediate: boolean = true) {
    if (immediate) {
      if (!ClickUtil.flag) {
        ClickUtil.flag = true;
        typeof func === 'function' && func();
        ClickUtil.throttleTimeoutID = setTimeout(() => {
          ClickUtil.flag = false;
          clearTimeout(ClickUtil.throttleTimeoutID);
        }, wait);
      }
    } else {
      if (!ClickUtil.flag) {
        ClickUtil.flag = true;
        ClickUtil.throttleTimeoutID = setTimeout(() => {
          ClickUtil.flag = false;
          typeof func === 'function' && func();
          clearTimeout(ClickUtil.throttleTimeoutID);
        }, wait);
      }
    }
  }


  /**
   * 防抖：一定时间内，只有最后一次操作，再过wait毫秒后才执行函数
   * @param func 要执行的函数
   * @param wait 延时的时间
   * @param clickId 设置的点击事件id，用于区分多个点击事件，不传默认单个点击事件
   */
  static debounce(func: () => void, wait: number = 1000, clickId: string = ClickUtil.defaultId) {
    let cacheID = CacheUtil.get<number>(`ClickUtil_debounce_timeoutID_${clickId}`); //获取id
    if (cacheID !== undefined && cacheID !== null) {
      clearTimeout(cacheID);
    }
    let timeoutID = setTimeout(() => {
      typeof func === 'function' && func();
      clearTimeout(timeoutID);
    }, wait);
    CacheUtil.put<number>(`ClickUtil_debounce_timeoutID_${clickId}`, timeoutID); //缓存id
  }


}