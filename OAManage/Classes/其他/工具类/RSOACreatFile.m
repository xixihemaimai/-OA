//
//  RSOACreatFile.m
//  OAManage
//
//  Created by mac on 2019/11/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSOACreatFile.h"

@implementation RSOACreatFile

+ (NSString*)getPathWithinDocumentDir:(NSString*)aPath
{
    NSString* fullPath = nil;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    if ([paths count] > 0) {
        fullPath = (NSString*)[paths objectAtIndex:0];
        if ([aPath length] > 0) {
            fullPath = [fullPath stringByAppendingPathComponent:aPath];
        }
    }
    return fullPath;
}

+(BOOL)judgePathWithinDocumentDir:(NSString*)aPath{
    BOOL isJudge;
    NSString* dataPath = [self getPathWithinDocumentDir:aPath];
    //判断是否存在数据表
    if (!([dataPath length] > 0 && [[NSFileManager defaultManager] fileExistsAtPath:dataPath])) {
        isJudge = NO;
    }else{
        isJudge = YES;
    }
    return isJudge;
}
@end
