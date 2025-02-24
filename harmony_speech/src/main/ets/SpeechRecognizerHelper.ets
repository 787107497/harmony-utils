import { speechRecognizer } from '@kit.CoreSpeechKit';
import { Helper } from './Helper';

/**
 * 语音识别
 */
export class SpeechRecognizerHelper {
  private static recognitionEngine: speechRecognizer.SpeechRecognitionEngine | undefined = undefined;

  /**
   * 创建SpeechRecognitionEngine实例，并初始化引擎。
   * @param params 创建引擎实例的配置项。
   * @param recognizerMode 语言模式。当前支持“short“和“long”。且当params为undefined时该参数才生效
   * @returns
   */
  static async createEngine(params?: speechRecognizer.CreateEngineParams,
    recognizerMode: string = 'long'): Promise<speechRecognizer.SpeechRecognitionEngine> {
    if (params === undefined || params === null) {
      const createEngineParams: speechRecognizer.CreateEngineParams = {
        language: 'zh-CN', //语种，当前仅支持“zh-CN”中文。
        online: 1, //模式。1为离线，当前仅支持离线模式。
        extraParams: {
          locate: "CN", //<'locate', string> 区域信息。可选，不设置时默认为“CN”，当前仅支持“CN”。
          recognizerMode: recognizerMode  //<'recognizerMode', Object> 语言模式。可选，不设置时默认为“short”，当前支持“short“和“long”。
        }
      };
      params = createEngineParams;
    }
    SpeechRecognizerHelper.recognitionEngine = await speechRecognizer.createEngine(params); //创建实例
    return SpeechRecognizerHelper.recognitionEngine;
  }


  /**
   * 设置语音识别回调。
   * @param listener 回调对象，识别过程中所有回调信息均通过此对象返回。
   */
  static setListener(listener: speechRecognizer.RecognitionListener): void {
    SpeechRecognizerHelper.recognitionEngine?.setListener(listener);
  }


  /**
   * 启动语音识别。
   * @param startParams 启动语音识别的相关参数，用于设置会话ID、音频配置信息等。
   */
  static startListening(startParams: speechRecognizer.StartParams): void {
    SpeechRecognizerHelper.recognitionEngine?.startListening(startParams);
  }


  /**
   * 启动语音识别。
   * @param sessionId  实时语音识别模式。0-实时录音识别，1-实时音频转文字识别。
   * @param recognitionMode  会话ID。
   * @param maxAudioDuration 最大支持音频时长。短语音模式支持范围[20000-60000]，单位ms，不传参时默认20000ms。长语音模式支持范围[20000 - 8 * 60 * 60 * 1000]，单位ms。
   * @param enablePartialResult 蹦字模式。（只支持长语音模式下进行配置），true-开启蹦字模式，false-false
   */
  static startEasyListening(sessionId: string, recognitionMode: number = 0, maxAudioDuration: number = 60000,
    enablePartialResult: boolean = false): void {
    const startParams: speechRecognizer.StartParams = {
      sessionId: sessionId,
      audioInfo: {
        audioType: 'pcm', //音频类型。当前仅支持“pcm”。
        sampleRate: 16000, //音频的采样率。当前仅支持16000采样率。
        sampleBit: 16, //音频返回的采样位数。当前仅支持16位。
        soundChannel: 1 //音频返回的通道数信息。当前仅支持通道1。
      },
      extraParams: {
        recognitionMode: recognitionMode, //0：实时录音识别（需应用开启录音权限：ohos.permission.MICROPHONE），若需结束录音，则调用finish方法；
        maxAudioDuration: maxAudioDuration, //最大支持音频时长。
        recognizerOption: {
          enablePartialResult: enablePartialResult //蹦字模式。（只支持长语音模式下进行配置）
        }
      }
    }
    SpeechRecognizerHelper.recognitionEngine?.startListening(startParams);

  }


  /**
   * 写音频流，最大音频长度为60000ms。为了确保收到识别结果，请优先调用setListener和startListening。
   * @param sessionId 会话ID。
   * @param audio 待识别的音频数据，当前仅支持音频数据长度为640字节或1280字节。建议每次发送音频调用间隔为20ms（传输音频长度为640字节）或40ms（传输音频长度为1280字节）。
   */
  static writeAudio(sessionId: string, audio: Uint8Array): void {
    SpeechRecognizerHelper.recognitionEngine?.writeAudio(sessionId, audio);
  }


  /**
   * 结束识别。为了确保事件回调，请优先调用setListener。
   * @param sessionId 会话ID。
   */
  static finish(sessionId: string): void {
    SpeechRecognizerHelper.recognitionEngine?.finish(sessionId);
  }


  /**
   * 取消识别。为了确保事件回调，请优先调用setListener。
   * @param sessionId 会话ID。
   */
  static cancel(sessionId: string): void {
    SpeechRecognizerHelper.recognitionEngine?.cancel(sessionId);
  }


  /**
   * 判断引擎是否繁忙。true：引擎正处于繁忙状态。false：引擎没有处于繁忙状态。
   * @param sessionId 会话ID。
   */
  static isBusy(): boolean {
    return SpeechRecognizerHelper.recognitionEngine?.isBusy() ?? false;
  }


  /**
   * 关闭引擎，释放资源。
   * @param sessionId 会话ID。
   */
  static shutdown(): void {
    SpeechRecognizerHelper.recognitionEngine?.shutdown();
  }


  /**
   * 处理音频识别结果信息，提取文本信息。
   * @param result
   * @returns
   */
  static handleResult(result: speechRecognizer.SpeechRecognitionResult): string {
    if (result && result.isFinal && Helper.isNotEmpty(result.result)) {
      return result.result;
    }
    return "";
  }


  /**
   * 生成会话ID
   * @returns
   */
  static generateSessionId(): string {
    return `speech_${Helper.getTodayStr('yyyyMMddHHmmssfff')}`;
  }
}