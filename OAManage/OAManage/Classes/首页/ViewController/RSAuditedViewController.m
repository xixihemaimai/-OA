//
//  RSAuditedViewController.m
//  OAManage
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSAuditedViewController.h"
#import "RSApprovalCell.h"
//#import "RSShenHeViewController.h"
//#import "RSWKOAmanagerViewController.h"


//新的cell
#import "RSNewAuditedCell.h"
//新的跳转界面
#import "RSInputWorkViewController.h"
#import "RSNewAuditedModel.h"


@interface RSAuditedViewController ()<ZZQEmptyViewDelegate>

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * workArray;

@end

@implementation RSAuditedViewController

- (NSMutableArray *)workArray{
    if (!_workArray) {
        _workArray = [NSMutableArray array];
    }
    return _workArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reLoadCurrentViewAudditedData) name:@"reLoadCurrentViewData" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadWork) name:@"reloadWork" object:nil];
    
    
}


- (void)reloadWork{
    
    self.pageNum = 1;
     [self.tableview.mj_header beginRefreshing];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addBtn setTitle:@"新增" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addBtn addTarget:self action:@selector(addWorkAction:) forControlEvents:UIControlEventTouchUpInside];
               //menuBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = item;

    self.emptyView.emptyMode = ZZQEmptyViewModeWorkOnly;
    self.emptyView.label.text = @"暂无工作日志，";
    self.emptyView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self.emptyView.button setTitle:@"去新增" forState:UIControlStateNormal];
    [self.emptyView.button setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
    self.emptyView.label.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    self.emptyView.hidden = NO;
    self.emptyView.button.hidden = NO;
    self.emptyView.workType = @"1";
    self.emptyView.delegate = self;
   
//    if ([self.parentViewController isKindOfClass:[RSShenHeViewController class]]) {
//        if (IS_IPHONE) {
            // 设置frame
    //self.tableview.contentInset = UIEdgeInsetsMake(46, 0, 0, 0);
//    self.emptyView.hidden = YES;
//        }else{
//            if (DEVICES_IS_PRO_12_9) {
//                self.tableview.contentInset = UIEdgeInsetsMake(60 * SCALE_TO_PRO, 0, 0, 0);
//            }else{
//                self.tableview.contentInset = UIEdgeInsetsMake((60 /SCW ) * SCW, 0, 0, 0);
//            }
//        }
//    }
//    self.title = @"待审核";
    self.title = @"工作日志";
    self.pageNum = 1;
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadAuditedNewData)];
    self.tableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadAuditedMoreNewData)];
    [self.tableview.mj_header beginRefreshing];
}

- (void)reLoadCurrentViewAudditedData{
    self.pageNum = 1;
    
}

//下拉
- (void)reloadAuditedNewData{
    self.pageNum = 1;
    [self reloadAuditedData];
}

//上拉
- (void)reloadAuditedMoreNewData{
    [self reloadAuditedData];
}

- (void)reloadAuditedData{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    [dict setValue:URL_NEWDIARY_IOS((long)self.pageNum, 10) forKey:@"data"];
    [network newReloadWebServiceNoDataURL:URL_DIARY_IOS andParameters:dict andURLName:URL_DIARY_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
      if (self.pageNum == 1) {
          [self.workArray removeAllObjects];
          //self.auditedArray = array;
          [self.workArray addObjectsFromArray:array];
          self.pageNum = 2;
          [self.tableview reloadData];
          [self.tableview.mj_header endRefreshing];
      }else{
          NSArray * array1 = array;
          [self.workArray addObjectsFromArray:array1];
          self.pageNum++;
          [self.tableview reloadData];
          [self.tableview.mj_footer endRefreshing];
      }
      if (self.workArray.count > 0 ) {
          self.emptyView.hidden = YES;
      }else{
          self.emptyView.hidden = NO;
      }
    };
    
    network.failure = ^(NSDictionary *dict) {
        if (self.workArray.count > 0 ) {
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
        }
            [self.tableview.mj_header endRefreshing];
            [self.tableview.mj_footer endRefreshing];
    };
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.workArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * NEWCELLID = @"NEWCELLID";
    RSNewAuditedCell * cell = [tableView dequeueReusableCellWithIdentifier:NEWCELLID];
    if (!cell) {
        cell = [[RSNewAuditedCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NEWCELLID];
    }
    cell.auditedmodel = self.workArray[indexPath.row];
    cell.deleteBtn.tag = indexPath.row;
    cell.editBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteWorkAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editBtn addTarget:self action:@selector(editWorkAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)deleteWorkAction:(UIButton *)deleteBtn{
    [JHSysAlertUtil presentAlertViewWithTitle:@"是否删除工作日志" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
           //取消
    } confirm:^{
       //确定
        RSNewAuditedModel * auditemodel = self.workArray[deleteBtn.tag];
        NetworkTool * network = [[NetworkTool alloc]init];
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
        [dict setValue:URL_DIARY_NEWDELETE_IOS((long)auditemodel.auditedId) forKey:@"data"];
        [network newReloadWebServiceNoDataURL:URL_DIARY_DELETE_IOS andParameters:dict andURLName:URL_DIARY_DELETE_IOS];
        network.deleteSuccess = ^{
            //[self.workArray removeObjectAtIndex:deleteBtn.tag];
            self.pageNum = 1;
            [self.tableview.mj_header beginRefreshing];
        };
    }];
}

- (void)editWorkAction:(UIButton *)editBtn{
    RSNewAuditedModel * auditemodel = self.workArray[editBtn.tag];
    RSInputWorkViewController * inputWorkVc = [[RSInputWorkViewController alloc]init];
    inputWorkVc.showType = @"update";
    inputWorkVc.auditedId = auditemodel.auditedId;
    [self.navigationController pushViewController:inputWorkVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (void)emptyViewHadClick:(ZZQEmptyView *)emptyView{
    //新增工作日志
    RSInputWorkViewController * inputWorkVc = [[RSInputWorkViewController alloc]init];
    inputWorkVc.showType = @"add";
    [self.navigationController pushViewController:inputWorkVc animated:YES];
}
//新增工作日志
- (void)addWorkAction:(UIButton *)addBtn{
    //新增工作日志
    RSInputWorkViewController * inputWorkVc = [[RSInputWorkViewController alloc]init];
    inputWorkVc.showType = @"add";
    [self.navigationController pushViewController:inputWorkVc animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
