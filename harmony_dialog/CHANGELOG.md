# 版本记录


## 1.1.0
1. SelectDialog，添加selectedIndex参数，设置选中索引。
2. TextPickerDialog，修复canLoop参数问题。
3.

## 1.0.9
1. 优化部分弹框的最大宽度。
2. 优化ToastTip部分参数配置。
3. 优化ToastTip新增支持水平布局，参数alignment。


## 1.0.8
1. 新增日期选择器弹框，showDatePickerDialog。
2. BottomSheetOptions 支持 cancelFontColor/cancelFontWeight 属性，用于自定义【取消】字体样式。
3. 加载弹框，修改为可传入dialogId; 并废弃closeLoading()、isShowLoading()、getLoadingDialogId()方法。
4. DialogConfig的uiContext改为uiAbilityContext，并且类型为common.UIAbilityContext；所以后面需要在UIAbility的onCreate方法里初始化uiAbilityContext。

```typescript
//1.0.8版本适配指南：

DialogHelper.setDefaultConfig((config) => {
config.uiContext = this.context
})
//改为
DialogHelper.setDefaultConfig((config) => {
config.uiAbilityContext = this.context
})

DialogHelper.closeLoading();
//改为
DialogHelper.closeDialog("xxx");
```

## 1.0.7
1. 修复部分弹框，buttons设置按钮颜色不生效。
2. 优化BottomSheetDialog和ActionSheetDialog的展示。
3. 新增参数maxHeight，设置弹窗高度默认最大值；很多弹框都是自适应高度，谨慎设置该值。
4. 新增加载弹框方法isShowLoading()、getLoadingDialogId()。
5. 输入类弹框新增参数defaultFocus；设置弹框默认获得焦点，打开弹窗同时弹出输入法。
6. 新增选择器弹框，showTextPickerDialog。

## 1.0.6
1. 优化弹框关闭可能出现的异常。

## 1.0.5
1. 优化代码。   
2. 输入弹框添加maxLength、controller、inputFilter参数。   
    1、maxLength：文本的最大输入字符数。   
    2、controller：TextInputController，输入控制器。   
    3、inputFilter：InputFilter，通过正则表达式设置输入过滤器。   

## 1.0.4
1. 优化代码。   
2. showLoading，Loading弹框内置SpinKit，支持20多种动画。   

## 1.0.3
1. 优化吐司（Toast）支持backCancel。    
2. 优化showCustomContentDialog等的多按钮参数buttons?: Array<ResourceStr | ButtonOptions>。    

## 1.0.2
1. 在代码里添加开源协议。    
2. 优化代码。    
3. 优化弹框宽度，弹框默认宽度为calc(100% - 32vp)。    
4. 添加 maxWidth，优化在大屏上的显示效果。    

## 1.0.1
1. 优化代码。    
2. 优化有子窗口的情况下，弹框异常显示的问题。    

## 1.0.0 初版
1. 发布1.0.0初版。        