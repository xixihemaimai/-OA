//
//  RSOnlineContentCell.m
//  OAManage
//
//  Created by mac on 2020/3/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSOnlineContentCell.h"
#import "RSInformationLabel.h"

@interface RSOnlineContentCell()


@property (nonatomic,strong)RSInformationLabel * onlineLabel ;

@property (nonatomic,strong)UIImageView * onlineImage;

@end


@implementation RSOnlineContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView * onlineImage = [[UIImageView alloc]init];
        //onlineImage.image = [UIImage imageNamed:@"线上培训"];
        onlineImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:onlineImage];
        _onlineImage = onlineImage;
        
        
        RSInformationLabel * onlineLabel = [[RSInformationLabel alloc]init];
        onlineLabel.numberOfLines = 0;
        onlineLabel.text = @"让你效率翻倍的计划-跳出定计划又做不完的死循环";
        onlineLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        onlineLabel.font = [UIFont systemFontOfSize:15];
        onlineLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:onlineLabel];
        _onlineLabel = onlineLabel;
        
        
        onlineImage.frame = CGRectMake(15, 11.5, 128, 97 - 23);
        
//        onlineImage.sd_layout
//        .leftSpaceToView(self.contentView, 15)
//        .topSpaceToView(self.contentView, 11.5)
//        .bottomSpaceToView(self.contentView, 11.5)
//        .widthIs(128);
        
        onlineImage.layer.cornerRadius = 7.8;
//        onlineImage.layer.masksToBounds = YES;
        
        
//        onlineLabel.sd_layout
//        .leftSpaceToView(onlineImage, 15)
//        .rightSpaceToView(self.contentView, 12.5)
//        .topEqualToView(onlineImage)
//        .bottomEqualToView(onlineImage);
        
        onlineLabel.frame  = CGRectMake(CGRectGetMaxX(onlineImage.frame) + 15, 11.5, SCW - CGRectGetMaxX(onlineImage.frame) - 15 - 12.5, 97 - 23);
        
    }
    return self;
}


- (void)setOnlinemodel:(RSOnlineModel *)onlinemodel{
    _onlinemodel = onlinemodel;
    
    [_onlineImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_NEWPOST_IOS,_onlinemodel.coverUrl]] placeholderImage:[UIImage imageNamed:@"默认图"]];
    
    _onlineLabel.text = _onlinemodel.videoDescribe;
    
}


@end
