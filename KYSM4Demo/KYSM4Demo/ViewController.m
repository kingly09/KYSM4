//
//  ViewController.m
//  KYSM4Demo
//
//  Created by kingly on 2017/11/6.
//  Copyright © 2017年 kingly. All rights reserved.
//

#import "ViewController.h"
#import "NSString+KYSM4.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self cbcDemo];
    [self ECBDemo];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 CBC模式示例
 */
-(void)cbcDemo{
    
    
    //密钥
    NSString *secretKey = @"JeF8U9wHFOMfs2Y8";
    //初始化向量
    NSString *iv = @"UISwD9fW6cFh9SNS";
    // 需要加密的字符串
    NSString *testString = @"CBC模式示例:测试 国密Sm4算法";
    
    NSString *encryptionString = [testString encryptionWithSM4Key:secretKey iv:iv];
    NSLog(@"加密: %@", encryptionString);
    
    NSString *decryptionString = [encryptionString decryptionWithSM4Key:secretKey iv:iv];
    NSLog(@"解密: %@", decryptionString);
    
}

/**
 ECB模式示例
 */
-(void)ECBDemo{
    
    //密钥
    NSString *secretKey = @"JeF8U9wHFOMfs2Y8";
    // 需要加密的字符串
    NSString *testString = @"ECB模式示例:测试 国密Sm4算法";
    
    NSString *encryptionString = [testString encryptionWithSM4Key:secretKey];
    NSLog(@"加密: %@", encryptionString);
    
    NSString *decryptionString = [encryptionString decryptionWithSM4Key:secretKey];
    NSLog(@"解密: %@", decryptionString);
    
}

@end
