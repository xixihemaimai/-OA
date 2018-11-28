//
//  FSAES128.m
//  OAManage
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FSAES128.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation FSAES128

//加密
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key andKInItVector:(NSString * const)kInitVector{
    size_t const kKeySize = kCCKeySizeAES128;
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    //NSData * contentData = [self dataForHexString:content];
    NSUInteger dataLength = contentData.length;
    // 为结束符'\\0' +1
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        // 对加密后的数据进行 base64 编码
        
       // return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSData * data = [NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize];
        return [self hexStringFromData:data];
       
    }
    free(encryptedBytes);
    return nil;
}



//解密
+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key andKInItVector:(NSString * const)kInitVector{
    size_t const kKeySize = kCCKeySizeAES128;
    // 把 base64 String 转换成 Data
    //NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSData * contentData = [self dataForHexString:content];
    
    NSUInteger dataLength = contentData.length;
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          decryptedBytes,
                                          decryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize] encoding:NSUTF8StringEncoding];
            }
    free(decryptedBytes);
    return nil;
}


//加密
//+(NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key
//{
//    char keyPtr[kCCKeySizeAES128+1];
//    memset(keyPtr, 0, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//
//    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
//    NSUInteger dataLength = [data length];
//
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    size_t numBytesEncrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
//                                          kCCAlgorithmAES128,
//                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
//                                          keyPtr,
//                                          kCCBlockSizeAES128,
//                                          NULL,
//                                          [data bytes],
//                                          dataLength,
//                                          buffer,
//                                          bufferSize,
//                                          &numBytesEncrypted);
//    if (cryptStatus == kCCSuccess) {
//        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
//        //return [GTMBase64 stringByEncodingData:resultData];
//        return [self hexStringFromData:resultData];
//
//    }
//    free(buffer);
//    return nil;
//}
////解密
//+(NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key
//{
//    char keyPtr[kCCKeySizeAES128 + 1];
//    memset(keyPtr, 0, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//
//    //NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
//
//    NSData *data=[self dataForHexString:encryptText];
//
//    NSUInteger dataLength = [data length];
//    size_t bufferSize = dataLength + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//
//    size_t numBytesCrypted = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
//                                          kCCAlgorithmAES128,
//                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
//                                          keyPtr,
//                                          kCCBlockSizeAES128,
//                                          NULL,
//                                          [data bytes],
//                                          dataLength,
//                                          buffer,
//                                          bufferSize,
//                                          &numBytesCrypted);
//    if (cryptStatus == kCCSuccess) {
//        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
//        NSLog(@"-------------------------------------");
//        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
//    }
//    free(buffer);
//    NSLog(@"===============================");
//    return nil;
//}



// 普通字符串转换为十六进
+ (NSString *)hexStringFromData:(NSData *)data {
    Byte *bytes = (Byte *)[data bytes];
    // 下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i=0; i<[data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i] & 0xff]; //16进制数
        newHexStr = [newHexStr uppercaseString];

        if([newHexStr length] == 1) {
            newHexStr = [NSString stringWithFormat:@"0%@",newHexStr];
        }

        hexStr = [hexStr stringByAppendingString:newHexStr];

    }
    return hexStr;
}
//
//
//
////十六进制转Data
////十六进制转Data
+ (NSData*)dataForHexString:(NSString*)hexString
{
    if (hexString == nil) {
        return nil;
    }
    const char* ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* data = [NSMutableData data];
    while (*ch) {
        if (*ch == ' ') {
            continue;
        }
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') {
            byte = *ch - '0';
        }else if ('a' <= *ch && *ch <= 'f') {
            byte = *ch - 'a' + 10;
        }else if ('A' <= *ch && *ch <= 'F') {
            byte = *ch - 'A' + 10;
        }
        ch++;
        byte = byte << 4;
        if (*ch) {
            if ('0' <= *ch && *ch <= '9') {
                byte += *ch - '0';
            } else if ('a' <= *ch && *ch <= 'f') {
                byte += *ch - 'a' + 10;
            }else if('A' <= *ch && *ch <= 'F'){
                byte += *ch - 'A' + 10;
            }
            ch++;
        }
        [data appendBytes:&byte length:1];
    }
    return data;
}


@end
