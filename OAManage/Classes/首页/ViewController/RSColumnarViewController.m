//
//  RSColumnarViewController.m
//  OAManage
//
//  Created by mac on 2020/9/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSColumnarViewController.h"
#import "ColumnChartView.h"
#import "HQPickerView.h"


@interface RSColumnarViewController ()

@property (nonatomic,strong) UIView * headerView;

@property (nonatomic,strong) UIView * choiceTime;

@property (nonatomic,strong) UIView * excelView;

@property (nonatomic,strong) UIButton * totalBtn;

@property (nonatomic,strong) UIButton * contraseBtn;

@property (nonatomic,strong) UIButton * beginBtn;

@property (nonatomic,strong) UIButton * endBtn;

@end

@implementation RSColumnarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tableview removeFromSuperview];
    //self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    self.emptyView.hidden = YES;
    
    [self customChoiceTimeView];
    
    self.title = @"荒料出入库数据总结";
    
    
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
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F5F5"];
    _headerView = headerView;
    
    UIView * choiceTime = [[UIView alloc]init];
    choiceTime.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [headerView addSubview:choiceTime];
    _choiceTime = choiceTime;
    //统计年份
    UILabel * totalYearLabel = [[UILabel alloc]init];
    totalYearLabel.text = @"统计年份";
    totalYearLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    totalYearLabel.font = [UIFont systemFontOfSize:15];
    [choiceTime addSubview:totalYearLabel];

    UIButton * totalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [totalBtn setTitle:@"2019" forState:UIControlStateNormal];
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
    
    NSString * time = [self acquisitionTimeType:0];
//    NSLog(@"======================%@",time);
    
    UIButton * contraseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contraseBtn setTitle:[time substringToIndex:4] forState:UIControlStateNormal];
    [contraseBtn setImage:[UIImage imageNamed:@"向下"] forState:UIControlStateNormal];
    contraseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    contraseBtn.tag = 2;
    [contraseBtn addTarget:self action:@selector(choiceTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [contraseBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [contraseBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    [choiceTime addSubview:contraseBtn];
    _contraseBtn = contraseBtn;
    
    choiceTime.sd_layout
    .leftSpaceToView(headerView, 0)
    .topSpaceToView(headerView, 0)
    .rightSpaceToView(headerView, 0)
    .heightIs(95);
    
    totalYearLabel.sd_layout
    .leftSpaceToView(choiceTime, 12)
    .topSpaceToView(choiceTime, 15)
    .heightIs(21)
    .widthIs(62);
    
    totalBtn.sd_layout
    .leftSpaceToView(totalYearLabel, 9.5)
    .topSpaceToView(choiceTime, 12)
    .heightIs(27)
    .widthIs(70);
    
    totalBtn.titleLabel.sd_layout
    .leftSpaceToView(totalBtn, 11)
    .centerYEqualToView(totalBtn)
    .widthIs(40);
    
    totalBtn.imageView.sd_layout
    .leftSpaceToView(totalBtn.titleLabel, 0)
    .centerYEqualToView(totalBtn)
    .widthIs(10)
    .heightIs(5.5);
    
    contrast.sd_layout
    .leftSpaceToView(totalBtn, 19)
    .topEqualToView(totalYearLabel)
    .bottomEqualToView(totalYearLabel)
    .widthIs(62);
    
    contraseBtn.sd_layout
    .leftSpaceToView(contrast, 9.5)
    .topSpaceToView(choiceTime, 12)
    .heightIs(27)
    .widthIs(70);
    
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
    [beginBtn setTitle:@"01月" forState:UIControlStateNormal];
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
    [endBtn setTitle:[NSString stringWithFormat:@"%@月",[time substringFromIndex:time.length - 2]] forState:UIControlStateNormal];
    [endBtn setImage:[UIImage imageNamed:@"向下"] forState:UIControlStateNormal];
    endBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    endBtn.tag = 4;
    [endBtn addTarget:self action:@selector(choiceTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [endBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [endBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    [choiceTime addSubview:endBtn];
    _endBtn = endBtn;
    
    totalMonthLabel.sd_layout
    .leftEqualToView(totalYearLabel)
    .topSpaceToView(totalYearLabel, 16)
    .rightEqualToView(totalYearLabel)
    .heightIs(21);
    
    beginBtn.sd_layout
    .leftEqualToView(totalBtn)
    .rightEqualToView(totalBtn)
    .topSpaceToView(totalBtn, 9.5)
    .heightIs(27);
    
    midView.sd_layout
    .leftSpaceToView(beginBtn, 11.5)
    .heightIs(0.5)
    .widthIs(9)
    .topSpaceToView(totalBtn, 23);
    
    endBtn.sd_layout
    .leftSpaceToView(midView, 12.5)
    .topEqualToView(beginBtn)
    .bottomEqualToView(beginBtn)
    .widthIs(70);
    
    beginBtn.titleLabel.sd_layout
    .leftSpaceToView(beginBtn, 11)
    .centerYEqualToView(beginBtn)
    .widthIs(40);
    
    beginBtn.imageView.sd_layout
    .leftSpaceToView(beginBtn.titleLabel, 0)
    .centerYEqualToView(beginBtn)
    .widthIs(10)
    .heightIs(5.5);
    
    endBtn.titleLabel.sd_layout
    .leftSpaceToView(endBtn, 11)
    .centerYEqualToView(endBtn)
    .widthIs(35);
    
    endBtn.imageView.sd_layout
    .leftSpaceToView(endBtn.titleLabel, 0)
    .centerYEqualToView(endBtn)
    .widthIs(10)
    .heightIs(5.5);
    
    totalBtn.layer.cornerRadius = 13.5;
    contraseBtn.layer.cornerRadius = 13.5;
    beginBtn.layer.cornerRadius = 13.5;
    endBtn.layer.cornerRadius = 13.5;
    
    [self showEexcelView];
    
    [self showColumnChartView];
    
}



- (void)showEexcelView{
    
    UIView * excelView = [[UIView alloc]init];
    excelView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    excelView.frame = CGRectMake(12, CGRectGetMaxY(self.choiceTime.frame) + 20, SCW - 24, 293);
    excelView.layer.cornerRadius = 6;
    [self.headerView addSubview:excelView];
    _excelView = excelView;
       
    UIView * leftView = [[UIView alloc]init];
    leftView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    leftView.frame = CGRectMake(0, 14, 4, 20);
    [excelView addSubview:leftView];
       
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"荒料出入库,收款情况";
    titleLabel.font = [UIFont fontWithName:@"PingFangSC" size: 16];
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    titleLabel.frame = CGRectMake(CGRectGetMaxX(leftView.frame) + 12, 14, 165, 20);
    [excelView addSubview:titleLabel];

    for (int i = 0; i < 5; i++) {
        UIView * dataView = [[UIView alloc]init];
        if (i % 2 == 0) {
            dataView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
        }else{
            dataView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        }
        for (int j = 0; j < 4; j++) {
            UILabel * dataLabel = [[UILabel alloc]init];
            dataLabel.textAlignment = NSTextAlignmentCenter;
            if (i == 0) {
                dataLabel.font = [UIFont systemFontOfSize:15];
                dataLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
                if (j == 0) {
                    dataLabel.text = @"荒料";
                }else if (j == 1){
                    dataLabel.text = @"2019";
                }else if (j == 2){
                    dataLabel.text = @"2020";
                }else if (j == 3){
                    dataLabel.text = @"差异比";
                }
               }else if (i == 1){
                dataLabel.font = [UIFont systemFontOfSize:13];
                dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                   if (j == 0) {
                       dataLabel.text = @"入库(立方)";
                   }else if (j == 1){
                       dataLabel.text = @"87560.398";
                   }else if (j == 2){
                       dataLabel.text = @"88050.404";
                   }else if (j == 3){
                       dataLabel.text = @"0.56%";
                   }
               }else if (i == 2){
                   dataLabel.font = [UIFont systemFontOfSize:13];
                   dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                   if (j == 0) {
                       dataLabel.text = @"出库(立方)";
                   }else if (j == 1){
                       dataLabel.text = @"57944.33";
                   }else if (j == 2){
                       dataLabel.text = @"69088.449";
                   }else if (j == 3){
                       dataLabel.text = @"19.23%";
                   }
               }else if (i == 3){
                   dataLabel.font = [UIFont systemFontOfSize:13];
                   dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                   if (j == 0) {
                       dataLabel.text = @"收款(元)";
                   }else if (j == 1){
                       dataLabel.text = @"11902470.41";
                   }else if (j == 2){
                       dataLabel.text = @"9662225.51";
                   }else if (j == 3){
                       dataLabel.text = @"-18.82";
                   }
               }else if (i == 4){
                   dataLabel.font = [UIFont systemFontOfSize:13];
                   dataLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
                   if (j == 0) {
                       dataLabel.text = @"空地租金(元)";
                   }else if (j == 1){
                       dataLabel.text = @"18989990";
                   }
               }
               dataLabel.frame = CGRectMake(j * (SCW - 48)/4, 0, (SCW - 48)/4, 44);
               [dataView addSubview:dataLabel];
           }
           dataView.frame = CGRectMake(12, i * 44 + CGRectGetMaxY(titleLabel.frame) + 18 , SCW - 48,  44);
           [excelView addSubview:dataView];
       }
}

- (void)showColumnChartView{
    
    ColumnChartView * columnChartView2 = [[ColumnChartView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(self.excelView.frame) + 12, SCW - 24, 317)];
    [self.headerView addSubview:columnChartView2];
    columnChartView2.backgroundColor = [UIColor whiteColor];
    columnChartView2.isSingleColumn = NO;
    columnChartView2.scrollEnabled = YES;
    columnChartView2.isColumnGradientColor = YES;
    columnChartView2.columnWidth = @"50";
       //    self.columnChartView2.columnColor = @"#fbca58";
    columnChartView2.legendPostion = LegendPositionTop;
    columnChartView2.legendNameArray = @[@"2019年",@"2020年"];
       //    self.columnChartView2.legendColorArray = @[@"#27C79A",@"#FCC828"];
    columnChartView2.columnGradientColorArray = @[@[@"#27C79A",@"#27C79A"],@[@"#FCC828",@"#FCC828"]];//@[@[@"#2c8efa",@"#42cbfe"],@[@"#f6457d",@"#f88d5c"]];
    columnChartView2.dataNameArray = @[@"入库单(立方)",@"出库+加工领料(立方)",@"荒料出库(立方)",@"荒料入库(立方)"];
    columnChartView2.numberOfColumn = 2;
    columnChartView2.dataArray = @[@[@"70000",@"60192"],@[@"84030",@"20662"],@[@"23123",@"43252"],@[@"78976",@"78876"]];
    columnChartView2.showDataLabel = YES;
    columnChartView2.showDataHorizontalLine = YES;
    columnChartView2.layer.cornerRadius = 6;
    [columnChartView2 resetData];
    
    ColumnChartView * columnChartView = [[ColumnChartView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(columnChartView2.frame) + 10, SCW - 24, 272) andDataNameArray:@[@"2019",@"2020"] andDataArray:@[@"11902470.41",@"7662225.51"] andColumnColor:@"#fbca58"];
    columnChartView.isSingleColumn = YES;
    columnChartView.legendPostion = LegendPositionTop;
    columnChartView.scrollEnabled = NO;
    columnChartView.columnWidth = @"24.5";
    columnChartView.legendNameArray = @[@"2019年",@"2020年"];
    columnChartView.backgroundColor = [UIColor whiteColor];
    columnChartView.isColumnGradientColor = YES;
    columnChartView.columnGradientColorArray = @[@"#27C79A",@"#FCC828"];
    [self.headerView addSubview:columnChartView];
    columnChartView.showDataLabel = YES;
    columnChartView.layer.cornerRadius = 6;
    columnChartView.showDataHorizontalLine = YES;
    [columnChartView resetData];
    
    [self.headerView setupAutoHeightWithBottomView:columnChartView bottomMargin:20];
    [self.headerView layoutIfNeeded];
    self.tableview.tableHeaderView = self.headerView;
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
            [picker.customArr addObject:[NSString stringWithFormat:@"%d月",1 + i]];
        }
    }
    [self.view addSubview:picker];
    [picker bringSubviewToFront:self.view];
    picker.pickBlock = ^(UIPickerView *pickerView, NSString *text) {
        [choiceTimeBtn setTitle:text forState:UIControlStateNormal];
    };
}


@end
