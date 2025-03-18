import { audio } from '@kit.AudioKit';
import { BusinessError } from '@kit.BasicServicesKit';

import fs from '@ohos.file.fs';
import { Helper } from './Helper';

/**
 * 录音工具类
 */
export class AudioCapturerHelper{

  private static audioCapturer: audio.AudioCapturer | undefined = undefined;
  private static file: fs.File | undefined = undefined;


  /**
   * 开始录音
   * @returns
   */
  static async startRecord(): Promise<string> {
    let filePath = Helper.getCacheDirPath('audio', `audio_${Helper.getTodayStr('yyyyMMddHHmmssfff')}.pcm`); //pcm wav
    await AudioCapturerHelper.createAudioCapturer();
    AudioCapturerHelper.onReadDataCallback(filePath);
    let start = await AudioCapturerHelper.start();
    if (start) {
      return filePath
    }
    return "";
  }


  /**
   * 结束录音
   */
  static async stopRecord() {
    await AudioCapturerHelper.stop();
    await AudioCapturerHelper.release();
    AudioCapturerHelper.audioCapturer = undefined;
    if (AudioCapturerHelper.file) {
      Helper.close(AudioCapturerHelper.file);
    }
  }


  /**
   * 创建音频采集器
   * @param options 配置音频采集器。
   * @returns
   */
  static async createAudioCapturer(options?: audio.AudioCapturerOptions): Promise<audio.AudioCapturer> {
    if (options === undefined || options === null) {
      const audioCapturerOptions: audio.AudioCapturerOptions = {
        streamInfo: {
          samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_16000, //采样率，采样率为16000。
          channels: audio.AudioChannel.CHANNEL_1, //通道，单声道。
          sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE, //采样格式，带符号的16位整数，小尾数。
          encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW //编码格式，PCM编码。
        },
        capturerInfo: {
          source: audio.SourceType.SOURCE_TYPE_MIC, //音源类型，Mic音频源
          capturerFlags: 0 //音频采集器标志。 0代表音频采集器。
        }
      };
      options = audioCapturerOptions;
    }
    AudioCapturerHelper.audioCapturer = await audio.createAudioCapturer(options);
    return AudioCapturerHelper.audioCapturer;
  }


  /**
   * 监听音频数据读取回调事件（当需要读取音频流数据时触发），使用callback方式返回结果.
   * @param filePath 文件全路径
   * @returns
   */
  static onReadDataCallback(filePath: string) {
    let bufferSize: number = 0;
    AudioCapturerHelper.file = Helper.openSync(filePath);
    let readDataCallback: Callback<ArrayBuffer> = (buffer: ArrayBuffer) => {
      Helper.writeSync(AudioCapturerHelper.file!!.fd, buffer, { offset: bufferSize, length: buffer.byteLength });
      bufferSize += buffer.byteLength;
    };
    AudioCapturerHelper.audioCapturer?.on('readData', readDataCallback);
    return filePath;
  }


  /**
   * 开始音频采集
   */
  static async start(): Promise<boolean> {
    let blResult: boolean = false;
    if (AudioCapturerHelper.audioCapturer !== undefined) {
      const stateGroup = [audio.AudioState.STATE_PREPARED, audio.AudioState.STATE_PAUSED, audio.AudioState.STATE_STOPPED];
      const state = AudioCapturerHelper.audioCapturer.state.valueOf();
      if (stateGroup.indexOf(state) === -1) { //当且仅当状态为STATE_PREPARED、STATE_PAUSED和STATE_STOPPED之一时才能启动采集
        return false;
      }
      await AudioCapturerHelper.audioCapturer?.start().then(() => {
        blResult = true;
      }).catch((err: BusinessError) => {
        console.error(`AudioCapturerHelper-start()异常信息，code：${err.code} - msg：${err.message}`);
        blResult = false;
      })
    }
    return blResult;
  }


  /**
   * 停止采集
   */
  static async stop(): Promise<boolean> {
    let blResult: boolean = false;
    if (AudioCapturerHelper.audioCapturer !== undefined) {
      const state = AudioCapturerHelper.audioCapturer.state.valueOf();
      //只有采集器状态为STATE_RUNNING或STATE_PAUSED的时候才可以停止
      if (state !== audio.AudioState.STATE_RUNNING && state !== audio.AudioState.STATE_PAUSED) {
        return false;
      }
      await AudioCapturerHelper.audioCapturer?.stop().then(() => {
        blResult = true;
      }).catch((err: BusinessError) => {
        console.error(`AudioCapturerHelper-stop()异常信息，code：${err.code} - msg：${err.message}`);
        blResult = false;
      })
    }
    return blResult;
  }


  /**
   * 销毁实例，释放资源
   */
  static async release() {
    let blResult: boolean = false;
    if (AudioCapturerHelper.audioCapturer !== undefined) {
      const state = AudioCapturerHelper.audioCapturer.state.valueOf();
      //采集器状态不是STATE_RELEASED或STATE_NEW状态，才能release
      if (state === audio.AudioState.STATE_RELEASED || state === audio.AudioState.STATE_NEW) {
        return false;
      }
      await AudioCapturerHelper.audioCapturer?.release().then(() => {
        blResult = true;
      }).catch((err: BusinessError) => {
        console.error(`AudioCapturerHelper-release()异常信息，code：${err.code} - msg：${err.message}`);
        blResult = false;
      })
    }
    return blResult;
  }


}