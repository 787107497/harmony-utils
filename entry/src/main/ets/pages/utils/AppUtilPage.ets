import { font, KeyboardAvoidMode, router } from '@kit.ArkUI';
import { AppUtil, LogUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';
import { DescribeBean } from '../../model/DescribeBean';
import { MockSetup } from '@ohos/hamock';
import { TitleBarView } from '../../component/TitleBarView';
import {
  AbilityLifecycleCallback,
  ApplicationStateChangeCallback,
  ConfigurationConstant,
  EnvironmentCallback
} from '@kit.AbilityKit';
import { DialogAction, DialogHelper } from '@pura/harmony-dialog';
import { JSON } from '@kit.ArkTS';
import { Utils } from '../../utils/Utils';

/**
 * APP相关工具类
 */
@Entry
@Component
struct Index {
  private scroller: Scroller = new Scroller();
  @State describe: DescribeBean = router.getParams() as DescribeBean;
  @State mode: number = KeyboardAvoidMode.OFFSET; //上抬模式
  @State bright: number = 0.0; //屏幕亮度值
  @State isKeepScreenOn: boolean = false; //屏幕是否为常亮状态
  @State privacyMode: boolean = false; //是否隐私模式
  @State statusBar: boolean = false;
  @State blGray: boolean = false; //置灰状态
  @State colorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT; //深浅色模式
  @State blZhCn: boolean = false; //默认中文

  private applicationStateChangeCallback: ApplicationStateChangeCallback = {
    onApplicationForeground() {
      LogUtil.warn('applicationStateChangeCallback onApplicationForeground');
    },
    onApplicationBackground() {
      LogUtil.warn('applicationStateChangeCallback onApplicationBackground');
    }
  };
  @State callback1: number = -1;
  private environmentCallback: EnvironmentCallback = {
    onConfigurationUpdated(config) {
      LogUtil.warn(`onConfigurationUpdated config:\n${JSON.stringify(config, null)}`);
    },
    onMemoryLevel(level) {
      LogUtil.warn(`onMemoryLevel level: ${level}`);
    }
  };
  @State callback2: number = -1;
  private abilityLifecycleCallback: AbilityLifecycleCallback = {
    onAbilityCreate(ability) {
      LogUtil.info(`AbilityLifecycleCallback onAbilityCreate ability: ${ability}`);
    },
    onWindowStageCreate(ability, windowStage) {
      LogUtil.info(`AbilityLifecycleCallback onWindowStageCreate ability: ${ability}`);
      LogUtil.info(`AbilityLifecycleCallback onWindowStageCreate windowStage: ${windowStage}`);
    },
    onWindowStageActive(ability, windowStage) {
      LogUtil.info(`AbilityLifecycleCallback onWindowStageActive ability: ${ability}`);
      LogUtil.info(`AbilityLifecycleCallback onWindowStageActive windowStage: ${windowStage}`);
    },
    onWindowStageInactive(ability, windowStage) {
      LogUtil.info(`AbilityLifecycleCallback onWindowStageInactive ability: ${ability}`);
      LogUtil.info(`AbilityLifecycleCallback onWindowStageInactive windowStage: ${windowStage}`);
    },
    onWindowStageDestroy(ability, windowStage) {
      LogUtil.info(`AbilityLifecycleCallback onWindowStageDestroy ability: ${ability}`);
      LogUtil.info(`AbilityLifecycleCallback onWindowStageDestroy windowStage: ${windowStage}`);
    },
    onAbilityDestroy(ability) {
      LogUtil.info(`AbilityLifecycleCallback onAbilityDestroy ability: ${ability}`);
    },
    onAbilityForeground(ability) {
      LogUtil.info(`AbilityLifecycleCallback onAbilityForeground ability: ${ability}`);
    },
    onAbilityBackground(ability) {
      LogUtil.info(`AbilityLifecycleCallback onAbilityBackground ability: ${ability}`);
    },
    onAbilityContinue(ability) {
      LogUtil.info(`AbilityLifecycleCallback onAbilityContinue ability: ${ability}`);
    }
  };


  @MockSetup
  mock() {
    this.describe = new DescribeBean("AppUtil", "APP相关工具类");
  }

  build() {
    Column() {
      TitleBarView({ describe: this.describe })
      Divider()
      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button("getContext()")
            .btnStyle()
            .onClick(() => {
              let context = AppUtil.getContext();
              ToastUtil.showToast("成功获取上下文");
            })
          Button("getUIContext()")
            .btnStyle()
            .onClick(() => {
              let uiContext = AppUtil.getUIContext();
              ToastUtil.showToast("成功获取UIContext");
            })
          Button("getWindowStage()")
            .btnStyle()
            .onClick(() => {
              let windowStage = AppUtil.getWindowStage();
              LogUtil.error(JSON.stringify(windowStage, null, 2));
              ToastUtil.showToast("成功获取WindowStage");
            })
          Button("getMainWindow()")
            .btnStyle()
            .onClick(() => {
              let mainWindow = AppUtil.getMainWindow();
              LogUtil.error(JSON.stringify(mainWindow, null, 2));
              ToastUtil.showToast("成功获取主窗口");
            })
          Button("setGrayScale()")
            .btnStyle()
            .onClick(() => {
              if (!this.blGray) {
                this.blGray = true;
                AppUtil.setGrayScale(1);
                ToastUtil.showToast("一键置灰成功");
              } else {
                this.blGray = false;
                AppUtil.setGrayScale(0);
                ToastUtil.showToast("取消置灰成功");
              }
            })
          Button("setColorMode()")
            .btnStyle()
            .onClick(() => {
              if (this.colorMode !== ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
                this.colorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT;
                AppUtil.setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT);
              } else {
                this.colorMode = ConfigurationConstant.ColorMode.COLOR_MODE_DARK;
                AppUtil.setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_DARK);
              }
            })
          Button("setFont()")
            .btnStyle()
            .onClick(() => {
              font.registerFont({ familyName: 'WCSF', familySrc: $rawfile('wcsf.ttf') });
              AppUtil.setFont('WCSF');
            })
          Button("setLanguage()")
            .btnStyle()
            .onClick(() => {
              if (this.blZhCn) {
                this.blZhCn = false;
                AppUtil.setLanguage('en-us');
              } else {
                this.blZhCn = true;
                AppUtil.setLanguage('zh-cn');
              }
              ToastUtil.showToast("设置成功！");
            })
          Button("setSupportedProcessCache()")
            .btnStyle()
            .onClick(() => {
              AppUtil.setSupportedProcessCache(true);
              ToastUtil.showToast("设置成功！");
            })
          Button("clearUpApplicationData()")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showAlertDialog({
                content: '是否清理应用本身的数据？',
                primaryButton:'取消',
                secondaryButton:'清理',
                onAction: (action) => {
                  if (action === DialogAction.SURE) {
                    AppUtil.clearUpApplicationData();
                  }
                }
              });
            })
          Button("killAllProcesses()")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showAlertDialog({
                content: '是否终止应用的所有进程？',
                primaryButton:'取消',
                secondaryButton:'终止',
                onAction: (action) => {
                  if (action === DialogAction.SURE) {
                    AppUtil.killAllProcesses();
                  }
                }
              });
            })
          Button("restartApp()")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showAlertDialog({
                autoCancel: false,
                backCancel: false,
                content: '是否重启应用？',
                primaryButton:'取消',
                secondaryButton:'重启',
                onAction: (action) => {
                  if (action === DialogAction.SURE) {
                    AppUtil.restartApp();
                  }
                }
              });
            })
          Button("exit()")
            .btnStyle()
            .onClick(() => {
              DialogHelper.showAlertDialog({
                content: '是否重退出应用？',
                primaryButton:'取消',
                secondaryButton:'退出',
                onAction: (action) => {
                  if (action === DialogAction.SURE) {
                    AppUtil.exit();
                  }
                }
              });
            })
          Button("getRunningProcessInformation()")
            .btnStyle()
            .onClick(async () => {
              let processInformation = await AppUtil.getRunningProcessInformation();
              let jsonStr = JSON.stringify(processInformation, null, 2);
              Utils.showSheetText(jsonStr);
            })
          Button("onApplicationStateChange()")
            .btnStyle()
            .onClick(() => {
              AppUtil.onApplicationStateChange(this.applicationStateChangeCallback);
              DialogHelper.showToast('添加“applicationStateChange”监听成功！');
            })
          Button("offApplicationStateChange()")
            .btnStyle()
            .onClick(() => {
              AppUtil.offApplicationStateChange(this.applicationStateChangeCallback);
              DialogHelper.showToast('移除“applicationStateChange”监听成功！');
            })
          Button("onEnvironment()")
            .btnStyle()
            .onClick(() => {
              this.callback1 = AppUtil.onEnvironment(this.environmentCallback);
              DialogHelper.showToast('添加“environment”监听成功！');
            })
          Button("offEnvironment()")
            .btnStyle()
            .onClick(() => {
              if (this.callback1 !== -1) {
                AppUtil.offEnvironment(this.callback1);
                DialogHelper.showToast('移除“environment”监听成功！');
              }
            })
          Button("onAbilityLifecycle()")
            .btnStyle()
            .onClick(() => {
              this.callback2 = AppUtil.onAbilityLifecycle(this.abilityLifecycleCallback);
              DialogHelper.showToast('添加“abilityLifecycle”监听成功！');
            })
          Button("offAbilityLifecycle()")
            .btnStyle()
            .onClick(() => {
              if (this.callback2 !== -1) {
                AppUtil.offAbilityLifecycle(this.callback2);
                DialogHelper.showToast('移除“abilityLifecycle”监听成功！');
              }
            })
          Button("getKeyboardAvoidMode()")
            .btnStyle()
            .onClick(() => {
              this.mode = AppUtil.getKeyboardAvoidMode();
              ToastUtil.showToast(`当前模式为: ${StrUtil.equal(this.mode, KeyboardAvoidMode.OFFSET) ? "上抬模式" : "压缩模式"}`)
            })
          Button("setKeyboardAvoidMode()")
            .btnStyle()
            .onClick(() => {
              AppUtil.setKeyboardAvoidMode(StrUtil.equal(this.mode, KeyboardAvoidMode.OFFSET) ?
              KeyboardAvoidMode.RESIZE : KeyboardAvoidMode.OFFSET);
              this.mode = AppUtil.getKeyboardAvoidMode();
              ToastUtil.showToast(`设置模式为: ${StrUtil.equal(this.mode, KeyboardAvoidMode.OFFSET) ? "上抬模式" :
                "压缩模式"}`)
            })
          TextInput({ placeholder: '设置模式后点击输入框查看效果' })
            .width("95%")
            .margin({ bottom: 10 })

          Button("isPortrait()")
            .btnStyle()
            .onClick(() => {
              let isPortrait = AppUtil.isPortrait();
              ToastUtil.showToast(`当前是否竖屏: ${isPortrait}`);
            })
          Button("isLandscape()")
            .btnStyle()
            .onClick(() => {
              let isLandscape = AppUtil.isLandscape();
              ToastUtil.showToast(`当前是否横屏: ${isLandscape}`);
            })
          Button("getStatusBarHeight()")
            .btnStyle()
            .onClick(() => {
              let statusBarHeight = AppUtil.getStatusBarHeight();
              ToastUtil.showToast(`状态栏的高度为：${statusBarHeight}px`)
            })
          Button("getNavigationIndicatorHeight()")
            .btnStyle()
            .onClick(() => {
              let indicatorHeight = AppUtil.getNavigationIndicatorHeight();
              ToastUtil.showToast(`底部导航条的高度为：${indicatorHeight}px`)
            })
          Button("setStatusBar()")
            .btnStyle()
            .onClick(() => {
              this.statusBar = this.statusBar ? false : true;
              if (this.statusBar) {
                AppUtil.setStatusBar();
              } else {
                AppUtil.setStatusBar(false, true);
              }
            })
          Button("getBundleInfo()")
            .btnStyle()
            .onClick(async () => {
              let bundleInfo = await AppUtil.getBundleInfo();
              let infoStr = JSON.stringify(bundleInfo, null, 2);
              Utils.showSheetText(infoStr);
            })
          Button("getAppInfoSync()")
            .btnStyle()
            .onClick(() => {
              let appInfo = AppUtil.getAppInfoSync();
              let infoStr = JSON.stringify(appInfo, null, 2);
              Utils.showSheetText(infoStr);
            })
          Button("getSignatureInfo()")
            .btnStyle()
            .onClick(async () => {
              let signatureInfo = await AppUtil.getSignatureInfo();
              let infoStr = JSON.stringify(signatureInfo, null, 2);
              Utils.showSheetText(infoStr);
            })
          Button("getBundleName()\ngetVersionCode()\ngetVersionName()\ngetTargetVersion()\ngetInstallTime()\ngetUpdateTime()\ngetAppProvisionType()\ndebug()")
            .labelStyle({ maxLines: 10 })
            .type(ButtonType.Normal)
            .borderRadius(10)
            .padding({ top: 10, bottom: 10 })
            .btnStyle()
            .onClick(() => {
              let bundleName = AppUtil.getBundleName();
              let versionCode = AppUtil.getVersionCode();
              let versionName = AppUtil.getVersionName();
              let targetVersion = AppUtil.getTargetVersion();
              let infoStr = `bundleName: ${bundleName}\nversionCode: ${versionCode}\nversionName: ${versionName}\ntargetVersion: ${targetVersion}`;
              let installTime = AppUtil.getInstallTime();
              let updateTime = AppUtil.getUpdateTime();
              infoStr = infoStr + `\ninstallTime: ${installTime}\nupdateTime: ${updateTime}`;
              let appProvisionType = AppUtil.getAppProvisionType();
              let debug = AppUtil.debug();
              infoStr = infoStr + `\nappProvisionType: ${appProvisionType}\ndebug: ${debug}`;
              Utils.showSheetText(infoStr);
            })
        }
        .margin({ top: 5, bottom: 5 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor($r('app.color.main_background'))
  }
}


@Styles
function btnStyle() {
  .width('90%')
  .margin({ top: 10, bottom: 5 })
}