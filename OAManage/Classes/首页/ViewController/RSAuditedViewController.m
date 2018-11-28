//
//  RSAuditedViewController.m
//  OAManage
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAuditedViewController.h"
#import "RSApprovalCell.h"
#import "RSShenHeViewController.h"
#import "RSWKOAmanagerViewController.h"

@interface RSAuditedViewController ()

@property (nonatomic,assign)NSInteger pageNum;

@end

@implementation RSAuditedViewController

- (NSMutableArray *)auditedArray{
    if (!_auditedArray) {
        _auditedArray = [NSMutableArray array];
    }
    return _auditedArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.parentViewController isKindOfClass:[RSShenHeViewController class]]) {
        if (IS_IPHONE) {
            // 设置frame
            self.tableview.contentInset = UIEdgeInsetsMake(46, 0, 0, 0);
        }else{
            if (DEVICES_IS_PRO_12_9) {
                self.tableview.contentInset = UIEdgeInsetsMake(60 * SCALE_TO_PRO, 0, 0, 0);
            }else{
                self.tableview.contentInset = UIEdgeInsetsMake((60 /SCW ) * SCW, 0, 0, 0);
            }
        }
    }
    self.title = @"待审核";
    self.pageNum = 1;
    RSWeakself
    [self reloadAuditedNewData];
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        [weakSelf reloadAuditedNewData];
        [weakSelf.tableview.mj_header endRefreshing];
    }];
    
    self.tableview.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf reloadAuditedNewData];
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
    
    
}


- (void)reloadAuditedNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString *const kInitVector = @"16-Bytes--String";
    NetworkTool * network = [[NetworkTool alloc]init];
    NSNumber * number = [NSNumber numberWithInteger:self.pageNum];
    NSString * notice = URL_YIGODATA_DATA(number,@(5));
    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_TOBEAUDIT, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_TOBEAUDIT];
    network.successArrayReload = ^(NSMutableArray *array) {
        if (self.pageNum == 1) {
            [self.auditedArray removeAllObjects];
            self.auditedArray = array;
            self.pageNum = 2;
        }else{
            NSArray * array1 = array;
            [self.auditedArray addObjectsFromArray:array1];
            self.pageNum++;
        }
        if (self.auditedArray.count > 0 ) {
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
        }
        [self.tableview reloadData];
    };
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.auditedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELLID = @"CELLID";
    RSApprovalCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[RSApprovalCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLID];
    }
    RSAuditedModel * auditemodel = self.auditedArray[indexPath.row];
    cell.auditemodel = auditemodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
 
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (IS_IPHONE) {
        
        return (93 / SCW) * SCW;
    }else{
        
        if (DEVICES_IS_PRO_12_9) {
            
            return  120 * SCALE_TO_PRO;
            
        }else{
            return (120 / SCW) * SCW;
            
        }
        
        
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    RSAuditedModel * auditemodel = self.auditedArray[indexPath.row];
    RSWKOAmanagerViewController * wkOaVc = [[RSWKOAmanagerViewController alloc]init];
    wkOaVc.billId = auditemodel.billId;
    wkOaVc.workItemId = auditemodel.workItemId;
    wkOaVc.billKey = auditemodel.billKey;
    wkOaVc.usertime = auditemodel.createtime;
    
    [self.navigationController pushViewController:wkOaVc animated:YES];
    
}





@end
