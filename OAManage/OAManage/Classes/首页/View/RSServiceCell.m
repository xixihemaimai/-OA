//
//  RSServiceCell.m
//  OAManage
//
//  Created by mac on 2019/11/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSServiceCell.h"
#import "RSInformationLabel.h"
@interface RSServiceCell()

@property (nonatomic,strong)UILabel * contentLabel;

@property (nonatomic,strong)UIImageView * contentImage;


@end



@implementation RSServiceCell

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
        
        RSInformationLabel * contentLabel = [[RSInformationLabel alloc]initWithFrame:CGRectMake(15, 8, SCW - 100, 50)];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:12];
        contentLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.text = @"海西石材城由福建三叶集团重磅打造，地处世界石材加工中心--中国·水头，占地2000亩,海西石材城由福建三叶集团重磅打造，地处世界石材加工中心--中国·水头，占地2000亩,海西石材城由福建三叶集团重磅打造，地处世界石材加工中心--中国·水头，占地2000亩,海西石材城由福建三叶集团重磅打造，地处世界石材加工中心--中国·水头，占地2000亩,海西石材城由福建三叶集团重磅打造，地处世界石材加工中心--中国·水头，占地2000亩";
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
        
        
        UIImageView * contentImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCW - 80, 8, 65, 50)];
        //contentImage.image = [UIImage imageNamed:@"背景"];
        [self.contentView addSubview:contentImage];
        contentImage.contentMode = UIViewContentModeScaleToFill;
        _contentImage = contentImage;
        
        
        UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(15, 65.5, SCW - 30, 0.5)];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
        [self.contentView addSubview:bottomview];
        
        
//        contentImage.sd_layout
//        .rightSpaceToView(self.contentView, 15)
//        .topSpaceToView(self.contentView, 8)
//        .widthIs(65.5)
//        .heightIs(50);
//        contentImage.layer.cornerRadius = 4.76;
//        contentImage.layer.masksToBounds = YES;
//
//        contentLabel.sd_layout
//        .leftSpaceToView(self.contentView, 15)
//        .topEqualToView(contentImage)
//        .rightSpaceToView(contentImage, 6.5)
//        .bottomSpaceToView(self.contentView, 8);
//
        
//        bottomview.sd_layout
//        .leftSpaceToView(self.contentView, 15)
//        .rightSpaceToView(self.contentView, 15)
//        .bottomSpaceToView(self.contentView, 0)
//        .heightIs(0.5);
                
    }
    return self;
}

- (void)setInformationmodel:(RSInformationModel *)informationmodel{
    _informationmodel = informationmodel;
    _contentLabel.text = _informationmodel.title;
//    [_contentImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_NEWPOST_IOS,_informationmodel.imageUrl]] placeholderImage:[UIImage imageNamed:@"默认图"]];
    
    [_contentImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_NEWPOST_IOS,_informationmodel.imageUrl]] placeholderImage:[UIImage imageNamed:@"qit"]];
}


@end
