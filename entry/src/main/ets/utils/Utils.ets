import { DialogHelper } from '@pura/harmony-dialog';
import { ArrayUtil } from '@pura/harmony-utils';
import { TextSheetBuilder } from '../component/TextSheetView';
import { MenuBean } from '../model/MenuBean';
import { TextSheetOptions } from '../model/TextSheetOptions';

export class Utils {


  /**
   * 文本展示Sheet
   * @param content
   */
  static showSheetText(content: string) {
    let options: TextSheetOptions = {
      title: {
        title: "结果展示",
      },
      content: content,
      detents: [SheetSize.FIT_CONTENT, SheetSize.MEDIUM, SheetSize.FIT_CONTENT],
      borderWidth: 0,
      mode: SheetMode.EMBEDDED,
      preferType: SheetType.BOTTOM,
    };
    DialogHelper.showBindSheet(wrapBuilder(TextSheetBuilder), options);
  }


  /**
   * 创建菜单假数据
   * @returns
   */
  static getMenus(): Array<MenuBean> {
    let menus = new Array<MenuBean>();
    menus.push({
      index: 0, text: '微信',
      icon: $r('sys.media.ohos_ic_normal_white_grid_doc')
    });
    menus.push({
      index: 1, text: 'QQ',
      icon: $r('sys.media.ohos_ic_normal_white_grid_xls')
    });
    menus.push({
      index: 2, text: '抖音',
      icon: $r('sys.media.ohos_ic_normal_white_grid_pdf')
    });
    menus.push({
      index: 3, text: '今日头条',
      icon: $r('sys.media.ohos_ic_normal_white_grid_txt')
    });
    menus.push({
      index: 4, text: '支付宝',
      icon: $r('sys.media.ohos_ic_normal_white_grid_xml')
    });
    menus.push({
      index: 5, text: '钉钉',
      icon: $r('sys.media.ohos_ic_normal_white_grid_html')
    });

    menus.push({
      index: 6, text: '淘宝',
      icon: $r('sys.media.ohos_ic_normal_white_grid_compress')
    });
    menus.push({
      index: 7, text: '哔哩哔哩',
      icon: $r('sys.media.ohos_ic_normal_white_grid_audio')
    });
    menus.push({
      index: 8, text: '浏览器',
      icon: $r('sys.media.ohos_ic_normal_white_grid_calendar')
    });
    menus.push({
      index: 9, text: '运动健康',
      icon: $r('sys.media.ohos_ic_normal_white_grid_flac')
    });
    menus.push({
      index: 10, text: '夸克',
      icon: $r('sys.media.ohos_ic_normal_white_grid_wav')
    });
    menus.push({
      index: 11, text: '百度',
      icon: $r('sys.media.ohos_ic_normal_white_grid_wma')
    });
    menus.push({
      index: 12, text: '微博',
      icon: $r('sys.media.ohos_ic_normal_white_grid_zip')
    });
    menus.push({
      index: 13, text: '腾讯新闻',
      icon: $r('sys.media.ohos_ic_normal_white_grid_mp3')
    });
    menus.push({
      index: 14, text: '企业微信',
      icon: $r('sys.media.ohos_ic_normal_white_grid_zip')
    });
    return menus;
  }


  /**
   * 大概判断是否是图片选择
   * @param types  .tif,.pjp,.jfif,.bmp,.webp,.svg,.gif,.svgz,.jpg,.hevc,.jpeg,.pjpeg,.png,.ico,.avif,.apng,.heic,.xbm,.tiff,.heif
   */
  static isPhoto(types: string[]) {
    return ArrayUtil.contain(types, ".jpg") && ArrayUtil.contain(types, ".jpeg") && ArrayUtil.contain(types, ".png");
  }

  /**
   * 大概判断是否是视频片选择
   * @param types  .ogm,.ogv,.mpg,.mp4,.mpeg,.m4v,.webm
   */
  static isVideo(types: string[]) {
    return ArrayUtil.contain(types, ".mp4") && ArrayUtil.contain(types, ".m4v");
  }
}