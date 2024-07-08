import { LogUtil } from './LogUtil';
import picker from '@ohos.file.picker';
import { camera, cameraPicker } from '@kit.CameraKit';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';


const DOCUMENT_DEFAULT_SELECT_NUMBER: number = 9; //数量

/**
 * 拍照、文件(文件、图片、视频、音频)选择和保存,工具类
 *  需要权限：
 *    ohos.permission.READ_MEDIA
 *    ohos.permission.WRITE_MEDIA
 *    ohos.permission.CAMERA
 */
export class PickerUtil {

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
      if (!options.mediaTypes || options.mediaTypes.length == 0) {
        options.mediaTypes = [cameraPicker.PickerMediaType.PHOTO, cameraPicker.PickerMediaType.VIDEO];
      }
      let pickerProfile: cameraPicker.PickerProfile = {
        cameraPosition: options.cameraPosition ? options.cameraPosition : camera.CameraPosition.CAMERA_POSITION_BACK,
        videoDuration: options.videoDuration,
        saveUri: options.saveUri
      };

      let context = getContext() as common.Context;
      let pickerResult: cameraPicker.PickerResult = await cameraPicker.pick(context,
        options.mediaTypes, pickerProfile);
      if (pickerResult && pickerResult.resultUri) {
        return pickerResult.resultUri;
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`PickerUtil-camera-异常 ~ code: ${error.code} -·- message: ${error.message}`);
    }
    return "";
  }


  /**
   * 通过选择模式拉起PhotoViewPicker界面，用户可以选择一个或多个图片/视频。
   * @param options
   * @returns
   */
  static async selectPhoto(options?: picker.PhotoSelectOptions): Promise<Array<string>> {
    try {
      if (!options) {
        options = new picker.PhotoSelectOptions();
      }
      if (!options.MIMEType) { //可选择的媒体文件类型，若无此参数，则默认为图片和视频类型。
        options.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      }
      if (!options.maxSelectNumber) { //选择媒体文件数量的最大值,默认9
        options.maxSelectNumber = DOCUMENT_DEFAULT_SELECT_NUMBER;
      }
      let photoPicker = new picker.PhotoViewPicker();
      let photoSelectResult: picker.PhotoSelectResult = await photoPicker.select(options);
      if (photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0) {
        return photoSelectResult.photoUris;
      } else {
        return [];
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`PickerUtil-selectPhoto-异常 ~ code: ${error.code} -·- message: ${error.message}`);
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
        let photoSaveResult = await photoPicker.save();
        if (photoSaveResult && photoSaveResult.length > 0) {
          return photoSaveResult;
        } else {
          return [];
        }
      } else {
        let PhotoSaveOptions = new picker.PhotoSaveOptions();
        PhotoSaveOptions.newFileNames = newFileNames;
        let photoSaveResult = await photoPicker.save(PhotoSaveOptions);
        if (photoSaveResult && photoSaveResult.length > 0) {
          return photoSaveResult;
        } else {
          return [];
        }
      }
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`PickerUtil-savePhoto-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return [];
    }
  }


  /**
   * 通过选择模式拉起documentPicker界面，用户可以选择一个或多个文件。
   * @param options
   * @returns
   */
  static async selectDocument(options?: picker.DocumentSelectOptions): Promise<Array<string>> {
    try {
      if (!options) {
        options = new picker.DocumentSelectOptions();
      }
      if (!options.maxSelectNumber) { //选择媒体文件数量的最大值,默认9
        options.maxSelectNumber = DOCUMENT_DEFAULT_SELECT_NUMBER;
      }
      if (!options.selectMode) { //支持选择的资源类型,默认文件
        options.selectMode = picker.DocumentSelectMode.FILE;
      }
      let documentPicker = new picker.DocumentViewPicker();
      return await documentPicker.select(options);
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`PickerUtil-selectDocument-异常 ~ code: ${error.code} -·- message: ${error.message}`);
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
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`PickerUtil-saveDocument-异常 ~ code: ${error.code} -·- message: ${error.message}`);
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
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`PickerUtil-selectAudio-异常 ~ code: ${error.code} -·- message: ${error.message}`);
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
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`PickerUtil-saveAudio-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return [];
    }
  }

}


/**
 * 相机参数类
 */
export class CameraOptions {
  mediaTypes: Array<cameraPicker.PickerMediaType> = [cameraPicker.PickerMediaType.PHOTO, cameraPicker.PickerMediaType.VIDEO]; //媒体类型。
  cameraPosition: camera.CameraPosition = camera.CameraPosition.CAMERA_POSITION_BACK; //相机的位置。
  saveUri?: string; //保存配置信息的uri。
  videoDuration?: number; //录制的最大时长。
}