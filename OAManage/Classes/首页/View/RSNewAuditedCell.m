//
//  RSNewAuditedCell.m
//  OAManage
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSNewAuditedCell.h"

@implementation RSNewAuditedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        //图片
        UIButton * timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [timeBtn setBackgroundImage:[UIImage imageNamed:@"编组复制"] forState:UIControlStateNormal];
        [timeBtn setTitle:@"周一" forState:UIControlStateNormal];
        [timeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
        timeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:timeBtn];
        
        //时间
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"2020-01-07";
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:timeLabel];
        
        //删除
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:deleteBtn];
        
        //编辑
        UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
        [editBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:editBtn];
        //下划线
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:bottomview];
        
        timeBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 15)
        .widthIs(25)
        .heightIs(24);
        
        
        timeLabel.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(timeBtn, 8)
        .topEqualToView(timeBtn)
        .bottomEqualToView(timeBtn)
        .widthRatioToView(self.contentView, 0.4);
        
        
        editBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 15)
        .widthIs(44)
        .heightIs(18);
        
        editBtn.layer.cornerRadius = 9;
        editBtn.layer.masksToBounds = YES;
        
        
        deleteBtn.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(editBtn, 8)
        .topEqualToView(editBtn)
        .bottomEqualToView(editBtn)
        .widthIs(44);
        
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(0.5);
        
    }
    return self;
}



@end
