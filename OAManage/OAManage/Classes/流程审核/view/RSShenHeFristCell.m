//
//  RSShenHeFristCell.m
//  OAManage
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSShenHeFristCell.h"

@implementation RSShenHeFristCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        

        
        
        
        //上面的view
        UIView * topView = [[UIView alloc]init];
        topView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:topView];
        
        
        
        //图片
        UIImageView * shenHeImageView = [[UIImageView alloc]init];
        shenHeImageView.image = [UIImage imageNamed:@"全部"];
        [self.contentView addSubview:shenHeImageView];
        _shenHeImageView = shenHeImageView;
        //文字
        UILabel * shenHeLabel = [[UILabel alloc]init];
        shenHeLabel.font = [UIFont systemFontOfSize:Textadaptation(13)];
        shenHeLabel.numberOfLines = 0;        
        shenHeLabel.lineBreakMode = 1;
        shenHeLabel.backgroundColor = [UIColor clearColor];
        shenHeLabel.textColor = [UIColor colorWithHexColorStr:@"#7D7D7D"];
        shenHeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:shenHeLabel];
        _shenHeLabel = shenHeLabel;
        
        UILabel * countLabel = [[UILabel alloc]init];
        countLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#FF8C76"];
        countLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.font = [UIFont systemFontOfSize:Textadaptation(9)];
        countLabel.text = @"21";
        [self.contentView addSubview:countLabel];
        _countLabel = countLabel;
        
        
        //底部view
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:bottomView];
        
        
//        topView.sd_layout
//        .leftSpaceToView(self.contentView, 0)
//        .topSpaceToView(self.contentView, 0)
//        .rightSpaceToView(self.contentView, 0)
//        .heightIs(8);
        
        topView.frame = CGRectMake(0, 0, self.contentView.yj_width, 8);
        bottomView.frame = CGRectMake(0, self.contentView.yj_height  - 8, self.contentView.yj_width, 8);

//        bottomView.sd_layout
//        .leftSpaceToView(self.contentView, 0)
//        .rightSpaceToView(self.contentView, 0)
//        .bottomSpaceToView(self.contentView, 0)
//        .heightIs(8);
        
       
//        shenHeImageView.sd_layout
//        .centerYEqualToView(self.contentView)
//        .leftSpaceToView(self.contentView, 2)
//        .widthIs(8)
//        .heightEqualToWidth();
        
        shenHeImageView.frame = CGRectMake(12.5, self.contentView.yj_height/2 - 4, 8, 8);
        
//
//
//            if (iPhone4 || iPhone5) {
//
//                shenHeLabel.frame = CGRectMake(12, CGRectGetMaxY(topView.frame), SCW - 37, self.contentView.yj_height - CGRectGetMaxY(topView.frame));
//
////                shenHeLabel.sd_layout
////                .leftSpaceToView(self.contentView, 12)
////                .topSpaceToView(topView, 0)
////                .bottomSpaceToView(bottomView, 0)
////                .rightSpaceToView(self.contentView, 25);
//                countLabel.frame = CGRectMake(CGRectGetMaxX(shenHeLabel.frame), 20, 12, 12);
//
////                countLabel.sd_layout
////                .leftSpaceToView(shenHeLabel, 0)
////                .topSpaceToView(self.contentView, 20)
////                .widthIs(12)
////                .heightEqualToWidth();
//
//            }else
                if (iPhone6p || iPhoneXR || iPhoneXSMax){
                
                shenHeLabel.frame = CGRectMake(12, CGRectGetMaxY(topView.frame), 88 - 27, self.contentView.yj_height - CGRectGetMaxY(topView.frame));
                countLabel.frame = CGRectMake(CGRectGetMaxX(shenHeLabel.frame) - 5, 16, 14, 14);
                
//                shenHeLabel.sd_layout
//                .leftSpaceToView(self.contentView, 12)
//                .topSpaceToView(topView, 0)
//                .bottomSpaceToView(bottomView, 0)
//                .rightSpaceToView(self.contentView, 15);
                
//                countLabel.sd_layout
//                .leftSpaceToView(shenHeLabel, -5)
//                .topSpaceToView(self.contentView, 16)
//                .widthIs(14)
//                .heightEqualToWidth();
            }
            else{
                
                shenHeLabel.frame = CGRectMake(12, CGRectGetMaxY(topView.frame), 88 - 32, self.contentView.yj_height - CGRectGetMaxY(topView.frame));
                countLabel.frame = CGRectMake(CGRectGetMaxX(shenHeLabel.frame), 16, 12, 12);
                
                
//                shenHeLabel.sd_layout
//                .leftSpaceToView(self.contentView, 12)
//                .topSpaceToView(topView, 0)
//                .bottomSpaceToView(bottomView, 0)
//                .rightSpaceToView(self.contentView, 20);
                
//                countLabel.sd_layout
//                .leftSpaceToView(shenHeLabel, 0)
//                .topSpaceToView(self.contentView, 16)
//                .widthIs(12)
//                .heightEqualToWidth();
            }
        countLabel.layer.cornerRadius = countLabel.yj_width * 0.5;
        countLabel.layer.masksToBounds = true;
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
