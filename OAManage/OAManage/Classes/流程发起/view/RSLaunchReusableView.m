//
//  RSLaunchReusableView.m
//  OAManage
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSLaunchReusableView.h"

@implementation RSLaunchReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =[UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        UILabel * launchLabel = [[UILabel alloc]init];
        launchLabel.text =@"行政流程";
        launchLabel.font = [UIFont systemFontOfSize:14.0f];
        launchLabel.textAlignment = NSTextAlignmentLeft;
        launchLabel.textColor =[UIColor colorWithHexColorStr:@"#333333"];
        [self addSubview:launchLabel];
        _launchLabel = launchLabel;
        launchLabel.frame = CGRectMake(15, 10, self.yj_width - 30, 21);
        
//        launchLabel.sd_layout
//        .leftSpaceToView(self, 15)
//        .topSpaceToView(self, 10)
//        .bottomSpaceToView(self, 10)
//        .rightSpaceToView(self, 15)
//        .heightIs(21);
        
        
    }
    return self;
}



@end
