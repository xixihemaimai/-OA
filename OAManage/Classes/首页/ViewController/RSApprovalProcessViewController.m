//
//  RSApprovalProcessViewController.m
//  OAManage
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSApprovalProcessViewController.h"
#import "RSProgressView.h"
#import "RSProgressStatusCell.h"

@interface RSApprovalProcessViewController ()


@property (nonatomic,strong)NSMutableArray * approvalArray;

@property (nonatomic,strong)RSProgressView * progressView;

@end

@implementation RSApprovalProcessViewController

- (NSMutableArray *)approvalArray{
    if (!_approvalArray) {
        _approvalArray = [NSMutableArray array];
    }
    return _approvalArray;
}

static NSString * APPROVALHEADERVIEW = @"APPROVALHEADERVIEW";
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"审批";
    CGFloat H = (89 / SCW) * SCW;
    RSProgressView * progressView = [[RSProgressView alloc]initWithFrame:CGRectMake(0, 0, SCW, H)];
    self.progressView = progressView;
    self.tableview.tableHeaderView = progressView;
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ECECEC"];

   RSWeakself
    [self reloadApprovalprocessNewData];
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        [weakSelf reloadApprovalprocessNewData];
        [weakSelf.tableview.mj_header endRefreshing];
    }];
}

- (void)reloadApprovalprocessNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString *const kInitVector = @"16-Bytes--String";
    NetworkTool * network = [[NetworkTool alloc]init];
    NSString * billID = [NSString stringWithFormat:@"%ld",(long)self.billId];
    NSString * notice = URL_YIGODATA_AUDITFLOW(billID);
    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_AUDITFLOW, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_AUDITFLOW];
    network.successArrayReload = ^(NSMutableArray *array) {
        [self.approvalArray removeAllObjects];
        self.approvalArray = array;
        if (self.approvalArray.count > 0) {
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
        }
        [self.tableview reloadData];
    };
    network.successReload = ^(NSDictionary *dict) {
        NSInteger type = [dict[@"billstatus"] integerValue];
        //0 开始 1进行 2结束
        if (type == 0) {
            //开始
            self.progressView.firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
            self.progressView.firstLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
            self.progressView.secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
            self.progressView.secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            self.progressView.thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
            self.progressView.thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];

        }else if (type == 1){
            self.progressView.firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
            self.progressView.firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            self.progressView.secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
            self.progressView.secondLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
            self.progressView.thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
            self.progressView.thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];

        }else{
            self.progressView.firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
            self.progressView.firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            self.progressView.secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
            self.progressView.secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            self.progressView.thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
            self.progressView.thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];

        }
    };
    network.failure = ^(NSDictionary *dict) {
        if (self.approvalArray.count > 0) {
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
        }
        [self.tableview.mj_header endRefreshing];
    };
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.approvalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELLPROGRESSSTATUSID = @"CELLPROGRESSSTATUSID";
    RSProgressStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLPROGRESSSTATUSID];
    if (!cell) {
        cell = [[RSProgressStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLPROGRESSSTATUSID];
    }
    RSApprovalProcessModel * approvalProcessmodel = self.approvalArray[indexPath.row];
    cell.approvalProcessmodel = approvalProcessmodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       return  (144 / SCW) * SCW;
}

@end
