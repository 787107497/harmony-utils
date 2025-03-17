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


import { AppUtil } from './AppUtil';
import { StrUtil } from './StrUtil';
import { resourceManager } from '@kit.LocalizationKit';


/**
 * TODO 资源工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class ResUtil {


  /**
   * 获取提供访问应用资源的能力
   * @returns
   */
  static getResourceManager(): resourceManager.ResourceManager {
    return AppUtil.getContext().resourceManager;
  }


  /**
   * 获取指定资源对应的布尔结果
   * @param resId 资源ID值/资源信息
   * @returns
   */
  static getBoolean(resId: number | Resource): boolean {
    if (typeof resId === 'number') {
      return ResUtil.getResourceManager().getBoolean(resId);
    } else {
      return ResUtil.getResourceManager().getBoolean(resId);
    }
  }

  /**
   * 获取指定资源名称对应的布尔结果
   * @param resName 资源名称。
   * @returns
   */
  static getBooleanByName(resName: string): boolean {
    return ResUtil.getResourceManager().getBooleanByName(resName);
  }


  /**
   * 获取指定资源对应的integer数值或者float数值
   * @param resId 资源ID值/资源信息
   * @returns
   */
  static getNumber(resId: number | Resource): number {
    if (typeof resId === 'number') {
      return ResUtil.getResourceManager().getNumber(resId);
    } else {
      return ResUtil.getResourceManager().getNumber(resId);
    }
  }

  /**
   * 获取指定资源名称对应的integer数值或者float数值
   * @param resName 资源名称。
   * @returns
   */
  static getNumberByName(resName: string): number {
    return ResUtil.getResourceManager().getNumberByName(resName);
  }


  /**
   * 获取指定资源对应的字符串
   * @param resId 资源ID值
   * @param args 格式化字符串资源参数。
   *   支持参数类型：%d、%f、%s、%%、%数字\$d、%数字\$f、%数字\$s；
   *   说明：%%转义为%; %数字\$d表示使用第几个参数；
   *   举例：%%d格式化后为%d字符串; %1\$d表示使用第一个参数
   */
  static getStringSync(resId: number | Resource, args?: Array<string | number>): string {
    if (args !== undefined && args.length > 0) {
      if (typeof resId === 'number') {
        return ResUtil.getResourceManager().getStringSync(resId, ...args);
      } else {
        return ResUtil.getResourceManager().getStringSync(resId, ...args);
      }
    } else {
      if (typeof resId === 'number') {
        return ResUtil.getResourceManager().getStringSync(resId);
      } else {
        return ResUtil.getResourceManager().getStringSync(resId);
      }
    }
  }

  /**
   * 获取指定资源对应的字符串
   * @param resId 资源ID值/资源信息
   */
  static async getStringValue(resId: number | Resource): Promise<string> {
    if (typeof resId === 'number') {
      return ResUtil.getResourceManager().getStringValue(resId);
    } else {
      return ResUtil.getResourceManager().getStringValue(resId);
    }
  }

  /**
   * 获取指定资源名称对应的字符串
   * @param resName 资源名称
   * @param args 格式化字符串资源参数。
   *   支持参数类型：%d、%f、%s、%%、%数字\$d、%数字\$f、%数字\$s；
   *   说明：%%转义为%; %数字\$d表示使用第几个参数；
   *   举例：%%d格式化后为%d字符串; %1\$d表示使用第一个参数
   */
  static getStringByNameSync(resName: string, args?: Array<string | number>): string {
    if (args !== undefined && args.length > 0) {
      return ResUtil.getResourceManager().getStringByNameSync(resName, ...args);
    } else {
      return ResUtil.getResourceManager().getStringByNameSync(resName);
    }
  }

  /**
   * 获取指定资源名称对应的字符串
   * @param resName 资源名称
   */
  static async getStringByName(resName: string): Promise<string> {
    return ResUtil.getResourceManager().getStringByName(resName);
  }


  /**
   * 获取指定资源对应的字符串数组
   * @param resId 资源ID值/资源信息
   */
  static getStringArrayValueSync(resId: number | Resource): Array<string> {
    if (typeof resId === 'number') {
      return ResUtil.getResourceManager().getStringArrayValueSync(resId);
    } else {
      return ResUtil.getResourceManager().getStringArrayValueSync(resId);
    }
  }

  /**
   * 获取指定资源ID对应的字符串数组
   * @param resId 资源ID值/资源信息
   */
  static async getStringArrayValue(resId: number | Resource): Promise<Array<string>> {
    if (typeof resId === 'number') {
      return ResUtil.getResourceManager().getStringArrayValue(resId);
    } else {
      return ResUtil.getResourceManager().getStringArrayValue(resId);
    }
  }

  /**
   * 获取指定资源名称对应的字符串数组
   * @param resName 资源名称
   */
  static getStringArrayByNameSync(resName: string): Array<string> {
    return ResUtil.getResourceManager().getStringArrayByNameSync(resName);
  }

  /**
   * 获取指定资源名称对应的字符串数组
   * @param resName 资源名称
   */
  static async getStringArrayByName(resName: string): Promise<Array<string>> {
    return ResUtil.getResourceManager().getStringArrayByName(resName);
  }


  /**
   * 根据指定数量获取指定resource对象表示的单复数字符串
   * @param resId 资源ID值/资源信息
   * @param num 数量值
   */
  static getPluralStringValueSync(resId: number | Resource, num: number): string {
    if (typeof resId === 'number') {
      return ResUtil.getResourceManager().getPluralStringValueSync(resId, num);
    } else {
      return ResUtil.getResourceManager().getPluralStringValueSync(resId, num);
    }
  }

  /**
   * 根据指定数量获取指定resource对象表示的单复数字符串
   * @param resId 资源ID值/资源信息
   * @param num 数量值
   */
  static async getPluralStringValue(resId: number | Resource, num: number): Promise<string> {
    if (typeof resId === 'number') {
      return ResUtil.getResourceManager().getPluralStringValue(resId, num);
    } else {
      return ResUtil.getResourceManager().getPluralStringValue(resId, num);
    }
  }

  /**
   * 根据指定数量获取指定资源名称表示的单复数字符串
   * @param resName 资源名称
   * @param num 数量值
   */
  static getPluralStringByNameSync(resName: string, num: number): string {
    return ResUtil.getResourceManager().getPluralStringByNameSync(resName, num);
  }

  /**
   * 根据指定数量获取指定资源名称表示的单复数字符串
   * @param resName 资源名称
   * @param num 数量值
   */
  static async getPluralStringByName(resName: string, num: number): Promise<string> {
    return ResUtil.getResourceManager().getPluralStringByName(resName, num);
  }


  /**
   * 获取指定资源对应的颜色值（十进制）
   * @param resId 资源ID值/资源信息
   * @returns
   */
  static getColorSync(resId: number | Resource): number {
    if (typeof resId === 'number') {
      return ResUtil.getResourceManager().getColorSync(resId);
    } else {
      return ResUtil.getResourceManager().getColorSync(resId);
    }
  }

  /**
   * 获取指定资源对应的颜色值（十进制）
   * @param resId 资源ID值/资源信息
   * @returns
   */
  static async getColor(resId: number | Resource): Promise<number> {
    if (typeof resId === 'number') {
      return ResUtil.getResourceManager().getColor(resId);
    } else {
      return ResUtil.getResourceManager().getColor(resId);
    }
  }

  /**
   * 获取指定资源名称对应的颜色值（十进制）
   * @param resName 资源名称
   * @returns
   */
  static getColorByNameSync(resName: string): number {
    return ResUtil.getResourceManager().getColorByNameSync(resName);
  }

  /**
   * 获取指定资源名称对应的颜色值（十进制）
   * @param resName 资源名称
   * @returns
   */
  static async getColorByName(resName: string): Promise<number> {
    return ResUtil.getResourceManager().getColorByName(resName);
  }


  /**
   * 用户获取指定资源ID对应的媒体文件内容/获取指定资源ID对应的默认或指定的屏幕密度媒体文件内容
   * @param resId 资源ID值/资源信息。
   * @param density 资源获取需要的屏幕密度，0或缺省表示默认屏幕密度。
   * @returns
   */
  static getMediaContentSync(resId: number | Resource, density?: number): Uint8Array {
    if (density !== undefined) {
      if (typeof resId === 'number') {
        return ResUtil.getResourceManager().getMediaContentSync(resId, density);
      } else {
        return ResUtil.getResourceManager().getMediaContentSync(resId, density);
      }
    } else {
      if (typeof resId === 'number') {
        return ResUtil.getResourceManager().getMediaContentSync(resId);
      } else {
        return ResUtil.getResourceManager().getMediaContentSync(resId);
      }
    }
  }

  /**
   * 用户获取指定资源ID对应的媒体文件内容/获取指定资源ID对应的默认或指定的屏幕密度媒体文件内容
   * @param resId 资源ID值/资源信息。
   * @param density 资源获取需要的屏幕密度，0或缺省表示默认屏幕密度。
   * @returns
   */
  static async getMediaContent(resId: number | Resource, density?: number): Promise<Uint8Array> {
    if (density !== undefined) {
      if (typeof resId === 'number') {
        return ResUtil.getResourceManager().getMediaContent(resId, density);
      } else {
        return ResUtil.getResourceManager().getMediaContent(resId, density);
      }
    } else {
      if (typeof resId === 'number') {
        return ResUtil.getResourceManager().getMediaContent(resId);
      } else {
        return ResUtil.getResourceManager().getMediaContent(resId);
      }
    }
  }

  /**
   * 用户获取指定资源名称对应的媒体文件内容/获取指定资源名称对应的默认或指定的屏幕密度媒体文件内容
   * @param resName 资源名称。
   * @param density 资源获取需要的屏幕密度，0或缺省表示默认屏幕密度。
   * @returns
   */
  static getMediaByNameSync(resName: string, density?: number): Uint8Array {
    if (density !== undefined) {
      return ResUtil.getResourceManager().getMediaByNameSync(resName, density);
    } else {
      return ResUtil.getResourceManager().getMediaByNameSync(resName);
    }
  }

  /**
   * 用户获取指定资源名称对应的媒体文件内容/获取指定资源名称对应的默认或指定的屏幕密度媒体文件内容
   * @param resName 资源名称。
   * @param density 资源获取需要的屏幕密度，0或缺省表示默认屏幕密度。
   * @returns
   */
  static async getMediaByName(resName: string, density?: number): Promise<Uint8Array> {
    if (density !== undefined) {
      return ResUtil.getResourceManager().getMediaByName(resName, density);
    } else {
      return ResUtil.getResourceManager().getMediaByName(resName);
    }
  }


  /**
   * 获取指定资源ID对应的图片资源Base64编码/获取指定资源ID对应的默认或指定的屏幕密度图片资源Base64编码
   * @param resId 资源ID值/资源信息。
   * @param density 资源获取需要的屏幕密度，0或缺省表示默认屏幕密度。
   * @returns
   */
  static getMediaContentBase64Sync(resId: number | Resource, density?: number): string {
    if (density !== undefined) {
      if (typeof resId === 'number') {
        return ResUtil.getResourceManager().getMediaContentBase64Sync(resId, density);
      } else {
        return ResUtil.getResourceManager().getMediaContentBase64Sync(resId, density);
      }
    } else {
      if (typeof resId === 'number') {
        return ResUtil.getResourceManager().getMediaContentBase64Sync(resId);
      } else {
        return ResUtil.getResourceManager().getMediaContentBase64Sync(resId);
      }
    }
  }

  /**
   * 获取指定资源ID对应的图片资源Base64编码/获取指定资源ID对应的默认或指定的屏幕密度图片资源Base64编码
   * @param resId 资源ID值/资源信息。
   * @param density 资源获取需要的屏幕密度，0或缺省表示默认屏幕密度。
   * @returns
   */
  static async getMediaContentBase64(resId: number | Resource, density?: number): Promise<string> {
    if (density !== undefined) {
      if (typeof resId === 'number') {
        return ResUtil.getResourceManager().getMediaContentBase64(resId, density);
      } else {
        return ResUtil.getResourceManager().getMediaContentBase64(resId, density);
      }
    } else {
      if (typeof resId === 'number') {
        return ResUtil.getResourceManager().getMediaContentBase64(resId);
      } else {
        return ResUtil.getResourceManager().getMediaContentBase64(resId);
      }
    }
  }

  /**
   * 获取指定资源名称对应的图片资源Base64编码/获取指定资源名称对应的默认或指定的屏幕密度图片资源Base64编码
   * @param resName 资源名称。
   * @param density 资源获取需要的屏幕密度，0或缺省表示默认屏幕密度。
   * @returns
   */
  static getMediaBase64ByNameSync(resName: string, density?: number): string {
    if (density !== undefined) {
      return ResUtil.getResourceManager().getMediaBase64ByNameSync(resName, density);
    } else {
      return ResUtil.getResourceManager().getMediaBase64ByNameSync(resName);
    }
  }

  /**
   * 获取指定资源名称对应的图片资源Base64编码/获取指定资源名称对应的默认或指定的屏幕密度图片资源Base64编码
   * @param resName 资源名称。
   * @param density 资源获取需要的屏幕密度，0或缺省表示默认屏幕密度。
   * @returns
   */
  static async getMediaBase64ByName(resName: string, density?: number): Promise<string> {
    if (density !== undefined) {
      return ResUtil.getResourceManager().getMediaBase64ByName(resName, density);
    } else {
      return ResUtil.getResourceManager().getMediaBase64ByName(resName);
    }
  }


  /**
   * 获取resources/rawfile目录下对应的rawfile文件内容
   * @param path rawfile文件路径
   * @returns
   */
  static getRawFileContentSync(path: string): Uint8Array {
    return ResUtil.getResourceManager().getRawFileContentSync(path);
  }

  /**
   * 获取resources/rawfile目录下对应的rawfile文件内容
   * @param path rawfile文件路径
   * @returns
   */
  static async getRawFileContent(path: string): Promise<Uint8Array> {
    return ResUtil.getResourceManager().getRawFileContent(path);
  }

  /**
   * 获取resources/rawfile目录下对应的rawfile文件内容
   * @param path rawfile文件路径
   * @returns
   */
  static getRawFileContentStrSync(path: string): string {
    let uint8Array = ResUtil.getRawFileContentSync(path);
    return StrUtil.unit8ArrayToStr(uint8Array);
  }

  /**
   * 获取resources/rawfile目录下对应的rawfile文件内容
   * @param path rawfile文件路径
   * @returns
   */
  static async getRawFileContentStr(path: string): Promise<string> {
    let uint8Array = await ResUtil.getRawFileContent(path);
    return StrUtil.unit8ArrayToStr(uint8Array);
  }


  /**
   * 获取resources/rawfile目录下文件夹及文件列表（若文件夹中无文件，则不返回；若文件夹中有文件，则返回文件夹及文件列表）
   * @param path rawfile文件夹路径。
   * @returns
   */
  static getRawFileListSync(path: string): Array<string> {
    return ResUtil.getResourceManager().getRawFileListSync(path);
  }

  /**
   * 获取resources/rawfile目录下文件夹及文件列表（若文件夹中无文件，则不返回；若文件夹中有文件，则返回文件夹及文件列表）
   * @param path rawfile文件夹路径。
   * @returns
   */
  static async getRawFileList(path: string): Promise<Array<string>> {
    return ResUtil.getResourceManager().getRawFileList(path);
  }


  /**
   * 用户获取resources/rawfile目录下对应rawfile文件所在hap的descriptor信息
   * @param path rawfile文件路径
   * @returns
   */
  static async getRawFd(path: string): Promise<resourceManager.RawFileDescriptor> {
    return ResUtil.getResourceManager().getRawFd(path);
  }

  /**
   * 用户关闭resources/rawfile目录下rawfile文件所在hap的descriptor信息
   * @param path rawfile文件路径
   * @returns
   */
  static async closeRawFd(path: string) {
    return ResUtil.getResourceManager().closeRawFd(path);
  }

  /**
   * 用户关闭resources/rawfile目录下rawfile文件所在hap的descriptor信息
   * @param path rawfile文件路径
   * @returns
   */
  static closeRawFdSync(path: string) {
    return ResUtil.getResourceManager().closeRawFdSync(path);
  }


  /**
   * 获取设备的Configuration
   * @returns
   */
  static getConfigurationSync(): resourceManager.Configuration {
    return ResUtil.getResourceManager().getConfigurationSync();
  }

  /**
   * 获取设备的Configuration
   * @returns
   */
  static async getConfiguration(): Promise<resourceManager.Configuration> {
    return ResUtil.getResourceManager().getConfiguration();
  }


  /**
   * 获取设备的DeviceCapability
   * @returns
   */
  static getDeviceCapabilitySync(): resourceManager.DeviceCapability {
    return ResUtil.getResourceManager().getDeviceCapabilitySync();
  }

  /**
   * 获取设备的DeviceCapability
   * @returns
   */
  static async getDeviceCapability(): Promise<resourceManager.DeviceCapability> {
    return ResUtil.getResourceManager().getDeviceCapability();
  }


  /**
   * 应用运行时，加载指定的资源路径，实现资源覆盖。
   * @param path 资源路径。
   * @returns
   */
  static addResource(path: string) {
    ResUtil.getResourceManager().addResource(path);
  }

  /**
   * 用户运行时，移除指定的资源路径，还原被覆盖前的资源。
   * @param path 资源路径。
   * @returns
   */
  static removeResource(path: string) {
    ResUtil.getResourceManager().removeResource(path);
  }

  /**
   * 用户判断指定路径是否是rawfile下的目录（true：表示是rawfile下的目录，false：表示不是rawfile下的目录）
   * @param path rawfile路径。
   * @returns
   */
  static isRawDir(path: string): boolean {
    return ResUtil.getResourceManager().isRawDir(path);
  }


}