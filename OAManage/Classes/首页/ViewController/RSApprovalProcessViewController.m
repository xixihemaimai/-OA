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

#import "RSApprovalProcessModel.h"

//添加的界面
#import "RSSalertView.h"
//新的组头视图
#import "RSApprovalHeaderView.h"
//新的模型
#import "RSApprovalProcessSecondModel.h"
//新的cell
#import "RSApprovalProcessCell.h"


@interface RSApprovalProcessViewController ()


@property (nonatomic,strong)NSMutableArray * approvalArray;

//@property (nonatomic,strong)RSProgressView * progressView;


@property (nonatomic,strong)RSSalertView * salertview;


@property (nonatomic,assign)NSInteger select;


@end

@implementation RSApprovalProcessViewController

- (NSMutableArray *)approvalArray{
    if (!_approvalArray) {
        _approvalArray = [NSMutableArray array];
    }
    return _approvalArray;
}


- (RSSalertView *)salertview{
    if (!_salertview) {
        _salertview = [[RSSalertView alloc]initWithFrame:CGRectMake(33, (SCH/2) - 214, SCW - 66, 428)];
        _salertview.backgroundColor = [UIColor whiteColor];
        _salertview.layer.cornerRadius = 15;
    }
    return _salertview;
}


static NSString * APPROVALHEADERVIEW = @"APPROVALHEADERVIEW";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"填写日志";
    
    
    
    self.emptyView.hidden = YES;
    
    
    
    
    
    
    for (int i = 0 ; i < 5; i++) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        RSApprovalProcessSecondModel * approvalprocessmodel = [RSApprovalProcessSecondModel statusWithDict:dict];
        [self.approvalArray addObject:approvalprocessmodel];
    }
    
    [self.tableview reloadData];
    
    
    
    
    
//    self.title = @"审批";
//    CGFloat H = 0.0;
//    if (IS_IPHONE) {
//         H = (89 / SCW) * SCW;
//    }else{
//        if (DEVICES_IS_PRO_12_9) {
//            H = 89 * SCALE_TO_PRO;
//        }else{
//            H = (89 / SCW) * SCW;
//        }
//    }
//    RSProgressView * progressView = [[RSProgressView alloc]initWithFrame:CGRectMake(0, 0, SCW, H)];
//    self.progressView = progressView;
//    self.tableview.tableHeaderView = progressView;
//    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ECECEC"];
//
//   RSWeakself
//    [self reloadApprovalprocessNewData];
//    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
//        [weakSelf reloadApprovalprocessNewData];
//        [weakSelf.tableview.mj_header endRefreshing];
//    }];
 
    [self setCustomTableViewFootView];
    
    
    [self setSaveBtnCustomView];
}



- (void)setSaveBtnCustomView{
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:saveBtn];
    [saveBtn bringSubviewToFront:self.view];
    
    saveBtn.layer.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
    saveBtn.layer.shadowColor = [UIColor colorWithHexColorStr:@"#E5E5E5"].CGColor;
    saveBtn.layer.shadowOffset = CGSizeMake(0,-1.5);
    saveBtn.layer.shadowOpacity = 1;
    saveBtn.layer.shadowRadius = 5;
    
}


- (void)setCustomTableViewFootView{
    
    UIView * footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UITextView * footTextview = [[UITextView alloc]initWithFrame:CGRectMake(15, 8, SCW - 30, 68)];
    footTextview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F7FA"];
    footTextview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
    footTextview.returnKeyType = UIReturnKeySend;
    //contentTextview.delegate = self;
    [footView addSubview:footTextview];
    
    footTextview.layer.cornerRadius = 4;
    footTextview.layer.masksToBounds = YES;

    [footView setupAutoHeightWithBottomView:footTextview bottomMargin:8];
    [footView layoutIfNeeded];
    self.tableview.tableFooterView = footView;
    //UITextView * footTextview = [UITextView alloc]ini
}





//- (void)reloadApprovalprocessNewData{
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * aes = [user objectForKey:@"AES"];
//    NSString *const kInitVector = @"16-Bytes--String";
//    NetworkTool * network = [[NetworkTool alloc]init];
//    NSString * billID = [NSString stringWithFormat:@"%ld",self.billId];
//    NSString * notice = URL_YIGODATA_AUDITFLOW(billID);
//    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
//    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
//    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_AUDITFLOW, canshu);
//    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_AUDITFLOW];
//    network.successArrayReload = ^(NSMutableArray *array) {
//        [self.approvalArray removeAllObjects];
//        self.approvalArray = array;
//        if (self.approvalArray.count > 0) {
//            self.emptyView.hidden = YES;
//        }else{
//            self.emptyView.hidden = NO;
//        }
//        [self.tableview reloadData];
//    };
//
//
//    network.successReload = ^(NSDictionary *dict) {
//        NSInteger type = [dict[@"billstatus"] integerValue];
//        //0 开始 1进行 2结束
//        if (type == 0) {
//            //开始
//            self.progressView.firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
//            self.progressView.firstLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
//            self.progressView.secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
//            self.progressView.secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//            self.progressView.thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
//            self.progressView.thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//
//        }else if (type == 1){
//            self.progressView.firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
//            self.progressView.firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//            self.progressView.secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
//            self.progressView.secondLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
//            self.progressView.thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
//            self.progressView.thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//
//        }else{
//            self.progressView.firstView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
//            self.progressView.firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//            self.progressView.secondView.backgroundColor = [UIColor colorWithHexColorStr:@"#cfcfcf"];
//            self.progressView.secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
//            self.progressView.thirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
//            self.progressView.thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
//
//        }
//    };
//    network.failure = ^(NSDictionary *dict) {
//        if (self.approvalArray.count > 0) {
//            self.emptyView.hidden = YES;
//        }else{
//            self.emptyView.hidden = NO;
//        }
//        [self.tableview.mj_header endRefreshing];
//    };
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSApprovalHeaderView * approvalHeaderview = [[RSApprovalHeaderView alloc]initWithReuseIdentifier:APPROVALHEADERVIEW];
    if (section == 0) {
        approvalHeaderview.titleLabel.text = @"今日计划";
    }else if (section == 1){
        approvalHeaderview.titleLabel.text = @"明日计划";
    }else if (section == 2){
        approvalHeaderview.titleLabel.text = @"今日未完成工作";
    }
    else{
        approvalHeaderview.titleLabel.text = @"今日总结";
        approvalHeaderview.addBtn.hidden = YES;
    }
    approvalHeaderview.addBtn.tag = section;
    [approvalHeaderview.addBtn addTarget:self action:@selector(addWorkContentAction:) forControlEvents:UIControlEventTouchUpInside];
    return approvalHeaderview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return self.approvalArray.count;
    
    if (section == 0) {
        
      return self.approvalArray.count;
    }else{
        
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELLPROGRESSSTATUSID = @"CELLPROGRESSSTATUSID";
    RSApprovalProcessCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLPROGRESSSTATUSID];
    if (!cell) {
        cell = [[RSApprovalProcessCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLPROGRESSSTATUSID];
    }
    cell.contentView.tag = indexPath.section;
    cell.approvalProcessmodel = self.approvalArray[indexPath.row];
    cell.openBtn.tag = indexPath.row;
    [cell.openBtn addTarget:self action:@selector(oepnAndCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
//    static NSString * CELLPROGRESSSTATUSID = @"CELLPROGRESSSTATUSID";
//    RSProgressStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLPROGRESSSTATUSID];
//    if (!cell) {
//        cell = [[RSProgressStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLPROGRESSSTATUSID];
//    }
//    RSApprovalProcessModel * approvalProcessmodel = self.approvalArray[indexPath.row];
//    cell.approvalProcessmodel = approvalProcessmodel;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RSApprovalProcessSecondModel * approvalprocessmodel = self.approvalArray[indexPath.row];
    
    //NSLog(@"===================%ld------------%lf",indexPath.row,approvalprocessmodel.cellH);
    return approvalprocessmodel.cellH;
    
    
    //return 40;
//    if (IS_IPHONE) {
//       return  (144 / SCW) * SCW;
//    }else{
//        if (DEVICES_IS_PRO_12_9) {
//            return  200 * SCALE_TO_PRO;
//        }else{
//            return  (200 / SCW) * SCW;
//        }
//    }
}


- (void)oepnAndCloseAction:(UIButton *)openBtn{
    
    UIView *v = [openBtn superview];//获取父类view
       UIView * v1 = [v superview];
    NSLog(@"-+++++++++++++++++%ld",v1.tag);
    
   RSApprovalProcessSecondModel * approvalProcessmodel = self.approvalArray[openBtn.tag];
    openBtn.selected = !openBtn.selected;
    //NSLog(@"=+============================%d",openBtn.selected);
    approvalProcessmodel.open = openBtn.selected;
//    if (openBtn.selected) {
//        approvalProcessmodel.open = true;
//    }else{
//        approvalProcessmodel.open = false;
//    }
    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:openBtn.tag inSection:0];
    [self.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSLog(@"======-----------------------%ld-----------%ld",indexPath.section,indexPath.row);
    
}


- (void)addWorkContentAction:(UIButton *)addBtn{
    [self.salertview showView];
    switch (addBtn.tag) {
        case 0:
            self.salertview.titleLabel.text = @"今日计划";
            break;
        case 1:
            self.salertview.titleLabel.text = @"明日计划";
            break;
        case 2:
            self.salertview.titleLabel.text = @"今日未完成工作";
            break;
        default:
            self.salertview.titleLabel.text = @"今日计划";
            break;
    }
    [self.salertview.choiceBtn setTitle:@"低" forState:UIControlStateNormal];
    self.salertview.select = 0;
    
}

@end
