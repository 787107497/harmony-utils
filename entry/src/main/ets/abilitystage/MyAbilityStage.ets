import { AbilityStage, Want } from '@kit.AbilityKit';
import { CrashUtil } from '@pura/harmony-utils';

export default class MyAbilityStage extends AbilityStage {

  onCreate() {
    CrashUtil.enableAppRecovery();

    let want: Want = {
      bundleName: 'com.harmony.utils',
      abilityName: 'EntryAbility'
    };
    CrashUtil.setRestartWant(want)
  }

}