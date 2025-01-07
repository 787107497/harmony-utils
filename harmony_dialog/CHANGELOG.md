# 版本记录

## 1.1.1
1. 修复Toast, 全局参数alignment不起作用问题。
2. Toast，新增全局参数toast_alignment（当该值为undefined时alignment值起作用）。

## 1.1.0
1. SelectDialog，添加selectedIndex参数，设置选中索引。
2. TextPickerDialog，修复canLoop参数问题。
3. TextInputDialog 新增showPassword、showPasswordIcon、passwordIcon、passwordRules、cancelButton等参数。
4. LoadingDialog和LoadingProgress，新增参数shadow，阴影效果。
5. 修改showToast实现方式，解决一些网友反馈的问题。

```typescript
//1.1.0版本适配指南：由于修改了吐司（showToast）实现方式，所以只支持以下参数

uiContext?: UIContext; //UIContext上下文
message?: string | Resource; //显示的文本信息。默认字体为'Harmony Sans'，不支持设置其他字体。
duration?: number //默认值1500ms，取值区间：1500ms-10000ms。若小于1500ms则取默认值，若大于10000ms则取上限值10000ms。
fontColor?: ResourceColor; // 文本提示框文本颜色。默认值：Color.Black
bottom?: string | number; //设置弹窗底部边框距离导航条的高度，ToastShowMode.TOP_MOST模式下，软键盘拉起时，如果bottom值过小，toast要被软键盘遮挡时，会自动避让至距离软键盘80vp处。ToastShowMode.DEFAULT模式下，软键盘拉起时，会上移软键盘的高度。默认值：80vp。说明：当底部没有导航条时，bottom为设置弹窗底部边框距离窗口底部的高度。设置对齐方式alignment后，bottom不生效。
alignment?: Alignment; //对齐方式。默认值：undefined，默认底部偏上位置。
offset?: Offset; //在对齐方式上的偏移。默认值：{ dx: 0, dy: 0 }，默认没有偏移。说明： 只支持设置px类型的数值，如需设置vp，可以将vp改成px传入。
backgroundColor?: ResourceColor; //文本提示框背板颜色，建议八位色值前两位为透明度。默认值：Color.Transparent。说明：当设置了backgroundColor为非透明色时，backgroundBlurStyle需要设置为BlurStyle.NONE，否则颜色显示将不符合预期效果。
backgroundBlurStyle?: BlurStyle; //文本提示框背板模糊材质。默认值：BlurStyle.COMPONENT_ULTRA_THICK。说明：设置为BlurStyle.NONE即可关闭背景虚化。当设置了backgroundBlurStyle为非NONE值时，则不要设置backgroundColor，否则颜色显示将不符合预期效果。
shadow?: ShadowOptions | ShadowStyle; //文本提示框背板阴影。默认值：ShadowStyle.OUTER_DEFAULT_MD
showMode?: promptAction.ToastShowMode; //设置弹窗是否显示在应用之上。默认值：ToastShowMode.DEFAULT，默认显示在应用内。
```

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