# harmony-web (API12)

## 🏆简介与推荐

[harmony-web](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-web) 是一款基于鸿蒙 WebView
打造的功能强大且极易上手的库，它不仅轻巧灵便、灵活度极高，还提供了一系列针对鸿蒙 WebView 的问题解决方案，助力开发者轻松应对各类开发挑战。

[harmony-utils](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils)
一款功能丰富且极易上手的HarmonyOS工具库，借助众多实用工具类，致力于助力开发者迅速构建鸿蒙应用。

[harmony-dialog](https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog)
一款极为简单易用的零侵入弹窗，仅需一行代码即可轻松实现，无论在何处都能够轻松弹出。

## 🌞下载安装

`ohpm i @pura/harmony-web`

OpenHarmony ohpm
环境配置等更多内容，请参考[如何安装 OpenHarmony ohpm 包](https://ohpm.openharmony.cn/#/cn/help/downloadandinstall)
<br>


## 📚 ***ArkWeb*** 组件，参数说明

| 名称          | 类型                          | 描述           | 是否必选 |
|:------------|:----------------------------|:-------------|:-----|
| controller  | webview.WebviewController   | 控制器          | Y    |
| src         | ResourceStr                 | 网页资源地址       | Y    |
| options     | ArkWebOptions               | ArkWeb属性参数   | N    |
| webClient   | ArkWebClient                | ArkWeb生命周期事件 | N    |
| arkJsObject | ArkJsObject 或 ArkJsObject[] | 需要注册的接口对象    | N    |

## 📚 ArkWebHelper，方法说明

| 方法名                | 介绍                    |
|:-------------------|:----------------------|
| init               | 初始化                   |
| prepareForPageLoad | 预连接url，在加载url之前调用此API |

## 📚示例代码

```
@Entry
@ComponentV2
struct Index {
  private controller: webview.WebviewController = new webview.WebviewController();
  @Local webUrl: string = "";
  @Local options: ArkWebOptions = new ArkWebOptions();
  @Local webClient: MyWebClient = new MyWebClient();
  @Local jsObject: MyJsObject = new MyJsObject();

  onBackPress(): boolean {
    if (this.controller?.accessBackward()) {
      this.controller?.backward();
      return true;
    }
    return false;
  }

  aboutToAppear(): void {
    let params: Params = router.getParams() as Params;
    this.webUrl = params.webUrl;
  }

  build() {
    Column() {
      ArkWeb({
        controller: this.controller,
        src: this.webUrl,
        options: this.options,
        webClient: this.webClient,
        arkJsObject: this.jsObject
      })
    }
    .height('100%')
    .width('100%')
  }

}
```

## 🍎沟通与交流🙏

使用过程中发现任何问题都可以提 [Issue](https://gitee.com/tongyuyan/harmony-utils/issues) 给我们；   
当然，我们也非常欢迎你给我们发 [PR](https://gitee.com/tongyuyan/harmony-utils/pulls) 。

[https://gitee.com/tongyuyan/harmony-utils](https://gitee.com/tongyuyan/harmony-utils)   
[https://github.com/787107497](https://github.com/787107497)

鸿蒙技术交流QQ群：1029219059

## 🌏开源协议

本项目基于 [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0.html) ，在拷贝和借鉴代码时，请大家务必注明出处。
