//
//  RSAFNetwrokShare.h
//  OAManage
//
//  Created by mac on 2021/4/13.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSAFNetwrokShare : NSObject

@property (nonatomic,strong)AFHTTPSessionManager * manger;

+ (instancetype) share;

@end

NS_ASSUME_NONNULL_END
