//
//  RSManageCell.m
//  OAManage
//
//  Created by mac on 2020/9/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSManageCell.h"

@implementation RSManageCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        UIImageView * manageView = [[UIImageView alloc]init];
        manageView.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:manageView];
        _manageView = manageView;
        
        manageView.frame = CGRectMake(19.5, 60/2 - 25/2, 25, 25);
        
        
        UILabel * manageLabel = [[UILabel alloc]init];
        manageLabel.text = @"荒料出入库情况";
        manageLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        manageLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:manageLabel];
        _manageLabel = manageLabel;
        
        UIView * midView = [[UIView alloc]init];
        midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:midView];
        
//        manageView.sd_layout
//        .centerYEqualToView(self.contentView)
//        .leftSpaceToView(self.contentView, 19.5)
//        .widthIs(25)
//        .heightEqualToWidth();
        
        manageLabel.frame = CGRectMake(CGRectGetMaxX(manageView.frame) + 15,  60/2 - 24/2,SCW - CGRectGetMaxX(manageView.frame) - 15 - 20, 24);
        
//        manageLabel.sd_layout
//        .centerYEqualToView(self.contentView)
//        .rightSpaceToView(self.contentView, 20)
//        .leftSpaceToView(manageView, 15)
//        .heightIs(24);
        
//        midView.sd_layout
//        .leftSpaceToView(self.contentView, 0)
//        .rightSpaceToView(self.contentView, 0)
//        .bottomSpaceToView(self.contentView, 0)
//        .heightIs(0.5);
        
        midView.frame = CGRectMake(0, SCW, 59.5, 0.5);
        
    }
    return self;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
