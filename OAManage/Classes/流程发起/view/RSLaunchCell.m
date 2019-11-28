//
//  RSLaunchCell.m
//  OAManage
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSLaunchCell.h"

@implementation RSLaunchCell



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        //图片
        UIImageView * funtionImage = [[UIImageView alloc]init];
        funtionImage.image = [UIImage imageNamed:@"个人信息"];
        [self.contentView addSubview:funtionImage];
        _funtionImage = funtionImage;
        
        funtionImage.sd_layout
        .leftSpaceToView(self.contentView, 30)
        .topSpaceToView(self.contentView, 4)
        .bottomSpaceToView(self.contentView, 4)
        .widthIs(32)
        .heightEqualToWidth();
        
        //文字
        UILabel * funtionLabel = [[UILabel alloc]init];
        funtionLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        funtionLabel.font = [UIFont systemFontOfSize:13];
        funtionLabel.numberOfLines = 0;
        funtionLabel.text = @"行政采购审批";
        [self.contentView addSubview:funtionLabel];
        _funtionLabel = funtionLabel;
        
        funtionLabel.sd_layout
        .leftSpaceToView(funtionImage, 9.5)
        .topEqualToView(funtionImage)
        .bottomEqualToView(funtionImage)
        .rightSpaceToView(self.contentView, 12);
        
        
        
    }
    return self;
}




@end
