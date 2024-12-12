# 版本记录

## 1.0.7
1. 优化部分弹框的按钮。
2. 优化BottomSheetDialog和ActionSheetDialog的展示。
3. 新增参数maxHeight，设置弹窗高度默认最大值；很多弹框都是自适应高度，谨慎设置该值。
4. 新增加载弹框方法isShowLoading()、getLoadingDialogId()。
5. 修复部分弹框，buttons设置按钮颜色不生效。
6. 输入类弹框新增参数defaultFocus；设置弹框默认获得焦点，打开弹窗同时弹出输入法。
7. 新增显示选择器弹框，showTextPickerDialog。

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