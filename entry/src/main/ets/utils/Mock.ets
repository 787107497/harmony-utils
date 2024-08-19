import { DescribeBean } from '../entity/DescribeBean';

/**
 * 模拟数据
 */
export class Mock {
  //获取模拟数据
  static getData(): Array<DescribeBean> {
    let data: Array<DescribeBean> = new Array<DescribeBean>();
    data.push(new DescribeBean("AppUtil", "APP相关工具类", 1));
    data.push(new DescribeBean("DeviceUtil", "设备相关工具类", 1));
    data.push(new DescribeBean("DisplayUtil", "屏幕相关工具类", 1));
    data.push(new DescribeBean("PermissionUtil", "申请授权工具类", 1));
    data.push(new DescribeBean("AuthUtil", "手机的生物认证（指纹、人脸、密码）工具类", 1));
    data.push(new DescribeBean("NotificationUtil", "通知工具类", 1));
    data.push(new DescribeBean("PreferencesUtil", "Preferences（用户首选项）工具类", 1));
    data.push(new DescribeBean("FileUtil", "文件操作相关工具类", 1));
    data.push(new DescribeBean("PickerUtil", "拍照、文件(文件、图片、视频、音频)选择和保存,工具类", 1));
    data.push(new DescribeBean("PhotoHelper", "相册选择和保存,工具类", 1));
    data.push(new DescribeBean("PreviewUtil", "文件预览工具类", 1));
    data.push(new DescribeBean("NetworkUtil", "网络相关工具类", 1));
    data.push(new DescribeBean("LocationUtil", "定位工具类(WGS-84坐标系)", 1));
    data.push(new DescribeBean("PasteboardUtil", "剪贴板工具类", 1));
    data.push(new DescribeBean("SnapshotUtil", "组件截图和窗口截图工具类", 1));
    data.push(new DescribeBean("ScanUtil", "码工具类（扫码、码图生成、图片识码）", 1));
    data.push(new DescribeBean("ImageUtil", "图片相关工具类", 1));
    data.push(new DescribeBean("KeyboardUtil", "键盘工具类", 1));
    data.push(new DescribeBean("LogUtil", "日志工具类", 1));
    data.push(new DescribeBean("CrashUtil", "全局异常捕获，崩溃日志收集", 1));
    data.push(new DescribeBean("CharUtil", "字符工具类", 1));
    data.push(new DescribeBean("StrUtil", "字符串工具类", 1));
    data.push(new DescribeBean("Base64Util", "Base64工具类", 1));
    data.push(new DescribeBean("NumberUtil", "number工具类", 1));
    data.push(new DescribeBean("DateUtil", "日期工具类", 1));
    data.push(new DescribeBean("ArrayUtil", "数组工具类", 1));
    data.push(new DescribeBean("RandomUtil", "随机工具类", 1));
    data.push(new DescribeBean("ObjectUtil", "对象工具类", 1));
    data.push(new DescribeBean("JSONUtil", "JSON工具类", 1));
    data.push(new DescribeBean("CacheUtil", "缓存工具类", 1));
    data.push(new DescribeBean("ClickUtil", "节流、防抖 工具类（可用于点击事件，防止按钮被重复点击）", 1));
    data.push(new DescribeBean("TempUtil", "温度转换工具类，华氏度与摄氏度相互转换", 1));
    data.push(new DescribeBean("AssetUtil", "关键资产存储服务工具类", 1));
    data.push(new DescribeBean("EmitterUtil", "Emitter工具类（进行线程间通信）", 1));
    data.push(new DescribeBean("DialogUtil", "弹窗工具类（AlertDialog）", 1));
    data.push(new DescribeBean("ToastUtil", "土司工具类（promptAction）", 1));
    data.push(new DescribeBean("SM2", "SM2加解密", 2));
    data.push(new DescribeBean("SM3", "SM3工具类", 2));
    data.push(new DescribeBean("SM4", "SM4加解密", 2));
    data.push(new DescribeBean("MD5", "MD5工具类", 2));
    data.push(new DescribeBean("SHA", "SHA工具类", 2));
    data.push(new DescribeBean("AES", "AES加解密", 2));
    data.push(new DescribeBean("DES", "DES加解密", 2));
    data.push(new DescribeBean("RSA", "RSA加解密", 2));
    data.push(new DescribeBean("ECDSA", "ECDSA工具类", 2));
    return data;
  }
}