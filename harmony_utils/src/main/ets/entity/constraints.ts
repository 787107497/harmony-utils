import { ArrayList, HashMap } from "@kit.ArkTS";


export type CommonSingleType = Object | String | Number | Boolean | null | undefined; //通用单个联合类型
export type CommonAllType = CommonSingleType | Array<CommonSingleType> | ArrayList<CommonSingleType> | HashMap<CommonSingleType, CommonSingleType>; //通用所有联合类型


export type Constructor<T> = new (...args: any[]) => T;