//
//  RSMarketModuleViewController.m
//  OAManage
//
//  Created by mac on 2020/9/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSMarketModuleViewController.h"
#import "RSMarketModuleCell.h"

#import "RSManageViewController.h"
#import "RSContractViewController.h"

@interface RSMarketModuleViewController ()

@end

@implementation RSMarketModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"市场模块";
    self.emptyView.hidden = YES;
    [self customHeaderView];
}

- (void)customHeaderView{
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    //到期合同
    UIButton * expireView = [[UIButton alloc]init];
    [headerView addSubview:expireView];
    expireView.sd_layout
    .leftSpaceToView(headerView, 15)
    .topSpaceToView(headerView, 20)
    .widthIs(SCW/2 - 25)
    .heightIs(77);
    
    expireView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    expireView.layer.shadowColor = [UIColor colorWithRed:213/255.0 green:211/255.0 blue:211/255.0 alpha:0.5].CGColor;
    expireView.layer.shadowOffset = CGSizeMake(0,0);
    expireView.layer.shadowOpacity = 1;
    expireView.layer.shadowRadius = 5;
    
    UILabel * expireLabel = [[UILabel alloc]init];
    expireLabel.text = @"到期合同";
    expireLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    expireLabel.font = [UIFont systemFontOfSize:14];
    expireLabel.textAlignment = NSTextAlignmentLeft;
    [expireView addSubview:expireLabel];
    
    UILabel * expireNumberLabel = [[UILabel alloc]init];
    expireNumberLabel.text = @"10";
    expireNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    expireNumberLabel.font = [UIFont systemFontOfSize:24];
    expireNumberLabel.textAlignment = NSTextAlignmentLeft;
    [expireView addSubview:expireNumberLabel];
    
    UILabel * numberLabel = [[UILabel alloc]init];
    numberLabel.text = @"个";
    numberLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    numberLabel.font = [UIFont systemFontOfSize:12];
    numberLabel.textAlignment = NSTextAlignmentLeft;
    [expireView addSubview:numberLabel];
    
    expireLabel.sd_layout
    .leftSpaceToView(expireView, 20)
    .topSpaceToView(expireView, 12)
    .rightSpaceToView(expireView, 20)
    .heightIs(20);

    CGSize size = [expireNumberLabel sizeThatFits:CGSizeMake(MAXFLOAT,20)];
    expireNumberLabel.sd_layout
    .leftEqualToView(expireLabel)
    .topSpaceToView(expireLabel, 0)
    .widthIs(size.width)
    .heightIs(34);
    
    numberLabel.sd_layout
    .leftSpaceToView(expireNumberLabel, 0)
    .topSpaceToView(expireLabel, 5)
    .widthIs(10)
    .bottomEqualToView(expireNumberLabel);

    UIImageView * expireImage = [[UIImageView alloc]init];
    expireImage.image = [UIImage imageNamed:@"形状结合"];
    [expireView addSubview:expireImage];
    
    expireImage.sd_layout
    .rightSpaceToView(expireView, 0)
    .bottomSpaceToView(expireView, 0)
    .widthIs(30)
    .heightIs(30);
        
    UIButton * todayView = [[UIButton alloc]init];
    [headerView addSubview:todayView];

    todayView.sd_layout
    .rightSpaceToView(headerView, 15)
    .topSpaceToView(headerView, 20)
    .widthIs(SCW/2 - 25)
    .heightIs(77);
    
    todayView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    todayView.layer.shadowColor = [UIColor colorWithRed:213/255.0 green:211/255.0 blue:211/255.0 alpha:0.5].CGColor;
    todayView.layer.shadowOffset = CGSizeMake(0,0);
    todayView.layer.shadowOpacity = 1;
    todayView.layer.shadowRadius = 5;
    
    UILabel * todayLabel = [[UILabel alloc]init];
    todayLabel.text = @"今日到期";
    todayLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    todayLabel.font = [UIFont systemFontOfSize:14];
    todayLabel.textAlignment = NSTextAlignmentLeft;
    [todayView addSubview:todayLabel];
    
    
    UILabel * todayNumberLabel = [[UILabel alloc]init];
    todayNumberLabel.text = @"10";
    todayNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    todayNumberLabel.font = [UIFont systemFontOfSize:24];
    todayNumberLabel.textAlignment = NSTextAlignmentLeft;
    [todayView addSubview:todayNumberLabel];
    
    
    UILabel * numbertodayLabel = [[UILabel alloc]init];
    numbertodayLabel.text = @"个";
    numbertodayLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    numbertodayLabel.font = [UIFont systemFontOfSize:12];
    numbertodayLabel.textAlignment = NSTextAlignmentLeft;
    [todayView addSubview:numbertodayLabel];
    
    CGSize todaysize = [todayNumberLabel sizeThatFits:CGSizeMake(MAXFLOAT,20)];
    
    todayLabel.sd_layout
    .leftSpaceToView(todayView, 20)
    .topSpaceToView(todayView, 12)
    .rightSpaceToView(todayView, 20)
    .heightIs(20);
    
    todayNumberLabel.sd_layout
    .leftEqualToView(todayLabel)
    .topSpaceToView(todayLabel, 0)
    .widthIs(todaysize.width)
    .heightIs(34);
    
    numbertodayLabel.sd_layout
    .leftSpaceToView(todayNumberLabel, 0)
    .topSpaceToView(todayLabel, 5)
    .widthIs(10)
    .bottomEqualToView(todayNumberLabel);
    
    UIImageView * todayImage = [[UIImageView alloc]init];
    todayImage.image = [UIImage imageNamed:@"形状结合备份"];
    [todayView addSubview:todayImage];
    
    todayImage.sd_layout
    .rightSpaceToView(todayView, 0)
    .bottomSpaceToView(todayView, 0)
    .widthIs(30)
    .heightIs(30);
    
    [headerView setupAutoHeightWithBottomView:expireView bottomMargin:20];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * MARKETMODULECELLID = @"MARKETMODULECELLID";
    RSMarketModuleCell * cell = [tableView dequeueReusableCellWithIdentifier:MARKETMODULECELLID];
    if (!cell) {
        cell = [[RSMarketModuleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MARKETMODULECELLID];
    }
    if (indexPath.row == 0) {
        cell.mananImage.image = [UIImage imageNamed:@"画板110"];
        cell.mananLabel.text = @"合同管理";
        cell.functionLabel.text = @"查询审批合同";
    }else if (indexPath.row == 1){
        cell.mananImage.image = [UIImage imageNamed:@"画板备份"];
        cell.mananLabel.text = @"账单管理";
        cell.functionLabel.text = @"总费用报表,商户明细表";
    }else if (indexPath.row == 2){
        cell.mananImage.image = [UIImage imageNamed:@"画板备份 2"];
        cell.mananLabel.text = @"报表管理";
        cell.functionLabel.text = @"查看各类报表";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
       //合同管理
        RSContractViewController * contractVc = [[RSContractViewController alloc]init];
        [self.navigationController pushViewController:contractVc animated:YES];
    }else if (indexPath.row == 1) {
        //账单管理
        RSManageViewController * manageVc = [[RSManageViewController alloc]init];
        manageVc.title = @"账单管理";
        [self.navigationController pushViewController:manageVc animated:YES];
    }else if(indexPath.row == 2){
        //报表管理
        RSManageViewController * manage1Vc = [[RSManageViewController alloc]init];
        manage1Vc.title = @"报表管理";
        [self.navigationController pushViewController:manage1Vc animated:YES];
    }   
}

@end
