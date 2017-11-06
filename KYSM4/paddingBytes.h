//
//  paddingBytes.h
//  KYSM4Demo
//
//  Created by kingly on 2017/11/6.
//  Copyright © 2017年 kingly. All rights reserved.
//

#ifndef paddingBytes_h
#define paddingBytes_h

#include <stdio.h>

/**
 *
 *  对要加密的字符串进行补足字节
 *
 *  @param input        要加密的字符串
 *  @param stringLength 输入参数：要加密的字符串的长度
 */
void paddingForEncryption(unsigned char **input, unsigned long stringLength);


/**
 *
 *  补足字节的反操作
 *
 *  @param input        要解密的字符串
 *  @param stringLength 输出参数：字符串的实际长度
 */
void unpaddingForDecryption(unsigned char **input, unsigned long *stringLength);

#endif /* paddingBytes_h */
