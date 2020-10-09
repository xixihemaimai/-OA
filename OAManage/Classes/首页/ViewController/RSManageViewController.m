//
//  RSManageViewController.m
//  OAManage
//
//  Created by mac on 2020/9/21.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSManageViewController.h"
#import "RSManageCell.h"

#import "RSBalanceViewController.h"

#import "RSColumnarViewController.h"

@interface RSManageViewController ()

@end

@implementation RSManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emptyView.hidden = YES;    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.title isEqualToString:@"报表管理"]) {
        return 5;
    }else{
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * MANAGECELLID = @"MANAGECELLID";
    RSManageCell * cell = [tableView dequeueReusableCellWithIdentifier:MANAGECELLID];
    if (!cell) {
        cell = [[RSManageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MANAGECELLID];
    }
    if ([self.title isEqualToString:@"报表管理"]) {
        if (indexPath.row == 0) {
            cell.manageView.image = [UIImage imageNamed:@"发起流程复制 3"];
            cell.manageLabel.text = @"荒料出入库情况";
        }else if (indexPath.row == 1){
            cell.manageView.image = [UIImage imageNamed:@"发起流程复制 3备份 2"];
            cell.manageLabel.text = @"大板出入库情况";
        }else if (indexPath.row == 2){
            cell.manageView.image = [UIImage imageNamed:@"发起流程复制 3备份 3"];
            cell.manageLabel.text = @"招商业务租赁情况表";
        }else if (indexPath.row == 3){
            cell.manageView.image = [UIImage imageNamed:@"发起流程复制 3备份 4"];
            cell.manageLabel.text = @"招商总账单表";
        }else{
            cell.manageView.image = [UIImage imageNamed:@"发起流程复制 3备份 5"];
            cell.manageLabel.text = @"招商商户账单明细表";
        }
    }else{
        if (indexPath.row == 0) {
            cell.manageView.image = [UIImage imageNamed:@"发起流程复制 3备份"];
            cell.manageLabel.text = @"园区费用应收余额表";
        }else if (indexPath.row == 1){
            cell.manageView.image = [UIImage imageNamed:@"发起流程复制 3备份 6"];
            cell.manageLabel.text = @"园区商户费用应收余额表";
        }else if (indexPath.row == 2){
            cell.manageView.image = [UIImage imageNamed:@"发起流程复制 3备份 7"];
            cell.manageLabel.text = @"园区收款明细表";
        }else{
            cell.manageView.image = [UIImage imageNamed:@"发起流程复制 3备份 8"];
            cell.manageLabel.text = @"园区应收明细表";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.title isEqualToString:@"报表管理"]) {
        RSColumnarViewController * columnarVc = [[RSColumnarViewController alloc]init];
        [self.navigationController pushViewController:columnarVc animated:YES];
    }else{
        RSBalanceViewController * balanceVc = [[RSBalanceViewController alloc]init];
           [self.navigationController pushViewController:balanceVc animated:YES];
    }
}



@end
