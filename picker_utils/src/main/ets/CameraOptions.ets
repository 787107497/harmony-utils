import { camera, cameraPicker } from "@kit.CameraKit";

/**
 * 相机参数类 */
export class CameraOptions {
  mediaTypes: Array<cameraPicker.PickerMediaType> = [cameraPicker.PickerMediaType.PHOTO, cameraPicker.PickerMediaType.VIDEO]; //媒体类型。
  cameraPosition: camera.CameraPosition = camera.CameraPosition.CAMERA_POSITION_BACK; //相机的位置。
  saveUri?: string; //保存配置信息的uri。
  videoDuration?: number; //录制的最大时长。
}


export const PICKER_DEFAULT_SELECT_NUMBER: number = 9; //选择器默认选择数量