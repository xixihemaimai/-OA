//
//  RSOACreatFile.h
//  OAManage
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSOACreatFile : NSObject
+ (NSString*)getPathWithinDocumentDir:(NSString*)aPath;

+(BOOL)judgePathWithinDocumentDir:(NSString*)aPath;
@end

NS_ASSUME_NONNULL_END
