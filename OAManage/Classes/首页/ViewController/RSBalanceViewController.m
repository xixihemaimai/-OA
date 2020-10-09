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

@interface RSBalanceViewController ()

@property (nonatomic,strong)UIButton * beginBtn;

@property (nonatomic,strong)UIButton * endBtn;


@property(nonatomic,strong) DIYSystemDatePickerView *datePickerView;

@end



@implementation RSBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"余额表详情";
    self.emptyView.hidden = YES;
    
    self.tableview.scrollEnabled = NO;
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [self setCustomHeaderView];
}


- (void)setCustomHeaderView{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    
    UIView * contractView = [[UIView alloc]init];
    [headerView addSubview:contractView];

    contractView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    contractView.layer.cornerRadius = 6;
    contractView.layer.shadowColor = [UIColor colorWithRed:213/255.0 green:211/255.0 blue:211/255.0 alpha:0.5].CGColor;
    contractView.layer.shadowOffset = CGSizeMake(0,0);
    contractView.layer.shadowOpacity = 1;
    contractView.layer.shadowRadius = 5;
    
    contractView.sd_layout
    .leftSpaceToView(headerView, 12)
    .topSpaceToView(headerView, 12)
    .rightSpaceToView(headerView, 12)
    .heightIs(133);
    
    
    //合同标题
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"结算对象";
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#D5D5D5"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [contractView addSubview:titleLabel];
    
    
    titleLabel.sd_layout
    .leftSpaceToView(contractView, 22.5)
    .widthIs(60)
    .topSpaceToView(contractView, 21)
    .heightIs(20);
    
    
    //合同标题的标签
    UITextField * titleField = [[UITextField alloc]init];
    [contractView addSubview:titleField];
    
    titleField.sd_layout
    .leftSpaceToView(titleLabel, 5)
    .rightSpaceToView(contractView, 22.5)
    .heightIs(20)
    .topEqualToView(titleLabel);
    
    //分隔线
    UIView * contractTitleView = [[UIView alloc]init];
    contractTitleView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [contractView addSubview:contractTitleView];
    
    contractTitleView.sd_layout
    .leftEqualToView(titleLabel)
    .rightEqualToView(titleField)
    .heightIs(0.5)
    .topSpaceToView(titleLabel, 6);
    
    //会计起始时间
    UILabel * timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"会计起始时间";
    timeLabel.textColor = [UIColor colorWithHexColorStr:@"#D5D5D5"];
    timeLabel.font = [UIFont systemFontOfSize:12];
    [contractView addSubview:timeLabel];
    
    timeLabel.sd_layout
    .topSpaceToView(contractTitleView, 8.5)
    .heightIs(16.5)
    .widthIs(100)
    .leftEqualToView(contractTitleView);
    
    UIButton * beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [beginBtn setTitle:@"2019-02-11" forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    beginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [contractView addSubview:beginBtn];
    beginBtn.tag = 0;
    [beginBtn addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
    beginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _beginBtn = beginBtn;
    
    
    beginBtn.sd_layout
    .leftEqualToView(timeLabel)
    .topSpaceToView(timeLabel, 0)
    .rightEqualToView(timeLabel)
    .heightIs(24);
//    .widthIs(120);
    
    
    //会计结束时间
    UILabel * timeEndLabel = [[UILabel alloc]init];
    timeEndLabel.text = @"会计结束时间";
    timeEndLabel.textColor = [UIColor colorWithHexColorStr:@"#D5D5D5"];
    timeEndLabel.font = [UIFont systemFontOfSize:12];
    [contractView addSubview:timeEndLabel];
    
    timeEndLabel.sd_layout
    .topSpaceToView(contractTitleView, 8.5)
    .rightSpaceToView(contractView, 22.5)
    .heightIs(16.5)
    .widthIs(100);
    
    UIButton * endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endBtn setTitle:@"2019-02-11" forState:UIControlStateNormal];
    [endBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    endBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    endBtn.tag = 1;
    [endBtn addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [contractView addSubview:endBtn];
    endBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _endBtn = endBtn;
    
    endBtn.sd_layout
    .rightEqualToView(timeEndLabel)
    .topSpaceToView(timeEndLabel, 0)
    .heightIs(24)
    .leftEqualToView(timeEndLabel);

    //分隔线
    UIView * contractTimeView = [[UIView alloc]init];
    contractTimeView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [contractView addSubview:contractTimeView];
    
    contractTimeView.sd_layout
    .leftEqualToView(timeLabel)
    .rightEqualToView(timeEndLabel)
    .topSpaceToView(beginBtn, 0)
    .heightIs(0.5);
    
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
    [contractView addSubview:searchBtn];
    
    searchBtn.sd_layout
    .rightSpaceToView(contractView, 22.5)
    .topSpaceToView(contractTimeView, 7.5)
    .heightIs(23)
    .widthIs(45);
    
    searchBtn.layer.cornerRadius = 2.5;
    searchBtn.layer.masksToBounds = YES;
    
    NSMutableArray *dic=[[NSMutableArray alloc] init];
    //修改表格显示内容标题 只需要在BCContentOB文件中修改属性以及其他
    //调整第一列的宽度 可在MyTableListView.m中最上面修改 FIRSTCELLWIDTH
    //调整每一行的高度 可在MyTableListView.m中最上面修改 ALLCELLHIGH
    //调整第一列后的宽度 可在MyTableListView.m中最上面修改 OTHERCELLWIDTH
    //点击下面按钮 可增加一行显示在最上面 如有需要可自行 调整更新以及添加代理等
    //若有其他调整 可自调
    for (int i = 0; i < 15; i++) {
        BCContentOB *ddd=[[BCContentOB alloc] init];
        ddd.name=[NSString stringWithFormat:@"%d",i];
        ddd.attributeFirst=@"1";
        ddd.attributeSecond=@"2";
        ddd.attributeThird=@"3";
        ddd.attributeFourth=@"4";
        ddd.attributeFifth=@"5";
        ddd.attributeSixth=@"6";
        ddd.attributeSeventh=@"7";
        ddd.attributeEighth=@"8";
        [dic addObject:ddd];
    }
    RSWeakself
    MyTableListView * tablelist = [[MyTableListView alloc] initWithFrame:CGRectMake(13, CGRectGetMaxY(contractView.frame) + 20 , SCW - 13, SCH - CGRectGetMaxY(contractView.frame) - 20 ) andContentDicArray:dic];
    //tablelist.delegate=self;
    [headerView addSubview:tablelist];
    //设置代理作用:选中某一个 可自行修改
    tablelist.detailBlock = ^(NSInteger index) {
        NSLog(@"=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-%ld",index);
        RSPopViewController * popVc = [[RSPopViewController alloc]init];
        [weakSelf yc_bottomPresentController:popVc presentedHeight:234 completeHandle:^(BOOL presented) {
        }];
    };
    [headerView setupAutoHeightWithBottomView:tablelist bottomMargin:50];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    _datePickerView = [[DIYSystemDatePickerView alloc]initWithType:DIYSystemDatePickerENUM0
                                                   getSelectBeginTime:^(NSString *beginTimeStr) {
        [weakSelf.beginBtn setTitle:beginTimeStr forState:(UIControlStateNormal)];
                                                   } getSelectEndTime:^(NSString *endTimeStr) {
        [weakSelf.endBtn setTitle:endTimeStr forState:(UIControlStateNormal)];
                                                   }];
   [self.view addSubview:_datePickerView];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if ([self.title isEqualToString:@"报表管理"]) {
//        return 5;
//    }else{
        return 4;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * BALANCECELLID = @"BALANCECELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BALANCECELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:BALANCECELLID];
    }
    return cell;
}



@end
