//
//  RSSLHeaderView.m
//  OAManage
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLHeaderView.h"

@interface RSSLHeaderView ()


@property (nonatomic,strong)UIView * exceptionView;


@property (nonatomic,strong)UILabel * productNameLabel;

@property (nonatomic,strong)UILabel * productNumberLabel;

@property (nonatomic,strong)UILabel * productTurnLabel;

@end


@implementation RSSLHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
        UIView * exceptionView = [[UIView alloc]init];
        exceptionView.backgroundColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
        [self.contentView addSubview:exceptionView];
               
               
//               exceptionView.sd_layout
//               .leftSpaceToView(self.contentView, 12)
//               .rightSpaceToView(self.contentView, 12)
//               .topSpaceToView(self.contentView, 10)
//               .heightIs(98);
        
        
        exceptionView.frame = CGRectMake(12, 10, SCW - 24, 98);
               
               
               exceptionView.layer.cornerRadius = 8;
               _exceptionView = exceptionView;
               
               
               UIImageView * yellewView = [[UIImageView alloc]init];
               //yellewView.backgroundColor = [UIColor colorWithHexColorStr:@"#FBC05F"];
               yellewView.image = [UIImage imageNamed:@"Rectangle 32 Copy 4"];
               yellewView.contentMode = UIViewContentModeScaleAspectFill;
               yellewView.clipsToBounds = YES;
               [exceptionView addSubview:yellewView];
               
        yellewView.frame = CGRectMake(0, 18, 4, 17);
               
//               yellewView.sd_layout
//               .leftSpaceToView(exceptionView, 0)
//               .topSpaceToView(exceptionView, 18)
//               .heightIs(17)
//               .widthIs(4);
               
               UIImageView * blueView = [[UIImageView alloc]init];
               blueView.image = [UIImage imageNamed:@"Rectangle 32 Copy 5"];
               blueView.contentMode = UIViewContentModeScaleAspectFill;
               blueView.clipsToBounds = YES;
               [exceptionView addSubview:blueView];
               
//               blueView.sd_layout
//               .rightSpaceToView(exceptionView, 0)
//               .topSpaceToView(exceptionView, 18)
//               .heightIs(17)
//               .widthIs(4);
        blueView.frame = CGRectMake(exceptionView.yj_width - 4, 18, 4, 17);
               
               //物料名称
               UILabel * productNameLabel = [[UILabel alloc]init];
               productNameLabel.text = @"白玉兰";
               productNameLabel.font = [UIFont systemFontOfSize:17];
               productNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
               productNameLabel.textAlignment = NSTextAlignmentLeft;
               [exceptionView addSubview:productNameLabel];
               _productNameLabel = productNameLabel;
               
//               productNameLabel.sd_layout
//               .leftSpaceToView(exceptionView, 14)
//               .topSpaceToView(exceptionView, 14)
//               .widthRatioToView(exceptionView, 0.4)
//               .heightIs(24);
               
        productNameLabel.frame = CGRectMake(14, 14, exceptionView.yj_width * 0.4, 24);
               
               //物料号
               UILabel * productNumberLabel = [[UILabel alloc]init];
               productNumberLabel.text = @"ESB00295/DH-539";
               productNumberLabel.font = [UIFont systemFontOfSize:12];
               productNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
               productNumberLabel.textAlignment = NSTextAlignmentLeft;
               [exceptionView addSubview:productNumberLabel];
               _productNumberLabel = productNumberLabel;
//               productNumberLabel.sd_layout
//               .leftEqualToView(productNameLabel)
//               .topSpaceToView(productNameLabel, 0)
//               .rightEqualToView(productNameLabel)
//               .heightIs(17);
               
        productNumberLabel.frame = CGRectMake(14, CGRectGetMaxY(productNameLabel.frame), exceptionView.yj_width * 0.4, 17);
               
               //分割线
               UIView * midView = [[UIView alloc]init];
               midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
               [exceptionView addSubview:midView];
               
//               midView.sd_layout
//               .leftSpaceToView(exceptionView, 0)
//               .rightSpaceToView(exceptionView, 0)
//               .topSpaceToView(productNumberLabel, 6)
//               .heightIs(0.5);
               
               
        midView.frame = CGRectMake(0, CGRectGetMaxY(productNumberLabel.frame) + 6, exceptionView.yj_width, 0.5);
               
               
               //底部的UIbutton
               
               UIButton * downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
               [downBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
               [exceptionView addSubview:downBtn];
               _downBtn = downBtn;
        
        downBtn.frame = CGRectMake(10, CGRectGetMaxY(midView.frame), exceptionView.yj_width - 20, exceptionView.yj_height - CGRectGetMaxY(midView.frame));
               
//               downBtn.sd_layout
//               .topSpaceToView(midView, 0)
//               .leftSpaceToView(exceptionView, 10)
//               .rightSpaceToView(exceptionView, 10)
//               .bottomSpaceToView(exceptionView, 0);
               
               
               //匝号
               UILabel * productTurnLabel = [[UILabel alloc]init];
               productTurnLabel.text = @"匝号：5-5";
               productTurnLabel.font = [UIFont systemFontOfSize:14];
               productTurnLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
               productTurnLabel.textAlignment = NSTextAlignmentLeft;
               [downBtn addSubview:productTurnLabel];
               _productTurnLabel = productTurnLabel;
        
//               productTurnLabel.sd_layout
//               .leftSpaceToView(downBtn, 1)
//               .topSpaceToView(downBtn, 10)
//               .widthRatioToView(downBtn, 0.5)
//               .heightIs(20);
               
        productTurnLabel.frame = CGRectMake(1, 10, downBtn.yj_width * 0.5, 20);
               
               
               //删除按键
               UIButton * productDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
               [productDeleteBtn setImage:[UIImage imageNamed:@"垃圾桶"] forState:UIControlStateNormal];
               [exceptionView addSubview:productDeleteBtn];
               _productDeleteBtn = productDeleteBtn;
               
               
               UIImageView * downImageView = [[UIImageView alloc]init];
              // [downBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
               downImageView.image = [UIImage imageNamed:@"system-pull-down"];
               downImageView.clipsToBounds = YES;
               downImageView.contentMode = UIViewContentModeScaleAspectFill;
               [downBtn addSubview:downImageView];
               _downImageView = downImageView;
        
        productDeleteBtn.frame = CGRectMake(SCW - 24 - 16 - 28, 14, 28, 28);
               
//               productDeleteBtn.sd_layout
//               .rightSpaceToView(exceptionView, 16)
//               .topSpaceToView(exceptionView, 14)
//               .widthIs(28)
//               .heightEqualToWidth();

        
//               downImageView.sd_layout
//               .topSpaceToView(downBtn, 16)
//               .rightSpaceToView(downBtn, 11)
//               .widthIs(16)
//               .heightIs(9);
        
        downImageView.frame = CGRectMake(downBtn.yj_width - 11 - 16, 16, 16, 9);
        
        
    }
    return self;
}


- (void)setSlpiecemodel:(RSSLPieceModel *)slpiecemodel{
    _slpiecemodel = slpiecemodel;
    
    if (_slpiecemodel.isbool) {
            _exceptionView.layer.cornerRadius = 0;
           CGRect rect = CGRectMake(0, 0, SCW - 24, 98);
           CGRect oldRect = rect;
           oldRect.size.width = SCW - 24;
           UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
           CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
           maskLayer.path = maskPath.CGPath;
           maskLayer.frame = oldRect;
           _exceptionView.layer.mask = maskLayer;
           self.downImageView.image = [UIImage imageNamed:@"system-pull-down copy 2"];
        }else{
            _exceptionView.layer.cornerRadius = 8;
           self.downImageView.image = [UIImage imageNamed:@"system-pull-down"];
        }
       _productNameLabel.text = _slpiecemodel.mtlName;
       _productNumberLabel.text = _slpiecemodel.blockNo;
       _productTurnLabel.text = [NSString stringWithFormat:@"匝号:%@",_slpiecemodel.turnsNo];
}


@end
