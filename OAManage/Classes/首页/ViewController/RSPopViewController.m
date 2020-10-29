//
//  RSPopViewController.m
//  OAManage
//
//  Created by mac on 2020/9/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSPopViewController.h"

@interface RSPopViewController ()

@end

@implementation RSPopViewController

- (instancetype)initwithContentObjectLabel:(NSString *)objectLabel andNumberLabel:(NSString *)numberLabel andPayServiceArray:(NSArray *)payService andPayNumberArray:(NSArray *)payNumber{
       if (self == [super init]) {
//           RSPopViewController * popVc = [[RSPopViewController alloc]init];
           [self setContentViewObjectLabel:objectLabel andNumberLabel:numberLabel andPayServiceArray:payService andPayNumberArray:payNumber];
       }
       return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setContentViewObjectLabel:(NSString *)object andNumberLabel:(NSString *)number andPayServiceArray:(NSArray *)payService andPayNumberArray:(NSArray *)payNumber{
    UIView * contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    contentView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:contentView];
    
    UIRectCorner rectCorner = UIRectCornerTopLeft | UIRectCornerTopRight;
    //任意视图
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(20.5,20.5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentView.bounds;
    maskLayer.path = bezierPath.CGPath;
    contentView.layer.mask = maskLayer;
    
    UIButton * deletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deletBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [contentView addSubview:deletBtn];
    deletBtn.frame = CGRectMake(SCW - 40, 14, 28, 28);
    [deletBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * objectLabel = [[UILabel alloc]init];
    objectLabel.text = object;
    objectLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    objectLabel.font = [UIFont systemFontOfSize:17];
    objectLabel.textAlignment = NSTextAlignmentLeft;
    objectLabel.numberOfLines = 0;
//    CGSize todaysize = [objectLabel sizeThatFits:CGSizeMake(MAXFLOAT,24)];
    objectLabel.frame = CGRectMake(23.5, 40.5, SCW/2 + 30, 48);
    [contentView addSubview:objectLabel];
    
    UILabel * numberLabel = [[UILabel alloc]init];
    numberLabel.text = number;
    numberLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    numberLabel.font = [UIFont systemFontOfSize:17];
    numberLabel.textAlignment = NSTextAlignmentLeft;
    numberLabel.numberOfLines = 0;
//    CGSize size = [numberLabel sizeThatFits:CGSizeMake(MAXFLOAT,24)];
    numberLabel.frame = CGRectMake(CGRectGetMaxX(objectLabel.frame), 40.5, SCW - CGRectGetMaxX(objectLabel.frame), 48);
    [contentView addSubview:numberLabel];
    
    
    UIView * detailView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(objectLabel.frame) + 15, SCW, contentView.yj_height - 65)];
    detailView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [contentView addSubview:detailView];
    for (int i = 0; i < payService.count; i++) {
        //加工费
         UILabel * machiningLabel = [[UILabel alloc]init];
        machiningLabel.text = payService[i];
         machiningLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
         machiningLabel.font = [UIFont systemFontOfSize:16];
         machiningLabel.textAlignment = NSTextAlignmentLeft;
         machiningLabel.frame = CGRectMake(40, (i * 22.5) + (15 * i) , 150, 22.5);
         [detailView addSubview:machiningLabel];
         
         UILabel * machNumberLabel = [[UILabel alloc]init];
         machNumberLabel.text = payNumber[i];
         machNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
         machNumberLabel.font = [UIFont systemFontOfSize:16];
         machNumberLabel.textAlignment = NSTextAlignmentRight;
         machNumberLabel.frame = CGRectMake(SCW - 40 - 100, (i * 22.5) + (15 * i), 100, 22.5);
         [detailView addSubview:machNumberLabel];
    }
}

- (void)deleteAction:(UIButton *)deleteBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
