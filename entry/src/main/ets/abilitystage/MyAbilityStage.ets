import { AbilityStage, Configuration, ConfigurationConstant, Want } from '@kit.AbilityKit';
import { CrashUtil, LogUtil } from '@pura/harmony-utils';

export default class MyAbilityStage extends AbilityStage {

  onCreate() {
    CrashUtil.enableAppRecovery();
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);

    let want: Want = {
      bundleName: 'com.harmony.utils',
      abilityName: 'EntryAbility'
    };
    CrashUtil.setRestartWant(want)
  }


  onConfigurationUpdate(newConfig: Configuration): void {
    LogUtil.error("onConfigurationUpdate: " + JSON.stringify(newConfig));
  }



}