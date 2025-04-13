import { AbilityStage, Configuration, ConfigurationConstant, Want } from '@kit.AbilityKit';
import { AppUtil, CrashUtil, LogUtil } from '@pura/harmony-utils';

export default class MyAbilityStage extends AbilityStage {

  onCreate() {
    CrashUtil.enableAppRecovery();
    let want: Want = {
      bundleName: 'com.harmony.utils',
      abilityName: 'EntryAbility'
    };
    CrashUtil.setRestartWant(want);
  }


  onConfigurationUpdate(newConfig: Configuration): void {
    LogUtil.error("onConfigurationUpdate: " + JSON.stringify(newConfig));
  }



}