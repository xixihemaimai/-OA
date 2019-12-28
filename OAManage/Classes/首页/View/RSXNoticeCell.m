//
//  RSXNoticeCell.m
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSXNoticeCell.h"


@interface RSXNoticeCell()

@property (nonatomic,strong)UIImageView * tagImageView;

@property (nonatomic,strong)UILabel * titelLabel;

@end

@implementation RSXNoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UIImageView * tagImageView = [[UIImageView alloc]init];
        tagImageView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        [self.contentView addSubview:tagImageView];
        _tagImageView = tagImageView;
        
        
        tagImageView.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .centerYEqualToView(self.contentView)
        .widthIs(25)
        .heightIs(12);
        
        
        UILabel * titelLabel = [[UILabel alloc]init];
        titelLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
        titelLabel.font = [UIFont systemFontOfSize:15];
        titelLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titelLabel];
        
        titelLabel.sd_layout
        .leftSpaceToView(tagImageView, 6)
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(25);
        _titelLabel = titelLabel;
        
        
        
    }
    return self;
}



- (void)setNoticemodel:(RSNoticeModel *)noticemodel{
    _noticemodel = noticemodel;
    
    if ([_noticemodel.noticeType isEqualToString:@"通告"]) {
        _tagImageView.image = [UIImage imageNamed:@"通告复制"];
    }else if ([_noticemodel.noticeType isEqualToString:@"奖惩"]){
         _tagImageView.image = [UIImage imageNamed:@"奖惩"];
    }else if ([_noticemodel.noticeType isEqualToString:@"通知"]){
        _tagImageView.image = [UIImage imageNamed:@"通知"];
    }
    else{
        _tagImageView.image = [UIImage imageNamed:@"其他"];
    }
    _titelLabel.text = noticemodel.title;
    
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
