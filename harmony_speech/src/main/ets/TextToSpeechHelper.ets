import { textToSpeech } from '@kit.CoreSpeechKit';

export class TextToSpeechHelper {
  private static ttsEngine: textToSpeech.TextToSpeechEngine | undefined = undefined; //TextToSpeechEngine实例

  /**
   * 创建TextToSpeechEngine实例，并初始化引擎。
   * @param params 创建引擎实例的配置项
   * @returns
   */
  static async createEngine(params?: textToSpeech.CreateEngineParams):Promise<textToSpeech.TextToSpeechEngine> {
    if (params === undefined || params === null) {
      const createEngineParams: textToSpeech.CreateEngineParams = {
        language: 'zh-CN', //语种，当前仅支持中文，推荐使用“zh-CN”格式，兼容“zh_CN”格式。
        online: 1, //模式。0为在线，目前不支持；1为离线，当前仅支持离线模式。
        person: 0, //音色。0为聆小珊女声音色，当前仅支持聆小珊女声音色
        extraParams: {
          "style": 'interaction-broadcast', //风格。interaction-broadcast：广播风格
          "locate": 'CN', //区域信息。可选，不设置时默认为“CN”，当前仅支持“CN”。CN:中国。
          "name": 'EngineName', //引擎名称。可选，引擎名称，不设置时默认为空，当前支持多应用、多实例，同一个设备上所有应用一共最多支持3个实例。
          'isBackStage': false, //是否支持后台播报。可选，不设置时默认不支持后台播报。设置'isBackStage': true时，TTS支持后台播报。
        }
      }
      params = createEngineParams;
    }
    TextToSpeechHelper.ttsEngine = await textToSpeech.createEngine(params); //创建实例
    return TextToSpeechHelper.ttsEngine;
  }



 static speak(originalText: string) {

 }



  // let extraParam: Record<string, Object> = {
  //   "queueMode": 0,
  //   // 语速。可选，支持范围[0.5-2]，不传参时默认为1。
  //   "speed": 1,
  //   // 音量。 可选，支持范围[0-2]，不传参时默认为1
  //   "volume": 2,
  //   // 音调。
  //   // 可选，支持范围[0.5-2]，不传参时默认为1
  //   "pitch": 1,
  //   // 语境，播放阿拉伯数字用的语种。 可选，当前仅支持“zh-CN”中文，不传参时默认“zh-CN”。
  //   "languageContext": 'zh-CN',
  //   // 音频类型，当前仅支持“pcm”
  //   "audioType": "pcm",
  //   // 通道。 可选，参数范围0-16，整数类型，可参考音频流使用来选择适合自己的音频场景。 不传参时默认为3，语音助手通道
  //   "soundChannel": 3,
  //   // 合成类型。 可选，不传参时默认为1。 0：仅合成不播报，返回音频流。 1：合成与播报不返回音频流。
  //   "playType": 1
  // };
    // 设置播报相关参数



    let speakParams: textToSpeech.SpeakParams = {

      requestId: this.requestId, // requestId在同一实例内仅能用一次，请勿重复设置

      extraParams: extraParam

    };

    // 调用播报方法

    this.ttsEngine?.speak(originalText, speakParams);

  }

  /** 停止转换 */

  async stop() {

    this.ttsEngine?.stop()

  }


  /** 创建引擎 */
  async createEngine1() {

    return this.ttsEngine = await textToSpeech.createEngine(TextToSpeechHelper.initParamsInfo)

  }



  /** 创建引擎的配置参数 */

  private static extraParam: Record<string, Object> =

    {

    }


  /** 会话ID，一个实例只能使用一次 */

  private requestId: string

  constructor() {

    this.requestId = `tts` + Date.now()

  }


  /** 设置回调监听 */

  async setListener(callback?: (res: textToSpeech.CompleteResponse) => void) {

    // 设置speak的回调信息

    let speakListener: textToSpeech.SpeakListener = {

      // 开始播报回调

      onStart(requestId: string, response: textToSpeech.StartResponse) {

        console.info(`onStart, requestId: ${requestId} response: ${JSON.stringify(response)}`);

      },

      // 合成完成及播报完成回调

      onComplete(requestId: string, response: textToSpeech.CompleteResponse) {

        console.info(`onComplete, requestId: ${requestId} response: ${JSON.stringify(response)}`);

        callback && callback(response)

      },

      // 停止播报回调

      onStop(requestId: string, response: textToSpeech.StopResponse) {

        console.info(`onStop, requestId: ${requestId} response: ${JSON.stringify(response)}`);

      },

      // 返回音频流

      onData(requestId: string, audio: ArrayBuffer, response: textToSpeech.SynthesisResponse) {

        console.info(`onData, requestId: ${requestId} sequence: ${JSON.stringify(response)} audio: ${JSON.stringify(audio)}`);

      },

      // 错误回调

      onError(requestId: string, errorCode: number, errorMessage: string) {

        console.error(`onError, requestId: ${requestId} errorCode: ${errorCode} errorMessage: ${errorMessage}`);

      }

    };

    // 设置回调

    this.ttsEngine?.setListener(speakListener);

  }


}