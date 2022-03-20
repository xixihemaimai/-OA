//
//  RSPopViewController.m
//  OAManage
//
//  Created by mac on 2020/9/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSPopViewController.h"
#import "RSBalanCell.h"

@interface RSPopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray * payService;

@property (nonatomic,strong)NSArray * payNumber;

@end

@implementation RSPopViewController

- (instancetype)initwithContentObjectLabel:(NSString *)objectLabel andNumberLabel:(NSString *)numberLabel andPayServiceArray:(NSArray *)payService andPayNumberArray:(NSArray *)payNumber andHeight:(CGFloat)height{
       if (self == [super init]) {
//           RSPopViewController * popVc = [[RSPopViewController alloc]init];
           [self setContentViewObjectLabel:objectLabel andNumberLabel:numberLabel andPayServiceArray:payService andPayNumberArray:payNumber andHeight:height];
       }
       return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setContentViewObjectLabel:(NSString *)object andNumberLabel:(NSString *)number andPayServiceArray:(NSArray *)payService andPayNumberArray:(NSArray *)payNumber andHeight:(CGFloat)height{
    _payService = payService;
    _payNumber = payNumber;
    UIView * contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    contentView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 80);
    [self.view addSubview:contentView];
    
    UIButton * deletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deletBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [contentView addSubview:deletBtn];
    deletBtn.frame = CGRectMake(SCW - 40, 5, 28, 28);
    [deletBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * objectLabel = [[UILabel alloc]init];
    objectLabel.text = object;
    objectLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    objectLabel.font = [UIFont systemFontOfSize:17];
    objectLabel.textAlignment = NSTextAlignmentLeft;
    objectLabel.numberOfLines = 0;
    objectLabel.frame = CGRectMake(23.5, 30.5, SCW/2 + 30, 48);
    [contentView addSubview:objectLabel];
    
    UILabel * numberLabel = [[UILabel alloc]init];
    numberLabel.text = number;
    numberLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    numberLabel.font = [UIFont systemFontOfSize:17];
    numberLabel.textAlignment = NSTextAlignmentLeft;
    numberLabel.numberOfLines = 0;
//    CGSize size = [numberLabel sizeThatFits:CGSizeMake(MAXFLOAT,24)];
    numberLabel.frame = CGRectMake(CGRectGetMaxX(objectLabel.frame), 30.5, SCW - CGRectGetMaxX(objectLabel.frame), 48);
    [contentView addSubview:numberLabel];
    
        UIRectCorner rectCorner = UIRectCornerTopLeft | UIRectCornerTopRight;
        //任意视图
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(20.5,20.5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = contentView.bounds;
        maskLayer.path = bezierPath.CGPath;
    contentView.layer.mask = maskLayer;
    
    
    
    UITableView * contentTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(contentView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(contentView.frame) ) style:UITableViewStylePlain];
    contentTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableview.rowHeight = 40;
    contentTableview.delegate = self;
    contentTableview.dataSource = self;
    contentTableview.showsVerticalScrollIndicator = false;
    contentTableview.contentInset = UIEdgeInsetsMake(0, 0, 400, 0);
    [self.view addSubview:contentTableview];
    [contentTableview reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.payService.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PAYCELLID = @"PAYCELLID";
    RSBalanCell * cell = [tableView dequeueReusableCellWithIdentifier:PAYCELLID];
    if (!cell) {
        cell = [[RSBalanCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PAYCELLID];
    }
    cell.machiningLabel.text = self.payService[indexPath.row];
    cell.machNumberLabel.text = [NSString stringWithFormat:@"%@",self.payNumber[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)deleteAction:(UIButton *)deleteBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
