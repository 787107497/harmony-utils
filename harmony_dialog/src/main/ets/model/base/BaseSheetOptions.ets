/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-dialog
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { UIContext } from '@kit.ArkUI';


/**
 * TODO 半模态工具类，Base参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-dialog
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 1029219059 */
export interface BaseSheetOptions extends SheetOptions {

  uiContext?: UIContext; //在UIContext实例对应的窗口中显示半模态。说明：使用openBindSheet启动的半模态页面，不支持设置、更新该属性。
  dialogId?: string; //弹框id，具有唯一性
  targetId?: number | string; //需要绑定组件的ID，若不指定则不绑定任何组件。string类型：传入组件的id，number类型：传入组件的UniqueId this.getUniqueId()。

}