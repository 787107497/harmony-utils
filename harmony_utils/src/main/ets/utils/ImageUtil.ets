import { image } from '@kit.ImageKit';
import { resourceManager } from '@kit.LocalizationKit';
import { AppUtil } from './AppUtil';
import { Base64Util } from './Base64Util';
import { FileUtil } from './FileUtil';
import { LogUtil } from './LogUtil';
import { BusinessError } from '@kit.BasicServicesKit';


/**
 * 图片相关工具类
 */
export class ImageUtil {

  private constructor() {}


  /**
   * 图片base64字符串转PixelMap
   * @param base64 图片base64字符串
   * @returns
   */
  static base64ToPixelMap(base64: string): Promise<image.PixelMap> {
    //将原始图片base64字符串转变为通过base64字符串
    const reg = new RegExp('data:image/\\w+;base64,');
    const base64Str = base64.replace(reg, '');
    //将通用base64字符串转变为arrayBuffer
    let arrayBuffer = Base64Util.decodeSync(base64Str).buffer as ArrayBuffer;
    //将arrayBuffer转变为pixelMap
    let imageSource = image.createImageSource(arrayBuffer);
    let opts: image.DecodingOptions = { editable: false }
    //注意：这里return的是Promise，因此使用时需要在业务侧拿到最终的PixelMap
    return imageSource.createPixelMap(opts);
  }


  /**
   * PixelMap转图片base64字符串
   * @param pixelMap
   * @param format 目标格式,默认png,当前只支持jpg、webp和png。当传入的格式与文件格式不匹配，可能会导致生成错误的Base64字符串。
   * @returns
   */
  static async pixelMapToBase64Str(pixelMap: image.PixelMap, format: string = 'image/png'): Promise<string> {
    try {
      let packOpts: image.PackingOption = { format: format, quality: 100 }
      const arrayBuffer = await ImageUtil.packingFromPixelMap(pixelMap, packOpts);
      let base64Str: string = Base64Util.encodeToStrSync(new Uint8Array(arrayBuffer));
      let headStr = `data:${format};base64,`;
      if (!base64Str.startsWith(headStr)) {
        base64Str = headStr + base64Str
      }
      return base64Str;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`ImageUtil-pixelMapToBase64Str-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return '';
    }
  }


  /**
   * 保存pixelMap到本地
   * @param pixelMap PixelMap
   * @param path 文件夹路径
   * @param name 文件名
   * @param format 目标格式。默认png。当前只支持jpg（image/jpeg）、webp和png（image/png）。
   * @returns
   */
  static async savePixelMap(pixelMap: image.PixelMap, path: string, name: string, format: string = 'image/png'): Promise<string> {
    try {
      if (!FileUtil.accessSync(path)) {
        FileUtil.mkdirSync(path) //如果文件夹不存在就创建
      }
      let filePath = path + FileUtil.separator + name;
      let file = FileUtil.openSync(filePath)
      let packOpts: image.PackingOption = { format: format, quality: 100 }
      await ImageUtil.packToFileFromPixelMap(pixelMap, file.fd, packOpts)
      FileUtil.closeSync(file.fd)  //关闭文件
      return filePath;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`ImageUtil-savePixelMap-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return '';
    }
  }


  /**
   * 保存ImageSource到本地
   * @param pixelMap PixelMap
   * @param path 文件夹路径
   * @param name 文件名
   * @param format 目标格式。默认png。当前只支持jpg（image/jpeg）、webp和png（image/png）。
   * @returns
   */
  static async saveImageSource(source: image.ImageSource, path: string, name: string, format: string = 'image/png'): Promise<string> {
    try {
      if (!FileUtil.accessSync(path)) {
        FileUtil.mkdirSync(path) //如果文件夹不存在就创建
      }
      let filePath = path + FileUtil.separator + name;
      let file = FileUtil.openSync(filePath)
      let packOpts: image.PackingOption = { format: format, quality: 100 }
      await ImageUtil.packToFileFromImageSource(source, file.fd, packOpts)
      FileUtil.closeSync(file.fd) //关闭文件
      return filePath;
    } catch (err) {
      let error = err as BusinessError;
      LogUtil.error(`ImageUtil-saveImageSource-异常 ~ code: ${error.code} -·- message: ${error.message}`);
      return '';
    }
  }


  /**
   * 创建图片源实例
   * @param src（联合类型: string、number、ArrayBuffer、resourceManager.RawFileDescriptor）
   *   path string 图片路径，当前仅支持应用沙箱路径。当前支持格式有：.jpg .png .gif .bmp .webp RAW SVG10+ .ico11+。
   *   fd  number 文件描述符fd。
   *   buf  ArrayBuffer  图像缓冲区数组。
   *   rawfile resourceManager.RawFileDescriptor 图像资源文件的RawFileDescriptor。
   * options SourceOptions  图片属性，包括图片像素密度、像素格式和图片尺寸。
   *   sourceDensity  number ImageSource的密度。
   *   sourcePixelFormat  PixelMapFormat 图片像素格式。
   *   sourceSize  Size 图像像素大小。
   * @returns
   */
  static createImageSource(src: string | number | ArrayBuffer | resourceManager.RawFileDescriptor, options?: image.SourceOptions): image.ImageSource {
    if (typeof src === 'string') {
      if (options) {
        return image.createImageSource(src, options);
      } else {
        return image.createImageSource(src);
      }
    } else if (typeof src === 'number') {
      if (options) {
        return image.createImageSource(src, options);
      } else {
        return image.createImageSource(src);
      }
    } else if (src instanceof ArrayBuffer) {
      if (options) {
        return image.createImageSource(src, options);
      } else {
        return image.createImageSource(src);
      }
    } else {
      if (options) {
        return image.createImageSource(src, options);
      } else {
        return image.createImageSource(src);
      }
    }
  }


  /**
   * 以增量的方式创建图片源实例
   * @param buf ArrayBuffer  增量数据
   * @param options SourceOptions  图片属性，包括图片像素密度、像素格式和图片尺寸。
   *   sourceDensity  number ImageSource的密度。
   *   sourcePixelFormat  PixelMapFormat 图片像素格式。
   *   sourceSize  Size 图像像素大小。
   * @returns
   */
  static createIncrementalSource(buf: ArrayBuffer, options?: image.SourceOptions): image.ImageSource {
    if (options) {
      return image.CreateIncrementalSource(buf, options);
    } else {
      return image.CreateIncrementalSource(buf);
    }
  }


  /**
   * 图片压缩或重新打包，使用Promise形式返回结果。
   * @param source PixelMap-打包的PixelMap资源。
   * @param options 设置打包参数:
   *   format 目标格式。当前只支持jpg（image/jpeg）、webp 和 png（image/png）。
   *   quality JPEG编码中设定输出图片质量的参数，取值范围为0-100。
   *   bufferSize 接收编码数据的缓冲区大小，单位为Byte。默认为10MB。bufferSize需大于编码后图片大小。
   * @returns
   */
  static packingFromPixelMap(source: image.PixelMap, options: image.PackingOption): Promise<ArrayBuffer> {
    const imagePacker: image.ImagePacker = image.createImagePacker();
    return imagePacker.packing(source, options).finally(() => {
      imagePacker.release(); //释放
    });
  }


  /**
   * 图片压缩或重新打包，使用Promise形式返回结果。
   * @param source ImageSource-打包的图片源。
   * @param options 设置打包参数:
   *   format 目标格式。当前只支持jpg（image/jpeg）、webp 和 png（image/png）。
   *   quality JPEG编码中设定输出图片质量的参数，取值范围为0-100。
   *   bufferSize 接收编码数据的缓冲区大小，单位为Byte。默认为10MB。bufferSize需大于编码后图片大小。
   * @returns
   */
  static packingFromImageSource(source: image.ImageSource, options: image.PackingOption): Promise<ArrayBuffer> {
    const imagePacker: image.ImagePacker = image.createImagePacker();
    return imagePacker.packing(source as image.ImageSource, options).finally(() => {
      imagePacker.release(); //释放
    });
  }


  /**
   * 将PixelMap图片源编码后直接打包进文件。
   * @param source PixelMap-打包的PixelMap资源。
   * @param fd 文件描述符。
   * @param option 设置打包参数:
   *   format 目标格式。当前只支持jpg（image/jpeg）、webp 和 png（image/png）。
   *   quality JPEG编码中设定输出图片质量的参数，取值范围为0-100。
   *   bufferSize 接收编码数据的缓冲区大小，单位为Byte。默认为10MB。bufferSize需大于编码后图片大小。
   * @returns
   */
  static packToFileFromPixelMap(source: image.PixelMap, fd: number, options: image.PackingOption): Promise<void> {
    const imagePacker: image.ImagePacker = image.createImagePacker();
    return imagePacker.packToFile(source, fd, options).finally(() => {
      imagePacker.release(); //释放
    });
  }


  /**
   * 将ImageSource图片源编码后直接打包进文件。
   * @param source ImageSource-打包的图片源。
   * @param fd 文件描述符。
   * @param option 设置打包参数:
   *   format 目标格式。当前只支持jpg（image/jpeg）、webp 和 png（image/png）。
   *   quality JPEG编码中设定输出图片质量的参数，取值范围为0-100。
   *   bufferSize 接收编码数据的缓冲区大小，单位为Byte。默认为10MB。bufferSize需大于编码后图片大小。
   * @returns
   */
  static packToFileFromImageSource(source: image.ImageSource, fd: number, options: image.PackingOption): Promise<void> {
    const imagePacker: image.ImagePacker = image.createImagePacker();
    return imagePacker.packToFile(source, fd, options).finally(() => {
      imagePacker.release(); //释放
    });
  }


  /**
   * 用户获取resource目录下的media中的图片PixelMap
   * @param resource 例如：$r("app.media.icon"
   * @returns
   */
  static async getPixelMapFromMedia(resource: Resource): Promise<image.PixelMap> {
    let resourceManager = AppUtil.getContext().resourceManager;
    let uint8Array = resourceManager.getMediaContentSync(resource);
    return await ImageUtil.createImageSource(uint8Array.buffer).createPixelMap();
  }


}