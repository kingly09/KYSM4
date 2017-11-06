//
//  paddingBytes.c
//  KYSM4Demo
//
//  Created by kingly on 2017/11/6.
//  Copyright © 2017年 kingly. All rights reserved.
//

#include "paddingBytes.h"
#include <stdlib.h>
#include <string.h>


/**
 为要加密的原文进行填充字节

 @param input unsigned char  要加密的字符串
 @param stringLength unsigned long  输入参数：要加密的字符串的长度
 */
void paddingForEncryption(unsigned char **input, unsigned long stringLength)
{
    unsigned long length = stringLength;
    if (!*input || length <= 0)
    {
        return;
    }
    
    int mod = 16 - length % 16;
    length = length + mod;
    unsigned char *modChar = (unsigned char*)malloc(sizeof(unsigned char) * (mod + 1));
    memset(modChar, 0, mod + 1);
    memset(modChar, mod, mod);
    
    unsigned char *newChar = (unsigned char*)malloc(sizeof(unsigned char) * (length + 1));
    memset(newChar, 0, length + 1);
    unsigned char *pNewChar = newChar;
    
    unsigned char *pInput = *input;
    
    while (*pInput)
    {
        *pNewChar = *pInput;
        ++pNewChar;
        ++pInput;
    }
    
    unsigned char *pModChar = modChar;
    while (*pModChar)
    {
        *pNewChar = *pModChar;
        ++pNewChar;
        ++pModChar;
    }
    
    pInput = NULL;
    pNewChar = NULL;
    pModChar = NULL;
    free(modChar);
    free(*input);
    *input = newChar;
}

/**
 为已解密的消息去掉填充的字节

 @param input unsigned char  要解密的字符串
 @param stringLength unsigned long 输出参数：字符串的实际长度
 */
void unpaddingForDecryption(unsigned char **input, unsigned long *stringLength)
{
    if (!*input)
    {
        return;
    }
    
    size_t length = 0;
    unsigned char *pInput = *input;
    while (*pInput)
    {
        ++length;
        ++pInput;
    }
    
    //将pInput指向最后一个字节
    --pInput;
    
    //将后面mod个字节置为0
    int mod = *pInput;
    *stringLength = length - mod;
    
    while (mod)
    {
        *pInput = 0;
        --mod;
        --pInput;
    }
}
