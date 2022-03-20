//
//  RSToBeInitiatedViewController.m
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSToBeInitiatedViewController.h"
#import "RSApprovalCell.h"

@interface RSToBeInitiatedViewController ()

@property (nonatomic,strong)NSMutableArray * InitianArray;


@property (nonatomic,assign)NSInteger pageNum;


@end

@implementation RSToBeInitiatedViewController

- (NSMutableArray *)InitianArray{
    if (!_InitianArray) {
        _InitianArray = [NSMutableArray array];
    }
    return _InitianArray;
}


- (void)viewWillAppear:(BOOL)animated{
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadNoticationNew) name:@"reLoadCurrentViewData" object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNum = 1;
    
    
    
    self.emptyView.hidden = NO;
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadNoticeData)];
    self.tableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadNoticMoreNewData)];
    [self.tableview.mj_header beginRefreshing];
    
}


//- (void)reloadNoticationNew{
//
//    self.pageNum = 1;
//       [self reloadShenHeNewData];
//
//}


 

- (void)reloadNoticeData{
    self.pageNum = 1;
    [self reloadShenHeNewData];
}

- (void)reloadNoticMoreNewData{
    [self reloadShenHeNewData];
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.InitianArray.count;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (93 / SCW) * SCW;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * TOBECELLID = @"TOBECELLID";
    RSApprovalCell * cell = [tableView dequeueReusableCellWithIdentifier:TOBECELLID];
    if (!cell) {
        cell = [[RSApprovalCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TOBECELLID];
    }
    // cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    cell.auditemodel = self.InitianArray[indexPath.row];
    UIColor * color = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];//通过RGB来定义自己的颜色
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];//这句不可省略
    cell.selectedBackgroundView.backgroundColor = color;
    cell.approvalBottomView.sd_layout
    .heightIs(0);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSAuditedModel * auditedmodel = self.InitianArray[indexPath.row];
    RSWKOAmanagerViewController * wkoamanagerVc = [[RSWKOAmanagerViewController alloc]init];
    wkoamanagerVc.type = @"2";
    wkoamanagerVc.title = auditedmodel.billName;
    wkoamanagerVc.billId = auditedmodel.billId;
    wkoamanagerVc.isaddProcess = @"1";
    wkoamanagerVc.billKey = auditedmodel.billKey;
    [self.navigationController pushViewController:wkoamanagerVc animated:YES];
    RSWeakself
    wkoamanagerVc.UpdateView = ^{
        weakSelf.pageNum = 1;
           [weakSelf reloadShenHeNewData];
    };
}


- (void)reloadShenHeNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString *const kInitVector = @"16-Bytes--String";
    NetworkTool * network = [[NetworkTool alloc]init];
    NSNumber * number = [NSNumber numberWithInteger:self.pageNum];
    //NSString * notice = URL_YIGODATA_DATA(number,@(100));
    NSString * notice = URL_YIGODDATA_FLOWLIST(number, @(10), @"5", @"");
    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_MYAUDIT, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_MYAUDIT];
    network.successArrayReload = ^(NSMutableArray *array) {
        if (self.pageNum == 1) {
            [self.InitianArray removeAllObjects];
             self.InitianArray = array;
            if (self.InitianArray.count > 0) {
                self.emptyView.hidden = YES;
            }else{
                self.emptyView.hidden = NO;
            }
            [self.tableview.mj_header endRefreshing];
            self.pageNum = 2;
        }else{
            self.emptyView.hidden = YES;
            NSArray * array1 = array;
            [self.InitianArray addObjectsFromArray:array1];
            [self.tableview.mj_footer endRefreshing];
            self.pageNum++;
        }
        [self.tableview reloadData];  
    };
    network.failure = ^(NSDictionary *dict) {
            if (self.InitianArray.count > 0) {
                self.emptyView.hidden = YES;
            }else{
                self.emptyView.hidden = NO;
            }
            [self.tableview.mj_header endRefreshing];
            [self.tableview.mj_footer endRefreshing];
    };
}




- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}




@end
