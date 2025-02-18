import { TextReader } from '@kit.SpeechKit';

/**
 * 朗读控件回调事件
 */
export class TextReaderListener {
  onStateChange?: Callback<TextReader.ReadState>; //当前正在播放的文章状态变更时，触发该回调执行。

  onStop?: Callback<void>; //调用stop接口或用户主动滑动通知栏退出，触发回调。
  onRelease?: Callback<void>; //调用release释放资源，触发回调。

  onShowPanel?: Callback<void>; //拉起面板，触发回调。
  onHidePanel?: Callback<void>; //收回面板，触发回调。

  onSetArticle?: Callback<string>; //注册设置文章回调函数，点击文章或者切换文章时，若目标文章内容为空（bodyInfo值为空）时，触发该回调执行。
  onClickArticle?: Callback<string>; //点击文章标题，触发回调。
  onClickAuthor?: Callback<string>; //点击作者，触发回调。
  onClickNotification?: Callback<string>; //点击通知栏，触发回调。预留参数，暂未支持。
  onRequestMore?: Callback<void>; //拉到播放列表底端时，触发该回调执行。
  onEventNotification?: Callback<TextReader.NotificationEvent>; //通知栏+播控中心状态变化
  onEventPanel?: Callback<TextReader.PanelEvent>; //播放面板状态变化，其中PanelEvent中的BPC_10 click事件回调只支持手机
  onEventReadList?: Callback<Array<TextReader.ListEventState>>; //播报列表发生相关事件时，触发该回调执行
}



