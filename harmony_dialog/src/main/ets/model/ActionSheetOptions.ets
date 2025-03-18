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


/**
 * TODO BottomSheetDialog按钮参数类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/08/18
 */
export class ActionSheetOptions {
  value: ResourceStr = ''; //按钮的内容。
  fontColor?: ResourceColor; //按钮的字体颜色。
  fontSize?: number | string | Resource; //按钮的文字大小，，默认16。
}
