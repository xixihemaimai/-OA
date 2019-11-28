//
//  RSGyRollingCell.m
//  OAManage
//
//  Created by mac on 2019/11/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSGyRollingCell.h"

@implementation RSGyRollingCell



- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UIImageView * tagImageView = [[UIImageView alloc]init];
        tagImageView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:tagImageView];
        _tagImageView = tagImageView;
        
        
        tagImageView.sd_layout
        .leftSpaceToView(self.contentView, 9.5)
        .topSpaceToView(self.contentView, 1.5)
        .widthIs(25)
        .heightIs(12);
        
        
        UILabel * titelLabel = [[UILabel alloc]init];
        titelLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        titelLabel.font = [UIFont systemFontOfSize:12];
        titelLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titelLabel];
        
        titelLabel.sd_layout
        .leftSpaceToView(tagImageView, 6)
        .topEqualToView(tagImageView)
        .bottomEqualToView(tagImageView)
        .rightSpaceToView(self.contentView, 15);
        _titelLabel = titelLabel;
        
        
        UIImageView * secondImageView = [[UIImageView alloc]init];
        secondImageView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:secondImageView];
        _secondImageView = secondImageView;
        
        
        secondImageView.sd_layout
        .leftEqualToView(tagImageView)
        .topSpaceToView(tagImageView, 5)
        .rightEqualToView(tagImageView)
        .heightIs(12);
        
        
        UILabel * secondtitelLabel = [[UILabel alloc]init];
        secondtitelLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        secondtitelLabel.font = [UIFont systemFontOfSize:12];
        secondtitelLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:secondtitelLabel];
        
        secondtitelLabel.sd_layout
        .leftSpaceToView(secondImageView, 6)
        .topEqualToView(secondImageView)
        .bottomEqualToView(secondImageView)
        .rightSpaceToView(self.contentView, 15);
        
        _secondtitelLabel = secondtitelLabel;
        
        
        
        
    }
    return self;
}

@end
