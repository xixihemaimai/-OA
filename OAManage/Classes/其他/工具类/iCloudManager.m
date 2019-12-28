//
//  iCloudManager.m
//  OAManage
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "iCloudManager.h"

@implementation iCloudManager

+ (BOOL)iCloudEnable {
    NSFileManager *manager = [NSFileManager defaultManager];
    //NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];
    if (manager.ubiquityIdentityToken != nil) {
        return YES;
    }
    
//    if (url != nil) {
//        return YES;
//    }
    NSLog(@"iCloud 不可用");
    return NO;
}


+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block {
    ZZDocument *iCloudDoc = [[ZZDocument alloc]initWithFileURL:url];
    [iCloudDoc openWithCompletionHandler:^(BOOL success) {
        if (success) {
            [iCloudDoc closeWithCompletionHandler:^(BOOL success) {
                NSLog(@"关闭成功");
            }];
            if (block) {
                block(iCloudDoc.data);
            }
        }
    }];
}


@end
