//
//  NSString+KYSM4.h
//  KYSM4Demo
//
//  Created by kingly on 2017/11/6.
//  Copyright © 2017年 kingly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KYSM4)

/**
 *  使用密钥和初始化向量生成CBC模式的SM4加解密对象
 *
 *  @param secretKey 密钥
 *  @param iv        初始化向量
 *
 *  @return SM4加密字符串
 */
- (nullable NSString *)encryptionWithSM4Key:(nonnull NSString *)secretKey iv:(nonnull NSString *)iv;

/**
 在CBC模式下，利用给定的密钥，初始化向量，对字符串解密

 @param secretKey 密钥
 @param iv 初始化向量
 @return SM4解密字符串
 */
- (nullable NSString *)decryptionWithSM4Key:(nonnull NSString *)secretKey iv:(nonnull NSString *)iv;
/**
 *  使用密钥生成ECB模式的SM4加解密对象
 *
 *  @param secretKey 密钥
 *
 *  @return SM4加解密对象
 */
- (nullable NSString *)encryptionWithSM4Key:(nonnull NSString *)secretKey;

/**
 *  在ECB模式下，利用给定的密钥，对字符串解密
 *
 *  @param secretKey 密钥
 *
 *  @return SM4解密字符串
 */
- (nullable NSString *)decryptionWithSM4Key:(nonnull NSString *)secretKey;

@end
