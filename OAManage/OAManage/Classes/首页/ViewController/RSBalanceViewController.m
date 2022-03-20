//
//  RSBalanceViewController.m
//  OAManage
//
//  Created by mac on 2020/9/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSBalanceViewController.h"
#import "MyTableListView.h"
#import "BCContentOB.h"

#import "DIYSystemDatePickerView.h"

#import "RSPopViewController.h"

//#import "RSOALocalDB.h"
#import "RSShipperMode.h"
#import "RSNameOfCargoViewController.h"

@interface RSBalanceViewController ()

@property (nonatomic,strong)UIButton * beginBtn;

@property (nonatomic,strong)UIButton * endBtn;

@property (nonatomic,strong) DIYSystemDatePickerView *datePickerView;

@property (nonatomic,strong)UIView * contractView;

@property (nonatomic,assign)NSInteger pageNum;

//中间值，用来保存选择结算对象的ID
@property (nonatomic,assign)NSInteger tempID;

@property (nonatomic,strong)NSMutableArray * balanceArray;

@property (nonatomic,strong)MyTableListView * tablelist;

@property (nonatomic,strong)UIButton * deleteBtn;

@property (nonatomic,strong)UIButton * objectBtn;


@end

@implementation RSBalanceViewController
- (NSMutableArray *)balanceArray{
    if (!_balanceArray) {
        _balanceArray = [NSMutableArray array];
    }
    return _balanceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNum = 1;
    self.tempID = 0;
    self.emptyView.hidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self setCustomHeaderView];
    [self.tableview removeFromSuperview];
    [self showExcelView];
    
    
    self.tablelist.collectionView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadReportList)];
    self.tablelist.collectionView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadReportListMore)];
    
    
    [self setTimePickerView];
}


- (void)reloadReportList{
    self.pageNum = 1;
    [self reloadBalanceNewData];
}

- (void)reloadReportListMore{
    [self reloadBalanceNewData];
}


- (void)reloadBalanceNewData{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSString * url = [NSString string];
    NSString * filter = [NSString string];
    if (self.marketpee == market_fee) {
        url = URL_MARKET_FEE_IOS;
        filter = [NSString stringWithFormat:@"{monthFrom:'%@',monthTo:'%@',typeId:'%ld'}",_beginBtn.currentTitle,_endBtn.currentTitle,(long)self.tempID];
    }else if (self.marketpee == dealer_fee){
        url = URL_DEALER_FEE_IOS;
        filter = [NSString stringWithFormat:@"{monthFrom:'%@',monthTo:'%@',typeId:'%ld'}",_beginBtn.currentTitle,_endBtn.currentTitle,(long)self.tempID];
    }else if (self.marketpee == pay_market_fee){
        url = URL_PAY_MARKET_IOS;
        filter = [NSString stringWithFormat:@"{monthFrom:'%@',monthTo:'%@',typeId:'%ld'}",_beginBtn.currentTitle,_endBtn.currentTitle,(long)self.tempID];
    }else if (self.marketpee == market_fee_dtl){
        url = URL_MARKET_DTL_IOS;
        filter = [NSString stringWithFormat:@"{monthFrom:'%@',monthTo:'%@',typeId:'%ld'}",_beginBtn.currentTitle,_endBtn.currentTitle,(long)self.tempID];
    }
    NSString * data = [NSString stringWithFormat:@"{pageNum:'%@',pageSize:'%d',filter:%@}",[NSNumber numberWithInteger:self.pageNum],10,filter];
    NSDictionary * dict = @{@"loginToken":self.usermodel.appLoginToken,@"data":data};
    RSWeakself
    [network newReloadWebServiceNoDataURL:url andParameters:dict andURLName:url];
    network.successArrayReload = ^(NSMutableArray *array) {
        if (weakSelf.pageNum == 1) {
            [weakSelf.balanceArray removeAllObjects];
            [weakSelf.tablelist.arrayContent removeAllObjects];
            [weakSelf.balanceArray addObjectsFromArray:array];
            [weakSelf.tablelist addColumnarContentArray:weakSelf.balanceArray];
            weakSelf.pageNum = 2;
            [weakSelf.tablelist.collectionView.mj_header endRefreshing];
        }else{
            [weakSelf.balanceArray addObjectsFromArray:array];
            [weakSelf.tablelist addColumnarContentArray:array];
            weakSelf.pageNum++;
            [weakSelf.tablelist.collectionView.mj_footer endRefreshing];
        }
    };
    network.failure = ^(NSDictionary *dict) {
        [weakSelf.tablelist.collectionView.mj_header endRefreshing];
        [weakSelf.tablelist.collectionView.mj_footer endRefreshing];
    };
}

- (void)reloadMerchantsReceivableNewDataTypeId:(NSInteger)typeId andBlock:(void(^)(NSDictionary * valueDict))block{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSString * data = [NSString stringWithFormat:@"{monthFrom:'%@',monthTo:'%@',typeId:'%ld'}",_beginBtn.currentTitle,_endBtn.currentTitle,(long)typeId];
   // NSString * data = [NSString stringWithFormat:@"{pageNum:'%@',pageSize:'%d',filter:%@}",[NSNumber numberWithInteger:self.pageNum],100,filter];
    NSDictionary * dic = @{@"loginToken":self.usermodel.appLoginToken,@"data":data};
    //RSWeakself
    [network newReloadWebServiceNoDataURL:URL_DEALER_DTL_IOS andParameters:dic andURLName:URL_DEALER_DTL_IOS];
    network.successReload = ^(NSDictionary * dict) {
        if (block) {
            block(dict);
        }
    };
}

- (void)setCustomHeaderView{
    
    UIView * contractView = [[UIView alloc]init];
    [self.view addSubview:contractView];
    contractView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    contractView.layer.cornerRadius = 6;
    contractView.layer.shadowColor = [UIColor colorWithRed:213/255.0 green:211/255.0 blue:211/255.0 alpha:0.5].CGColor;
    contractView.layer.shadowOffset = CGSizeMake(0,0);
    contractView.layer.shadowOpacity = 1;
    contractView.layer.shadowRadius = 5;
    _contractView = contractView;
    
    contractView.sd_layout
    .leftSpaceToView(self.view, 12)
    .topSpaceToView(self.navigationController.navigationBar,13)
    .rightSpaceToView(self.view, 12)
    .heightIs(133);
    
    
    contractView.frame = CGRectMake(12, CGRectGetMaxY(self.navigationController.navigationBar.frame) + 13, SCW - 24, 133);
    
    
    //合同标题
    UIButton * objectBtn = [[UIButton alloc]init];
    if (self.marketpee == market_fee) {
        [objectBtn setTitle:@"费用类型" forState:UIControlStateNormal];
    }else{
        [objectBtn setTitle:@"结算对象" forState:UIControlStateNormal];
    }
    
    [objectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#D5D5D5"] forState:UIControlStateNormal];
    objectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [objectBtn addTarget:self action:@selector(choiceObjectAction:) forControlEvents:UIControlEventTouchUpInside];
    [contractView addSubview:objectBtn];
    _objectBtn = objectBtn;
    
    objectBtn.frame = CGRectMake(22.5, 21, SCW - 24 - 45, 20);
    
//    objectBtn.sd_layout
//    .leftSpaceToView(contractView, 22.5)
//    .rightSpaceToView(contractView, 22.5)
//    .topSpaceToView(contractView, 21)
//    .heightIs(20);
    
    objectBtn.titleLabel.sd_layout
    .leftSpaceToView(objectBtn, 5);
    
    //分隔线
    UIView * contractTitleView = [[UIView alloc]init];
    contractTitleView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [contractView addSubview:contractTitleView];
    
//    contractTitleView.sd_layout
//    .leftEqualToView(objectBtn)
//    .rightEqualToView(objectBtn)
//    .heightIs(0.5)
//    .topSpaceToView(objectBtn, 6);
    
    contractTitleView.frame = CGRectMake(22.5, CGRectGetMaxY(objectBtn.frame) + 6, SCW - 24 - 45, 0.5);
    
    
    //会计起始时间
    UILabel * timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"会计起始时间";
    timeLabel.textColor = [UIColor colorWithHexColorStr:@"#D5D5D5"];
    timeLabel.font = [UIFont systemFontOfSize:12];
    [contractView addSubview:timeLabel];
    
//    timeLabel.sd_layout
//    .topSpaceToView(contractTitleView, 8.5)
//    .heightIs(16.5)
//    .widthIs(100)
//    .leftEqualToView(contractTitleView);
    
    timeLabel.frame = CGRectMake(22.5,CGRectGetMaxY(contractTitleView.frame) + 8.5, 100, 16.5);
    
    
    
    UIButton * beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [beginBtn setTitle:@"2019-02-11" forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    beginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [contractView addSubview:beginBtn];
    beginBtn.tag = 0;
    [beginBtn addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
    beginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _beginBtn = beginBtn;
    
//    beginBtn.sd_layout
//    .leftEqualToView(timeLabel)
//    .topSpaceToView(timeLabel, 0)
//    .rightEqualToView(timeLabel)
//    .heightIs(24);
    
    
    beginBtn.frame = CGRectMake( 22.5, CGRectGetMaxY(timeLabel.frame), 100, 24);
    //.widthIs(120);
    
    //会计结束时间
    UILabel * timeEndLabel = [[UILabel alloc]init];
    timeEndLabel.text = @"会计结束时间";
    timeEndLabel.textColor = [UIColor colorWithHexColorStr:@"#D5D5D5"];
    timeEndLabel.font = [UIFont systemFontOfSize:12];
    [contractView addSubview:timeEndLabel];
//
//    timeEndLabel.sd_layout
//    .topSpaceToView(contractTitleView, 8.5)
//    .rightSpaceToView(contractView, 22.5)
//    .heightIs(16.5)
//    .widthIs(100);
//
    timeEndLabel.frame = CGRectMake(contractView.yj_width - 22.5 - 100, CGRectGetMaxY(contractTitleView.frame) + 8.5, 100, 16.5);
    
    UIButton * endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endBtn setTitle:@"2019-02-11" forState:UIControlStateNormal];
    [endBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    endBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    endBtn.tag = 1;
    [endBtn addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [contractView addSubview:endBtn];
    endBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _endBtn = endBtn;
    
//    endBtn.sd_layout
//    .rightEqualToView(timeEndLabel)
//    .topSpaceToView(timeEndLabel, 0)
//    .heightIs(24)
//    .leftEqualToView(timeEndLabel);
    
    endBtn.frame = CGRectMake(contractView.yj_width - 22.5 - 100, CGRectGetMaxY(timeEndLabel.frame), 100, 24);
    
    //分隔线
    UIView * contractTimeView = [[UIView alloc]init];
    contractTimeView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [contractView addSubview:contractTimeView];
    
//    contractTimeView.sd_layout
//    .leftEqualToView(timeLabel)
//    .rightEqualToView(timeEndLabel)
//    .topSpaceToView(beginBtn, 0)
//    .heightIs(0.5);
    
    contractTimeView.frame = CGRectMake(22.5, CGRectGetMaxY(beginBtn.frame), contractView.yj_width - 22.5, 0.5);
    
    
      UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
      [deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
      [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
      [contractView addSubview:deleteBtn];
    deleteBtn.hidden = YES;
    _deleteBtn = deleteBtn;
    
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn addTarget:self action:@selector(seacrhBeginAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    [contractView addSubview:searchBtn];
    searchBtn.qi_eventInterval = 5.0f;
    
//    searchBtn.sd_layout
//    .rightSpaceToView(contractView, 22.5)
//    .topSpaceToView(contractTimeView, 7.5)
//    .heightIs(23)
//    .widthIs(45);
//
    searchBtn.frame = CGRectMake(contractView.yj_width - 45 - 22.5, CGRectGetMaxY(contractTimeView.frame) + 7.5, 45, 23);
    
    searchBtn.layer.cornerRadius = 2.5;
    searchBtn.layer.masksToBounds = YES;
    
//    deleteBtn.sd_layout
//    .topEqualToView(objectBtn)
//    .widthIs(25)
//    .rightSpaceToView(contractView, 22.5)
//    .heightIs(25);
    
    deleteBtn.frame = CGRectMake(contractView.yj_width - 22.5 - 25,21, 25, 25);
    
    
    //NSMutableArray *dic=[[NSMutableArray alloc] init];
    //修改表格显示内容标题 只需要在BCContentOB文件中修改属性以及其他
    //调整第一列的宽度 可在MyTableListView.m中最上面修改 FIRSTCELLWIDTH
    //调整每一行的高度 可在MyTableListView.m中最上面修改 ALLCELLHIGH
    //调整第一列后的宽度 可在MyTableListView.m中最上面修改 OTHERCELLWIDTH
    //点击下面按钮 可增加一行显示在最上面 如有需要可自行 调整更新以及添加代理等
    //若有其他调整 可自调
    //    for (int i = 0; i < 8; i++) {
    //        BCContentOB *ddd=[[BCContentOB alloc] init];
    //        ddd.name=[NSString stringWithFormat:@"%d",i+1];
    //        ddd.attributeFirst=[NSString stringWithFormat:@"%d",i];
    //        ddd.attributeSecond=@"3283928398293829";
    //        ddd.attributeThird=[NSString stringWithFormat:@"%d",i];
    //        ddd.attributeFourth=[NSString stringWithFormat:@"%d",i];
    //        [dic addObject:ddd];
    //    }
//    self.tableview.sd_layout
//    .topSpaceToView(contractView, 20);
    
}


- (void)setTimePickerView{
    RSWeakself
    _datePickerView = [[DIYSystemDatePickerView alloc]initWithType:DIYSystemDatePickerENUM0
                                                getSelectBeginTime:^(NSString *beginTimeStr) {
        
        if (weakSelf.marketpee == pay_market_fee || weakSelf.marketpee == market_fee_dtl) {
             [weakSelf.beginBtn setTitle:[beginTimeStr substringToIndex:7] forState:(UIControlStateNormal)];
        }else{
             [weakSelf.beginBtn setTitle:beginTimeStr forState:(UIControlStateNormal)];
        }
    } getSelectEndTime:^(NSString *endTimeStr) {
//        [weakSelf.endBtn setTitle:endTimeStr forState:(UIControlStateNormal)];
        if (weakSelf.marketpee == pay_market_fee || weakSelf.marketpee == market_fee_dtl) {
             [weakSelf.endBtn setTitle:[endTimeStr substringToIndex:7] forState:(UIControlStateNormal)];
        }else{
             [weakSelf.endBtn setTitle:endTimeStr forState:(UIControlStateNormal)];
        }
    }];
    [self.view addSubview:_datePickerView];
}



- (void)showExcelView{
    NSArray * array = [NSArray array];
    NSArray * buteArray = [NSArray array];
    if (self.marketpee == market_fee) {
        array = @[@"序号",@"费用类型",@"上期总应收",@"本期应收",@"总收款",@"本期结存"];
        buteArray = @[@"feeName",@"moneyBegin",@"moneyIn",@"moneyOut",@"moneyEnd"];
    }else if (self.marketpee == dealer_fee){
        array = @[@"序号",@"结算对象",@"上期总应收",@"本期应收",@"总收款",@"本期结存"];
        buteArray = @[@"dealerName",@"moneyBegin",@"moneyIn",@"moneyOut",@"moneyEnd"];
    }else if (self.marketpee == pay_market_fee){
        array = @[@"序号",@"结算对象",@"费用类型",@"金额",@"会计期",@"摘要",@"收款类型"];
        buteArray = @[@"dealerName",@"feeName",@"money",@"month",@"notes"];
    }else if (self.marketpee == market_fee_dtl){
        array = @[@"序号",@"结算对象",@"费用类型",@"金额",@"会计期"];
        buteArray = @[@"dealerName",@"feeName",@"money",@"month"];
    }
//    UIView * headerView = [[UIView alloc]init];
//    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    RSWeakself
    //SCH - CGRectGetMaxY(self.contractView.frame) - 80)
    MyTableListView * tablelist = [[MyTableListView alloc] initWithFrame:CGRectMake(13, CGRectGetMaxY(_contractView.frame) + 20, SCW - 13,SCH - CGRectGetMaxY(_contractView.frame) - _contractView.yj_height + 30) andContentDicArray:nil andAttributeName:array andAttribute:buteArray andMarketPee:self.marketpee];
    _tablelist = tablelist;
//    [headerView addSubview:tablelist];
    [self.view addSubview:tablelist];
    //设置代理作用:选中某一个 可自行修改
    tablelist.detailBlock = ^(NSInteger index) {
        RSColumnarModel * columnarmodel = weakSelf.balanceArray[index];
        [weakSelf reloadMerchantsReceivableNewDataTypeId:columnarmodel.dealerId andBlock:^(NSDictionary *valueDict) {
            NSArray * array = [valueDict objectForKey:@"fee"];
            NSMutableArray * payServiceArray = [NSMutableArray array];
            NSMutableArray * payNumberArray = [NSMutableArray array];
            for (int i = 0; i < array.count; i++) {
                RSColumnarModel * columnarPaymodel = array[i];
                [payServiceArray addObject:columnarPaymodel.feeName];
                [payNumberArray addObject:columnarPaymodel.value];
            }
            RSPopViewController * popVc = [[RSPopViewController alloc]initwithContentObjectLabel:[NSString stringWithFormat:@"%@总欠费",columnarmodel.dealerName] andNumberLabel:[NSString stringWithFormat:@"%@",[valueDict objectForKey:@"totalFee"]] andPayServiceArray:payServiceArray andPayNumberArray:payNumberArray andHeight:300];
            [weakSelf yc_bottomPresentController:popVc presentedHeight:400 completeHandle:^(BOOL presented) {
            }];
        }];
    };
//    [headerView setupAutoHeightWithBottomView:tablelist bottomMargin:0];
//    [headerView layoutIfNeeded];
//    self.tableview.tableHeaderView = headerView;
}

//选择结算对象
- (void)choiceObjectAction:(UIButton *)objectBtn{
    RSNameOfCargoViewController * nameOfCargoVc = [[RSNameOfCargoViewController alloc]init];
    if (self.marketpee == market_fee) {
        nameOfCargoVc.title = @"费用类型";
        nameOfCargoVc.type = @"fee";
        [self.navigationController pushViewController:nameOfCargoVc animated:YES];
        nameOfCargoVc.feeblock = ^(RSFeeModel * _Nonnull feemodel, NSString * _Nonnull type) {
            [objectBtn setTitle:feemodel.name forState:UIControlStateNormal];
            self.tempID = feemodel.feeId;
            [objectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
            self.deleteBtn.hidden = NO;
        };
    }else{
        nameOfCargoVc.title = @"货主名称";
        nameOfCargoVc.type = @"dealer";
        [self.navigationController pushViewController:nameOfCargoVc animated:YES];
        nameOfCargoVc.block = ^(RSShipperMode * _Nonnull shippermodel, NSString * _Nonnull type) {
            [objectBtn setTitle:shippermodel.name forState:UIControlStateNormal];
            self.tempID = shippermodel.shipperId;
            [objectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
            self.deleteBtn.hidden = NO;
        };
    }
}

- (void)choiceAction:(UIButton *)btn{
    if (btn.tag == 0) {
        //开始时间
        [_datePickerView showBeginTimePicker];
    }else{
        //结束时间
        [_datePickerView showEndTimePicker];
    }
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    //    if ([self.title isEqualToString:@"报表管理"]) {
//    //        return 5;
//    //    }else{
//    return 0;
//    //    }
//}
//
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//  return nil;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//  return nil;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString * BALANCECELLID = @"BALANCECELLID";
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BALANCECELLID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:BALANCECELLID];
//    }
//    return cell;
//}


- (void)seacrhBeginAction:(UIButton *)searchBtn{
    
    [self.tablelist.arrayContent removeAllObjects];
    [self.tablelist.table reloadData];
    [self.tablelist.collectionView reloadData];
    [self.tablelist.rightTable reloadData];
//    [self.tableview.tableHeaderView removeFromSuperview];
    [self.tablelist.collectionView.mj_header beginRefreshing];
}

- (void)deleteAction:(UIButton *)deleteBtn{
    deleteBtn.hidden = YES;
    self.tempID = 0;
    if (self.marketpee == market_fee) {
        [self.objectBtn setTitle:@"费用类型" forState:UIControlStateNormal];
    }else{
        [self.objectBtn setTitle:@"结算对象" forState:UIControlStateNormal];
    }
    [self.objectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#D5D5D5"] forState:UIControlStateNormal];
}


@end
