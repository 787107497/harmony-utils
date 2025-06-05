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

import { pasteboard } from '@kit.BasicServicesKit';
import { Want } from '@kit.AbilityKit';
import { image } from '@kit.ImageKit';
import { PermissionUtil } from './PermissionUtil';

/**
 * TODO 剪贴板工具类
 * 需要权限：ohos.permission.READ_PASTEBOARD  //允许应用读取剪贴板。
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class PasteboardUtil {

  /**
   * 申请剪贴板权限
   * @returns
   */
  static async requestPermissions(): Promise<boolean> {
    return await PermissionUtil.requestPermissionsEasy('ohos.permission.READ_PASTEBOARD');
  }


  /**
   * 获取系统剪贴板对象
   * @returns
   */
  static getSystemPasteboard(): pasteboard.SystemPasteboard {
    const systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
    return systemPasteboard;
  }


  /**
   * 判断系统剪贴板中是否有内容，使用Promise异步回调。
   * @returns
   */
  static async hasData(): Promise<boolean> {
    return PasteboardUtil.getSystemPasteboard().hasData();
  }

  /**
   * 判断系统剪贴板中是否有内容。
   * @returns
   */
  static hasDataSync(): boolean {
    return PasteboardUtil.getSystemPasteboard().hasDataSync();
  }


  /**
   * 将数据写入系统剪贴板，使用Promise异步回调。
   * @param mimeType 剪贴板数据对应的MIME类型，可以是常量中已定义的类型，包括HTML类型，WANT类型，纯文本类型，URI类型，PIXELMAP类型；也可以是自定义的MIME类型。
   * @param value 自定义数据内容。
   * @returns
   */
  static async setData(mimeType: string, value: pasteboard.ValueType): Promise<void> {
    const pasteData: pasteboard.PasteData = pasteboard.createData(mimeType, value);
    PasteboardUtil.getSystemPasteboard().setData(pasteData);
  }

  /**
   * 将数据写入系统剪贴板。
   * @param mimeType 剪贴板数据对应的MIME类型，可以是常量中已定义的类型，包括HTML类型，WANT类型，纯文本类型，URI类型，PIXELMAP类型；也可以是自定义的MIME类型。
   * @param value 自定义数据内容。
   * @returns
   */
  static setDataSync(mimeType: string, value: pasteboard.ValueType) {
    const pasteData: pasteboard.PasteData = pasteboard.createData(mimeType, value);
    PasteboardUtil.getSystemPasteboard().setDataSync(pasteData);
  }


  /**
   * 读取系统剪贴板内容，使用Promise异步回调。
   * @returns
   */
  static async getData(): Promise<pasteboard.PasteData> {
    return PasteboardUtil.getSystemPasteboard().getData();
  }

  /**
   * 读取系统剪贴板内容
   * @returns
   */
  static getDataSync(): pasteboard.PasteData {
    return PasteboardUtil.getSystemPasteboard().getDataSync();
  }


  /**
   * 将纯文本数据写入系统剪贴板，使用Promise异步回调。
   * @param text 纯文本数据
   * @returns
   */
  static async setDataText(text: string): Promise<void> {
    PasteboardUtil.setData(pasteboard.MIMETYPE_TEXT_PLAIN, text);
  }

  /**
   * 将纯文本数据写入系统剪贴板。
   * @param text 纯文本数据
   * @returns
   */
  static setDataTextSync(text: string) {
    PasteboardUtil.setDataSync(pasteboard.MIMETYPE_TEXT_PLAIN, text);
  }


  /**
   * 读取系统剪贴板纯文本内容，使用Promise异步回调。
   * @returns
   */
  static async getDataText(): Promise<string> {
    const pasteData: pasteboard.PasteData = await PasteboardUtil.getData();
    return pasteData.getPrimaryText();
  }

  /**
   * 读取系统剪贴板纯文本内容。
   * @returns
   */
  static getDataTextSync(): string {
    return PasteboardUtil.getDataSync().getPrimaryText();
  }


  /**
   * 将HTML数据写入系统剪贴板，使用Promise异步回调。
   * @param html HTML内容
   * @returns
   */
  static async setDataHtml(html: string): Promise<void> {
    PasteboardUtil.setData(pasteboard.MIMETYPE_TEXT_HTML, html);
  }

  /**
   * 将HTML数据写入系统剪贴板。
   * @param html HTML内容
   * @returns
   */
  static async setDataHtmlSync(html: string) {
    PasteboardUtil.setDataSync(pasteboard.MIMETYPE_TEXT_HTML, html);
  }


  /**
   * 读取系统剪贴板HTML内容，使用Promise异步回调。
   * @returns
   */
  static async getDataHtml(): Promise<string> {
    const pasteData: pasteboard.PasteData = await PasteboardUtil.getData();
    return pasteData.getPrimaryHtml();
  }

  /**
   * 读取系统剪贴板HTML内容。
   * @returns
   */
  static getDataHtmlSync(): string {
    return PasteboardUtil.getDataSync().getPrimaryHtml();
  }


  /**
   * 将URI数据写入系统剪贴板，使用Promise异步回调。
   * @param uri URI内容
   * @returns
   */
  static async setDataUri(uri: string): Promise<void> {
    PasteboardUtil.setData(pasteboard.MIMETYPE_TEXT_URI, uri);
  }

  /**
   * 将URI数据写入系统剪贴板。
   * @param uri URI内容
   * @returns
   */
  static setDataUriSync(uri: string) {
    PasteboardUtil.setDataSync(pasteboard.MIMETYPE_TEXT_URI, uri);
  }


  /**
   * 读取系统剪贴板URI内容，使用Promise异步回调。
   * @returns
   */
  static async getDataUri(): Promise<string> {
    const pasteData: pasteboard.PasteData = await PasteboardUtil.getData();
    return pasteData.getPrimaryUri();
  }

  /**
   * 读取系统剪贴板URI内容。
   * @returns
   */
  static getDataUriSync(): string {
    return PasteboardUtil.getDataSync().getPrimaryUri();
  }


  /**
   * 将Want数据写入系统剪贴板，使用Promise异步回调。
   * @param want Want内容
   * @returns
   */
  static async setDataWant(want: Want): Promise<void> {
    PasteboardUtil.setData(pasteboard.MIMETYPE_TEXT_WANT, want);
  }

  /**
   * 将Want数据写入系统剪贴板。
   * @param want Want内容
   * @returns
   */
  static setDataWantSync(want: Want) {
    PasteboardUtil.setDataSync(pasteboard.MIMETYPE_TEXT_WANT, want);
  }


  /**
   * 读取系统剪贴板Want内容，使用Promise异步回调。
   * @returns
   */
  static async getDataWant(): Promise<Want> {
    const pasteData: pasteboard.PasteData = await PasteboardUtil.getData();
    return pasteData.getPrimaryWant();
  }

  /**
   * 读取系统剪贴板Want内容。
   * @returns
   */
  static getDataWantSync(): Want {
    return PasteboardUtil.getDataSync().getPrimaryWant();
  }


  /**
   * 将PixelMap数据写入系统剪贴板，使用Promise异步回调。
   * @param pixelMap PixelMap
   * @returns
   */
  static async setDataPixelMap(pixelMap: image.PixelMap): Promise<void> {
    PasteboardUtil.setData(pasteboard.MIMETYPE_PIXELMAP, pixelMap);
  }

  /**
   * 将PixelMap数据写入系统剪贴板。
   * @param pixelMap PixelMap
   * @returns
   */
  static setDataPixelMapSync(pixelMap: image.PixelMap) {
    PasteboardUtil.setDataSync(pasteboard.MIMETYPE_PIXELMAP, pixelMap);
  }


  /**
   * 读取系统剪贴板PixelMap内容，使用Promise异步回调。
   * @returns
   */
  static async getDataPixelMap(): Promise<image.PixelMap> {
    const pasteData: pasteboard.PasteData = await PasteboardUtil.getData();
    return pasteData.getPrimaryPixelMap();
  }

  /**
   * 读取系统剪贴板PixelMap内容。
   * @returns
   */
  static getDataPixelMapSync(): image.PixelMap {
    return PasteboardUtil.getDataSync().getPrimaryPixelMap();
  }


  /**
   * 读取系统剪贴板里的字符串（），使用Promise异步回调。
   * @returns
   */
  static async getDataStr(): Promise<string> {
    if (PasteboardUtil.hasDataSync()) {
      let pasteData = await PasteboardUtil.getData();
      let mimeType = pasteData.getPrimaryMimeType();
      if (mimeType === pasteboard.MIMETYPE_TEXT_PLAIN) {
        return pasteData.getPrimaryText();
      } else if (mimeType === pasteboard.MIMETYPE_TEXT_HTML) {
        return pasteData.getPrimaryHtml();
      } else if (mimeType === pasteboard.MIMETYPE_TEXT_URI) {
        return pasteData.getPrimaryUri();
      }
    }
    return "";
  }

  /**
   * 读取系统剪贴板里的字符串。
   * @returns
   */
  static getDataStrSync(): string {
    if (PasteboardUtil.hasDataSync()) {
      let pasteData = PasteboardUtil.getDataSync();
      let mimeType = pasteData.getPrimaryMimeType();
      if (mimeType === pasteboard.MIMETYPE_TEXT_PLAIN) {
        return pasteData.getPrimaryText();
      } else if (mimeType === pasteboard.MIMETYPE_TEXT_HTML) {
        return pasteData.getPrimaryHtml();
      } else if (mimeType === pasteboard.MIMETYPE_TEXT_URI) {
        return pasteData.getPrimaryUri();
      }
    }
    return "";
  }


  /**
   * 读取系统剪贴板里的内容（纯文本内容、HTML内容、URI内容、Want内容、PixelMap内容）。
   * @returns
   */
  static getDataEasy(): string | Want | image.PixelMap | undefined {
    if (PasteboardUtil.hasDataSync()) {
      let pasteData = PasteboardUtil.getDataSync();
      let mimeType = pasteData.getPrimaryMimeType();
      if (mimeType === pasteboard.MIMETYPE_TEXT_PLAIN) {
        return pasteData.getPrimaryText();
      } else if (mimeType === pasteboard.MIMETYPE_TEXT_HTML) {
        return pasteData.getPrimaryHtml();
      } else if (mimeType === pasteboard.MIMETYPE_TEXT_URI) {
        return pasteData.getPrimaryUri();
      } else if (mimeType === pasteboard.MIMETYPE_TEXT_WANT) {
        return pasteData.getPrimaryWant();
      } else if (mimeType === pasteboard.MIMETYPE_PIXELMAP) {
        return pasteData.getPrimaryPixelMap();
      }
    }
    return undefined;
  }


  /**
   * 清空系统剪贴板内容，使用Promise异步回调。
   * @returns
   */
  static async clearData(): Promise<void> {
    PasteboardUtil.getSystemPasteboard().clearData();
  }

  /**
   * 清空系统剪贴板内容。
   * @returns
   */
  static clearDataSync() {
    PasteboardUtil.getSystemPasteboard().clearDataSync();
  }


  /**
   * 读取系统剪贴板里的字符串。该方法已废弃，建议使用getDataStrSync()。
   * @returns
   */
  static getDataSyncStr(): string {
    return PasteboardUtil.getDataStrSync();
  }


}