// 单例对象 GlobalContext.ts
export class GlobalContext {

  private constructor() {}


  private static instance: GlobalContext;
  private _objects = new Map<string, Object>();


  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  getObject(value: string): Object | undefined {
    return this._objects.get(value);
  }

  setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass);
  }


}