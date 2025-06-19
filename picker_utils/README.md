# picker_utils (API12+)

## 🏆简介与推荐

[picker_utils](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fpicker_utils)
是[harmony-utils](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils)
拆分出来的一个子库，包含PickerUtil、PhotoHelper、ScanUtil。   
主要解决：当使用 harmony-utils 三方库且未使用picker能力时，隐私政策中无需声明相机权限与储存权限。

## 🌞下载安装

`ohpm i @pura/picker_utils`

OpenHarmony ohpm
环境配置等更多内容，请参考[如何安装 OpenHarmony ohpm 包](https://ohpm.openharmony.cn/#/cn/help/downloadandinstall)
<br>

## 📚API详解 [使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/plug/MimeTypesPage.ets)

## 📂模块介绍

| 模块          | 介绍                       |
|:------------|:-------------------------|
| PickerUtil  | 拍照、文件(文件、图片、视频)选择和保存,工具类 |
| PhotoHelper | 相册相关工具类                  |
| ScanUtil    | 码工具类（扫码、码图生成、图片识码）       |

## PickerUtil（拍照、文件选择和保存,工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PickerUtilPage.ets)

| 方法                               | 介绍                                                  |
|:---------------------------------|:----------------------------------------------------|
| camera<br>cameraEasy             | 调用系统相机，拍照、录视频                                       |
| selectPhoto                      | 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频              |
| savePhoto                        | 通过保存模式拉起photoPicker进行保存图片或视频资源的文件名，若无参数，则默认需要用户自行输入 |
| selectDocument                   | 通过选择模式拉起documentPicker界面，用户可以选择一个或多个文件              |
| saveDocument<br>saveDocumentEasy | 通过保存模式拉起documentPicker界面，用户可以保存一个或多个文件              |
| selectAudio                      | 通过选择模式拉起audioPicker界面，用户可以选择一个或多个音频文件               |
| saveAudio                        | 通过保存模式拉起audioPicker界面，用户可以保存一个或多个音频文件               |

## PhotoHelper（相册相关,工具类）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/PhotoHelperPage.ets)

| 方法                           | 介绍                                     |
|:-----------------------------|:---------------------------------------|
| select<br>selectEasy         | 通过选择模式拉起photoPicker界面，用户可以选择一个或多个图片/视频 |
| save                         | 申请权限保存，保存图片或视频到相册。                     |
| showAssetsCreationDialog     | 弹窗授权保存，调用接口拉起保存确认弹窗。                   |
| showAssetsCreationDialogEasy | 弹窗授权保存，调用接口拉起保存确认弹窗，并保存。               |
| applyChanges                 | 安全控件保存，提交媒体变更请求，插入图片/视频。               |
| getPhotoAsset                | 获取对应uri的PhotoAsset对象,用于读取文件信息          |

## ScanUtil（码工具类(扫码、码图生成、图片识码)）[使用案例](https://gitee.com/tongyuyan/harmony-utils/blob/master/entry/src/main/ets/pages/utils/ScanUtilPage.ets)

| 方法                    | 介绍                             |
|:----------------------|:-------------------------------|
| startScanForResult    | 调用默认界面扫码，使用Promise方式异步返回解码结果   |
| generateBarcode       | 码图生成，使用Promise异步返回生成的码图        |
| decode                | 调用图片识码，使用Promise方式异步返回识码结果     |
| decodeImage           | 调用图像数据识码能力，使用Promise异步回调返回识码结果 |
| onPickerScanForResult | 通过picker拉起图库并选择图片,并调用图片识码      |
| canIUseScan           | 判断当前设备是否支持码能力                  |

## 🍎沟通与交流🙏

使用过程中发现任何问题都可以提 [Issue](https://gitee.com/tongyuyan/harmony-utils/issues) 给我们；   
当然，我们也非常欢迎你给我们发 [PR](https://gitee.com/tongyuyan/harmony-utils/pulls) 。

鸿蒙技术交流QQ群：1029219059

## 🌏开源协议

本项目基于 [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.html) ，在拷贝和借鉴代码时，请大家务必注明出处。
