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
        if (indexPath.row == 0) {
            if (self.usermodel.OA_BM_IO == true) {  
               [self creatColumnarVcIndexpath:indexPath andStatus:0];
            }else{
                jxt_showToastTitle(@"您没有这个权限进入",0.75);
            }
        }else if ( indexPath.row == 1){
            if (self.usermodel.OA_SL_IO == true) {
                [self creatColumnarVcIndexpath:indexPath andStatus:1];
            }else{
                jxt_showToastTitle(@"您没有这个权限进入",0.75);
            }
        }else if (indexPath.row == 3){
            if (self.usermodel.OA_Ledger == true) {
                [self creatColumnarVcIndexpath:indexPath andStatus:2];
            }else{
                 jxt_showToastTitle(@"您没有这个权限进入",0.75);
            }
        }else if (indexPath.row == 2){
            if (self.usermodel.OA_Lease == true) {
                 [self creatColumnarVcIndexpath:indexPath andStatus:3];
            }else{
                jxt_showToastTitle(@"您没有这个权限进入",0.75);
            }
        }else if (indexPath.row == 4){
            if (self.usermodel.OA_Ledger_Dtl == true) {
               [self creatColumnarVcIndexpath:indexPath andStatus:4];
            }else{
                jxt_showToastTitle(@"您没有这个权限进入",0.75);
            }
        }
    }else{
        if (indexPath.row == 0) {
            if (self.usermodel.OA_Market_Fee == true) {
               [self creatBalanceVcIndexpath:indexPath andStatus:0];
            }else{
                 jxt_showToastTitle(@"您没有这个权限进入",0.75);
            }
        }else if ( indexPath.row == 1){
            if (self.usermodel.OA_Market_Dealer_Fee == true) {
                [self creatBalanceVcIndexpath:indexPath andStatus:1];
            }else{
                 jxt_showToastTitle(@"您没有这个权限进入",0.75);
            }
        }else if (indexPath.row == 2){
            if (self.usermodel.OA_Market_Pay_In == true) {
                [self creatBalanceVcIndexpath:indexPath andStatus:4];
            }else{
                 jxt_showToastTitle(@"您没有这个权限进入",0.75);
            }
          
        }else if (indexPath.row == 3){
            if (self.usermodel.OA_Market_Settle_In == true) {
                [self creatBalanceVcIndexpath:indexPath andStatus:5];
            }else{
                 jxt_showToastTitle(@"您没有这个权限进入",0.75);
            }
        }
    }
}


- (void)creatColumnarVcIndexpath:(NSIndexPath *)indexPath andStatus:(NSInteger)status{
    
    /**
     //荒料出入库
        bmstock = 0,
        //大板出入库
        slstock = 1,
        //招商总账
        ledger = 2,
        //招商租赁
        lease = 3,
        //招商商户账单明细
        totalLedger = 4
     */
    
    RSColumnarViewController * columnarVc = [[RSColumnarViewController alloc]init];
    if (status == 0) {
        columnarVc.joinType = bmstock;
    }else if (status == 1){
        columnarVc.joinType = slstock;
    }else if (status == 2){
        columnarVc.joinType = ledger;
    }else if (status == 3){
        columnarVc.joinType = lease;
    }else if (status == 4){
        columnarVc.joinType = totalLedger;
    }
    RSManageCell * cell = (RSManageCell *)[self.tableview cellForRowAtIndexPath:indexPath];
    columnarVc.title = cell.manageLabel.text;
    [self.navigationController pushViewController:columnarVc animated:YES];
}



- (void)creatBalanceVcIndexpath:(NSIndexPath *)indexPath andStatus:(NSInteger)status{
    /*
    //获取园区费用应收余额列表
        market_fee = 1,
        //获取商户费用应收余额列表
        dealer_fee = 2,
        //获取商户费用应收明细
    //    dealer_fee_dtl = 3,
        //获取园区收款明细列表
        pay_market_fee = 4,
        //获取园区应收明细列表
        market_fee_dtl = 5
    */
    RSBalanceViewController * balanceVc = [[RSBalanceViewController alloc]init];
    if (status == 0) {
        balanceVc.marketpee = market_fee;
    }else if (status == 1){
        balanceVc.marketpee = dealer_fee;
    }else if (status == 4){
        balanceVc.marketpee = pay_market_fee;
    }else if (status == 5){
        balanceVc.marketpee = market_fee_dtl;
    }
   RSManageCell * cell = (RSManageCell *)[self.tableview cellForRowAtIndexPath:indexPath];
   balanceVc.title = cell.manageLabel.text;
   [self.navigationController pushViewController:balanceVc animated:YES];
}


@end
