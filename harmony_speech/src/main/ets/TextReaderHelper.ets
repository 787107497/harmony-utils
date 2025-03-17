import { common } from '@kit.AbilityKit';
import { TextReader, WindowManager } from '@kit.SpeechKit';
import { window } from '@kit.ArkUI';
import { TextReaderListener } from './TextReaderListener';

/**
 * 朗读控件 */
export class TextReaderHelper {


  /**
   * 朗读控件初始化，用于初始化TTS引擎和底层播放器，初始化失败会返回对应错误码。
   * @param windowStage 窗口管理器
   * @param context 当前应用上下文
   * @param readParams 朗读参数
   * @param panelName  默认值为‘小艺朗读’，并且readParams为undefined该值才生效
   * @returns
   */
  static async init(windowStage: window.WindowStage, context: common.BaseContext,
    readerParams?: TextReader.ReaderParam, panelName: string = '小艺朗读'): Promise<void> {
    WindowManager.setWindowStage(windowStage);
    if (readerParams === undefined || readerParams === null) {
      const params: TextReader.ReaderParam = {
        isVoiceBrandVisible: true,
        businessBrandInfo: { panelName: panelName }
      };
      readerParams = params;
    }
    return TextReader.init(context, readerParams); //初始化朗读控件
  }


 /**
  * 朗读控件起播，拉起播放器面板并开始播放。播放失败返回对应错误码。
  * @param readInfoList 播放文章列表
  * @param articleId 文章id，articleId不传时，默认从文章列表中的第一篇开始播放；传参时，从传入articleId对应的文章开始依次往下播放。（文章id不能重复，否则从列表进入同id的文章，会自动选择同id的第一篇朗读）
  * @returns
  */
  static start(readInfoList: TextReader.ReadInfo[], articleId?: string): Promise<void> {
    return TextReader.start(readInfoList, articleId);
  }

  /**
   * 朗读控件起播，拉起播放器面板并开始播放。
   * @param id 文章id
   * @param bodyInfo 正文信息（长度10000汉字以内）
   * @param title 标题
   * @param author 文章的作者
   * @param date 文章的时间
   * @returns
   */
  static startEasy(id: string, bodyInfo: string, title?: string, author?: string, date?: string): Promise<void> {
    const readInfoList: TextReader.ReadInfo[] = [{
      id: id,
      title: {
        text: title ?? '',
        isClickable: true
      },
      author: {
        text: author ?? '',
        isClickable: true
      },
      date: {
        text: date ?? '',
        isClickable: false
      },
      bodyInfo: bodyInfo
    }];
    return TextReaderHelper.start(readInfoList);
  }


  /**
   * 朗读控件停止朗读，执行播放面板的关闭，注销监听，重置参数。
   * @returns
   */
  static async stop(): Promise<void> {
    return TextReader.stop();
  }

  /**
   * 释放朗读控件的所有资源。
   * @returns
   */
  static async release(): Promise<void> {
    return TextReader.release();
  }


  /**
   * 暂停播放。
   */
  static pause(): boolean {
    try {
      TextReader.pause();
      return true;
    } catch (e) {
      console.error(`TextReader failed to pause. Code: ${e.code}, message: ${e.message}`);
      return false;
    }
  }


  /**
   * 继续播放。
   */
  static resume(): boolean {
    try {
      TextReader.resume();
      return true;
    } catch (e) {
      console.error(`TextReader failed to resume. Code: ${e.code}, message: ${e.message}`);
      return false;
    }
  }


  /**
   * 播放上一篇文章。
   */
  static playPrev(): boolean {
    try {
      TextReader.playPrev();
      return true;
    } catch (e) {
      console.error(`TextReader failed to play previous article. Code: ${e.code}, message: ${e.message}`);
      return false;
    }
  }


  /**
   * 播放下一篇文章。
   */
  static playNext(): boolean {
    try {
      TextReader.playNext();
      return true;
    } catch (e) {
      console.error(`TextReader failed to play next article. Code: ${e.code}, message: ${e.message}`);
      return false;
    }
  }


  /**
   * 隐藏播放面板。
   */
  static hidePanel(): boolean {
    try {
      TextReader.hidePanel();
      return true;
    } catch (e) {
      console.error(`TextReader failed to hide panel. Code: ${e.code}, message: ${e.message}`);
      return false;
    }
  }

  /**
   * 打开播放面板。
   */
  static showPanel(): boolean {
    try {
      TextReader.showPanel();
      return true;
    } catch (e) {
      console.error(`TextReader failed to show panel. Code: ${e.code}, message: ${e.message}`);
      return false;
    }
  }


  /**
   * 查询文章播报状态。
   * @param id 文章的id
   * @returns
   */
 static queryReadState(id: string): TextReader.ReadState {
    try {
      let readState = TextReader.queryReadState(id);
      return readState;
    } catch (e) {
      console.error(`TextReader failed to queryReadState. Code: ${e.code}, message: ${e.message}`);
      let readState: TextReader.ReadState = { id: id, state: 5 };
      return readState;
    }
  }


  /**
   * 设置文章内容。
   * @param id 文章id
   * @param content 文章内容，content不传或者为空时，播放指定id的文章时，控件内容页显示加载失败；传参时，将指定id文章的内容设置为content
   */
  static setArticleContent(id: string, content: string): boolean {
    try {
      TextReader.setArticleContent(id, content);
      return true;
    } catch (e) {
      console.error(`TextReader failed to setArticleContent. Code: ${e.code}, message: ${e.message}`);
      return false;
    }
  }


  /**
   * 设置指定文章的信息，并立即播放。
   * @param readInfo 文章信息，包括图片和内容；如果文章的ID不在列表中，则不会生效。
   */
  static setArticle(readInfo: TextReader.ReadInfo): boolean {
    try {
      TextReader.setArticle(readInfo);
      return true;
    } catch (e) {
      console.error(`TextReader failed to setArticle. Code: ${e.code}, message: ${e.message}`);
      return false;
    }
  }


  /**
   * 加载更多文章到文章列表。需在项目init和start之后调用，建议在'requestMore'操作监听中使用。
   * @param readInfos 要加载的文章列表
   * @param isEnd 是否还有更多内容需要加载
   * @returns
   */
  static loadMore(readInfos: TextReader.ReadInfo[], isEnd: boolean): boolean {
    try {
      TextReader.loadMore(readInfos, isEnd);
      return true;
    } catch (e) {
      console.error(`TextReader failed to loadMore. Code: ${e.code}, message: ${e.message}`);
      return false;
    }
  }


  /**
   * 设置监听事件
   * @param listener
   */
  static setListener(listener: TextReaderListener) {
    if (listener?.onStateChange) {
      TextReaderHelper.on('stateChange', listener.onStateChange);
    }
    if (listener?.onStop) {
      TextReaderHelper.on('stop', listener.onStop);
    }
    if (listener?.onRelease) {
      TextReaderHelper.on('release', listener.onRelease);
    }
    if (listener?.onShowPanel) {
      TextReaderHelper.on('showPanel', listener.onShowPanel);
    }
    if (listener?.onHidePanel) {
      TextReaderHelper.on('hidePanel', listener.onHidePanel);
    }
    if (listener?.onSetArticle) {
      TextReaderHelper.on('setArticle', listener.onSetArticle);
    }
    if (listener?.onClickArticle) {
      TextReaderHelper.on('clickArticle', listener.onClickArticle);
    }
    if (listener?.onClickAuthor) {
      TextReaderHelper.on('clickAuthor', listener.onClickAuthor);
    }
    if (listener?.onClickNotification) {
      TextReaderHelper.on('clickNotification', listener.onClickNotification);
    }
    if (listener?.onRequestMore) {
      TextReaderHelper.on('requestMore', listener.onRequestMore);
    }
    if (listener?.onEventPanel) {
      TextReaderHelper.on('eventPanel', listener.onEventPanel);
    }
    if (listener?.onEventNotification) {
      TextReaderHelper.on('eventNotification', listener.onEventNotification);
    }
    if (listener?.onEventReadList) {
      TextReaderHelper.on('eventReadList', listener.onEventReadList);
    }
  }


  /**
   * 注销监听事件
   * @param listener
   */
  static offListener(listener: TextReaderListener) {
    if (listener?.onStateChange) {
      TextReaderHelper.off('stateChange', listener.onStateChange);
    }
    if (listener?.onStop) {
      TextReaderHelper.off('stop', listener.onStop);
    }
    if (listener?.onRelease) {
      TextReaderHelper.off('release', listener.onRelease);
    }
    if (listener?.onShowPanel) {
      TextReaderHelper.off('showPanel', listener.onShowPanel);
    }
    if (listener?.onHidePanel) {
      TextReaderHelper.off('hidePanel', listener.onHidePanel);
    }
    if (listener?.onSetArticle) {
      TextReaderHelper.off('setArticle', listener.onSetArticle);
    }
    if (listener?.onClickArticle) {
      TextReaderHelper.off('clickArticle', listener.onClickArticle);
    }
    if (listener?.onClickAuthor) {
      TextReaderHelper.off('clickAuthor', listener.onClickAuthor);
    }
    if (listener?.onClickNotification) {
      TextReaderHelper.off('clickNotification', listener.onClickNotification);
    }
    if (listener?.onRequestMore) {
      TextReaderHelper.off('requestMore', listener.onRequestMore);
    }
    if (listener?.onEventPanel) {
      TextReaderHelper.off('eventPanel', listener.onEventPanel);
    }
    if (listener?.onEventNotification) {
      TextReaderHelper.off('eventNotification', listener.onEventNotification);
    }
    if (listener?.onEventReadList) {
      TextReaderHelper.off('eventReadList', listener.onEventReadList);
    }
  }


  /**
   * 添加监听事件
   */
  static on(type: 'stateChange' | 'stop' | 'release' | 'showPanel' | 'hidePanel'
    | 'setArticle' | 'clickArticle' | 'clickAuthor' | 'clickNotification'
    | 'requestMore' | 'eventPanel' | 'eventNotification' | 'eventReadList',
    callback: Callback<void> | Callback<string> | Callback<TextReader.ReadState> | Callback<TextReader.PanelEvent>
      | Callback<TextReader.NotificationEvent> | Callback<Array<TextReader.ListEventState>>) {
    try {
      if (type === 'stateChange') {
        TextReader.on(type, callback as Callback<TextReader.ReadState>);
      } else if (type === 'stop') {
        TextReader.on(type, callback as Callback<void>);
      } else if (type === 'release') {
        TextReader.on(type, callback as Callback<void>);
      } else if (type === 'showPanel') {
        TextReader.on(type, callback as Callback<void>);
      } else if (type === 'hidePanel') {
        TextReader.on(type, callback as Callback<void>);
      } else if (type === 'setArticle') {
        TextReader.on(type, callback as Callback<string>);
      } else if (type === 'clickArticle') {
        TextReader.on(type, callback as Callback<string>);
      } else if (type === 'clickAuthor') {
        TextReader.on(type, callback as Callback<string>);
      } else if (type === 'clickNotification') {
        TextReader.on(type, callback as Callback<string>);
      } else if (type === 'requestMore') {
        TextReader.on(type, callback as Callback<void>);
      } else if (type === 'eventPanel') {
        TextReader.on(type, callback as Callback<TextReader.PanelEvent>);
      } else if (type === 'eventNotification') {
        TextReader.on(type, callback as Callback<TextReader.NotificationEvent>);
      } else if (type === 'eventReadList') {
        TextReader.on(type, callback as Callback<Array<TextReader.ListEventState>>);
      }
    } catch (e) {
      console.error(`TextReader failed to set eventListener. Code: ${e.code}, message: ${e.message}`);
    }
  }

  /**
   * 注销监听事件
   */
  static off(type: 'stateChange' | 'stop' | 'release' | 'showPanel' | 'hidePanel'
    | 'setArticle' | 'clickArticle' | 'clickAuthor' | 'clickNotification'
    | 'requestMore' | 'eventPanel' | 'eventNotification' | 'eventReadList',
    callback: Callback<void> | Callback<string> | Callback<TextReader.ReadState> | Callback<TextReader.PanelEvent>
      | Callback<TextReader.NotificationEvent> | Callback<Array<TextReader.ListEventState>>) {
    try {
      if (type === 'stateChange') {
        TextReader.off(type, callback as Callback<TextReader.ReadState>);
      } else if (type === 'stop') {
        TextReader.off(type, callback as Callback<void>);
      } else if (type === 'release') {
        TextReader.off(type, callback as Callback<void>);
      } else if (type === 'showPanel') {
        TextReader.off(type, callback as Callback<void>);
      } else if (type === 'hidePanel') {
        TextReader.off(type, callback as Callback<void>);
      } else if (type === 'setArticle') {
        TextReader.off(type, callback as Callback<string>);
      } else if (type === 'clickArticle') {
        TextReader.off(type, callback as Callback<string>);
      } else if (type === 'clickAuthor') {
        TextReader.off(type, callback as Callback<string>);
      } else if (type === 'clickNotification') {
        TextReader.off(type, callback as Callback<string>);
      } else if (type === 'requestMore') {
        TextReader.off(type, callback as Callback<void>);
      } else if (type === 'eventPanel') {
        TextReader.off(type, callback as Callback<TextReader.PanelEvent>);
      } else if (type === 'eventNotification') {
        TextReader.off(type, callback as Callback<TextReader.NotificationEvent>);
      } else if (type === 'eventReadList') {
        TextReader.off(type, callback as Callback<Array<TextReader.ListEventState>>);
      }
    } catch (e) {
      console.error(`TextReader failed to unset eventListener. Code: ${e.code}, message: ${e.message}`);
    }
  }


}

