//
//  RSServiceViewController.m
//  OAManage
//
//  Created by mac on 2019/11/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSServiceViewController.h"
//头部
#import "RSServiceHeaderView.h"
//cell
#import "RSServiceCell.h"
//广告轮播
#import "ZKImgRunLoopView.h"
//通讯录
#import "RSMailListViewController.h"
//最新公告转动工具类
#import "GYRollingNoticeView.h"
//自定义公告旋转cell
#import "RSGyRollingCell.h"
//工作日志
#import "RSAuditedViewController.h"
//更多公告
#import "RSNoticeViewController.h"

@interface RSServiceViewController ()<GYRollingNoticeViewDelegate,GYRollingNoticeViewDataSource>
{
    NSArray *_arr0;
    
    GYRollingNoticeView * _noticeView;
}

@end

@implementation RSServiceViewController




static NSString * SERVICEHEADERVIEWID = @"SERVICEHEADERVIEWID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.title = @"首页";
    
    self.emptyView.hidden = YES;
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    
    
    UIButton * menuBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [menuBtn setImage:[UIImage imageNamed:@"通讯录复制"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(showPhoneContentMenu:) forControlEvents:UIControlEventTouchUpInside];
            //menuBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:menuBtn];
        self.navigationItem.leftBarButtonItem = item;
    
    
    _arr0 = @[@{@"arr": @[@{@"tag": @"奖惩", @"title": @"关于某一位优秀员工的奖励…"}, @{@"tag": @"通知", @"title": @"关于海西OA重新升级相关通知…"}]},@{@"arr": @[@{@"tag": @"其他", @"title": @"三星中端新机改名，全面屏火力全开"}, @{@"tag": @"通知", @"title": @"关于海西OA重新升级相关通知…"}]},@{@"arr": @[@{@"tag": @"奖惩", @"title": @"关于某一位优秀员工的奖励…"}, @{@"tag": @"通知", @"title": @"关于海西OA重新升级相关通知…"}]}];
       
       
  
    NSMutableArray * array = [NSMutableArray arrayWithObjects:@"123",@"456",@"789",@"qwe",@"nba",@"cba",@"cuba",@"wnba",@"wcba",@"nb",nil];
    NSArray * array1 = [self splitArray:array withSubSize:2];
    
    NSLog(@"++++++++++++++++++%@",array1);
    
    
    NSString * day = [self weekDayStr:@"2019-11-22"];
    
    NSLog(@"-------------------%@",day);
    
    [self showCustomHeaderview];
}




- (void)showCustomHeaderview{
    UIView * headerView = [[UIView alloc]init];
    ZKImgRunLoopView * kimageRun = [[ZKImgRunLoopView alloc]initWithFrame:CGRectMake(15, 13, SCW - 30, 160) placeholderImg:[UIImage imageNamed:@"背景"]];
    kimageRun.pageControl.numberOfPages = 3;
    kimageRun.pageControl.currentPage = 0;
    kimageRun.pageControl.marginSpacing = 8.5;
    kimageRun.pageControl.controlSize = CGSizeMake(5, 5);
    NSMutableArray * array = [NSMutableArray arrayWithObjects:@"背景",@"背景", @"背景",nil];
    kimageRun.imgArray = array;
    [kimageRun touchImageIndexBlock:^(NSInteger index) {
        
    }];
    kimageRun.layer.cornerRadius = 4;
    kimageRun.layer.masksToBounds = YES;
    [headerView addSubview:kimageRun];
    
    //公告
    
    UIImageView * noticeImage = [[UIImageView alloc]init];
    noticeImage.image = [UIImage imageNamed:@"最新 公告"];
    [headerView addSubview:noticeImage];
    
    noticeImage.sd_layout
    .leftSpaceToView(headerView, 15)
    .topSpaceToView(kimageRun, 10)
    .widthIs(33)
    .heightEqualToWidth();
    
    //分割线
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [headerView addSubview:midView];
    
    
    midView.sd_layout
    .leftSpaceToView(noticeImage, 10)
    .topEqualToView(noticeImage)
    .bottomEqualToView(noticeImage)
    .widthIs(0.5);
    
   
    
    //这边是公告
    GYRollingNoticeView * noticeView = [[GYRollingNoticeView alloc]init];
    noticeView.dataSource = self;
    noticeView.delegate = self;
    noticeView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [noticeView registerClass:[RSGyRollingCell class] forCellReuseIdentifier:@"RSGyRollingCell"];
    [noticeView reloadDataAndStartRoll];
    [headerView addSubview:noticeView];
    
    noticeView.sd_layout
    .leftSpaceToView(midView, 9.5)
    .topEqualToView(midView)
    .bottomEqualToView(midView)
    .rightSpaceToView(headerView, 15);
    _noticeView = noticeView;
    
    
    
    
    
    //下分割线
    UIView * newMidView = [[UIView alloc]init];
    newMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [headerView addSubview:newMidView];
    
    newMidView.sd_layout
    .leftEqualToView(noticeImage)
    .rightSpaceToView(headerView, 15)
    .topSpaceToView(noticeImage, 9.5)
    .heightIs(0.5);
    
    
    //工作日志和体系文件
    UIButton * firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [headerView addSubview:firstBtn];
    firstBtn.tag = 1;
    [firstBtn addTarget:self action:@selector(jumpWorkContentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    firstBtn.sd_layout
    .leftSpaceToView(headerView, 0)
    .topSpaceToView(newMidView, 0)
    .widthIs(SCW/2)
    .heightIs(76);
    
    UIImageView * firstImage = [[UIImageView alloc]init];
    firstImage.image = [UIImage imageNamed:@"画板1"];
    [firstBtn addSubview:firstImage];
    
    firstImage.sd_layout
    .leftSpaceToView(firstBtn, 30)
    .topSpaceToView(firstBtn, 22)
    .bottomSpaceToView(firstBtn, 22)
    .widthIs(28.5);
    
    UILabel * firstLabel = [[UILabel alloc]init];
    firstLabel.text = @"工作日志";
    firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    firstLabel.font = [UIFont systemFontOfSize:16];
    firstLabel.textAlignment = NSTextAlignmentLeft;
    [firstBtn addSubview:firstLabel];
    
    firstLabel.sd_layout
    .leftSpaceToView(firstImage, 11)
    .topSpaceToView(firstBtn,16)
    .heightIs(22.5)
    .rightSpaceToView(firstBtn, 0);
    
    
    UILabel * firstDetailLabel = [[UILabel alloc]init];
    firstDetailLabel.text = @"填写工作日志";
    firstDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    firstDetailLabel.font = [UIFont systemFontOfSize:10];
    firstDetailLabel.textAlignment = NSTextAlignmentLeft;
    [firstBtn addSubview:firstDetailLabel];
    
    firstDetailLabel.sd_layout
    .leftEqualToView(firstLabel)
    .rightEqualToView(firstLabel)
    .topSpaceToView(firstLabel, 0.5)
    .heightIs(14);

  
    UIButton * secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [headerView addSubview:secondBtn];
    secondBtn.tag = 2;
    [secondBtn addTarget:self action:@selector(jumpWorkContentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    secondBtn.sd_layout
    .leftSpaceToView(firstBtn, 0)
    .topEqualToView(firstBtn)
    .rightSpaceToView(headerView, 0)
    .bottomEqualToView(firstBtn);
    
    
    
    UIImageView * secondImage = [[UIImageView alloc]init];
    secondImage.image = [UIImage imageNamed:@"画板复制10"];
    [secondBtn addSubview:secondImage];
    
    secondImage.sd_layout
    .leftSpaceToView(secondBtn, 30)
    .topSpaceToView(secondBtn, 22)
    .bottomSpaceToView(secondBtn, 22)
    .widthIs(28.5);
    
    UILabel * secondLabel = [[UILabel alloc]init];
    secondLabel.text = @"体系文件";
    secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    secondLabel.font = [UIFont systemFontOfSize:16];
    secondLabel.textAlignment = NSTextAlignmentLeft;
    [secondBtn addSubview:secondLabel];
    
    secondLabel.sd_layout
    .leftSpaceToView(secondImage, 11)
    .topSpaceToView(secondBtn,16)
    .heightIs(22.5)
    .rightSpaceToView(secondBtn, 0);
    
    
    UILabel * secondDetailLabel = [[UILabel alloc]init];
    secondDetailLabel.text = @"查看公司相关文件";
    secondDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    secondDetailLabel.font = [UIFont systemFontOfSize:10];
    secondDetailLabel.textAlignment = NSTextAlignmentLeft;
    [secondBtn addSubview:secondDetailLabel];
    
    secondDetailLabel.sd_layout
    .leftEqualToView(secondLabel)
    .rightEqualToView(secondLabel)
    .topSpaceToView(secondLabel, 0.5)
    .heightIs(14);
    
    
    
    
    
    [headerView setupAutoHeightWithBottomView:firstBtn bottomMargin:0];
    
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    
    
    
}



//通讯录
- (void)showPhoneContentMenu:(UIButton *)menuBtn{
    RSMailListViewController * mailVc = [[RSMailListViewController alloc]init];
    [self.navigationController pushViewController:mailVc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSServiceHeaderView * serviceHeader = [[RSServiceHeaderView alloc]initWithReuseIdentifier:SERVICEHEADERVIEWID];
    [serviceHeader.moreBtn addTarget:self action:@selector(moreNoticeAction:) forControlEvents:UIControlEventTouchUpInside];
    return serviceHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * FIRSTCELLID = @"FIRSTCELLID";
    RSServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:FIRSTCELLID];
    if (!cell) {
        cell = [[RSServiceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:FIRSTCELLID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView
{
    return _arr0.count;
}

- (__kindof GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    RSGyRollingCell * cell = [rollingView dequeueReusableCellWithIdentifier:@"RSGyRollingCell"];
    NSDictionary * dic = _arr0[index];
    cell.tagImageView.image = [UIImage imageNamed:[dic[@"arr"] firstObject][@"tag"]];
    cell.titelLabel.text = [dic[@"arr"] firstObject][@"title"];
    cell.secondImageView.image = [UIImage imageNamed:[dic[@"arr"] lastObject][@"tag"]];
    cell.secondtitelLabel.text = [dic[@"arr"] lastObject][@"title"];
    return cell;
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index andRow:(NSInteger)row
{
    
    
    NSLog(@"点击的第几组: %lu 第几行:%lu", (unsigned long)index,(unsigned long)row);
}


//FIXME:更多
- (void)moreNoticeAction:(UIButton *)moreBtn{
    RSNoticeViewController * noticeVc = [[RSNoticeViewController alloc]init];
    [self.navigationController pushViewController:noticeVc animated:YES];
}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_noticeView stopRoll];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_noticeView reloadDataAndStartRoll];
}


- (void)jumpWorkContentAction:(UIButton *)btn{
    if (btn.tag == 1) {
        NSLog(@"工作日志");
        RSAuditedViewController * auditedVc = [[RSAuditedViewController alloc]init];
        [self.navigationController pushViewController:auditedVc animated:YES];
    }else{
        NSLog(@"体系文件");
        
    }
}



@end
