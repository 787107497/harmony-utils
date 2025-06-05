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

import { image } from '@kit.ImageKit';
import { componentSnapshot, window } from '@kit.ArkUI';
import { AppUtil } from './AppUtil';

/**
 * TODO 组件截图和窗口截图工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class SnapshotUtil {


  /**
   * 获取已加载的组件的截图，传入组件的组件id，找到对应组件进行截图。通过Promise返回结果。
   * @param id 目标组件的组件标识,组件的唯一标识id
   * @param options 截图相关的自定义参数。
   * @returns
   */
  static async get(id: string, options?: componentSnapshot.SnapshotOptions): Promise<image.PixelMap> {
    return componentSnapshot.get(id, options);
  }

  /**
   * 获取已加载的组件的截图，传入组件的组件id，找到对应组件进行截图。
   * @param id 目标组件的组件标识,组件的唯一标识id
   * @param options 截图相关的自定义参数。
   * @returns
   */
  static getSync(id: string, options?: componentSnapshot.SnapshotOptions): image.PixelMap {
    return componentSnapshot.getSync(id, options);
  }


  /**
   * 在应用后台渲染CustomBuilder自定义组件，并输出其截图。通过Promise返回结果并支持获取离屏组件绘制区域坐标和大小。
   * @param builder 自定义组件构建函数。
   * @param delay 指定触发截图指令的延迟时间。默认值：300,单位：毫秒。
   * @param checkImageStatus 指定是否允许在截图之前，校验图片解码状态。默认值：false。
   * @param options 截图相关的自定义参数。
   * @returns
   */
  static createFromBuilder(builder: CustomBuilder, delay: number = 300, checkImageStatus: boolean = false,
    options?: componentSnapshot.SnapshotOptions): Promise<image.PixelMap> {
    return componentSnapshot.createFromBuilder(builder, delay, checkImageStatus, options);
  }


  /**
   * 获取窗口截图，使用Promise异步回调。
   * @param windowClass 不传默认截图主窗口
   * @returns
   */
  static async snapshot(windowClass?: window.Window): Promise<image.PixelMap> {
    return (windowClass ?? AppUtil.getMainWindow()).snapshot();
  }


  /**
   * 开启系统截屏事件的监听
   * @param callBack 截图回调
   */
  static onSnapshotListener(callback: VoidCallback): void {
    AppUtil.getMainWindow().on("screenshot", callback);
  }


  /**
   * 关闭系统截屏事件的监听
   * @param callback 监听事件，不传关闭所有监听。
   */
  static removeSnapshotListener(callback?: VoidCallback): void {
    if (callback) {
      AppUtil.getMainWindow().off('screenshot', callback);
    } else {
      AppUtil.getMainWindow().off('screenshot');
    }
  }


}