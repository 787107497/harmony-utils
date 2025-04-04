import { FaultLogger } from "@kit.PerformanceAnalysisKit";

export declare class ExceptionBean {
  deviceInfo?: string;
  buildInfo?: string;
  version?: string;
  versionCode?: string;
  pid?: number;
  uid?: number;
  timestamp?: number;
  module?: string;
  summary?: string;
  fullLog?: string;
  reason?: string;
  type?: FaultLogger.FaultType;
  nowTime?: string;
}
