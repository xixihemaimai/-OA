//
//  RSMyLabel.m
//  OAManage
//
//  Created by mac on 2020/9/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSMyLabel.h"

@implementation RSMyLabel

- (void)drawTextInRect:(CGRect)rect{
    CGRect size = CGRectMake(rect.origin.x + 6.5, rect.origin.y + 5, rect.size.width - 10, rect.size.height -10);
    [super drawTextInRect:size];
}

@end
