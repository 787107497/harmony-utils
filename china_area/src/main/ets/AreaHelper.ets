/*
 * Copyright (C) 2024 桃花镇童长老 @nutpi/china_area
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

import { resourceManager } from '@kit.LocalizationKit';
import { buffer, JSON, util } from '@kit.ArkTS';
import { AreaEntity } from './AreaEntity';

export class AreaHelper {
  private constructor() {}

  private static areaStr: string = ""; //省市县的JSON字符串
  private static areaList: Array<AreaEntity> = []; //省市县集合


  /**
   * 获取省市县的JSON字符串
   */
  static getAreaStrSync(): string {
    if (AreaHelper.isEmpty(AreaHelper.areaStr)) {
      let uint8Array = AreaHelper.getResourceManager().getRawFileContentSync('area.json');
      AreaHelper.areaStr = AreaHelper.unit8ArrayToStr(uint8Array);
    }
    return AreaHelper.areaStr;
  }

  /**
   * 获取省市县的JSON字符串
   */
  static async getAreaStr(): Promise<string> {
    if (AreaHelper.isEmpty(AreaHelper.areaStr)) {
      let uint8Array = await AreaHelper.getResourceManager().getRawFileContent('area.json');
      AreaHelper.areaStr = AreaHelper.unit8ArrayToStr(uint8Array);
    }
    return AreaHelper.areaStr;
  }


  /**
   * 获取省市县的数据
   */
  static getAreaSync(): Array<AreaEntity> {
    if (AreaHelper.areaList == null || AreaHelper.areaList.length == 0) {
      let jsonStr = AreaHelper.getAreaStrSync();
      AreaHelper.areaList = JSON.parse(jsonStr) as Array<AreaEntity>;
    }
    return AreaHelper.areaList;
  }

  /**
   * 获取省市县的数据
   */
  static async getArea(): Promise<Array<AreaEntity>> {
    if (AreaHelper.areaList == null || AreaHelper.areaList.length == 0) {
      let jsonStr = await AreaHelper.getAreaStr();
      AreaHelper.areaList = JSON.parse(jsonStr) as Array<AreaEntity>;
    }
    return AreaHelper.areaList;
  }


  /**
   * 根据省名获取下面的市
   * @param provinceName 省名
   * @returns
   */
  static getCityByNameSync(provinceName: string): Array<AreaEntity> {
    let list = AreaHelper.getAreaSync();
    for (let index = 0; index < list.length; index++) {
      if (provinceName == list[index].text) {
        return list[index].children ?? []
      }
    }
    return [];
  }

  /**
   * 根据省名获取下面的市
   * @param provinceName 省名
   * @returns
   */
  static async getCityByName(provinceName: string): Promise<Array<AreaEntity>> {
    let list = await AreaHelper.getArea();
    for (let index = 0; index < list.length; index++) {
      if (provinceName == list[index].text) {
        return list[index].children ?? []
      }
    }
    return [];
  }


  /**
   * 根据市名获取下面的区县
   * @param cityName 市名
   * @returns
   */
  static getDistrictByNameSync(cityName: string): Array<AreaEntity> {
    let list = AreaHelper.getAreaSync();
    for (let index = 0; index < list.length; index++) {
      let cityList = list[index].children ?? [];
      for (let i = 0; i < cityList.length; i++) {
        if (cityName == cityList[i].text) {
          return cityList[i].children ?? []
        }
      }
    }
    return [];
  }

  /**
   * 根据市名获取下面的区县
   * @param cityName 市名
   * @returns
   */
  static async getDistrictByName(cityName: string): Promise<Array<AreaEntity>> {
    let list = await AreaHelper.getArea();
    for (let index = 0; index < list.length; index++) {
      let cityList = list[index].children ?? [];
      for (let i = 0; i < cityList.length; i++) {
        if (cityName == cityList[i].text) {
          return cityList[i].children ?? []
        }
      }
    }
    return [];
  }


  /**
   * 获取提供访问应用资源的能力
   * @returns
   */
  private static getResourceManager(): resourceManager.ResourceManager {
    return getContext().resourceManager;
  }


  /**
   * Uint8Array转字符串
   * @param src Uint8Array
   * @returns 字符串
   */
  private static unit8ArrayToStr(src: Uint8Array, encoding: buffer.BufferEncoding = 'utf-8'): string {
    let textDecoder = util.TextDecoder.create(encoding, { ignoreBOM: true })
    let result = textDecoder.decodeWithStream(src, { stream: true });
    return result;
  }


  /**
   * 判断字符串是否为空(undefined、null、字符串长度为0)
   * @param str 被检测的字符串
   * @return 是否为空
   */
  private static isEmpty(str: string | undefined | null): boolean {
    return str == undefined || str == null || str.length == 0;
  }


}
