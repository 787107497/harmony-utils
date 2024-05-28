import { uniformTypeDescriptor } from '@kit.ArkData';
import { filePreview } from '@kit.PreviewKit';
import { Want, wantConstant } from '@kit.AbilityKit';
import { FileUtil } from './FileUtil';
import { AppUtil } from './AppUtil';
import { StrUtil } from './StrUtil';


/**
 * 文件预览工具类
 */
export class PreviewUtil {

  private constructor() {}


  /**
   * 根据文件uri构建PreviewInfo
   * @param uri 文件的uri
   * @returns
   */
  static generatePreviewInfo(uri: string): filePreview.PreviewInfo {
    let fileName = FileUtil.getFileName(uri);
    let fileExtention = FileUtil.getFileExtention(fileName);
    let mimeType = PreviewUtil.getMimeType(fileExtention);
    let previewInfo: filePreview.PreviewInfo = {
      title: fileName,
      uri: uri,
      mimeType: mimeType
    };
    return previewInfo;
  }


  /**
   * 通过传入文件预览信息，打开预览窗口。1秒内重复调用无效。
   * @param previewInfo 文件的预览信息
   * @returns
   */
  static openPreview(previewInfo: filePreview.PreviewInfo): Promise<void> {
    return filePreview.openPreview(AppUtil.getContext(), previewInfo);
  }


  /**
   * 通过传入文件的uri，打开预览窗口。1秒内重复调用无效。
   * @param uri 文件的uri
   * @returns
   */
  static async openPreviewEasy(uri: string): Promise<void> {
    let previewInfo = PreviewUtil.generatePreviewInfo(uri);
    return await filePreview.openPreview(AppUtil.getContext(), previewInfo);
  }


  /**
   * 根据文件的uri判断文件是否可预览
   * @param uri 文件的uri
   * @returns
   */
  static canPreview(uri: string): Promise<boolean> {
    return filePreview.canPreview(AppUtil.getContext(), uri);
  }


  /**
   * 判断预览窗口是否已经存在
   */
  static hasDisplayed(): Promise<boolean> {
    return filePreview.hasDisplayed(AppUtil.getContext());
  }


  /**
   * 关闭预览窗口，仅当预览窗口存在时起效。
   */
  static closePreview() {
    return filePreview.closePreview(AppUtil.getContext());
  }


  /**
   * 加载预览文件信息。仅当预览窗口存在时起效。
   * @param previewInfo 文件的预览信息
   * @returns
   */
  static loadData(previewInfo: filePreview.PreviewInfo) {
    return filePreview.loadData(AppUtil.getContext(), previewInfo);
  }


  /**
   * 加载预览文件信息。仅当预览窗口存在时起效。
   * @param uri 文件的uri
   * @returns
   */
  static async loadDataEasy(uri: string): Promise<void> {
    let previewInfo = PreviewUtil.generatePreviewInfo(uri);
    return await filePreview.loadData(AppUtil.getContext(), previewInfo);
  }


  /**
   * 调用其他应用预览文件
   * @param uri 文件的uri
   * @param write 是否有写入权限
   * @returns
   */
  static onSharePreview(uri: string, write: boolean = true): Promise<void> {
    let fileName = FileUtil.getFileName(uri);
    let mimeType = PreviewUtil.getMimeType(FileUtil.getFileExtention(fileName));
    let want: Want = {
      // 配置被分享文件的读写权限，例如对被分享应用进行读写授权
      flags: write ? (wantConstant.Flags.FLAG_AUTH_WRITE_URI_PERMISSION | wantConstant.Flags.FLAG_AUTH_READ_URI_PERMISSION) : wantConstant.Flags.FLAG_AUTH_READ_URI_PERMISSION,
      action: 'ohos.want.action.sendData', //配置分享应用的隐式拉起规则
      uri: uri,
      type: mimeType
    }
    return AppUtil.getContext().startAbility(want);
  }


  /**
   * 根据文件后缀名获取文件mimeType
   * @param fileExtention 文件后缀名，例如 html txt
   */
  static getMimeType(fileExtention: string): string {
    let mimeType = PreviewUtil.getMimeTypeMap().get(fileExtention)
    if (mimeType) {
      return mimeType;
    }
    let belongingToTypeStr: string = '*';
    let typeStr: string = '*';
    let dataType = uniformTypeDescriptor.getUniformDataTypeByFilenameExtension(`.${fileExtention}`);
    let descriptor = uniformTypeDescriptor.getTypeDescriptor(dataType);
    let belongingToTypes = descriptor.belongingToTypes;
    if (belongingToTypes != undefined && belongingToTypes.length > 0) {
      let belong = belongingToTypes[0].replace('general.', '');
      if (StrUtil.isNotEmpty(belong)) {
        belongingToTypeStr = belong;
      }
    }
    if (StrUtil.isNotEmpty(descriptor.typeId) && !StrUtil.startsWith(descriptor.typeId, 'flex.')) {
      typeStr = descriptor.typeId.replace('general.', '');
    }
    return `${belongingToTypeStr}/${typeStr}`
  }


  /**
   * 根据文件后缀名获取对应文件类型的图标
   * @param fileExtention
   * @returns
   */
  static getIconFileStr(fileExtention: string): string {
    let dataType = uniformTypeDescriptor.getUniformDataTypeByFilenameExtension(`.${fileExtention}`);
    let descriptor = uniformTypeDescriptor.getTypeDescriptor(dataType);
    return descriptor.iconFile;
  }


  /**
   * filePreview支持的预览文件类型
   * @returns
   */
  static getMimeTypeMap(): Map<string, string> {
    let map = new Map<string, string>();
    map.set('txt', 'text/plain');
    map.set('html', 'text/html');
    map.set('htm', 'text/html');
    map.set('jpeg', 'image/jpeg');
    map.set('jpg', 'image/jpeg');
    map.set('png', 'image/png');
    map.set('gif', 'image/gif');
    map.set('webp', 'image/webp');
    map.set('bmp', 'image/bmp');
    map.set('svg', 'image/svg+xml');
    map.set('m4a', 'audio/mp4a-latm');
    map.set('aac', 'audio/aac');
    map.set('mp3', 'audio/mpeg');
    map.set('ogg', 'audio/ogg');
    map.set('wav', 'audio/x-wav');
    map.set('mp4', 'video/mp4');
    map.set('mkv', 'video/x-matroska');
    map.set('ts', 'video/mp2ts');
    return map;
  }


  /**
   * 判断当前设备是否支持文件预览能力
   * @returns
   */
  static canIUsePreview() {
    return canIUse("SystemCapability.Filemanagement.FilePreview.Core")
  }

}