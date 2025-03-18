/**
 * 通过正则表达式设置输入过滤器。匹配表达式的输入允许显示，不匹配的输入将被过滤。仅支持单个字符匹配，不支持字符串匹配。
 */
export interface InputFilter {
  value: ResourceStr; //正则表达式。
  error?: (value: string) => void; //正则匹配失败时，返回被过滤的内容。
}