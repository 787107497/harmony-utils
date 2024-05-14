import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { LogUtil } from './LogUtil';
import picker from '@ohos.file.picker';
import { camera, cameraPicker } from '@kit.CameraKit';
import { common } from '@kit.AbilityKit';
import { dataSharePredicates } from '@kit.ArkData';


const PHOTO_DEFAULT_SELECT_NUMBER: number = 9; //数量

/**
 * 拍照、文件(文件、图片、视频、音频)选择和保存,工具类
 */
export class FilePickerUtil {

  private constructor() {}


  /**
   * 调用系统相机，拍照、录视频
   * @param options
   * @returns
   */
  static async camera(options?: CameraOptions): Promise<string> {
    try {
      if (!options) {
        options = new CameraOptions();
      }
      if (!options.cameraPosition) {
        options.cameraPosition = camera.CameraPosition.CAMERA_POSITION_BACK;
      }
      if (!options.mediaTypes || options.mediaTypes.length == 0) {
        options.mediaTypes = [cameraPicker.PickerMediaType.PHOTO, cameraPicker.PickerMediaType.VIDEO];
      }
      let pickerProfile: cameraPicker.PickerProfile = new cameraPicker.PickerProfile();
      pickerProfile.cameraPosition = options.cameraPosition;
      if (options.saveUri) {
        pickerProfile.saveUri = options.saveUri;
      }
      if (options.videoDuration) {
        pickerProfile.videoDuration = options.videoDuration;
      }
      let context = getContext() as common.UIAbilityContext;
      let pickerResult: cameraPicker.PickerResult = await cameraPicker.pick(context,
        options.mediaTypes, pickerProfile);
      if (pickerResult && pickerResult.resultUri) {
        return pickerResult.resultUri;
      }
    } catch (err) {
      LogUtil.error("FilePickerUtil-camera-异常：" + JSON.stringify(err))
    }
    return "";
  }


  /**
   * 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频。
   * @param options
   * @returns
   */
  static async selectPhoto(options?: PhotoSelectOptions): Promise<Array<string>> {
    try {
      if (!options) {
        options = new PhotoSelectOptions();
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
      if (options.isSearchSupported == undefined) {
        options.isSearchSupported = true; //支持编辑照片。
      }
      let photoSelectOptions: photoAccessHelper.PhotoSelectOptions = {
        MIMEType: options.MIMEType,
        maxSelectNumber: options.maxSelectNumber,
        isPhotoTakingSupported: options.isPhotoTakingSupported,
        isEditSupported: options.isEditSupported,
        isSearchSupported: options.isSearchSupported,
        recommendationOptions: options.recommendationOptions,
        preselectedUris: options.preselectedUris
      }
      let photoPicker = new photoAccessHelper.PhotoViewPicker();
      let photoSelectResult: photoAccessHelper.PhotoSelectResult = await photoPicker.select(photoSelectOptions)
      if (photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0) {
        return photoSelectResult.photoUris
      } else {
        return [];
      }
    } catch (err) {
      LogUtil.error("FilePickerUtil-selectPhoto-异常：" + JSON.stringify(err))
      return [];
    }
  }


  /**
   * 通过保存模式拉起photoPicker进行保存图片或视频资源的文件名，若无此参数，则默认需要用户自行输入
   * @param newFileNames
   */
  static async savePhoto(newFileNames?: Array<string>): Promise<Array<string>> {
    try {
      let photoPicker = new picker.PhotoViewPicker();
      if (newFileNames == undefined || newFileNames == null || newFileNames.length == 0) {
        let photoSaveResult = await photoPicker.save()
        if (photoSaveResult && photoSaveResult.length > 0) {
          return photoSaveResult
        } else {
          return [];
        }
      } else {
        let PhotoSaveOptions = new picker.PhotoSaveOptions();
        PhotoSaveOptions.newFileNames = newFileNames;
        let photoSaveResult = await photoPicker.save(PhotoSaveOptions)
        if (photoSaveResult && photoSaveResult.length > 0) {
          return photoSaveResult
        } else {
          return [];
        }
      }
    } catch (error) {
      LogUtil.error("FilePickerUtil-savePhoto-异常：" + JSON.stringify(error))
      return [];
    }
  }


  /**
   * 通过选择模式拉起documentPicker界面，用户可以选择一个或多个文件。
   * @param options
   * @returns
   */
  static async selectDocument(options?: DocumentSelectOptions): Promise<Array<string>> {
    try {
      if (!options) {
        options = new DocumentSelectOptions();
      }
      if (!options.maxSelectNumber) { //选择媒体文件数量的最大值,默认9
        options.maxSelectNumber = PHOTO_DEFAULT_SELECT_NUMBER;
      }
      if (!options.selectMode) { //支持选择的资源类型,默认文件
        options.selectMode = 0;
      }
      let documentSelectOptions: picker.DocumentSelectOptions = {
        maxSelectNumber: options.maxSelectNumber,
        defaultFilePathUri: options.defaultFilePathUri,
        fileSuffixFilters: options.fileSuffixFilters,
        selectMode: options.selectMode
      }
      let documentPicker = new picker.DocumentViewPicker();
      return await documentPicker.select(documentSelectOptions);
    } catch (error) {
      LogUtil.error("FilePickerUtil-selectDocument-异常：" + JSON.stringify(error))
      return [];
    }
  }


  /**
   * 通过保存模式拉起documentPicker界面，用户可以保存一个或多个文件。
   * @param options
   * @returns
   */
  static async saveDocument(newFileNames?: Array<string>): Promise<Array<string>> {
    try {
      let documentPicker = new picker.DocumentViewPicker();
      if (newFileNames == undefined || newFileNames == null || newFileNames.length == 0) {
        return await documentPicker.save();
      } else {
        let documentSaveOptions = new picker.DocumentSaveOptions();
        documentSaveOptions.newFileNames = newFileNames;
        return await documentPicker.save(documentSaveOptions);
      }
    } catch (error) {
      LogUtil.error("FilePickerUtil-saveDocument-异常：" + JSON.stringify(error))
      return [];
    }
  }


  /**
   * 通过选择模式拉起audioPicker界面（目前拉起的是documentPicker，audioPicker在规划中），用户可以选择一个或多个音频文件。
   * @returns
   */
  static async selectAudio(): Promise<Array<string>> {
    try {
      let AudioSelectOptions = new picker.AudioSelectOptions();
      let audioPicker = new picker.AudioViewPicker();
      return await audioPicker.select(AudioSelectOptions);
    } catch (error) {
      LogUtil.error("FilePickerUtil-selectAudio-异常：" + JSON.stringify(error));
      return [];
    }
  }


  /**
   * 通过保存模式拉起audioPicker界面（目前拉起的是documentPicker，audioPicker在规划中），用户可以保存一个或多个音频文件。
   * @param newFileNames
   * @returns
   */
  static async saveAudio(newFileNames?: Array<string>): Promise<Array<string>> {
    try {
      let audioPicker = new picker.AudioViewPicker();
      if (newFileNames == undefined || newFileNames == null || newFileNames.length == 0) {
        return await audioPicker.save();
      } else {
        let AudioSaveOptions = new picker.AudioSaveOptions();
        AudioSaveOptions.newFileNames = newFileNames;
        return await audioPicker.save(AudioSaveOptions);
      }
    } catch (error) {
      LogUtil.error("FilePickerUtil-saveAudio-异常：" + JSON.stringify(error))
      return [];
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
        fetchColumns: [],
        predicates: predicates
      };
      let fetchResult: photoAccessHelper.FetchResult<photoAccessHelper.PhotoAsset> = await phAccessHelper.getAssets(fetchOption);
      // 得到uri对应的PhotoAsset对象，读取文件的部分信息
      const photoAsset: photoAccessHelper.PhotoAsset = await fetchResult.getFirstObject();
      return photoAsset;
    } catch (error) {
      console.error('getPhotoAssetFromUri-异常信息: ' + JSON.stringify(error));
      return null;
    }
  }



}


/**
 * 相机参数类
 */
class CameraOptions {
  mediaTypes: Array<cameraPicker.PickerMediaType> = [cameraPicker.PickerMediaType.PHOTO, cameraPicker.PickerMediaType.VIDEO]; //媒体类型。
  cameraPosition: camera.CameraPosition = camera.CameraPosition.CAMERA_POSITION_BACK; //相机的位置。
  saveUri?: string; //保存配置信息的uri。
  videoDuration?: number; //录制的最大时长。
}

/**
 * 相册选择参数类
 */
class PhotoSelectOptions {
  MIMEType?: photoAccessHelper.PhotoViewMIMETypes = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE; //可选择的媒体文件类型，若无此参数，则默认为图片和视频类型。
  maxSelectNumber?: number = PHOTO_DEFAULT_SELECT_NUMBER; //选择媒体文件数量的最大值(默认值为50，最大值为500)。
  isPhotoTakingSupported?: boolean = true; //支持拍照。
  isEditSupported?: boolean = true; //支持编辑照片。
  isSearchSupported?: boolean = true; //支持搜索。
  recommendationOptions?: photoAccessHelper.RecommendationOptions; //支持照片推荐。
  preselectedUris?: Array<string>; //预选择图片的uri数据。
}


/**
 * 文档选择参数类
 */
class DocumentSelectOptions {
  maxSelectNumber?: number = PHOTO_DEFAULT_SELECT_NUMBER; //选择文件最大个数，上限500，有效值范围1-500（选择目录仅支持特定设备，且目录选择的最大个数为1）
  defaultFilePathUri?: string; //指定选择的文件或者目录路径
  fileSuffixFilters?: Array<string>; //选择文件的后缀类型，若选择项存在多个后缀名，则每一个后缀名之间用英文逗号进行分隔
  selectMode?: picker.DocumentSelectMode = 0; //支持选择的资源类型，比如：文件、文件夹和二者混合，仅支持特定设备。系统能力： SystemCapability.FileManagement.UserFileService.FolderSelection
}