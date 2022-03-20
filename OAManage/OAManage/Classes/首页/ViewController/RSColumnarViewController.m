//
//  RSColumnarViewController.m
//  OAManage
//
//  Created by mac on 2020/9/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSColumnarViewController.h"
#import "ColumnChartView.h"

#import "RSColumnarModel.h"

#import "RSNameOfCargoViewController.h"

@interface RSColumnarViewController ()

@property (nonatomic,strong) UIView * showView;

@property (nonatomic,strong) UIView * choiceTime;

@property (nonatomic,strong) UIView * excelView;

@property (nonatomic,strong) UIButton * totalBtn;

@property (nonatomic,strong) UIButton * contraseBtn;

@property (nonatomic,strong) UIButton * beginBtn;

@property (nonatomic,strong) UIButton * endBtn;

@property (nonatomic,strong)NSMutableArray * columnarArray;

//中间值，用来保存选择结算对象的ID
@property (nonatomic,assign)NSInteger tempID;

@property (nonatomic,strong)UIButton * objectBtn;

@property (nonatomic,strong)UIButton * deleteBtn;

@end

@implementation RSColumnarViewController

- (NSMutableArray *)columnarArray{
    if (!_columnarArray) {
        _columnarArray = [NSMutableArray array];
    }
    return _columnarArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tempID = 0;
    self.emptyView.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    [self customChoiceTimeView];
}


- (void)reloadDataNumberDiffernetTypeNewData{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSString * data = [NSString string];
    NSString * url = [NSString string];
    if (self.joinType == ledger || self.joinType == totalLedger) {
        url = URL_LEDGER_IOS;
        
        if (self.joinType == ledger) {
            data = [NSString stringWithFormat:@"{countMonthFrom:'%@',countMonthTo:'%@',compareMonthFrom:'%@',compareMonthTo:'%@'}",[NSString stringWithFormat:@"%@-%@",_totalBtn.currentTitle,_beginBtn.currentTitle],[NSString stringWithFormat:@"%@-%@",_totalBtn.currentTitle,_endBtn.currentTitle],[NSString stringWithFormat:@"%@-%@",_contraseBtn.currentTitle,_beginBtn.currentTitle],[NSString stringWithFormat:@"%@-%@",_contraseBtn.currentTitle,_endBtn.currentTitle]];
        }else{
            data = [NSString stringWithFormat:@"{countMonthFrom:'%@',countMonthTo:'%@',compareMonthFrom:'%@',compareMonthTo:'%@',dealerId:'%ld'}",[NSString stringWithFormat:@"%@-%@",_totalBtn.currentTitle,_beginBtn.currentTitle],[NSString stringWithFormat:@"%@-%@",_totalBtn.currentTitle,_endBtn.currentTitle],[NSString stringWithFormat:@"%@-%@",_contraseBtn.currentTitle,_beginBtn.currentTitle],[NSString stringWithFormat:@"%@-%@",_contraseBtn.currentTitle,_endBtn.currentTitle],_tempID];
        }
       
    }else if (self.joinType == lease){
        url = URL_LEASE_IOS;
        data = [NSString stringWithFormat:@"{monthFrom:'%@',monthTo:'%@'}",[NSString stringWithFormat:@"%@-%@",_totalBtn.currentTitle,_beginBtn.currentTitle],[NSString stringWithFormat:@"%@-%@",_totalBtn.currentTitle,_endBtn.currentTitle]];
        
    }else{
        if (self.joinType == bmstock) {
            url = URL_BMSTOCK_IOS;
        }else{
            url = URL_SLSTOCK_IOS;
        }
        data = [NSString stringWithFormat:@"{countMonthFrom:'%@',countMonthTo:'%@',compareMonthFrom:'%@',compareMonthTo:'%@'}",[NSString stringWithFormat:@"%@-%@",_totalBtn.currentTitle,_beginBtn.currentTitle],[NSString stringWithFormat:@"%@-%@",_totalBtn.currentTitle,_endBtn.currentTitle],[NSString stringWithFormat:@"%@-%@",_contraseBtn.currentTitle,_beginBtn.currentTitle],[NSString stringWithFormat:@"%@-%@",_contraseBtn.currentTitle,_endBtn.currentTitle]];
    }
    
    NSDictionary * dict = @{@"loginToken":self.usermodel.appLoginToken,@"data":data};
    [network newReloadWebServiceNoDataURL:url andParameters:dict andURLName:url];
    RSWeakself
    network.successArrayReload = ^(NSMutableArray *array) {
        [weakSelf.columnarArray removeAllObjects];
        weakSelf.columnarArray = array;
//        NSLog(@"=======================%ld",weakSelf.columnarArray.count);
        [weakSelf showEexcelView];
    };
}


- (NSString *)acquisitionTimeType:(NSInteger)type{
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (type == 0) {
        formatter.dateFormat = @"yyyy-MM";
    }else{
        formatter.dateFormat = @"yyyy";
    }
    NSString * res = [formatter stringFromDate:date];
    return res;
}

- (void)customChoiceTimeView{
    
    UIView * headerView = [[UIView alloc]init];
    if (self.joinType == totalLedger) {
        headerView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCW, 125);
    }else{
        headerView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCW, 95);
    }
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    [self.view addSubview:headerView];
    
//    self.tableview.sd_layout
//    .topSpaceToView(headerView, 0);
    self.tableview.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame) + 10, SCW, 1000);
    
   
//    self.tableview.contentSize = CGSizeMake(0,1000);

    UIView * choiceTime = [[UIView alloc]init];
    choiceTime.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:choiceTime];
    _choiceTime = choiceTime;
    
    
    //结算对象
    UIButton * objectBtn = [[UIButton alloc]init];
    [objectBtn setTitle:@"结算对象" forState:UIControlStateNormal];
    [objectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#D5D5D5"] forState:UIControlStateNormal];
    objectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [objectBtn addTarget:self action:@selector(choiceObjectAction:) forControlEvents:UIControlEventTouchUpInside];
    [choiceTime addSubview:objectBtn];
    _objectBtn = objectBtn;
    //统计年份
    UILabel * totalYearLabel = [[UILabel alloc]init];
    totalYearLabel.text = @"统计年份";
    totalYearLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    totalYearLabel.font = [UIFont systemFontOfSize:15];
    [choiceTime addSubview:totalYearLabel];
    
    NSString * time = [self acquisitionTimeType:0];
    
    UIButton * totalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [totalBtn setTitle:[time substringToIndex:4] forState:UIControlStateNormal];
    [totalBtn setImage:[UIImage imageNamed:@"向下"] forState:UIControlStateNormal];
    totalBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [totalBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [totalBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    totalBtn.tag = 1;
    [totalBtn addTarget:self action:@selector(choiceTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [choiceTime addSubview:totalBtn];
    _totalBtn = totalBtn;
    
    //对比年份
    UILabel * contrast = [[UILabel alloc]init];
    contrast.text = @"对比年份";
    contrast.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    contrast.font = [UIFont systemFontOfSize:15];
    [choiceTime addSubview:contrast];
    
    
    //    NSLog(@"======================%@",time);
    
    UIButton * contraseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contraseBtn setTitle:@"2019" forState:UIControlStateNormal];
    [contraseBtn setImage:[UIImage imageNamed:@"向下"] forState:UIControlStateNormal];
    contraseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    contraseBtn.tag = 2;
    [contraseBtn addTarget:self action:@selector(choiceTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [contraseBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [contraseBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    [choiceTime addSubview:contraseBtn];
    _contraseBtn = contraseBtn;
    
//    choiceTime.sd_layout
//    .leftSpaceToView(headerView, 0)
//    .topSpaceToView(headerView, 0)
//    .rightSpaceToView(headerView, 0)
//    .heightIs(95);
    
    choiceTime.frame = CGRectMake(0, 0, SCW, 95);
    
    
    
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [choiceTime addSubview:deleteBtn];
    deleteBtn.hidden = YES;
    _deleteBtn = deleteBtn;
    
    if (self.joinType == totalLedger) {
       
        
        choiceTime.frame = CGRectMake(0, 0, SCW, 125);
//        choiceTime.sd_layout
//        .leftSpaceToView(headerView, 0)
//        .topSpaceToView(headerView, 0)
//        .rightSpaceToView(headerView, 0)
//        .heightIs(125);
        
        objectBtn.frame = CGRectMake(12, 10, SCW - 24, 27);
        
//        objectBtn.sd_layout
//        .rightSpaceToView(choiceTime, 12)
//        .leftSpaceToView(choiceTime, 12)
//        .topSpaceToView(choiceTime, 10)
//        .heightIs(27);
        
        objectBtn.titleLabel.sd_layout
        .leftSpaceToView(objectBtn, 0);
        
        objectBtn.hidden = NO;
        
        deleteBtn.hidden = YES;
        
        
//        totalYearLabel.sd_layout
//        .leftSpaceToView(choiceTime, 12)
//        .topSpaceToView(objectBtn, 10)
//        .heightIs(21)
//        .widthIs(62);
        
        totalYearLabel.frame = CGRectMake(12, CGRectGetMaxY(objectBtn.frame) + 10, 62, 21);
        
        
//        deleteBtn.sd_layout
//        .topSpaceToView(choiceTime, 10)
//        .widthIs(25)
//        .heightIs(25)
//        .rightSpaceToView(choiceTime, 12);
        
        deleteBtn.frame = CGRectMake(SCW - 12 - 25, 10, 25, 25);
        
    }else{
        
        choiceTime.frame = CGRectMake(0, 0, SCW, 95);
//        choiceTime.sd_layout
//        .leftSpaceToView(headerView, 0)
//        .topSpaceToView(headerView, 0)
//        .rightSpaceToView(headerView, 0)
//        .heightIs(95);
        
        objectBtn.hidden = YES;
        
        deleteBtn.hidden = YES;
//
//        totalYearLabel.sd_layout
//        .leftSpaceToView(choiceTime, 12)
//        .topSpaceToView(choiceTime, 15)
//        .heightIs(21)
//        .widthIs(62);
        
        totalYearLabel.frame = CGRectMake(12, 10, 62, 21);
    }
    
    
    
    
    
//    if (self.joinType == totalLedger) {
//
//
//
//       }else{
//
//
//       }
    
    
    
    totalBtn.frame = CGRectMake(CGRectGetMaxX(totalYearLabel.frame) + 9.5, totalYearLabel.yj_y , 70, 27);
//    totalBtn.sd_layout
//    .leftSpaceToView(totalYearLabel, 9.5)
//    .topEqualToView(totalYearLabel)
//    .heightIs(27)
//    .widthIs(70);
    
    totalBtn.titleLabel.sd_layout
    .leftSpaceToView(totalBtn, 11)
    .centerYEqualToView(totalBtn)
    .widthIs(40);
    
    totalBtn.imageView.sd_layout
    .leftSpaceToView(totalBtn.titleLabel, 0)
    .centerYEqualToView(totalBtn)
    .widthIs(10)
    .heightIs(5.5);
    
    contrast.frame = CGRectMake(CGRectGetMaxX(totalBtn.frame) + 19, totalYearLabel.yj_y, 62, 27);
//
//    contrast.sd_layout
//    .leftSpaceToView(totalBtn, 19)
//    .topEqualToView(totalYearLabel)
//    .bottomEqualToView(totalYearLabel)
//    .widthIs(62);
    
//    contraseBtn.sd_layout
//    .leftSpaceToView(contrast, 9.5)
//    .topEqualToView(contrast)
//    .heightIs(27)
//    .widthIs(70);
    
    contraseBtn.frame = CGRectMake(CGRectGetMaxX(contrast.frame) + 9.5, totalYearLabel.yj_y, 70, 27);
    
    
    contraseBtn.titleLabel.sd_layout
    .leftSpaceToView(contraseBtn, 11)
    .centerYEqualToView(contraseBtn)
    .widthIs(40);
    
    contraseBtn.imageView.sd_layout
    .leftSpaceToView(contraseBtn.titleLabel, 0)
    .centerYEqualToView(contraseBtn)
    .widthIs(10)
    .heightIs(5.5);
    
    //统计月份
    UILabel * totalMonthLabel = [[UILabel alloc]init];
    totalMonthLabel.text = @"统计月份";
    totalMonthLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    totalMonthLabel.font = [UIFont systemFontOfSize:15];
    [choiceTime addSubview:totalMonthLabel];
    
    UIButton * beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [beginBtn setTitle:@"01" forState:UIControlStateNormal];
    [beginBtn setImage:[UIImage imageNamed:@"向下"] forState:UIControlStateNormal];
    beginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    beginBtn.tag = 3;
    [beginBtn addTarget:self action:@selector(choiceTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [beginBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [beginBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    [choiceTime addSubview:beginBtn];
    _beginBtn = beginBtn;
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#979797"];
    [choiceTime addSubview:midView];
    
    UIButton * endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endBtn setTitle:[NSString stringWithFormat:@"%@",[time substringFromIndex:time.length - 2]] forState:UIControlStateNormal];
    [endBtn setImage:[UIImage imageNamed:@"向下"] forState:UIControlStateNormal];
    endBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    endBtn.tag = 4;
    [endBtn addTarget:self action:@selector(choiceTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [endBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [endBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    [choiceTime addSubview:endBtn];
    _endBtn = endBtn;
    
//    totalMonthLabel.sd_layout
//    .leftEqualToView(totalYearLabel)
//    .topSpaceToView(totalYearLabel, 16)
//    .rightEqualToView(totalYearLabel)
//    .heightIs(21);
    
    
    totalMonthLabel.frame = CGRectMake(12, CGRectGetMaxY(totalYearLabel.frame) + 16, 70, 21);
    
    
//    beginBtn.sd_layout
//    .leftEqualToView(totalBtn)
//    .rightEqualToView(totalBtn)
//    .topSpaceToView(totalBtn, 9.5)
//    .heightIs(27);
//
    beginBtn.frame = CGRectMake(CGRectGetMaxX(totalYearLabel.frame) + 9.5, CGRectGetMaxY(totalBtn.frame) + 9.5, 70, 27);
    
    
//    midView.sd_layout
//    .leftSpaceToView(beginBtn, 11.5)
//    .heightIs(0.5)
//    .widthIs(9)
//    .topSpaceToView(totalBtn, 23);
    
    midView.frame = CGRectMake(CGRectGetMaxX(beginBtn.frame) + 12.5, CGRectGetMaxY(totalBtn.frame) + 23, 9, 0.5);
    
//    endBtn.sd_layout
//    .leftSpaceToView(midView, 12.5)
//    .topEqualToView(beginBtn)
//    .bottomEqualToView(beginBtn)
//    .widthIs(70);
    
    endBtn.frame = CGRectMake(CGRectGetMaxX(midView.frame) + 12.5, CGRectGetMaxY(totalBtn.frame) + 9.5, 70, 27);
    
    beginBtn.titleLabel.sd_layout
    .leftSpaceToView(beginBtn, 24)
    .centerYEqualToView(beginBtn)
    .widthIs(40);
    
    beginBtn.imageView.sd_layout
    .rightSpaceToView(beginBtn, 10)
    .centerYEqualToView(beginBtn)
    .widthIs(10)
    .heightIs(5.5);
    
    endBtn.titleLabel.sd_layout
    .leftSpaceToView(endBtn, 24)
    .centerYEqualToView(endBtn)
    .widthIs(35);
    
    endBtn.imageView.sd_layout
    .rightSpaceToView(endBtn, 10)
    .centerYEqualToView(endBtn)
    .widthIs(10)
    .heightIs(5.5);
    
    totalBtn.layer.cornerRadius = 13.5;
    contraseBtn.layer.cornerRadius = 13.5;
    beginBtn.layer.cornerRadius = 13.5;
    endBtn.layer.cornerRadius = 13.5;
    
    UIButton * queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [queryBtn setTitle:@"查询" forState:UIControlStateNormal];
    [queryBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [queryBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    [queryBtn addTarget:self action:@selector(queryAction:) forControlEvents:UIControlEventTouchUpInside];
    [choiceTime addSubview:queryBtn];
    queryBtn.qi_eventInterval = 5.0f;
    
//    queryBtn.sd_layout
//    .rightSpaceToView(choiceTime, 12)
//    .topEqualToView(endBtn)
//    .widthIs(70)
//    .heightIs(27);
    
    queryBtn.frame = CGRectMake(SCW - 12 - 70, CGRectGetMaxY(totalBtn.frame) + 9.5, 70, 27);
    
    
    queryBtn.layer.cornerRadius = 13.5;
    
    if (self.joinType == lease) {
        contrast.hidden = YES;
        contraseBtn.hidden = YES;
    }else{
        contrast.hidden = NO;
        contrast.hidden = NO;
    }
}


//查询
- (void)queryAction:(UIButton *)queryBtn{
//    if (self.joinType == totalLedger) {
//        if ([_objectBtn.currentTitle isEqualToString:@"结算对象"]) {
//            jxt_showToastTitle(@"请先选择结算对象", 0.75);
//        }else{
//            [self.tableview.tableHeaderView removeFromSuperview];
//            [self reloadDataNumberDiffernetTypeNewData];
//        }
//    }else{
        [self.tableview.tableHeaderView removeFromSuperview];
        [self reloadDataNumberDiffernetTypeNewData];
//    }
}


- (void)choiceObjectAction:(UIButton *)objectBtn{
    RSNameOfCargoViewController * nameOfCargoVc = [[RSNameOfCargoViewController alloc]init];
    nameOfCargoVc.title = @"货主名称";
    nameOfCargoVc.type = @"dealer";
    [self.navigationController pushViewController:nameOfCargoVc animated:YES];
    nameOfCargoVc.block = ^(RSShipperMode * _Nonnull shippermodel, NSString * _Nonnull type) {
        [objectBtn setTitle:shippermodel.name forState:UIControlStateNormal];
        self.tempID = shippermodel.shipperId;
        [objectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        if (self.joinType == totalLedger) {
            self.deleteBtn.hidden = NO;
        }else{
            self.deleteBtn.hidden = YES;
        }
    };
}

- (void)showEexcelView{
    UIView * showView = [[UIView alloc]init];
    showView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    _showView = showView;
    showView.frame = CGRectMake(0, 0, SCW, 2000);
    UIView * excelView = [[UIView alloc]init];
    excelView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    if (self.joinType == bmstock) {
        excelView.frame = CGRectMake(12, 20, SCW - 24, 293);
    }else if (self.joinType == slstock){
//        showView.frame = CGRectMake(0, 0, SCW, 240);
        excelView.frame = CGRectMake(12, 20, SCW - 24, 200);
    }else if (self.joinType == ledger || self.joinType == totalLedger){
//        showView.frame = CGRectMake(0, 0, SCW, 270);
        excelView.frame = CGRectMake(12, 20, SCW - 24, 230);
    }else if (self.joinType == lease){
//        showView.frame = CGRectMake(0, 0, SCW, 740);
        excelView.frame = CGRectMake(12, 20, SCW - 24, 700);
    }
    excelView.layer.cornerRadius = 6;
    [self.showView addSubview:excelView];
    _excelView = excelView;
    
    UIView * leftView = [[UIView alloc]init];
    leftView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    leftView.frame = CGRectMake(0, 14, 4, 20);
    [excelView addSubview:leftView];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC" size: 16];
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    titleLabel.frame = CGRectMake(CGRectGetMaxX(leftView.frame) + 12, 14, SCW - 24 - CGRectGetMaxX(leftView.frame) , 20);
    [excelView addSubview:titleLabel];
    if (self.joinType == lease) {
        titleLabel.text = [NSString stringWithFormat:@"%@-%@大板架子位,业务楼,条板新租情况",_beginBtn.currentTitle,_endBtn.currentTitle];
        for (int i = 0; i < 5; i++) {
            UIView * dataView = [[UIView alloc]init];
            if (i % 2 == 0) {
                dataView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
            }else{
                dataView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
            }
            for (int j = 0; j < 4; j++) {
                UILabel * dataLabel = [[UILabel alloc]init];
                dataLabel.numberOfLines = 0;
                dataLabel.textAlignment = NSTextAlignmentCenter;
                if (i == 0) {
                    dataLabel.font = [UIFont systemFontOfSize:15];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                    if (j == 0) {
                        dataLabel.text = @"租赁情况";
                    }else if (j == 1){
                        dataLabel.text = @"架子位";
                    }else if (j == 2){
                        dataLabel.text = @"大板商铺";
                    }else if (j == 3){
                        dataLabel.text = @"条板商铺";
                    }
                }else if (i == 1){
                    dataLabel.font = [UIFont systemFontOfSize:13];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                    if (j == 0) {
                        dataLabel.text = @"新增(家)";
                    }else if (j == 1){
                        RSColumnarModel * columnarmodel = self.columnarArray[0];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.newDealerCount];
                    }else if (j == 2){
                        RSColumnarModel * columnarmodel = self.columnarArray[1];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.newDealerCount];
                    }else if (j == 3){
                        RSColumnarModel * columnarmodel = self.columnarArray[2];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.newDealerCount];
                    }
                }else if (i == 2){
                    dataLabel.font = [UIFont systemFontOfSize:13];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                    if (j == 0) {
                        dataLabel.text = @"新租格数/简数";
                    }else if (j == 1){
                        RSColumnarModel * columnarmodel = self.columnarArray[0];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.newQty];
                    }else if (j == 2){
                        RSColumnarModel * columnarmodel = self.columnarArray[1];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.newQty];
                    }else if (j == 3){
                        RSColumnarModel * columnarmodel = self.columnarArray[2];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.newQty];
                    }
                }else if (i == 3){
                    dataLabel.font = [UIFont systemFontOfSize:13];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                    if (j == 0) {
                        dataLabel.text = @"续租(家)";
                    }else if (j == 1){
                        RSColumnarModel * columnarmodel = self.columnarArray[0];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.rebackDealerCount];
                    }else if (j == 2){
                        RSColumnarModel * columnarmodel = self.columnarArray[1];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.rebackDealerCount];
                    }else if (j == 3){
                        RSColumnarModel * columnarmodel = self.columnarArray[2];
                        dataLabel.text =[NSString stringWithFormat:@"%ld",(long)columnarmodel.rebackDealerCount];
                    }
                }else if (i == 4){
                    dataLabel.font = [UIFont systemFontOfSize:13];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                    if (j == 0) {
                        dataLabel.text = @"续签格数/间数";
                    }else if (j == 1){
                        RSColumnarModel * columnarmodel = self.columnarArray[0];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.rebackQtyCount];
                    }
                    else if (j == 2){
                        RSColumnarModel * columnarmodel = self.columnarArray[1];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.rebackQtyCount];
                    }else if (j == 3){
                        RSColumnarModel * columnarmodel = self.columnarArray[2];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.rebackQtyCount];
                    }
                }
                dataLabel.frame = CGRectMake(j * (SCW - 48)/4, 0, (SCW - 48)/4, 44);
                [dataView addSubview:dataLabel];
            }
            dataView.frame = CGRectMake(12, i * 44 + CGRectGetMaxY(titleLabel.frame) + 18 , SCW - 48,  44);
            [excelView addSubview:dataView];
        }
        
        
        UIView * leftSecondView = [[UIView alloc]init];
        leftSecondView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
        leftSecondView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 5 * 44 + 25, 4, 20);
        [excelView addSubview:leftSecondView];
        
        UILabel * titleSecondLabel = [[UILabel alloc]init];
        titleSecondLabel.font = [UIFont fontWithName:@"PingFangSC" size: 16];
        titleSecondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleSecondLabel.text = [NSString stringWithFormat:@"%@-%@大板架子位,业务楼,条板退租情况",_beginBtn.currentTitle,_endBtn.currentTitle];
        titleSecondLabel.frame = CGRectMake(CGRectGetMaxX(leftSecondView.frame) + 12,CGRectGetMaxY(titleLabel.frame) + 5 * 44 + 25 , SCW - 24 - CGRectGetMaxX(leftSecondView.frame) , 20);
        [excelView addSubview:titleSecondLabel];
        
        for (int i = 0; i < 3; i++) {
            UIView * dataView = [[UIView alloc]init];
            if (i % 2 == 0) {
                dataView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
            }else{
                dataView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
            }
            for (int j = 0; j < 4; j++) {
                UILabel * dataLabel = [[UILabel alloc]init];
                dataLabel.numberOfLines = 0;
                dataLabel.textAlignment = NSTextAlignmentCenter;
                if (i == 0) {
                    dataLabel.font = [UIFont systemFontOfSize:15];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                    if (j == 0) {
                        dataLabel.text = @"租赁情况";
                    }else if (j == 1){
                        dataLabel.text = @"架子位";
                    }else if (j == 2){
                        dataLabel.text = @"大板商铺";
                    }else if (j == 3){
                        dataLabel.text = @"条板商铺";
                    }
                }else if (i == 1){
                    dataLabel.font = [UIFont systemFontOfSize:13];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                    if (j == 0) {
                        dataLabel.text = @"退租(家)";
                    }else if (j == 1){
                        RSColumnarModel * columnarmodel = self.columnarArray[0];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.renewalDealerCount];
                    }else if (j == 2){
                        RSColumnarModel * columnarmodel = self.columnarArray[1];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.renewalDealerCount];
                    }else if (j == 3){
                        RSColumnarModel * columnarmodel = self.columnarArray[2];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.renewalDealerCount];
                    }
                }else if (i == 2){
                    dataLabel.font = [UIFont systemFontOfSize:13];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                    if (j == 0) {
                        dataLabel.text = @"退租格数/间数";
                    }else if (j == 1){
                        RSColumnarModel * columnarmodel = self.columnarArray[0];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.renewalQty];
                    }else if (j == 2){
                        RSColumnarModel * columnarmodel = self.columnarArray[1];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.renewalQty];
                    }else if (j == 3){
                        RSColumnarModel * columnarmodel = self.columnarArray[2];
                        dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.renewalQty];
                    }
                }
                dataLabel.frame = CGRectMake(j * (SCW - 48)/4, 0, (SCW - 48)/4, 44);
                [dataView addSubview:dataLabel];
            }
            dataView.frame = CGRectMake(12, i * 44 + CGRectGetMaxY(titleSecondLabel.frame) + 18 , SCW - 48,  44);
            [excelView addSubview:dataView];
        }
        
        UIView * leftThirdView = [[UIView alloc]init];
        leftThirdView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
        leftThirdView.frame = CGRectMake(0, CGRectGetMaxY(titleSecondLabel.frame) + 5 + 3 * 44 + 25, 4, 20);
        [excelView addSubview:leftThirdView];
               
        UILabel * titleThirdLabel = [[UILabel alloc]init];
        titleThirdLabel.font = [UIFont fontWithName:@"PingFangSC" size: 16];
        titleThirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleThirdLabel.text = [NSString stringWithFormat:@"%@-%@大板架子位,业务楼,条板退租情况",_beginBtn.currentTitle,_endBtn.currentTitle];
        titleThirdLabel.frame = CGRectMake(CGRectGetMaxX(leftThirdView.frame) + 12,CGRectGetMaxY(titleSecondLabel.frame) + 5 + 3 * 44 + 25, SCW - 24 - CGRectGetMaxX(leftThirdView.frame) , 20);
        [excelView addSubview:titleThirdLabel];
        
        
        for (int i = 0; i < 4; i++) {
                  UIView * dataView = [[UIView alloc]init];
                  if (i % 2 == 0) {
                      dataView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
                  }else{
                      dataView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
                  }
                  for (int j = 0; j < 5; j++) {
                      UILabel * dataLabel = [[UILabel alloc]init];
                      dataLabel.numberOfLines = 0;
                      dataLabel.textAlignment = NSTextAlignmentCenter;
                      if (i == 0) {
                          dataLabel.font = [UIFont systemFontOfSize:15];
                          dataLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                          if (j == 0) {
                              dataLabel.text = [NSString stringWithFormat:@"%@-%@",_beginBtn.currentTitle,_beginBtn.currentTitle];
                          }else if (j == 1){
                              dataLabel.text = @"总间数格数";
                          }else if (j == 2){
                              dataLabel.text = @"已出租";
                          }else if (j == 3){
                              dataLabel.text = @"未出租";
                          }else if (j == 4){
                              dataLabel.text = @"比例";
                          }
                      }else if (i == 1){
                          dataLabel.font = [UIFont systemFontOfSize:13];
                          dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                          if (j == 0) {
                              dataLabel.text = @"架子位";
                          }else if (j == 1){
                              RSColumnarModel * columnarmodel = self.columnarArray[0];
                              dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.maxQty];
                          }else if (j == 2){
                              RSColumnarModel * columnarmodel = self.columnarArray[0];
                              dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.rentedQty];
                          }else if (j == 3){
                              RSColumnarModel * columnarmodel = self.columnarArray[0];
                              dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.notRentedQty];
                          }else if (j == 4){
                              RSColumnarModel * columnarmodel = self.columnarArray[0];
                              dataLabel.text = [NSString stringWithFormat:@"%@%%",columnarmodel.rate];
                          }
                      }else if (i == 2){
                          dataLabel.font = [UIFont systemFontOfSize:13];
                          dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                          if (j == 0) {
                              dataLabel.text = @"大板商铺";
                          }else if (j == 1){
                              RSColumnarModel * columnarmodel = self.columnarArray[1];
                              dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.maxQty];
                          }else if (j == 2){
                              RSColumnarModel * columnarmodel = self.columnarArray[1];
                              dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.rentedQty];
                          }else if (j == 3){
                              RSColumnarModel * columnarmodel = self.columnarArray[1];
                              dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.notRentedQty];
                          }else if (j == 4){
                              RSColumnarModel * columnarmodel = self.columnarArray[1];
                              dataLabel.text = [NSString stringWithFormat:@"%@%%",columnarmodel.rate];
                          }
                      }
                      else if (i == 3){
                          dataLabel.font = [UIFont systemFontOfSize:13];
                          dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                          if (j == 0) {
                              dataLabel.text = @"条板商铺";
                          }else if (j == 1){
                              RSColumnarModel * columnarmodel = self.columnarArray[2];
                              dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.maxQty];
                          }else if (j == 2){
                              RSColumnarModel * columnarmodel = self.columnarArray[2];
                              dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.rentedQty];
                          }else if (j == 3){
                              RSColumnarModel * columnarmodel = self.columnarArray[2];
                              dataLabel.text = [NSString stringWithFormat:@"%ld",(long)columnarmodel.notRentedQty];
                          }else if (j == 4){
                              RSColumnarModel * columnarmodel = self.columnarArray[2];
                              dataLabel.text = [NSString stringWithFormat:@"%@%%",columnarmodel.rate];
                          }
                      }
                      dataLabel.frame = CGRectMake(j * (SCW - 48)/5, 0, (SCW - 48)/5, 44);
                      [dataView addSubview:dataLabel];
                  }
                  dataView.frame = CGRectMake(12, i * 44 + CGRectGetMaxY(titleThirdLabel.frame) + 18 , SCW - 48,  44);
                  [excelView addSubview:dataView];
              }
    }else{
        NSInteger number = 0;
        if (self.joinType == bmstock) {
            number = 5;
            titleLabel.text = @"荒料出入库,收款情况";
        }else if (self.joinType == slstock){
            number = 3;
            titleLabel.text = @"大板出入库,收款情况";
        }else if (self.joinType == ledger || self.joinType == totalLedger){
            number = 4;
            titleLabel.text = @"招商总账信息";
        }
        for (int i = 0; i < number; i++) {
            UIView * dataView = [[UIView alloc]init];
            if (i % 2 == 0) {
                dataView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
            }else{
                dataView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
            }
            for (int j = 0; j < 4; j++) {
                UILabel * dataLabel = [[UILabel alloc]init];
                dataLabel.numberOfLines = 0;
                dataLabel.textAlignment = NSTextAlignmentCenter;
                if (i == 0) {
                    dataLabel.font = [UIFont systemFontOfSize:15];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                    if (j == 0) {
                        if (self.joinType == bmstock) {
                            dataLabel.text = @"荒料";
                        }else if (self.joinType == slstock){
                            dataLabel.text = @"大板";
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = @"租金收款";
                        }
                    }else if (j == 1){
                        dataLabel.text = _contraseBtn.currentTitle;
                    }else if (j == 2){
                        dataLabel.text = _totalBtn.currentTitle;
                    }else if (j == 3){
                        dataLabel.text = @"差异比";
                    }
                }else if (i == 1){
                    dataLabel.font = [UIFont systemFontOfSize:13];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                    if (j == 0) {
                        if (self.joinType == bmstock) {
                            dataLabel.text = @"入库(立方)";
                        }else if (self.joinType == slstock){
                            dataLabel.text = @"入库(平方)";
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = @"大板收款(元)";
                        }
                    }else if (j == 1){
                        
                        RSColumnarModel * columnarmodel = self.columnarArray[1];
                        if (self.joinType == bmstock) {
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.volumeIn];
                        }else if (self.joinType == slstock){
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.areaIn];
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.slAmount];
//                            NSLog(@"=============3=================%@",columnarmodel.slAmount);
//                            NSLog(@"========32323=========%@",[self getTheCorrectNum:columnarmodel.slAmount]);
                        }
                        
                    }else if (j == 2){
                        RSColumnarModel * columnarmodel = self.columnarArray[0];
                        if (self.joinType == bmstock) {
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.volumeIn];
                        }else if (self.joinType == slstock){
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.areaIn];
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.slAmount];
                        }
                    }else if (j == 3){
                        RSColumnarModel * columnarmodel = self.columnarArray[2];
                        if (self.joinType == bmstock) {
                            dataLabel.text = [NSString stringWithFormat:@"%@%%",columnarmodel.volumeIn];
                        }else if (self.joinType == slstock){
                            dataLabel.text = [NSString stringWithFormat:@"%@%%",columnarmodel.areaIn];
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = [NSString stringWithFormat:@"%@%%",columnarmodel.slAmount];
                        }
                    }
                }else if (i == 2){
                    dataLabel.font = [UIFont systemFontOfSize:13];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                    if (j == 0) {
                        if (self.joinType == bmstock) {
                            dataLabel.text = @"出库(立方)";
                        }else if (self.joinType == slstock){
                            dataLabel.text = @"出库(平方)";
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = @"条板收款(元)";
                        }
                    }else if (j == 1){
                        RSColumnarModel * columnarmodel = self.columnarArray[1];
                        if (self.joinType == bmstock) {
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.volumeOut];
                        }else if (self.joinType == slstock){
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.areaOut];
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.smAmount];
                        }
                    }else if (j == 2){
                        RSColumnarModel * columnarmodel = self.columnarArray[0];
                        if (self.joinType == bmstock) {
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.volumeOut];
                        }else if (self.joinType == slstock){
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.areaOut];
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.smAmount];
                        }
                    }else if (j == 3){
                        RSColumnarModel * columnarmodel = self.columnarArray[2];
                        if (self.joinType == bmstock) {
                            dataLabel.text = [NSString stringWithFormat:@"%@%%",columnarmodel.volumeOut];
                        }else if (self.joinType == slstock){
                            dataLabel.text = [NSString stringWithFormat:@"%@%%",columnarmodel.areaOut];
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = [NSString stringWithFormat:@"%@%%",columnarmodel.smAmount];
                        }
                    }
                }else if (i == 3){
                    dataLabel.font = [UIFont systemFontOfSize:13];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                    if (j == 0) {
                        if (self.joinType == bmstock) {
                            dataLabel.text = @"收款(元)";
                        }else if (self.joinType == slstock){
                            dataLabel.text = @"";
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = @"业务楼收款(元)";
                        }
                    }else if (j == 1){
                        RSColumnarModel * columnarmodel = self.columnarArray[1];
                        if (self.joinType == bmstock) {
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.bmStorageFee];
                        }else if (self.joinType == slstock){
                            dataLabel.text = @"入库(平方)";
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.pmAmount];
                        }
                    }else if (j == 2){
                        RSColumnarModel * columnarmodel = self.columnarArray[0];
                        if (self.joinType == bmstock) {
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.bmStorageFee];
                        }else if (self.joinType == slstock){
                            dataLabel.text = @"入库(平方)";
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.pmAmount];
                        }
                    }else if (j == 3){
                        RSColumnarModel * columnarmodel = self.columnarArray[2];
                        if (self.joinType == bmstock) {
                            dataLabel.text = [NSString stringWithFormat:@"%@%%",columnarmodel.bmStorageFee];
                        }else if (self.joinType == slstock){
                            dataLabel.text = @"入库(平方)";
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text =[NSString stringWithFormat:@"%@%%",columnarmodel.pmAmount];
                        }
                    }
                }else if (i == 4){
                    dataLabel.font = [UIFont systemFontOfSize:13];
                    dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                    if (j == 0) {
                        if (self.joinType == bmstock) {
                            dataLabel.text = @"空地租金(元)";
                        }else if (self.joinType == slstock){
                            dataLabel.text = @"";
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = @"";
                        }
                    }else if (j == 1){
//                        RSColumnarModel * columnarmodel = self.columnarArray[0];
                        if (self.joinType == bmstock) {
//                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.bmSpaceRent];
                            dataLabel.text = @"";
                        }else if (self.joinType == slstock){
                            dataLabel.text = @"入库(平方)";
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = @"大板收款(元)";
                        }
                    }
                    else if (j == 2){
                        RSColumnarModel * columnarmodel = self.columnarArray[1];
                        if (self.joinType == bmstock) {
                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.bmSpaceRent];
                        }else if (self.joinType == slstock){
                            dataLabel.text = @"入库(平方)";
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = @"大板收款(元)";
                        }
                    }else if (j == 3){
//                        RSColumnarModel * columnarmodel = self.columnarArray[2];
                        if (self.joinType == bmstock) {
//                            dataLabel.text = [NSString stringWithFormat:@"%@",columnarmodel.bmSpaceRent];
                            dataLabel.text = @"";
                        }else if (self.joinType == slstock){
                            dataLabel.text = @"入库(平方)";
                        }else if (self.joinType == ledger || self.joinType == totalLedger){
                            dataLabel.text = @"大板收款(元)";
                        }
                    }
                }
                dataLabel.frame = CGRectMake(j * (SCW - 40)/4, 0, (SCW - 40)/4, 44);
                [dataView addSubview:dataLabel];
            }
            dataView.frame = CGRectMake(12, i * 44 + CGRectGetMaxY(titleLabel.frame) + 18 , SCW - 48,  44);
            [excelView addSubview:dataView];
        }
    }
    if (self.joinType == lease) {
//        [self.showView setupAutoHeightWithBottomView:excelView bottomMargin:20];
//        [self.showView layoutIfNeeded];
        self.tableview.tableHeaderView = self.showView;
        
    }else{
        [self showColumnChartView];
    }
}




- (void)showColumnChartView{
    
    ColumnChartView * columnChartView2 = [[ColumnChartView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(self.excelView.frame) + 12, SCW - 24, 317)];
    [self.showView addSubview:columnChartView2];
    columnChartView2.backgroundColor = [UIColor whiteColor];
    columnChartView2.isSingleColumn = NO;
    columnChartView2.scrollEnabled = YES;
    NSString * type = [NSString string];
    if (self.joinType == bmstock) {
        type = [NSString stringWithFormat:@"%@-%@荒料出入库情况",_beginBtn.currentTitle,_endBtn.currentTitle];
        columnChartView2.dataNameArray = @[@"入库(立方)",@"出库(立方)"];
        NSMutableArray * array = [NSMutableArray array];
        RSColumnarModel * columnarmodel = self.columnarArray[1];
        RSColumnarModel * columnarOutModel = self.columnarArray[0];
        //columnarmodel.volumeIn
        NSArray * dataInArray = @[[NSString stringWithFormat:@"%@",columnarmodel.volumeIn],[NSString stringWithFormat:@"%@",columnarOutModel.volumeIn]];
        NSArray * dataOutArray = @[[NSString stringWithFormat:@"%@",columnarmodel.volumeOut],[NSString stringWithFormat:@"%@",columnarOutModel.volumeOut]];
        [array addObject:dataInArray];
        [array addObject:dataOutArray];
        //        columnChartView2.dataArray = @[@[@"70000",@"60192"],@[@"84030",@"20662"]];
        columnChartView2.dataArray = array;
        columnChartView2.numberOfColumn = (int)array.count;
        columnChartView2.legendNameArray = @[_contraseBtn.currentTitle,_totalBtn.currentTitle];
        columnChartView2.columnWidth = @"50";
    }else if (self.joinType == slstock){
        type = [NSString stringWithFormat:@"%@-%@大板出入库情况",_beginBtn.currentTitle,_endBtn.currentTitle];
        columnChartView2.dataNameArray = @[@"入库(平方)",@"出库(平方)"];
        NSMutableArray * array = [NSMutableArray array];
        RSColumnarModel * columnarmodel = self.columnarArray[1];
        RSColumnarModel * columnarOutModel = self.columnarArray[0];
        NSArray * dataInArray = @[[NSString stringWithFormat:@"%@",columnarmodel.areaIn],[NSString stringWithFormat:@"%@",columnarOutModel.areaIn]];
        NSArray * dataOutArray = @[[NSString stringWithFormat:@"%@",columnarmodel.areaOut],[NSString stringWithFormat:@"%@",columnarOutModel.areaOut]];
        [array addObject:dataInArray];
        [array addObject:dataOutArray];
        //        columnChartView2.dataArray = @[@[@"70000",@"60192"],@[@"84030",@"20662"]];
        columnChartView2.dataArray = array;
        columnChartView2.numberOfColumn = (int)array.count;
        columnChartView2.columnWidth = @"50";
    columnChartView2.legendNameArray = @[_contraseBtn.currentTitle,_totalBtn.currentTitle];
    }else if (self.joinType == ledger || self.joinType == totalLedger){
        type = [NSString stringWithFormat:@"%@-%@招商总账单情况",_beginBtn.currentTitle,_endBtn.currentTitle];
        
        columnChartView2.dataNameArray = @[@"大板收款(元)",@"条板收款(元)",@"业务楼收款(元)"];
        NSMutableArray * array = [NSMutableArray array];
        RSColumnarModel * columnarmodel = self.columnarArray[1];
        RSColumnarModel * columnarOutModel = self.columnarArray[0];
        NSArray * dataInArray = @[[NSString stringWithFormat:@"%@",columnarmodel.slAmount],[NSString stringWithFormat:@"%@",columnarOutModel.slAmount]];
        
        NSArray * dataOutArray = @[[NSString stringWithFormat:@"%@",columnarmodel.smAmount],[NSString stringWithFormat:@"%@",columnarOutModel.smAmount]];
        
        NSArray * dataDifArray = @[[NSString stringWithFormat:@"%@",columnarmodel.pmAmount],[NSString stringWithFormat:@"%@",columnarOutModel.pmAmount]];
        [array addObject:dataInArray];
        [array addObject:dataOutArray];
        [array addObject:dataDifArray];
        //        columnChartView2.dataArray = @[@[@"70000",@"60192"],@[@"84030",@"20662"]];
        columnChartView2.dataArray = array;
        columnChartView2.numberOfColumn = 3;
        columnChartView2.columnWidth = @"40";
        columnChartView2.legendNameArray = @[_contraseBtn.currentTitle,_totalBtn.currentTitle];
//        columnChartView2.legendNameArray = @[@"1",@"2"];
    }
    
    columnChartView2.contentTitle = type;
    columnChartView2.isColumnGradientColor = YES;
    
    //    self.columnChartView2.columnColor = @"#fbca58";
    columnChartView2.legendPostion = LegendPositionTop;
    
    //    self.columnChartView2.legendColorArray = @[@"#27C79A",@"#FCC828"];
    columnChartView2.columnGradientColorArray = @[@[@"#27C79A",@"#27C79A"],@[@"#FCC828",@"#FCC828"]];//@[@[@"#2c8efa",@"#42cbfe"],@[@"#f6457d",@"#f88d5c"]];
    //    columnChartView2.dataNameArray = @[@"入库单(立方)",@"出库+加工领料(立方)"];
    columnChartView2.showDataLabel = YES;
    columnChartView2.showDataHorizontalLine = YES;
    columnChartView2.layer.cornerRadius = 6;
    [columnChartView2 resetData];
    
    
    NSString * signerType = [NSString string];
    NSArray * dataInArray = [NSArray array];
    if (self.joinType == bmstock) {
        signerType = [NSString stringWithFormat:@"%@-%@荒料收款",_beginBtn.currentTitle,_endBtn.currentTitle];
        //       columnChartView2.dataNameArray = @[_totalBtn.currentTitle,_contraseBtn.currentTitle];
        RSColumnarModel * columnarmodel = self.columnarArray[1];
        RSColumnarModel * columnarOutModel = self.columnarArray[0];
        dataInArray = @[[NSString stringWithFormat:@"%@",columnarmodel.bmStorageFee],[NSString stringWithFormat:@"%@",columnarOutModel.bmStorageFee]];
        
        
    }else if (self.joinType == ledger || self.joinType == totalLedger){
        signerType = [NSString stringWithFormat:@"%@-%@招商总账单情况",_beginBtn.currentTitle,_endBtn.currentTitle];
    }
    
    ColumnChartView * columnChartView = [[ColumnChartView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(columnChartView2.frame) + 10, SCW - 24, 272) andDataNameArray:@[_contraseBtn.currentTitle,_totalBtn.currentTitle] andDataArray:dataInArray andColumnColor:@"#fbca58"];
    columnChartView.isSingleColumn = YES;
    columnChartView.contentTitle = signerType;
    columnChartView.legendPostion = LegendPositionTop;
    columnChartView.scrollEnabled = NO;
    columnChartView.columnWidth = @"24.5";
    columnChartView.legendNameArray = @[_contraseBtn.currentTitle,_totalBtn.currentTitle];
    columnChartView.backgroundColor = [UIColor whiteColor];
    columnChartView.isColumnGradientColor = YES;
    columnChartView.columnGradientColorArray = @[@"#27C79A",@"#FCC828"];
    [self.showView addSubview:columnChartView];
    columnChartView.showDataLabel = YES;
    columnChartView.layer.cornerRadius = 6;
    columnChartView.showDataHorizontalLine = YES;
    [columnChartView resetData];
    
    if (self.joinType == bmstock) {
        
//        [self.showView setupAutoHeightWithBottomView:columnChartView bottomMargin:20];
    }else if (self.joinType == slstock){
        [columnChartView removeFromSuperview];
//        [self.showView setupAutoHeightWithBottomView:columnChartView2 bottomMargin:20];
    }else if (self.joinType == ledger || self.joinType == totalLedger){
        [columnChartView removeFromSuperview];
//        [self.showView setupAutoHeightWithBottomView:columnChartView2 bottomMargin:20];
    }
//    [self.showView layoutIfNeeded];
    self.tableview.tableHeaderView = self.showView;
}

//选择时间
- (void)choiceTimeAction:(UIButton *)choiceTimeBtn{
    HQPickerView *picker = [[HQPickerView alloc]initWithFrame:CGRectMake(0, 0, SCW, 300)];
    if (choiceTimeBtn.tag == 1 || choiceTimeBtn.tag == 2) {
        //只能选择年份
        for (int i = 0; i < 7; i++) {
            [picker.customArr addObject:[NSString stringWithFormat:@"%d",2012 + i]];
        }
        NSString * res = [self acquisitionTimeType:1];
        if ([res intValue] > [picker.customArr.lastObject intValue]) {
            int count =  [res intValue] - [picker.customArr.lastObject intValue];
            for (int j = 0; j < count; j++) {
                [picker.customArr addObject:[NSString stringWithFormat:@"%d",[picker.customArr.lastObject intValue] + 1]];
            }
        }
    }else{
        //只能选择月份
        for (int i = 0; i < 12; i++) {
            NSString * time = [NSString stringWithFormat:@"%d",1 + i];
            if (time.length <= 1) {
                time = [NSString stringWithFormat:@"0%@",time];
            }
            [picker.customArr addObject:time];
        }
    }
    //    [self.view addSubview:picker];
    [[UIApplication sharedApplication].keyWindow addSubview:picker];
    //    [picker bringSubviewToFront:self.view];
    picker.pickBlock = ^(UIPickerView *pickerView, NSString *text) {
        
        //这边要判断是月份还是年
        if (choiceTimeBtn.tag == 3 || choiceTimeBtn.tag == 4) {
            //这边是月份
            NSString * temp = choiceTimeBtn.currentTitle;
            if (temp.length <= 1) {
                temp = [NSString stringWithFormat:@"0%@",temp];
            }
            [choiceTimeBtn setTitle:text forState:UIControlStateNormal];
            if ([self.beginBtn.currentTitle integerValue] >= [self.endBtn.currentTitle integerValue] ) {
                jxt_showToastTitle(@"起始月份不能大于终止月份", 0.75);
                [choiceTimeBtn setTitle:temp forState:UIControlStateNormal];
            }else{
                [choiceTimeBtn setTitle:text forState:UIControlStateNormal];
            }
        }else{
            //这边是年
            if (self.joinType == lease) {
                
                 [choiceTimeBtn setTitle:text forState:UIControlStateNormal];
                
            }else{
                NSString * temp = choiceTimeBtn.currentTitle;
                //text
                [choiceTimeBtn setTitle:text forState:UIControlStateNormal];
                if ([self.totalBtn.currentTitle isEqualToString:self.contraseBtn.currentTitle]) {
                    jxt_showToastTitle(@"统计和对比不能相同", 0.75);
                  [choiceTimeBtn setTitle:temp forState:UIControlStateNormal];
                }else{
                   [choiceTimeBtn setTitle:text forState:UIControlStateNormal];
                }
            }
        }
    };
}


- (void)deleteAction:(UIButton *)deleteBtn{
    [self.objectBtn setTitle:@"结算对象" forState:UIControlStateNormal];
    self.tempID = 0;
    [self.objectBtn setTitleColor:[UIColor colorWithHexColorStr:@"#D5D5D5"] forState:UIControlStateNormal];
    deleteBtn.hidden = YES;
}

@end
