# KYSM4
KYSM4是一个基于SM4国密算法的Objective-C的国密SM4加密类

前几天项目用到sm4加密解密，加密为十六进制字符串，再将十六进制字符串解密。sm4是密钥长度和加密明文加密密文都为16个字节十六进制数据，网上的sm4 c语言算法很容易搜到，笔者刚开始没怎么理解，以为只能对16字节数据进行加密，并且不论是多少字节的数据加密出来都是16字节的。后来看了下源码，应该是加密的数据应该是16字节或者16的整数倍个字节的数据，若不够16倍数字节应该补0x00数据，最后加密出来的数据和输入数据的长度应该一致。

# 安装


###要求

* Xcode 9 +
* iOS 8.0 +

### 手动安装

下载DEMO后,将子文件夹 **KYSM4** 拖入到项目中, 导入头文件`NSString+KYSM4.h` 开始使用.


### 使用CocoaPods安装

你可以在 **Podfile** 中加入下面一行代码来使用 **KYSM4** 

```
$ pod 'KYSM4'
```

在需要的地方，导入头文件`NSString+KYSM4.h` 开始使用.

### 使用Carthage安装

先使用 [Homebrew](https://brew.sh/) 安装 `Carthage `,使用命令如下：


```
$ brew update
$ brew install carthage
```

你可以在 **Cartfile** 文件中加入下面一行代码来使用 **KYSM4** 

```
$ github "kingly09/KYSM4" 
```

把 `KYSM4.framework` 拖到 Xcode 项目中使用。

详细怎么使用`Cartfile`管理iOS第三方依赖库 ，请见[https://my.oschina.net/kinglyphp/blog/1560525](https://my.oschina.net/kinglyphp/blog/1560525) 


# 实现的功能

1. 在CBC模式下，利用给定的密钥，初始化向量，对字符串加解密；
2. 在ECB模式下，利用给定的密钥，对字符串加解密。

# 如何使用

在您需要使用`KYSM4 ` 加密解密的类中，import 头文件`NSString+KYSM4.h`即可 。

在CBC模式下，利用给定的密钥，初始化向量，对字符串加解密；


```
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
```


 在ECB模式下，利用给定的密钥，对字符串加解密。
 
 
 ```
  //密钥
    NSString *secretKey = @"JeF8U9wHFOMfs2Y8";
    // 需要加密的字符串
    NSString *testString = @"ECB模式示例:测试 国密Sm4算法";
    
    NSString *encryptionString = [testString encryptionWithSM4Key:secretKey];
    NSLog(@"加密: %@", encryptionString);
    
    NSString *decryptionString = [encryptionString decryptionWithSM4Key:secretKey];
    NSLog(@"解密: %@", decryptionString);

 ```
 
# 更多有关SM4国密算法
 
 国家密码管理局：[http://www.oscca.gov.cn/](http://www.oscca.gov.cn/)
 
 
 SM4国密算法实现分析：[http://blog.csdn.net/archimekai/article/details/53095993](http://blog.csdn.net/archimekai/article/details/53095993)
 
 国产密码安全算法总结：[http://blog.csdn.net/u012198553/article/details/60964156](http://blog.csdn.net/u012198553/article/details/60964156)
 
  SMS4 密码算法：[pdf下载](https://github.com/kingly09/KYSM4/raw/master/sm4.pdf)


#  联系与建议反馈

>
> **weibo:** [http://weibo.com/balenn](http://weibo.com/balenn)
>
> **QQ:** 362108564
>

如果有任何你觉得不对的地方，或有更好的建议，以上联系都可以联系我。 十分感谢！ 
 

# LICENSE

**KYSM4** 被许可在 **MIT** 协议下使用。查阅 **LICENSE** 文件来获得更多信息。