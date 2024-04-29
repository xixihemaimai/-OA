//
//  RSTouchViewController.m
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTouchViewController.h"
#import "RSTouchCell.h"
#import "RSBLTouchViewController.h"




@interface RSTouchViewController ()


@property (nonatomic,strong)NSMutableArray * touchArray;

@property (nonatomic,assign)NSInteger pageNum;


@property (nonatomic,strong) UITextField * nameTextfield;


@property (nonatomic,strong) UIButton * beginBtn;

@property (nonatomic,strong) UIButton * endBtn;


@end

@implementation RSTouchViewController


- (NSMutableArray *)touchArray{
    if (!_touchArray) {
        _touchArray = [NSMutableArray array];
    }
    return _touchArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNum = 1;
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        self.title = @"荒料解控单";
    }else{
       self.title = @"大板解控单";
    }
    
    self.emptyView.hidden = YES;
    
    [self setTouchCustomHeaderView];
    
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [addBtn setTitle:@"新建" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addBtn addTarget:self action:@selector(addTouchAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    //[self reloadTouchData];
    
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadAuditedNewData)];
    self.tableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadAuditedMoreNewData)];
    [self.tableview.mj_header beginRefreshing];
    
    
    
    
}


- (void)reloadAuditedNewData{
    self.pageNum = 1;
    [self reloadTouchData];
    
}

- (void)reloadAuditedMoreNewData{
    [self reloadTouchData];
}




- (void)reloadTouchData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString *const kInitVector = @"16-Bytes--String";
    NetworkTool * network = [[NetworkTool alloc]init];
    NSNumber * number = [NSNumber numberWithInteger:self.pageNum];
    
    NSString * type = [NSString string];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        type = @"BM";
    }else{
        type = @"SL";
    }
    NSString * notice = URL_YIGODATA_LIFTLIST(number, @(10), self.beginBtn.currentTitle,self.endBtn.currentTitle,self.nameTextfield.text,type);
    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_LIFTLIST, canshu); 
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_LIFTLIST];
    network.successArrayReload = ^(NSMutableArray *array) {
      if (self.pageNum == 1) {
          [self.touchArray removeAllObjects];
          //self.auditedArray = array;
          [self.touchArray addObjectsFromArray:array];
          self.pageNum = 2;
          [self.tableview reloadData];
          [self.tableview.mj_header endRefreshing];
      }else{
          NSArray * array1 = array;     
          [self.touchArray addObjectsFromArray:array1];
          self.pageNum++;
          [self.tableview reloadData];
          [self.tableview.mj_footer endRefreshing];
      }
//      if (self.touchArray.count > 0 ) {
//          self.emptyView.hidden = YES;
//      }else{
//          self.emptyView.hidden = NO;
//      }
    };
    
    network.failure = ^(NSDictionary *dict) {
//        if (self.touchArray.count > 0 ) {
//            self.emptyView.hidden = YES;
//        }else{
//            self.emptyView.hidden = NO;
//        }
            [self.tableview.mj_header endRefreshing];
            [self.tableview.mj_footer endRefreshing];
    };
}




//新建
- (void)addTouchAction:(UIButton *)addBtn{
    RSBLTouchViewController * blVc = [[RSBLTouchViewController alloc]init];
    //blVc.title = @"新建出库单";
    blVc.selectType = self.selectType;
    blVc.showType = @"new";
    [self.navigationController pushViewController:blVc animated:YES];
    blVc.reload = ^(BOOL isreload) {
        self.pageNum = 1;
        [self reloadTouchData];
    };
}



- (void)setTouchCustomHeaderView{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    headerView.frame = CGRectMake(0, 0, SCW, 150);
    //内容
    
    UIView * contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    contentView.frame = CGRectMake(12.5, 12.5, SCW - 25, 132.5);
    [headerView addSubview:contentView];
    
    contentView.layer.cornerRadius = 6;
    contentView.layer.shadowColor = [UIColor colorWithHexColorStr:@"#d5d3d3"].CGColor;
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 5;
    //contentView.layer.masksToBounds = YES;
    
    //货主名
    UITextField * nameTextfield = [[UITextField alloc]init];
    nameTextfield.placeholder = @"货主名";
    nameTextfield.font = [UIFont systemFontOfSize:14];
    nameTextfield.textColor = [UIColor colorWithHexColorStr:@"#d5d5d5"];
    nameTextfield.frame = CGRectMake(22.5, 15, CGRectGetWidth(contentView.frame) - 50, 20);
    [contentView addSubview:nameTextfield];
    _nameTextfield = nameTextfield;
    //分隔线
    UIView * firstview = [[UIView alloc]init];
    firstview.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
    firstview.frame = CGRectMake(22.5, CGRectGetMaxY(nameTextfield.frame) + 6, CGRectGetWidth(contentView.frame) - 50, 0.5);
    [contentView addSubview:firstview];
    
    //起始时间
    UILabel * beginLabel = [[UILabel alloc]init];
    beginLabel.text = @"起始时间";
    beginLabel.textAlignment = NSTextAlignmentLeft;
    beginLabel.textColor = [UIColor colorWithHexColorStr:@"#d5d5d5"];
    beginLabel.font = [UIFont systemFontOfSize:12];
    beginLabel.frame = CGRectMake(22.5, CGRectGetMaxY(firstview.frame), 60, 25);
    [contentView addSubview:beginLabel];
    
    
    
    UIButton * beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   // [beginBtn setTitle:@"2019-12-25" forState:UIControlStateNormal];
    
    [beginBtn setTitleColor:[UIColor colorWithHexColorStr:@"333333"] forState:UIControlStateNormal];
    beginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [beginBtn addTarget:self action:@selector(beginAction:) forControlEvents:UIControlEventTouchUpInside];
    beginBtn.frame = CGRectMake(22.5, CGRectGetMaxY(beginLabel.frame), SCW/2 - 22.5, 24);
    [contentView addSubview:beginBtn];
    beginBtn.titleLabel.sd_layout
       .leftSpaceToView(beginBtn, 0);
    _beginBtn = beginBtn;
    
    
    //结束时间
    UILabel * endLabel = [[UILabel alloc]init];
    endLabel.text = @"结束时间";
    endLabel.textAlignment = NSTextAlignmentLeft;
    endLabel.textColor = [UIColor colorWithHexColorStr:@"#d5d5d5"];
    endLabel.font = [UIFont systemFontOfSize:12];
    endLabel.frame = CGRectMake(SCW/2 + 50, CGRectGetMaxY(firstview.frame), 60, 25);
    [contentView addSubview:endLabel];
    
    
    
    
    UIButton * endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [endBtn setTitle:@"2019-12-25" forState:UIControlStateNormal];
    [endBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    endBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [endBtn addTarget:self action:@selector(endAction:) forControlEvents:UIControlEventTouchUpInside];
    endBtn.frame = CGRectMake(SCW/2 + 50, CGRectGetMaxY(endLabel.frame), SCW/2 - 22.5, 24);
    [contentView addSubview:endBtn];
    
    endBtn.titleLabel.sd_layout
    .leftSpaceToView(endBtn, 0);
    _endBtn = endBtn;
   
    
    [self showDisplayTheTimeToSelectTime:beginBtn andSecondTime:endBtn];
    //分割线
    UIView * secondview = [[UIView alloc]init];
    secondview.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
    secondview.frame = CGRectMake(22.5, CGRectGetMaxY(beginBtn.frame) + 6, CGRectGetWidth(contentView.frame) - 50, 0.5);
    [contentView addSubview:secondview];
    
    
    //搜索的按键
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27c79a"]];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    searchBtn.frame = CGRectMake(CGRectGetWidth(contentView.frame) - 67.5, CGRectGetMaxY(secondview.frame) + 5, 45, 23);
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:searchBtn];
    searchBtn.layer.cornerRadius = 2.5;
    searchBtn.layer.masksToBounds = YES;
    self.tableview.tableHeaderView = headerView;
    
}


- (void)searchAction:(UIButton *)searchBtn{
    self.pageNum = 1;
    [self reloadTouchData];
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.touchArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * TOUCHCELLID = @"TOUCHCELLID";
    RSTouchCell * cell = [tableView dequeueReusableCellWithIdentifier:TOUCHCELLID];
    if (!cell) {
        cell = [[RSTouchCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TOUCHCELLID];
    }
    RSTouchModel * touchmodel = self.touchArray[indexPath.row];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        cell.areaLabel.text = [NSString stringWithFormat:@"总体积:%@m³",touchmodel.totalVaQty];
    }else{
        cell.areaLabel.text = [NSString stringWithFormat:@"总面积:%@m²",touchmodel.totalVaQty];
    }
    cell.touchmodel = touchmodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSTouchModel * touchmodel = self.touchArray[indexPath.row];
    RSBLTouchViewController * blVc = [[RSBLTouchViewController alloc]init];
    blVc.title = @"出库单";
    blVc.selectType = self.selectType;
    blVc.showType = @"reload";
    //blVc.billId = touchmodel.billId;
    blVc.touchmodel = touchmodel;
    [self.navigationController pushViewController:blVc animated:YES];
    blVc.reload = ^(BOOL isreload) {
           self.pageNum = 1;
           [self reloadTouchData];
    };
}

- (void)beginAction:(UIButton *)beginBtn{
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:[self nsstringConversionNSDate:beginBtn.currentTitle] CompleteBlock:^(NSDate *selectDate) {
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        [beginBtn setTitle:date forState:UIControlStateNormal];
    }];
    datepicker.doneButtonColor = [UIColor colorWithHexColorStr:@"#27c79a"];
    [datepicker show];
}

- (void)endAction:(UIButton *)endBtn{
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:[self nsstringConversionNSDate:endBtn.currentTitle] CompleteBlock:^(NSDate *selectDate) {
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        [endBtn setTitle:date forState:UIControlStateNormal];
    }];
    datepicker.doneButtonColor = [UIColor colorWithHexColorStr:@"#27c79a"];
    [datepicker show];
}



@end
