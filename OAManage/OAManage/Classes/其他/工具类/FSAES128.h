//
//  FSAES128.h
//  OAManage
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSAES128 : NSObject


//加密
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key andKInItVector:(NSString * const)kInitVector;
//解密
+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key andKInItVector:(NSString * const)kInitVector;
@end

NS_ASSUME_NONNULL_END
