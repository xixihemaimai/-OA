//
//  RSHomeSecondCell.m
//  OAManage
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSHomeSecondCell.h"

@implementation RSHomeSecondCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        
        //最外层的view
        UIView * homeSecondOuterView = [[UIView alloc]init];
        homeSecondOuterView.backgroundColor = [UIColor colorWithHexColorStr:@"#EFFFFB"];
        homeSecondOuterView.layer.cornerRadius = 6;
        homeSecondOuterView.layer.masksToBounds = YES;
        [self.contentView addSubview:homeSecondOuterView];
        
        
        
        //中间的view
        UIView * homeSecondView = [[UIView alloc]init];
        homeSecondView.layer.borderColor = [UIColor colorWithHexColorStr:@"#A3F5DE"].CGColor;
        homeSecondView.layer.borderWidth = 2;
       // homeSecondView.backgroundColor = [UIColor redColor];
        [homeSecondOuterView addSubview:homeSecondView];
        
        
        homeSecondOuterView.sd_layout
        .leftSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        homeSecondView.sd_layout
        .leftSpaceToView(homeSecondOuterView, 5)
        .rightSpaceToView(homeSecondOuterView, 5)
        .topSpaceToView(homeSecondOuterView, 5)
        .bottomSpaceToView(homeSecondOuterView, 5);
        
        CGFloat H = 0.0;
        
        if (IS_IPHONE) {
            
            H = (83 / SCW ) * SCW;
        }else{
            
            if (DEVICES_IS_PRO_12_9) {
                H =  105 * SCALE_TO_PRO;
               
            }else{
                 H = (105 /SCW ) * SCW;
            }
          
        }
        
        
        
        CAGradientLayer * gradientlayer = [[CAGradientLayer alloc]init];
        CGRect rect = CGRectMake(0, 0, SCW - 30, H);
        gradientlayer.frame = rect;

        [homeSecondView.layer addSublayer:gradientlayer];
        gradientlayer.colors = @[(__bridge id)[UIColor colorWithHexColorStr:@"#27C79A"].CGColor,(__bridge id)[UIColor colorWithHexColorStr:@"#4FE5CA"].CGColor];
        gradientlayer.locations = @[@(0),@(1)];
        gradientlayer.startPoint = CGPointMake(0, 0);
        gradientlayer.endPoint = CGPointMake(1, 0);
        
        
        UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(6, 6)];
        CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc] init];
        cornerRadiusLayer.frame = rect;
        cornerRadiusLayer.path = cornerRadiusPath.CGPath;
        homeSecondView.layer.mask = cornerRadiusLayer;
        
        
        
        //图片
        UIImageView * homeSecondImageView = [[UIImageView alloc]init];
        homeSecondImageView.image = [UIImage imageNamed:@"我的审批图标"];
        [homeSecondView addSubview:homeSecondImageView];
        
        
        //文字
        UILabel * homeSecondLabel = [[UILabel alloc]init];
        homeSecondLabel.text = @"我的审批";
        homeSecondLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        homeSecondLabel.textAlignment = NSTextAlignmentLeft;
        homeSecondLabel.font = [UIFont systemFontOfSize:Textadaptation(18)];
        [homeSecondView addSubview:homeSecondLabel];
        
        
        homeSecondImageView.sd_layout
        .centerYEqualToView(homeSecondView)
        .leftSpaceToView(homeSecondView, 12)
        .widthIs(67)
        .heightIs(55);
        
        homeSecondLabel.sd_layout
        .leftSpaceToView(homeSecondImageView, 10)
        .centerYEqualToView(homeSecondView)
        .rightSpaceToView(homeSecondView, 10)
        .heightIs(25);
        
   
        
        
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
