//
//  QLPreviewItemCustom.h
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>
NS_ASSUME_NONNULL_BEGIN

@interface QLPreviewItemCustom : NSObject<QLPreviewItem>


@property (nonatomic,readwrite) NSURL * previewItemURL;

@property (nonatomic,readwrite) NSString * previewItemTitle;

@end

NS_ASSUME_NONNULL_END
