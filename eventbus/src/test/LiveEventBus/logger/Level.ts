/*
 * Copyright (C) 2022 Huawei Device Co., Ltd.
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



export default class Level {
  private static defaultBundle:string = "sun.util.logging.resources.logging";

  public static ALL: Level = new Level('ALL',0);
  public static CONFIG: Level = new Level("CONFIG", 700, Level.defaultBundle);;
  public static FINE: Level = new Level("FINE", 500, Level.defaultBundle);
  public static FINER: Level = new Level("FINER", 400, Level.defaultBundle);;
  public static FINEST: Level = new Level("FINEST", 300, Level.defaultBundle);
  public static INFO: Level = new Level("INFO", 800, Level.defaultBundle);
  public static OFF: Level = new Level("OFF",99999, Level.defaultBundle);
  public static SEVERE: Level = new Level("SEVERE",1000, Level.defaultBundle);;
  public static WARNING: Level = new Level("WARNING", 900, Level.defaultBundle);;

  private name:string
  private value:number
  private resourceBundleName:string
  constructor(name: string, value: number,resourceBundleName?:string) {
    this.name = name
    this.value = value
    this.resourceBundleName = resourceBundleName;
  }
}