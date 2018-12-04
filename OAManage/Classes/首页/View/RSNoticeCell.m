//
//  RSNoticeCell.m
//  OAManage
//
//  Created by mac on 2018/12/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSNoticeCell.h"

@interface RSNoticeCell()




@property (nonatomic,strong) UILabel * noticeLabel;






@end


@implementation RSNoticeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"公告"];
        [self.contentView addSubview:imageView];
        
        
        
        UILabel * noticeLabel = [[UILabel alloc]init];
        noticeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        noticeLabel.font = [UIFont systemFontOfSize:Textadaptation(16)];
        noticeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:noticeLabel];
        _noticeLabel = noticeLabel;
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:bottomview];
        
        
        imageView.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 12)
        .widthIs(18)
        .heightEqualToWidth();
        
        noticeLabel.sd_layout
        .leftSpaceToView(imageView, 6)
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 11)
        .bottomSpaceToView(self.contentView, 11);
        
        bottomview.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0)
        .heightIs(1);
        

    }
    return self;
}



- (void)setInformationmodel:(RSInformationModel *)informationmodel{
    _informationmodel = informationmodel;
    _noticeLabel.text = [NSString stringWithFormat:@"%@",_informationmodel.title];
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
