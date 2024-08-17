/**
 * 类型约束
 * author: 桃花镇童长老ᥫ᭡
 * since: 2024/07/01
 * 仓库主页：https://ohpm.openharmony.cn/#/cn/detail/@pura%2Fharmony-utils
 * github: https://github.com/787107497
 * gitee: https://gitee.com/tongyuyan/harmony-utils
 * CSDN: https://blog.csdn.net/qq_32922545
 * QQ交流群: 569512366
 */
export declare namespace crypto {

  type BhuCoding = 'base64' | 'hex' | 'utf8' | 'utf-8';
  type BhCoding = 'base64' | 'hex';

  type SHA = 'SHA1' | 'SHA224' | 'SHA256' | 'SHA384' | 'SHA512'; //密钥类型，字符串参数

  type RSA_AlG = 'RSA512|PRIMES_2' | 'RSA768|PRIMES_2' | 'RSA1024|PRIMES_2' | 'RSA1024|PRIMES_3'
    | 'RSA2048|PRIMES_2'| 'RSA2048|PRIMES_3'| 'RSA3072|PRIMES_2'| 'RSA3072|PRIMES_2'
    | 'RSA4096|PRIMES_2'| 'RSA4096|PRIMES_3'| 'RSA4096|PRIMES_4'
    | 'RSA8192|PRIMES_2'| 'RSA8192|PRIMES_3'| 'RSA8192|PRIMES_4'| 'RSA8192|PRIMES_5'; //RSA密钥规格，字符串参数
  type RSA_TRAN_SOME = 'RSA|NoPadding' | 'RSA512|NoPadding' | 'RSA768|NoPadding' | 'RSA1024|NoPadding'
    | 'RSA2048|NoPadding' | 'RSA3072|NoPadding' | 'RSA4096|NoPadding' | 'RSA8192|NoPadding'
    | 'RSA|PKCS1' | 'RSA512|PKCS1' | 'RSA768|PKCS1' | 'RSA1024|PKCS1'
    | 'RSA2048|PKCS1' | 'RSA3072|PKCS1' | 'RSA4096|PKCS1' | 'RSA8192|PKCS1'
    | 'RSA2048|PKCS1_OAEP|SHA256|MGF1_SHA256' | 'RSA1024|PKCS1_OAEP|SHA256|MGF1_SHA256'; //RSA加解密规格，字符串参数
  type RSA_TRAN = RSA_TRAN_SOME | string;



}