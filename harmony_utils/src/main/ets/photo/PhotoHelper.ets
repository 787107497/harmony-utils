import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { dataSharePredicates } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { LogUtil } from '../utils/LogUtil';

const PHOTO_DEFAULT_SELECT_NUMBER: number = 9; //数量

/**
 * 相册选择和保存,工具类
 *  需要权限：
 *    ohos.permission.READ_IMAGEVIDEO
 *    ohos.permission.WRITE_IMAGEVIDEO
 */
export class PhotoHelper {

  private constructor() {}


  /**
   * 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频。
   * @param options
   * @returns
   */
  static async select(options?: photoAccessHelper.PhotoSelectOptions): Promise<Array<string>> {
    try {
      if (!options) {
        options = new photoAccessHelper.PhotoSelectOptions();
      }
      if (!options.MIMEType) { //可选择的媒体文件类型，若无此参数，则默认为图片和视频类型。
        options.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
      }
      if (!options.maxSelectNumber) { //选择媒体文件数量的最大值,默认9
        options.maxSelectNumber = PHOTO_DEFAULT_SELECT_NUMBER;
      }
      if (options.isPhotoTakingSupported == undefined) {
        options.isPhotoTakingSupported = true; //支持拍照。
      }
      if (options.isEditSupported == undefined) {
        options.isEditSupported = true; //支持编辑照片。
      }
      let photoPicker = new photoAccessHelper.PhotoViewPicker();
      let photoSelectResult: photoAccessHelper.PhotoSelectResult = await photoPicker.select(options);
      if (photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0) {
        return photoSelectResult.photoUris
      } else {
        return [];
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`PhotoHelper-select-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return [];
    }
  }


  /**
   * 保存图片或视频到相册
   * @param photoType 创建的文件类型，IMAGE或者VIDEO类型。
   * @param extension 文件名后缀参数，例如：'jpg'。
   * @param options 创建选项，例如{title: 'testPhoto'}。
   * @returns
   */
  static async save(photoType: photoAccessHelper.PhotoType, extension: string, options?: photoAccessHelper.CreateOptions): Promise<string | null> {
    try {
      let photoHelper = photoAccessHelper.getPhotoAccessHelper(getContext());
      return await photoHelper.createAsset(photoType, extension, options);
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`PhotoHelper-save-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return null;
    }
  }


  /**
   * 获取对应uri的PhotoAsset对象,用于读取文件信息。
   * @param uri 文件uri
   *    PhotoAsset - photoAccessHelper.PhotoKeys:
   *      URI  'uri'  文件uri。
   *      PHOTO_TYPE  'media_type'  媒体文件类型。
   *      DISPLAY_NAME  'display_name'  显示名字。
   *      SIZE  'size'  文件大小。
   *      DURATION  'duration'  持续时间（单位：毫秒）。
   *      WIDTH  'width'  图片宽度（单位：像素）。
   *      HEIGHT  'height'  图片高度（单位：像素）。
   *      DATE_TAKEN  'date_taken'  拍摄日期（文件拍照时间距1970年1月1日的秒数值）。
   *      ORIENTATION  'orientation'  图片文件的方向。
   *      TITLE  'title'  文件标题。
   *      getThumbnail 获取缩略图
   * @returns
   */
  static async getPhotoAsset(uri: string): Promise<photoAccessHelper.PhotoAsset | null> {
    try {
      let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(getContext());
      let predicates: dataSharePredicates.DataSharePredicates = new dataSharePredicates.DataSharePredicates();
      // 配置查询条件，使用PhotoViewPicker选择图片返回的uri进行查询
      predicates.equalTo('uri', uri);
      let fetchOption: photoAccessHelper.FetchOptions = {
        fetchColumns: ['media_type', 'display_name', 'size', 'title', 'width', 'height', 'date_taken',
          'uri', 'duration', 'orientation', 'date_added', 'date_modified', 'is_favorite'],
        predicates: predicates
      };
      let fetchResult: photoAccessHelper.FetchResult<photoAccessHelper.PhotoAsset> = await phAccessHelper.getAssets(fetchOption);
      // 得到uri对应的PhotoAsset对象，读取文件的部分信息
      const photoAsset: photoAccessHelper.PhotoAsset = await fetchResult.getFirstObject();
      return photoAsset;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`PhotoHelper-getPhotoAsset-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return null;
    }
  }

}