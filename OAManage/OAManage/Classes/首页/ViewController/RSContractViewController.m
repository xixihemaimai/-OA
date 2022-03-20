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


@property (nonatomic,strong)UITextField * titleField;

@property (nonatomic,strong)UIButton * beginBtn;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * contractArray;

@property (nonatomic,strong)UIButton * choiceStatusBtn;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,strong)UIButton * deleteBtn;
@end

@implementation RSContractViewController
-(NSMutableArray *)contractArray{
    if (!_contractArray) {
        _contractArray = [NSMutableArray array];
    }
    return _contractArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"合同管理";
    
    self.pageNum = 1;
    
    self.emptyView.hidden = YES;
    
    [self customHeaderView];
    
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadReportList)];
    MJChiBaoZiFooter * foot = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadReportListMore)];
    foot.refreshingTitleHidden = YES;
    self.tableview.mj_footer = foot;
    [self.tableview.mj_header beginRefreshing];
}


- (void)reloadReportList{
    self.pageNum = 1;
    [self reloadReportListNew];
}


- (void)reloadReportListMore{
    [self reloadReportListNew];
}


- (void)reloadReportListNew{
     self.status = 10;
    if ([_choiceStatusBtn.currentTitle isEqualToString:@"未提交"]) {
        self.status = 0;
    }else if ([_choiceStatusBtn.currentTitle isEqualToString:@"审核中"]){
        self.status = 2;
    }else if ([_choiceStatusBtn.currentTitle isEqualToString:@"已生效"]){
        self.status = 10;
    }else if ([_choiceStatusBtn.currentTitle isEqualToString:@"已过期"]){
        self.status = 12;
    }
    NetworkTool * network = [[NetworkTool alloc]init];
    NSString * time = [NSString string];
    if ([_beginBtn.currentTitle isEqualToString:@"合同日期"]) {
        time = @"";
    }else{
        time = _beginBtn.currentTitle;
    }
    NSString * filter = [NSString stringWithFormat:@"{status:'%ld',billTitle:'%@',billDate:'%@',warningType:'%ld'}",self.status,_titleField.text,time,self.warningType];
    NSString * data = [NSString stringWithFormat:@"{pageNum:'%@',pageSize:'%d',filter:%@}",[NSNumber numberWithInteger:self.pageNum],10,filter];
    NSDictionary * dict = @{@"loginToken":self.usermodel.appLoginToken,@"data":data};
    RSWeakself
    [network newReloadWebServiceNoDataURL:URL_CONTRACT_LIST_IOS andParameters:dict andURLName:URL_CONTRACT_LIST_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
        if (weakSelf.pageNum == 1) {
            [weakSelf.contractArray removeAllObjects];
            if (array.count > 0) {
                [weakSelf.contractArray addObjectsFromArray:array];
                weakSelf.pageNum = 2;
            }
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        }else{
            [self.contractArray addObjectsFromArray:array];
            self.pageNum++;
            [self.tableview reloadData];
            [weakSelf.tableview.mj_footer endRefreshing];
        }
    };
    
    network.failure = ^(NSDictionary *dict) {
      [self.tableview.mj_header endRefreshing];
      [self.tableview.mj_footer endRefreshing];
    };
    
}



- (void)customHeaderView{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    headerView.frame = CGRectMake(0, 0, SCW, 147);
    
    UIView * contractView = [[UIView alloc]init];
    [headerView addSubview:contractView];
    contractView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    contractView.layer.cornerRadius = 6;
    contractView.layer.shadowColor = [UIColor colorWithRed:213/255.0 green:211/255.0 blue:211/255.0 alpha:0.5].CGColor;
    contractView.layer.shadowOffset = CGSizeMake(0,0);
    contractView.layer.shadowOpacity = 1;
    contractView.layer.shadowRadius = 5;
    
    contractView.frame = CGRectMake(12, 12, SCW - 24, 114);
    
//    contractView.sd_layout
//    .leftSpaceToView(headerView, 12)
//    .topSpaceToView(headerView, 12)
//    .rightSpaceToView(headerView, 12)
//    .heightIs(114);
    
    //合同标题
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"合同标题";
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#D5D5D5"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [contractView addSubview:titleLabel];
    
    titleLabel.frame = CGRectMake(22.5,21, 60, 20);
    
//    titleLabel.sd_layout
//    .leftSpaceToView(contractView, 22.5)
//    .widthIs(60)
//    .topSpaceToView(contractView, 21)
//    .heightIs(20);
    
    //合同标题的标签
    UITextField * titleField = [[UITextField alloc]init];
    [contractView addSubview:titleField];
    _titleField = titleField;
    
//    titleField.sd_layout
//    .leftSpaceToView(titleLabel, 5)
//    .rightSpaceToView(contractView, 87.5)
//    .heightIs(20)
//    .topEqualToView(titleLabel);
    
    titleField.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5, 21, SCW - 24 - 87.5 - CGRectGetMaxX(titleLabel.frame) - 5, 20);
    
    UIButton * choiceStatusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [choiceStatusBtn setTitle:@"已生效" forState:UIControlStateNormal];
    
    
    [choiceStatusBtn setImage:[UIImage imageNamed:@"system-pull-down"] forState:UIControlStateNormal];
    choiceStatusBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [choiceStatusBtn addTarget:self action:@selector(choiceStatusAction:) forControlEvents:UIControlEventTouchUpInside];
    [choiceStatusBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    [contractView addSubview:choiceStatusBtn];
    _choiceStatusBtn = choiceStatusBtn;
    
    
    
    choiceStatusBtn.frame = CGRectMake(CGRectGetMaxX(titleField.frame),  21, 70, 23);
    
        
    choiceStatusBtn.titleLabel.sd_layout
    .leftSpaceToView(choiceStatusBtn, 8)
    .centerYEqualToView(choiceStatusBtn)
    .widthIs(40);
        
    choiceStatusBtn.imageView.sd_layout
    .leftSpaceToView(choiceStatusBtn.titleLabel, 0)
    .centerYEqualToView(choiceStatusBtn)
    .widthIs(10)
    .heightIs(5.5);
        
    choiceStatusBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#333333"].CGColor;
    choiceStatusBtn.layer.borderWidth = 0.5;
    choiceStatusBtn.layer.cornerRadius = 2.5;
 
    //分隔线
    UIView * contractTitleView = [[UIView alloc]init];
    contractTitleView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [contractView addSubview:contractTitleView];
    
//    contractTitleView.sd_layout
//    .leftEqualToView(titleLabel)
//    .rightEqualToView(titleField)
//    .heightIs(0.5)
//    .topSpaceToView(titleLabel, 6);
    
    contractTitleView.frame = CGRectMake(22.5, CGRectGetMaxY(titleLabel.frame) + 6, SCW - 76.5, 0.5);
    
    //合同日期
    
    
    UIButton * beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [beginBtn setTitleColor:[UIColor colorWithHexColorStr:@"#D5D5D5"] forState:UIControlStateNormal];
    beginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [beginBtn setTitle:@"合同日期" forState:UIControlStateNormal];
    [beginBtn addTarget:self action:@selector(beginAction:) forControlEvents:UIControlEventTouchUpInside];
    [contractView addSubview:beginBtn];
    
    beginBtn.titleLabel.sd_layout
    .leftSpaceToView(beginBtn, 0);
    
    
    _beginBtn = beginBtn;
    
    
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [contractView addSubview:deleteBtn];
    deleteBtn.hidden = YES;
    _deleteBtn = deleteBtn;
    
//
//    UILabel * timeLabel = [[UILabel alloc]init];
//    timeLabel.text = @"合同日期";
//    timeLabel.textColor = [UIColor colorWithHexColorStr:@"#D5D5D5"];
//    timeLabel.font = [UIFont systemFontOfSize:14];
//    [contractView addSubview:timeLabel];
//
//    timeLabel.sd_layout
//    .topSpaceToView(contractTitleView, 19.5)
//    .heightIs(20)
//    .widthIs(60)
//    .leftEqualToView(contractTitleView);
    
//    UITextField * timeField = [[UITextField alloc]init];
//    [contractView addSubview:timeField];
//    _timeField = timeField;
    
//    beginBtn.sd_layout
//    .leftEqualToView(contractTitleView)
//    .topSpaceToView(contractTitleView, 19.5)
//    .heightIs(20)
//    .rightSpaceToView(contractView, 66.5);
    
    beginBtn.frame = CGRectMake(22.5, CGRectGetMaxY(contractTitleView.frame) + 19.5, contractView.yj_width - 140, 20);
    
    
    
    //分隔线
    UIView * contractTimeView = [[UIView alloc]init];
    contractTimeView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [contractView addSubview:contractTimeView];
    
    contractTimeView.frame = CGRectMake(22.5, CGRectGetMaxY(beginBtn.frame) + 5, contractView.yj_width - 87.5, 0.5);
    
//    contractTimeView.sd_layout
//    .leftEqualToView(beginBtn)
//    .rightEqualToView(beginBtn)
//    .topSpaceToView(beginBtn, 5)
//    .heightIs(0.5);
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    [contractView addSubview:searchBtn];
    searchBtn.qi_eventInterval = 5.0f;
    
    searchBtn.frame = CGRectMake(CGRectGetMaxX(contractTimeView.frame), CGRectGetMaxY(contractTitleView.frame) + 19.5, 45, 23);
    
//    searchBtn.sd_layout
//    .leftSpaceToView(contractTimeView, 0)
//    .rightSpaceToView(contractView, 22.5)
//    .topEqualToView(beginBtn)
//    .heightIs(23)
//    .widthIs(45);
    
    searchBtn.layer.cornerRadius = 2.5;
    searchBtn.layer.masksToBounds = YES;
    
//    deleteBtn.sd_layout
//    .topEqualToView(beginBtn)
//    .rightSpaceToView(searchBtn, 12)
//    .bottomEqualToView(contractTimeView)
//    .widthIs(25);
    
    
    deleteBtn.frame = CGRectMake(contractView.yj_width - 100, CGRectGetMaxY(contractTitleView.frame) + 19.5, 25, 25);
    
    
//    choiceStatusBtn.sd_layout
//    .leftSpaceToView(titleField, 0)
//    .topSpaceToView(contractView, 21)
//    .rightEqualToView(searchBtn)
//    .heightIs(23);
   
    
//    [headerView setupAutoHeightWithBottomView:contractView bottomMargin:20];
//    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    
}

- (void)searchAction:(UIButton *)searchBtn{
    self.pageNum = 1;
    [self.tableview.mj_header beginRefreshing];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contractArray.count;
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
    cell.columnarmodel = self.contractArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //这边是跳H5
    RSColumnarModel * columnarmodel = self.contractArray[indexPath.row];
    RSWKOAmanagerViewController * wkVc = [[RSWKOAmanagerViewController alloc]init];
    wkVc.type = @"7";
    wkVc.billId = [columnarmodel.billId integerValue];
    wkVc.title = @"查看合同";
    wkVc.creatorName = columnarmodel.billTitle;
    [self.navigationController pushViewController:wkVc animated:YES];
}

//选择状态
- (void)choiceStatusAction:(UIButton *)choiceStatusBtn{
    HQPickerView *picker = [[HQPickerView alloc]initWithFrame:CGRectMake(0, 0, SCW, 300)];
    NSArray * array = @[@"未提交",@"审核中",@"已生效",@"已过期"];
    picker.customArr = (NSMutableArray *)array;
    [[UIApplication sharedApplication].keyWindow addSubview:picker];
    picker.pickBlock = ^(UIPickerView *pickerView, NSString *text) {
        [choiceStatusBtn setTitle:text forState:UIControlStateNormal];
    };
}


- (void)beginAction:(UIButton *)beginBtn{
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:[self nsstringConversionNSDate:beginBtn.currentTitle] CompleteBlock:^(NSDate *selectDate) {
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        [beginBtn setTitle:date forState:UIControlStateNormal];
        self.deleteBtn.hidden = NO;
    }];
    datepicker.doneButtonColor = [UIColor colorWithHexColorStr:@"#27c79a"];
    [datepicker show];
}


- (void)deleteAction:(UIButton *)deleteBtn{
    [_beginBtn setTitle:@"合同日期" forState:UIControlStateNormal];
    deleteBtn.hidden = YES;
}

@end
