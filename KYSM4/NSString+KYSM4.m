//
//  NSString+KYSM4.m
//  KYSM4Demo
//
//  Created by kingly on 2017/11/6.
//  Copyright © 2017年 kingly. All rights reserved.
//

#import "NSString+KYSM4.h"
#import "sm4.h"
#import "paddingBytes.h"


@implementation NSString (KYSM4)


/**
 *  使用密钥和初始化向量生成CBC模式的SM4加解密对象
 *
 *  @param secretKey 密钥
 *  @param iv        初始化向量
 *
 *  @return SM4加密字符串
 */
- (nullable NSString *)encryptionWithSM4Key:(nonnull NSString *)secretKey iv:(nonnull NSString *)iv {
    
    if ([secretKey length] != 16 || [iv length] != 16 || self == nil || [self length] == 0)
    {
#ifdef DEBUG
        NSLog(@"CBC模式 encryptionWithSM4Key方法入参有问题");
#endif
        return nil;
    }
    
    NSData *keyData = [secretKey dataUsingEncoding:NSUTF8StringEncoding];
    const char *keyChar = [secretKey cStringUsingEncoding:NSUTF8StringEncoding];
    size_t keyLength = [keyData length];
    
    NSData *msgData = [self dataUsingEncoding:NSUTF8StringEncoding];
    const char *msgChar = [self cStringUsingEncoding:NSUTF8StringEncoding];
    size_t msgLength = [msgData length];
    
    NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];
    const char *ivChar = [iv cStringUsingEncoding:NSUTF8StringEncoding];
    size_t ivLength = [ivData length];
    
    int paddingLength = 16 - (int)msgLength % 16 + (int)msgLength;
    
    unsigned char *pKey = (unsigned char*)malloc(sizeof(unsigned char) * (keyLength + 1));
    memset(pKey, 0, keyLength + 1);
    unsigned char *pfreeKey = pKey;
    unsigned char *pMsg = (unsigned char*)malloc(sizeof(unsigned char) * (msgLength + 1));
    memset(pMsg, 0, msgLength + 1);
    
    unsigned char *pIv = (unsigned char*)malloc(sizeof(unsigned char) * (ivLength + 1));
    memset(pIv, 0, ivLength + 1);
    unsigned char *pfreeIv = pIv;
    unsigned char *output = (unsigned char*)malloc(sizeof(unsigned char) * (paddingLength + 1));
    memset(output, 0, paddingLength + 1);
    unsigned char *pfreeoutput = output;
    
    unsigned char *pKeyChar = (unsigned char *)keyChar;
    unsigned char *pMsgChar = (unsigned char *)msgChar;
    unsigned char *pIvChar = (unsigned char *)ivChar;
    unsigned char *currentKey = (unsigned char *)pKey;
    unsigned char *currentMsg = (unsigned char *)pMsg;
    unsigned char *currentIv = (unsigned char *)pIv;
    unsigned char *pOutput = output;
    
    while (*pKeyChar)
    {
        *currentKey = *pKeyChar;
        ++pKeyChar;
        ++currentKey;
    }
    pKeyChar = NULL;
    currentKey = NULL;
    
    while (*pMsgChar)
    {
        *currentMsg = *pMsgChar;
        ++pMsgChar;
        ++currentMsg;
    }
    pMsgChar = NULL;
    currentMsg = NULL;
    
    while (*pIvChar)
    {
        *currentIv = *pIvChar;
        ++pIvChar;
        ++currentIv;
    }
    pIvChar = NULL;
    currentIv = NULL;
    
    paddingForEncryption(&pMsg, msgLength);
    unsigned char *pfreeMsg = pMsg;
    
    sm4_context ctx;
    sm4_setkey_enc(&ctx, pKey);
    sm4_crypt_cbc(&ctx,1,paddingLength,(unsigned char *)pIv,(unsigned char *)pMsg,(unsigned char *)output);
    
    //base64加密
    NSData *outdata = [NSData dataWithBytes:pOutput length:paddingLength];
    NSString *base64string = [outdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    free(pfreeKey);
    free(pfreeIv);
    free(pfreeMsg);
    free(pfreeoutput);
    pKey = NULL;
    pIv = NULL;
    pMsg = NULL;
    pOutput = NULL;
    pfreeoutput = NULL;
    pfreeMsg = NULL;
    pfreeIv = NULL;
    pfreeKey = NULL;
    
    return base64string;
}

/**
 在CBC模式下，利用给定的密钥，初始化向量，对字符串解密
 
 @param secretKey 密钥
 @param iv 初始化向量
 @return SM4解密字符串
 */
- (nullable NSString *)decryptionWithSM4Key:(nonnull NSString *)secretKey iv:(nonnull NSString *)iv {
    
    if ([secretKey length] != 16 || [iv length] != 16 || self == nil || [self length] == 0)
    {
#ifdef DEBUG
        NSLog(@"CBC模式 decryptionWithSM4Key方法入参有问题");
#endif
        return nil;
    }
    
    NSData *keyData = [secretKey dataUsingEncoding:NSUTF8StringEncoding];
    const char *keyChar = [secretKey cStringUsingEncoding:NSUTF8StringEncoding];
    size_t keyLength = [keyData length];
    
    //base64解密
    NSData *msgData = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    size_t msgLength = [msgData length];
    
    NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];
    const char *ivChar = [iv cStringUsingEncoding:NSUTF8StringEncoding];
    size_t ivLength = [ivData length];
    
    unsigned char *pKey = (unsigned char*)malloc(sizeof(unsigned char) * (keyLength + 1));
    unsigned char *pfreeKey = pKey;
    memset(pKey, 0, keyLength + 1);
    unsigned char *pMsg = (unsigned char*)malloc(sizeof(unsigned char) * (msgLength + 1));
    memset(pMsg, 0, msgLength + 1);
    unsigned char *pfreeMsg = pMsg;
    unsigned char *pIv = (unsigned char*)malloc(sizeof(unsigned char) * (ivLength + 1));
    memset(pIv, 0, ivLength + 1);
    unsigned char *pfreeIv = pIv;
    unsigned char *output = (unsigned char*)malloc(sizeof(unsigned char) * (msgLength + 1));
    memset(output, 0, msgLength + 1);
    
    
    unsigned char *pKeyChar = (unsigned char *)keyChar;
    unsigned char *pIvChar = (unsigned char *)ivChar;
    unsigned char *currentKey = (unsigned char *)pKey;
    __block unsigned char *currentMsg = (unsigned char *)pMsg;
    unsigned char *currentIv = (unsigned char *)pIv;
    unsigned char *pOutput = output;
    
    while (*pKeyChar)
    {
        *currentKey = *pKeyChar;
        ++pKeyChar;
        ++currentKey;
    }
    pKeyChar = NULL;
    currentKey = NULL;
    
    [msgData enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        for (NSInteger i = 0; i < byteRange.length; i++)
        {
            *currentMsg = *((unsigned char*)bytes + i);
            ++currentMsg;
        }
    }];
    currentMsg = NULL;
    
    while (*pIvChar)
    {
        *currentIv = *pIvChar;
        ++pIvChar;
        ++currentIv;
    }
    pIvChar = NULL;
    currentIv = NULL;
    
    
    sm4_context ctx;
    sm4_setkey_dec(&ctx, pKey);
    sm4_crypt_cbc(&ctx,0,(int)msgLength,(unsigned char *)pIv,(unsigned char *)pMsg,(unsigned char *)pOutput);
    
    unsigned long stringLength = 0;
    unpaddingForDecryption(&output, &stringLength);
    unsigned char *pfreeoutput = output;
    
    NSString *outString = [[NSString alloc]initWithBytes:output length:stringLength encoding:NSUTF8StringEncoding];
    
    free(pfreeKey);
    free(pfreeIv);
    free(pfreeMsg);
    free(pfreeoutput);
    pKey = NULL;
    pIv = NULL;
    pMsg = NULL;
    pOutput = NULL;
    output = NULL;
    pfreeKey = NULL;
    pfreeIv = NULL;
    pfreeMsg = NULL;
    pfreeoutput = NULL;
    
    return outString;
    
}
/**
 *  使用密钥生成ECB模式的SM4加解密对象
 *
 *  @param secretKey 密钥
 *
 *  @return SM4加解密对象
 */
- (nullable NSString *)encryptionWithSM4Key:(nonnull NSString *)secretKey {
    
    if ([secretKey length] != 16 || self == nil || [self length] == 0)
    {
#ifdef DEBUG
        NSLog(@"ECB模式 encryptionWithSM4Key方法入参有问题");
#endif
        return nil;
    }
    
    NSData *keyData = [secretKey dataUsingEncoding:NSUTF8StringEncoding];
    const char *keyChar = [secretKey cStringUsingEncoding:NSUTF8StringEncoding];
    size_t keyLength = [keyData length];
    
    NSData *msgData = [self dataUsingEncoding:NSUTF8StringEncoding];
    const char *msgChar = [self cStringUsingEncoding:NSUTF8StringEncoding];
    size_t msgLength = [msgData length];
    
    
    int paddingLength = 16 - (int)msgLength % 16 + (int)msgLength;
    
    unsigned char *pKey = (unsigned char*)malloc(sizeof(unsigned char) * (keyLength + 1));
    memset(pKey, 0, keyLength + 1);
    unsigned char *pfreeKey = pKey;
    
    unsigned char *pMsg = (unsigned char*)malloc(sizeof(unsigned char) * (msgLength + 1));
    memset(pMsg, 0, msgLength + 1);
    
    unsigned char *output = (unsigned char*)malloc(sizeof(unsigned char) * (paddingLength + 1));
    memset(output, 0, paddingLength + 1);
    unsigned char *pfreeoutput = output;
    
    unsigned char *pKeyChar = (unsigned char *)keyChar;
    unsigned char *pMsgChar = (unsigned char *)msgChar;
    unsigned char *currentKey = (unsigned char *)pKey;
    unsigned char *currentMsg = (unsigned char *)pMsg;
    unsigned char *pOutput = output;
    
    while (*pKeyChar)
    {
        *currentKey = *pKeyChar;
        ++pKeyChar;
        ++currentKey;
    }
    
    while (*pMsgChar)
    {
        *currentMsg = *pMsgChar;
        ++pMsgChar;
        ++currentMsg;
    }
    
    
    paddingForEncryption(&pMsg, msgLength);
    unsigned char *pfreeMsg = pMsg;
    
    sm4_context ctx;
    sm4_setkey_enc(&ctx, pKey);
    sm4_crypt_ecb(&ctx,1,paddingLength,(unsigned char *)pMsg,(unsigned char *)output);
    
    //base64加密
    NSData *outdata = [NSData dataWithBytes:pOutput length:paddingLength];
    NSString *base64string = [outdata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    free(pfreeKey);
    free(pfreeMsg);
    free(pfreeoutput);
    pKey = NULL;
    pMsg = NULL;
    pOutput = NULL;
    output = NULL;
    pfreeoutput = NULL;
    pfreeMsg = NULL;
    pfreeKey = NULL;
    
    return base64string;
    
}

/**
 *  在ECB模式下，利用给定的密钥，对字符串解密
 *
 *  @param secretKey 密钥
 *
 *  @return SM4解密字符串
 */
- (nullable NSString *)decryptionWithSM4Key:(nonnull NSString *)secretKey {
    
    if ([secretKey length] != 16 || self == nil || [self length] == 0)
    {
#ifdef DEBUG
        NSLog(@"ECB模式 decryptionWithSM4Key方法入参有问题");
#endif
        return nil;
    }
    
    NSData *keyData = [secretKey dataUsingEncoding:NSUTF8StringEncoding];
    const char *keyChar = [secretKey cStringUsingEncoding:NSUTF8StringEncoding];
    size_t keyLength = [keyData length];
    
    //base64解密
    NSData *msgData = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    size_t msgLength = [msgData length];
    
    
    unsigned char *pKey = (unsigned char*)malloc(sizeof(unsigned char) * (keyLength + 1));
    memset(pKey, 0, keyLength + 1);
    unsigned char *pfreeKey = pKey;
    
    unsigned char *pMsg = (unsigned char*)malloc(sizeof(unsigned char) * (msgLength + 1));
    memset(pMsg, 0, msgLength + 1);
    unsigned char *pfreeMsg = pMsg;
    
    unsigned char *output = (unsigned char*)malloc(sizeof(unsigned char) * (msgLength + 1));
    memset(output, 0, msgLength + 1);
    
    unsigned char *pKeyChar = (unsigned char *)keyChar;
    unsigned char *currentKey = (unsigned char *)pKey;
    __block unsigned char *currentMsg = (unsigned char *)pMsg;
    unsigned char *pOutput = output;
    
    while (*pKeyChar)
    {
        *currentKey = *pKeyChar;
        ++pKeyChar;
        ++currentKey;
    }
    
    [msgData enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        for (NSInteger i = 0; i < byteRange.length; i++)
        {
            *currentMsg = *((unsigned char*)bytes + i);
            ++currentMsg;
        }
    }];
    
    
    sm4_context ctx;
    sm4_setkey_dec(&ctx, pKey);
    sm4_crypt_ecb(&ctx,0,(int)msgLength,(unsigned char *)pMsg,(unsigned char *)output);
    
    unsigned long stringLength = 0;
    unpaddingForDecryption(&pOutput, &stringLength);
    unsigned char *pfreeoutput = pOutput;
    
    NSString *outString = [[NSString alloc]initWithBytes:pOutput length:stringLength encoding:NSUTF8StringEncoding];
    
    free(pfreeKey);
    free(pfreeoutput);
    free(pfreeMsg);
    pKey = NULL;
    pMsg = NULL;
    pOutput = NULL;
    output = NULL;
    pfreeMsg = NULL;
    pfreeoutput = NULL;
    pfreeKey = NULL;
    
    return outString;
    
}

@end
