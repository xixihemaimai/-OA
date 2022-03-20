//
//  iCloudManager.h
//  OAManage
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^downloadBlock)(id obj);

@interface iCloudManager : NSObject


+ (BOOL)iCloudEnable;

+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block;


@end

NS_ASSUME_NONNULL_END
