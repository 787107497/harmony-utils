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
 */

import { common } from '@kit.AbilityKit';
import { display, window } from '@kit.ArkUI';
import { resourceManager } from '@kit.LocalizationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { DialogHelper } from '../dialog/DialogHelper';


/**
 * TODO 工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059
 */
export class Helper {

  /**
   * 获取提供访问应用资源的能力
   * @returns
   */
  static getResourceManager(): resourceManager.ResourceManager {
    return getContext().resourceManager;
  }


  /**
   * 获取指定资源对应的integer数值或者float数值
   * @param res
   * @returns
   */
  static getNumber(res: Resource): number {
    return Helper.getResourceManager().getNumber(res);
  }


  /**
   * 获取指定资源对应的字符串
   * @param res
   */
  static getString(res: Resource): string {
    return Helper.getResourceManager().getStringSync(res);
  }


  /**
   * 获取按钮的字符串
   * @param resource
   * @returns
   */
  static getResourceStr(resource: ResourceStr | ButtonOptions | SheetInfo): string | null {
    try {
      if (typeof resource === 'string') {
        return resource;
      } else {
        return Helper.getString(resource as Resource);
      }
    } catch (e) {
      return null
    }
  }


  /**
   * 获取状态栏的高度，单位为px。
   * @returns
   */
  static getStatusBarHeight(uiContext?: common.UIAbilityContext): number {
    try {
      if (!uiContext) {
        uiContext = DialogHelper.getUIAbilityContext();
      }
      let height = uiContext.windowStage.getMainWindowSync()
        .getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
        .topRect.height;
      if (height > 0) {
        return px2vp(height);
      }
      return 32;
    } catch (err) {
      return 32;
    }
  }


  /**
   * 获取底部导航条的高度，单位为vp。
   * @returns
   */
  static getIndicatorHeight(uiContext?: common.UIAbilityContext): number {
    try {
      if (!uiContext) {
        uiContext = DialogHelper.getUIAbilityContext();
      }
      let height = uiContext.windowStage.getMainWindowSync()
        .getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
        .topRect.height;
      if (height > 0) {
        return px2vp(height);
      }
      return 28;
    } catch (err) {
      return 28;
    }
  }


  /**
   * 获取设备的屏幕宽度，单位为px。
   * @returns
   */
  static getDisplayWidth(): number {
    return display.getDefaultDisplaySync().width;
  }


  /**
   * 是否是大屏，大于手机屏幕宽度1600
   */
  static isLargeScreen(): boolean {
    return Helper.getDisplayWidth() > 1600;
  }


  /**
   * 获取底部类弹框的最大宽度
   * @param maxWidth 默认360vp
   * @returns 单位vp
   */
  static getMaxWidth(maxWidth: Length = 360): number {
    if (Helper.isLargeScreen()) {
      let oldWidth = 360;
      try {
        if (typeof maxWidth === 'number') { //number
          oldWidth = maxWidth;
        } else if (typeof maxWidth === 'string') { //string
          oldWidth = Helper.getVpByStr(maxWidth);
        } else {
          try { //number资源
            oldWidth = Helper.getNumber(maxWidth);
          } catch (e) { //string资源
            let strWidth = Helper.getString(maxWidth);
            oldWidth = Helper.getVpByStr(strWidth);
          }
        }
      } catch (e) {
        let error = e as BusinessError;
        console.log(`getMaxWidth-Error ~ code: ${error.code} -·- message: ${error.message}`);
      }
      const width = px2vp(Helper.getDisplayWidth());
      if (width < oldWidth + 40) { //当宽度大于屏幕宽度，默认为宽度。
        return width;
      }
      return oldWidth + 40;
    } else { //小屏幕直接获取屏幕宽度。
      return px2vp(Helper.getDisplayWidth());
    }
  }


  /**
   * 获取vp数据
   * @param str
   * @returns
   */
  static getVpByStr(str: string): number {
    if (str.toLowerCase().endsWith('vp')) {
      str = str.replaceAll('vp', '');
      return parseInt(str);
    } else if (str.toLowerCase().endsWith('px')) {
      str = str.replaceAll('px', '');
      return px2vp(parseInt(str));
    } else if (str.toLowerCase().endsWith('lpx')) {
      str = str.replaceAll('lpx', '');
      return lpx2px(px2vp(parseInt(str)));
    } else if (str.toLowerCase().endsWith('fp')) {
      str = str.replaceAll('fp', '');
      return fp2px(px2vp(parseInt(str)));
    } else {
      return parseInt(str);
    }
  }


  /**
   * 将DialogAlignment值转化为Alignment值
   */
  static getAlignment(dialogAlignment: DialogAlignment): Alignment | undefined {
    switch (dialogAlignment) {
      case DialogAlignment.Top:
        return Alignment.Top;
      case DialogAlignment.Center:
        return Alignment.Center;
      case DialogAlignment.Bottom:
        return Alignment.Bottom;
      case DialogAlignment.TopStart:
        return Alignment.TopStart;
      case DialogAlignment.TopEnd:
        return Alignment.TopEnd;
      case DialogAlignment.CenterStart:
        return Alignment.Start;
      case DialogAlignment.CenterEnd:
        return Alignment.End;
      case DialogAlignment.BottomStart:
        return Alignment.BottomStart;
      case DialogAlignment.BottomEnd:
        return Alignment.BottomEnd;
      case DialogAlignment.Default:
        return undefined;
    }
    return undefined;
  }


}
