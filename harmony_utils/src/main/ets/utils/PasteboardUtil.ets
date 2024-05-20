import { pasteboard } from '@kit.BasicServicesKit';
import { StrUtil } from './StrUtil';

/**
 * 剪贴板工具类
 */
export class PasteboardUtil {

  private constructor() {}


  /**
   * 将纯文本数据写入系统剪贴板，使用Promise异步回调。
   * @param data
   * @returns
   */
  static setDataText(text: string): Promise<void> {
    let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, text);
    return PasteboardUtil.getSystemPasteboard().setData(pasteData);
  }


  /**
   * 将Htm数据写入系统剪贴板，使用Promise异步回调。
   * @param data
   * @returns
   */
  static setDataHtml(html: string): Promise<void> {
    let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_HTML, html);
    return PasteboardUtil.getSystemPasteboard().setData(pasteData);
  }


  /**
   * 将Uri数据写入系统剪贴板，使用Promise异步回调。
   * @param data
   * @returns
   */
  static setDataUri(uri: string): Promise<void> {
    let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_URI, uri);
    return PasteboardUtil.getSystemPasteboard().setData(pasteData);
  }


  /**
   * 读取系统剪贴板内容，使用Promise异步回调。
   * @returns
   */
  static getData(): Promise<pasteboard.PasteData> {
    return PasteboardUtil.getSystemPasteboard().getData()
  }


  /**
   * 读取系统剪贴板里的字符串，使用Promise异步回调。
   * @returns
   */
  static async getDataStr(): Promise<string> {
    let text = '';
    if (PasteboardUtil.hasDataSync()) {
      let data = await PasteboardUtil.getData()
      text = data.getPrimaryText();
      if (StrUtil.isEmpty(text)) {
        text = data.getPrimaryHtml();
      }
      if (StrUtil.isEmpty(text)) {
        text = data.getPrimaryUri();
      }
      if (StrUtil.isEmpty(text)) {
        text = '';
      }
    }
    return text
  }


  /**
   * 读取系统剪贴板里的字符串。
   * @returns
   */
  static getDataSyncStr(): string {
    let text = '';
    if (PasteboardUtil.hasDataSync()) {
      let data = PasteboardUtil.getSystemPasteboard().getDataSync()
      text = data.getPrimaryText();
      if (StrUtil.isEmpty(text)) {
        text = data.getPrimaryHtml();
      }
      if (StrUtil.isEmpty(text)) {
        text = data.getPrimaryUri();
      }
      if (StrUtil.isEmpty(text)) {
        text = '';
      }
    }
    return text
  }


  /**
   * 清空系统剪贴板内容，使用Promise异步回调。
   * @returns
   */
  static clearData(): Promise<void> {
    return PasteboardUtil.getSystemPasteboard().clearData()
  }


  /**
   * 判断系统剪贴板中是否有内容，使用Promise异步回调。
   * @returns
   */
  static hasData(): Promise<boolean> {
    return PasteboardUtil.getSystemPasteboard().hasData()
  }

  /**
   * 判断系统剪贴板中是否有内容。
   * @returns
   */
  static hasDataSync(): boolean {
    return PasteboardUtil.getSystemPasteboard().hasDataSync()
  }

  /**
   * 获取系统剪贴板对象
   * @returns
   */
  private static getSystemPasteboard(): pasteboard.SystemPasteboard {
    let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
    return systemPasteboard;
  }
}