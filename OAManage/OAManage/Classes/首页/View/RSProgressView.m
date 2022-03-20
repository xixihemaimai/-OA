//
//  RSProgressView.m
//  OAManage
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSProgressView.h"

@implementation RSProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //第一个原点
        UIView * firstView = [[UIView alloc]init];
        firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [self addSubview:firstView];
        _firstView = firstView;
        
        
        
        //第一个中间的view
        UIView * firstProgressView = [[UIView alloc]init];
        firstProgressView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [self addSubview:firstProgressView];
        
        
        //第一个label
        UILabel * firstLabel = [[UILabel alloc]init];
        firstLabel.text  = @"提出申请";
       // firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        firstLabel.textAlignment = NSTextAlignmentLeft;
        firstLabel.font = [UIFont systemFontOfSize:Textadaptation(13)];
        [self addSubview:firstLabel];
        _firstLabel = firstLabel;
        
        
        //第二个原点
        UIView * secondView = [[UIView alloc]init];
       // secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
        [self addSubview:secondView];
        _secondView = secondView;
        
        
        //第二个中间的view
        UIView * secondProgressView = [[UIView alloc]init];
        secondProgressView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [self addSubview:secondProgressView];
        
        
        
        //第二个label
        UILabel * secondLabel = [[UILabel alloc]init];
        secondLabel.text  = @"进行中";
        //secondLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
        secondLabel.textAlignment = NSTextAlignmentCenter;
        secondLabel.font = [UIFont systemFontOfSize:Textadaptation(13)];
        [self addSubview:secondLabel];
        _secondLabel = secondLabel;
        
        //第三个原点
        UIView * thirdView = [[UIView alloc]init];
       // thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
        [self addSubview:thirdView];
        _thirdView = thirdView;
        
        //第三个label
        UILabel * thirdLabel = [[UILabel alloc]init];
        thirdLabel.text  = @"审核结束";
       // thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        thirdLabel.textAlignment = NSTextAlignmentRight;
        thirdLabel.font = [UIFont systemFontOfSize:Textadaptation(13)];
        [self addSubview:thirdLabel];
        _thirdLabel = thirdLabel;
        
        
        //底下view
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
        [self addSubview:bottomview];
    
        
//        firstView.sd_layout
//        .leftSpaceToView(self, 50)
//        .topSpaceToView(self, 25)
//        .widthIs(11)
//        .heightIs(11);
        
        
        firstView.frame = CGRectMake(50, 25, 11, 11);
        
        firstView.layer.cornerRadius = firstView.yj_width * 0.5;
        firstView.layer.masksToBounds = YES;
        
        
//        firstLabel.sd_layout
//        .leftSpaceToView(self, 29)
//        .topSpaceToView(firstView, 11)
//        .heightIs(19)
//        .widthRatioToView(self, 0.3);
        
        firstLabel.frame = CGRectMake(19, CGRectGetMaxY(firstView.frame) + 11, self.frame.size.width * 0.3, 19);
        
        
//        secondView.sd_layout
//        //.centerYEqualToView(centerView)
//        .topSpaceToView(self, 25)
//        .centerXEqualToView(self)
//        .widthIs(11)
//        .heightIs(11);
        
        secondView.frame = CGRectMake(self.frame.size.width/2 - 5.5, 25, 11, 11);
        
        secondView.layer.cornerRadius = secondView.yj_width * 0.5;
        secondView.layer.masksToBounds = YES;
        
//        secondLabel.sd_layout
//        .centerXEqualToView(self)
//        .topSpaceToView(secondView, 11)
//        .heightIs(19)
//           .widthRatioToView(self, 0.3);
        
        secondLabel.frame = CGRectMake(self.frame.size.width/2 - (self.frame.size.width * 0.3)/2, CGRectGetMaxY(secondView.frame) + 11, self.frame.size.width * 0.3, 19);
        
        firstProgressView.sd_layout
        .leftSpaceToView(firstView, 0)
        .rightSpaceToView(secondView, 0)
        .topSpaceToView(self, 29)
        .heightIs(1);
        
        firstProgressView.frame = CGRectMake(CGRectGetMaxX(firstView.frame), 29, self.frame.size.width * 0.3 , 1);
        
//        thirdView.sd_layout
//        .rightSpaceToView(self, 50)
//        .topSpaceToView(self, 25)
//        .widthIs(11)
//        .heightIs(11);
        
        thirdView.frame = CGRectMake(self.frame.size.width - 50 , 25, 11, 11);
        
        thirdView.layer.cornerRadius = thirdView.yj_width * 0.5;
        thirdView.layer.masksToBounds = YES;
        
        
//        secondProgressView.sd_layout
//        .leftSpaceToView(secondView, 0)
//        .rightSpaceToView(thirdView, 0)
//        .topSpaceToView(self, 29)
//        .heightIs(1);
        
        secondProgressView.frame = CGRectMake(CGRectGetMaxX(secondView.frame) + 5.5, 29, self.frame.size.width * 0.3, 1);
        
        
//        thirdLabel.sd_layout
//        .rightSpaceToView(self, 32)
//        .topSpaceToView(thirdView, 11)
//        .heightIs(19)
//        .widthRatioToView(self, 0.3);
        
        thirdLabel.frame = CGRectMake(self.frame.size.width - self.frame.size.width * 0.35, CGRectGetMaxY(thirdView.frame) + 11, self.frame.size.width * 0.3, 19);
        

        
//        bottomview.sd_layout
//        .leftSpaceToView(self, 0)
//        .rightSpaceToView(self, 0)
//        .bottomSpaceToView(self, 0)
//        .heightIs(8);
        
        bottomview.frame = CGRectMake(0, self.frame.size.height - 8, self.frame.size.width, 8);
        
    
    }
    return self;
}

@end
