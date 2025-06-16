/*
 * Copyright (C) 2024 桃花镇童长老 @pura/harmony-utils
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
 * TODO 温度转换工具类
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/05/01
 */
export class TempUtil {


  /**
   * 摄氏度转华氏度
   * @param c 摄氏度
   * @return 华氏度
   */
  static C2F(c: number): number {
    return c * (9 / 5) + 32
  }

  /**
   * 华氏度转摄氏度
   * @param f 华氏度
   * @return 摄氏度
   */
  static F2C(f: number): number {
    return (f - 32) * (5 / 9)
  }


  /**
   * 摄氏度转开尔文
   * @param c 摄氏度温度值
   * @returns 开尔文温度值
   */
  static C2K(c: number): number {
    return c + 273.15;
  }

  /**
   * 开尔文转摄氏度
   * @param k 开尔文温度值
   * @returns 摄氏度温度值
   */
  static K2C(k: number): number {
    return k - 273.15;
  }


  /**
   * 华氏度转开尔文
   * @param f - 华氏度温度值
   * @returns 开尔文温度值
   */
  static F2K(f: number): number {
    return (f - 32) * 5 / 9 + 273.15;
  }

  /**
   * 开尔文转华氏度
   * @param k 开尔文温度值
   * @returns 华氏度温度值
   */
  static K2F(k: number): number {
    return (k - 273.15) * 9 / 5 + 32;
  }


}