//
//  RSContractViewController.m
//  OAManage
//
//  Created by mac on 2020/9/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSContractViewController.h"
#import "RSContractCell.h"
@interface RSContractViewController ()

@end

@implementation RSContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"合同管理";
    
    self.emptyView.hidden = YES;
    
    [self customHeaderView];
}


- (void)customHeaderView{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UIView * contractView = [[UIView alloc]init];
    [headerView addSubview:contractView];
    contractView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    contractView.layer.cornerRadius = 6;
    contractView.layer.shadowColor = [UIColor colorWithRed:213/255.0 green:211/255.0 blue:211/255.0 alpha:0.5].CGColor;
    contractView.layer.shadowOffset = CGSizeMake(0,0);
    contractView.layer.shadowOpacity = 1;
    contractView.layer.shadowRadius = 5;
    
    contractView.sd_layout
    .leftSpaceToView(headerView, 12)
    .topSpaceToView(headerView, 12)
    .rightSpaceToView(headerView, 12)
    .heightIs(114);
    
    //合同标题
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"合同标题";
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#D5D5D5"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [contractView addSubview:titleLabel];
    
    titleLabel.sd_layout
    .leftSpaceToView(contractView, 22.5)
    .widthIs(60)
    .topSpaceToView(contractView, 21)
    .heightIs(20);
    
    //合同标题的标签
    UITextField * titleField = [[UITextField alloc]init];
    [contractView addSubview:titleField];
    
    titleField.sd_layout
    .leftSpaceToView(titleLabel, 5)
    .rightSpaceToView(contractView, 22.5)
    .heightIs(20)
    .topEqualToView(titleLabel);
    
    //分隔线
    UIView * contractTitleView = [[UIView alloc]init];
    contractTitleView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [contractView addSubview:contractTitleView];
    
    contractTitleView.sd_layout
    .leftEqualToView(titleLabel)
    .rightEqualToView(titleField)
    .heightIs(0.5)
    .topSpaceToView(titleLabel, 6);
    
    //合同日期
    UILabel * timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"合同日期";
    timeLabel.textColor = [UIColor colorWithHexColorStr:@"#D5D5D5"];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [contractView addSubview:timeLabel];
    
    timeLabel.sd_layout
    .topSpaceToView(contractTitleView, 19.5)
    .heightIs(20)
    .widthIs(60)
    .leftEqualToView(contractTitleView);
    
    UITextField * timeField = [[UITextField alloc]init];
    [contractView addSubview:timeField];
    
    timeField.sd_layout
    .leftSpaceToView(timeLabel, 5)
    .topEqualToView(timeLabel)
    .heightIs(20)
    .rightSpaceToView(contractView, 66.5);
    
    //分隔线
    UIView * contractTimeView = [[UIView alloc]init];
    contractTimeView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [contractView addSubview:contractTimeView];
    
    contractTimeView.sd_layout
    .leftEqualToView(timeLabel)
    .rightEqualToView(timeField)
    .topSpaceToView(timeLabel, 5)
    .heightIs(0.5);
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    [contractView addSubview:searchBtn];
    
    searchBtn.sd_layout
    .leftSpaceToView(contractTimeView, 0)
    .rightSpaceToView(contractView, 22.5)
    .topEqualToView(timeLabel)
    .heightIs(23)
    .widthIs(45);
    
    searchBtn.layer.cornerRadius = 2.5;
    searchBtn.layer.masksToBounds = YES;
    
    [headerView setupAutoHeightWithBottomView:contractView bottomMargin:20];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if ([self.title isEqualToString:@"报表管理"]) {
//        return 5;
//    }else{
        return 4;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CONTRACTCELLID = @"CONTRACTCELLID";
    RSContractCell * cell = [tableView dequeueReusableCellWithIdentifier:CONTRACTCELLID];
    if (!cell) {
        cell = [[RSContractCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CONTRACTCELLID];
    }
    return cell;
}






@end
