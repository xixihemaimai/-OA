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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setContentView];
}

- (void)setContentView{
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
    
    
    //结算对象某某某总欠款
    UILabel * objectLabel = [[UILabel alloc]init];
    objectLabel.text = @"结算对象某某某总欠款";
    objectLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    objectLabel.font = [UIFont systemFontOfSize:17];
    objectLabel.textAlignment = NSTextAlignmentLeft;
    CGSize todaysize = [objectLabel sizeThatFits:CGSizeMake(MAXFLOAT,24)];
    objectLabel.frame = CGRectMake(23.5, 40.5, todaysize.width, 24);
    [contentView addSubview:objectLabel];
    
    //数字
    UILabel * numberLabel = [[UILabel alloc]init];
    numberLabel.text = @"100w";
    numberLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    numberLabel.font = [UIFont systemFontOfSize:17];
    numberLabel.textAlignment = NSTextAlignmentLeft;
    CGSize size = [numberLabel sizeThatFits:CGSizeMake(MAXFLOAT,24)];
    numberLabel.frame = CGRectMake(CGRectGetMaxX(objectLabel.frame), 40.5, size.width, 24);
    [contentView addSubview:numberLabel];
    
    
    //加工费
    UILabel * machiningLabel = [[UILabel alloc]init];
    machiningLabel.text = @"加工费";
    machiningLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    machiningLabel.font = [UIFont systemFontOfSize:16];
    machiningLabel.textAlignment = NSTextAlignmentLeft;
    machiningLabel.frame = CGRectMake(40, CGRectGetMaxY(objectLabel.frame) + 15, 50, 22.5);
    [contentView addSubview:machiningLabel];
    
    
    UILabel * machNumberLabel = [[UILabel alloc]init];
    machNumberLabel.text = @"50w";
    machNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    machNumberLabel.font = [UIFont systemFontOfSize:16];
    machNumberLabel.textAlignment = NSTextAlignmentLeft;
    machNumberLabel.frame = CGRectMake(SCW - 40 - 40,CGRectGetMaxY(objectLabel.frame) + 15, 40, 22.5);
    [contentView addSubview:machNumberLabel];
    
    //堆存费
    UILabel * stackingLabel = [[UILabel alloc]init];
    stackingLabel.text = @"堆存费";
    stackingLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    stackingLabel.font = [UIFont systemFontOfSize:16];
    stackingLabel.textAlignment = NSTextAlignmentLeft;
    stackingLabel.frame = CGRectMake(40, CGRectGetMaxY(machiningLabel.frame) + 13, 50, 22.5);
    [contentView addSubview:stackingLabel];
      
      
    UILabel * stackNumberLabel = [[UILabel alloc]init];
    stackNumberLabel.text = @"50w";
    stackNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    stackNumberLabel.font = [UIFont systemFontOfSize:16];
    stackNumberLabel.textAlignment = NSTextAlignmentLeft;
    stackNumberLabel.frame = CGRectMake(SCW - 40 - 40,CGRectGetMaxY(machNumberLabel.frame) + 13, 40, 22.5);
    [contentView addSubview:stackNumberLabel];
    
    //架子位租赁费
    UILabel * shelfLabel = [[UILabel alloc]init];
    shelfLabel.text = @"架子位租赁费";
    shelfLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    shelfLabel.font = [UIFont systemFontOfSize:16];
    shelfLabel.textAlignment = NSTextAlignmentLeft;
    shelfLabel.frame = CGRectMake(40, CGRectGetMaxY(stackingLabel.frame) + 13, 100, 22.5);
    [contentView addSubview:shelfLabel];
      
      
    UILabel * shelfNumberLabel = [[UILabel alloc]init];
    shelfNumberLabel.text = @"50w";
    shelfNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    shelfNumberLabel.font = [UIFont systemFontOfSize:16];
    shelfNumberLabel.textAlignment = NSTextAlignmentLeft;
    shelfNumberLabel.frame = CGRectMake(SCW - 40 - 40,CGRectGetMaxY(stackNumberLabel.frame) + 13, 40, 22.5);
    [contentView addSubview:shelfNumberLabel];
    
    //业务室租赁费
    //business
    UILabel * businessLabel = [[UILabel alloc]init];
    businessLabel.text = @"业务室租赁费";
    businessLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    businessLabel.font = [UIFont systemFontOfSize:16];
    businessLabel.textAlignment = NSTextAlignmentLeft;
    businessLabel.frame = CGRectMake(40, CGRectGetMaxY(shelfLabel.frame) + 13, 100, 22.5);
    [contentView addSubview:businessLabel];
      
      
    UILabel * businessNumberLabel = [[UILabel alloc]init];
    businessNumberLabel.text = @"50w";
    businessNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    businessNumberLabel.font = [UIFont systemFontOfSize:16];
    businessNumberLabel.textAlignment = NSTextAlignmentLeft;
    businessNumberLabel.frame = CGRectMake(SCW - 40 - 40,CGRectGetMaxY(shelfNumberLabel.frame) + 13, 40, 22.5);
    [contentView addSubview:businessNumberLabel];
    
}

- (void)deleteAction:(UIButton *)deleteBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
