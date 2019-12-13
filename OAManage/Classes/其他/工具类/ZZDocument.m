//
//  ZZDocument.m
//  OAManage
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ZZDocument.h"

@implementation ZZDocument

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    self.data = contents;
    return YES;
}

@end
