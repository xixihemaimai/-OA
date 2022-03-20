//
//  RSLaunchFootReusableView.m
//  OAManage
//
//  Created by mac on 2019/11/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSLaunchFootReusableView.h"

@implementation RSLaunchFootReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UIView * footView = [[UIView alloc]init];
        footView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
        [self addSubview:footView];
        
//        footView.sd_layout
//        .leftSpaceToView(self, 0)
//        .rightSpaceToView(self, 0)
//        .bottomSpaceToView(self, 0)
//        .heightIs(7.5);
        
        
        footView.frame = CGRectMake(0, self.yj_height - 7.5, SCW, 7.5);
        
        
        
    }
    return self;
}

@end
