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
//更多资讯
#import "RSNoticeViewController.h"
//体系文件
#import "RSSystemViewController.h"
//更多公告
#import "RSNoticeMoreViewController.h"
//线上培训
#import "RSOnlineTrainingViewController.h"

#import "RSBannerModel.h"

#import "RSNoticeModel.h"
//市场模块
#import "RSMarketModuleViewController.h"

@interface RSServiceViewController ()<GYRollingNoticeViewDelegate,GYRollingNoticeViewDataSource>

//图片轮播
@property (nonatomic,strong)ZKImgRunLoopView * kimageRun;

@property (nonatomic,strong)NSMutableArray * contentArray;
//最新公告界面
@property (nonatomic,strong)GYRollingNoticeView * noticeView;

@property (nonatomic,strong)NSMutableArray * informationArray;
//未读数据
@property (nonatomic,strong)UIButton * unreadBtn;


@end

@implementation RSServiceViewController

- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}

- (NSMutableArray *)informationArray{
    if (!_informationArray) {
        _informationArray = [NSMutableArray array];
    }
    return _informationArray;
}

static NSString * SERVICEHEADERVIEWID = @"SERVICEHEADERVIEWID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    self.title = @"首页";
    self.emptyView.hidden = YES;
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    self.tableview.frame = CGRectMake(0, Height_NavBar, SCW, SCH - Height_NavBar - Height_TabBar);
    UIButton * menuBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [menuBtn setImage:[UIImage imageNamed:@"通讯录复制"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(showPhoneContentMenu:) forControlEvents:UIControlEventTouchUpInside];
    //menuBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:menuBtn];
    self.navigationItem.leftBarButtonItem = item;
 
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSMutableArray * array = [NSMutableArray array];
    RSNoticeModel * noticemodel = [[RSNoticeModel alloc]init];
    [array addObject:noticemodel];
    [dict setValue:array forKey:@"arr"];
    [self.contentArray addObject:dict];

    //获取企业图片
    [self reloadBannerNewData];
    //获取公告
    [self reloadNoticeNewData];
    
    [self reloadInformationNewData];

    [self showCustomHeaderview];
    
    //获取未读公告
    [self reloadUnReadNotice];
}

- (void)reloadBannerNewData{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
     NSString * mechanismS = [user objectForKey:@"mechanismName"];
    [dict setValue:URL_NEWBANNER_IOS(1, 6,mechanismS) forKey:@"data"];
    [network newReloadWebServiceNoDataURL:URL_BANNER_IOS andParameters:dict andURLName:URL_BANNER_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
        NSMutableArray * imageArray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            RSBannerModel * bannermodel = array[i];
            [imageArray addObject:[NSString stringWithFormat:@"%@%@",URL_NEWPOST_IOS,bannermodel.imageUrl]];
        }
        //[self.kimageRun.imgUrlArray addObjectsFromArray:imagearray];
        self.kimageRun.imgUrlArray = imageArray;
    };
}

- (void)reloadNoticeNewData{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
     NSString * mechanismS = [user objectForKey:@"mechanismName"];
    [dict setValue:URL_NEWNOTICE_IOS((long)1, 6,mechanismS) forKey:@"data"];
    [network newReloadWebServiceNoDataURL:URL_NOTICE_IOS andParameters:dict andURLName:URL_NOTICE_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
        [self.contentArray removeAllObjects];
        NSArray * array1 = [self splitArray:array withSubSize:2];
        for (int i = 0; i < array1.count; i++) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setValue:array1[i] forKey:@"arr"];
            [self.contentArray addObject:dict];
        }
        [self.noticeView reloadDataAndStartRoll];
    };
}

- (void)reloadInformationNewData{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
     NSString * mechanismS = [user objectForKey:@"mechanismName"];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    [dict setValue:URL_NEWINFORMATION_IOS(1, 6,mechanismS) forKey:@"data"];
    [network newReloadWebServiceNoDataURL:URL_INFORMATION_IOS andParameters:dict andURLName:URL_INFORMATION_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
        [self.informationArray removeAllObjects];
        self.informationArray = array;
        [self.tableview reloadData];
    };
}

//MARK:这边还是需要去子线程请求的部分---获取未读的数量，----获取完成之后在进行转到主线程去显示
- (void)reloadUnReadNotice{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * mechanismS = [user objectForKey:@"mechanismName"];
    [dict setValue:mechanismS forKey:@"orgCode"];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    [network newReloadWebServiceNoDataURL:URL_UNREAD_IOS andParameters:dict andURLName:URL_UNREAD_IOS];
    network.successReload = ^(NSDictionary *dict) {
        int number = [[dict objectForKey:@"data"] intValue];
        if (number == 0) {
            self.unreadBtn.hidden = YES;
            self.unreadBtn.sd_layout.widthIs(0);
            self.unreadBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        }else{
            self.unreadBtn.sd_layout.widthIs(20);
            if (number <= 99) {
                [self.unreadBtn setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
                self.unreadBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            }else{
                [self.unreadBtn setTitle:@"99+" forState:UIControlStateNormal];
                self.unreadBtn.titleLabel.font = [UIFont systemFontOfSize:10];
            }
            self.unreadBtn.hidden = NO;
        }
    };
}


- (void)showCustomHeaderview{
    UIView * headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, SCW, 346);
    
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    ZKImgRunLoopView * kimageRun = [[ZKImgRunLoopView alloc]initWithFrame:CGRectMake(15, 13, SCW - 30, 160) placeholderImg:[UIImage imageNamed:@"默认图"]];
    kimageRun.pageControl.numberOfPages = 3;
    kimageRun.pageControl.currentPage = 0;
    kimageRun.pageControl.marginSpacing = 8.5;
    kimageRun.pageControl.controlSize = CGSizeMake(5, 5);
    //NSMutableArray * array = [NSMutableArray arrayWithObjects:@"背景",@"背景", @"背景",nil];
    //kimageRun.imgArray = array;
    [kimageRun touchImageIndexBlock:^(NSInteger index) {
    }];
    kimageRun.layer.cornerRadius = 4;
    kimageRun.layer.masksToBounds = YES;
    [headerView addSubview:kimageRun];
    _kimageRun = kimageRun;
    
    //公告
    UIButton * noticeImage = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(kimageRun.frame) + 10, 33, 33)];
    [noticeImage setImage:[UIImage imageNamed:@"最新 公告"] forState:UIControlStateNormal];
    [noticeImage addTarget:self action:@selector(showMoreNoticeAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:noticeImage];
    
//    noticeImage.sd_layout
//    .leftSpaceToView(headerView, 15)
//    .topSpaceToView(kimageRun, 10)
//    .widthIs(33)
//    .heightEqualToWidth();
    
    //未读的公告
    UIButton * unreadBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noticeImage.frame) + 5, CGRectGetMaxY(kimageRun.frame) + 10, 20, 20)];
    [unreadBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    unreadBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    unreadBtn.backgroundColor = UIColor.redColor;
    unreadBtn.hidden = YES;
    [unreadBtn addTarget:self action:@selector(showMoreNoticeAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:unreadBtn];
    _unreadBtn = unreadBtn;
    
//    unreadBtn.sd_layout.leftSpaceToView(noticeImage, 5).topEqualToView(noticeImage  ).widthIs(20).heightEqualToWidth();
    
    unreadBtn.layer.cornerRadius = unreadBtn.yj_width * 0.5;
    unreadBtn.layer.masksToBounds = YES;
    
    //分割线
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(unreadBtn.frame) + 5, CGRectGetMaxY(kimageRun.frame) + 10, 0.5, 33)];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [headerView addSubview:midView];
    
//    midView.sd_layout
//    .leftSpaceToView(unreadBtn, 5)
//    .topEqualToView(noticeImage)
//    .bottomEqualToView(noticeImage)
//    .widthIs(0.5);
    
    //这边是公告
    GYRollingNoticeView * noticeView = [[GYRollingNoticeView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midView.frame), CGRectGetMaxY(kimageRun.frame) + 10, SCW - CGRectGetMaxX(midView.frame) - 15, 33)];
    noticeView.dataSource = self;
    noticeView.delegate = self;
    noticeView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [noticeView registerClass:[RSGyRollingCell class] forCellReuseIdentifier:@"RSGyRollingCell"];
    [noticeView reloadDataAndStartRoll];
    [headerView addSubview:noticeView];
    
//    noticeView.sd_layout
//    .leftSpaceToView(midView, 0)
//    .topEqualToView(midView)
//    .bottomEqualToView(midView)
//    .rightSpaceToView(headerView, 15);
    _noticeView = noticeView;

    //下分割线
    UIView * newMidView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(noticeImage.frame) + 9.5, SCW - CGRectGetMaxX(midView.frame) - 15, 0.5)];
    newMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
    [headerView addSubview:newMidView];
//    newMidView.sd_layout
//    .leftEqualToView(noticeImage)
//    .rightSpaceToView(headerView, 15)
//    .topSpaceToView(noticeImage, 9.5)
//    .heightIs(0.5);
    
    //工作日志和体系文件
    UIButton * firstBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(newMidView.frame), SCW/4, 122)];
    [firstBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [headerView addSubview:firstBtn];
    firstBtn.tag = 1;
    [firstBtn addTarget:self action:@selector(jumpWorkContentAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    firstBtn.sd_layout
//    .leftSpaceToView(headerView, 0)
//    .topSpaceToView(newMidView, 0)
//    .widthIs(SCW/4)
//    .heightIs(122);
    
    UIImageView * firstImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCW/4)/2 - 24, 122/2 - 24, 48, 48)];
    firstImage.image = [UIImage imageNamed:@"工作日志"];
    firstImage.contentMode = UIViewContentModeScaleAspectFill;
    [firstBtn addSubview:firstImage];
//    firstImage.sd_layout
//    .centerXEqualToView(firstBtn)
//    .centerYEqualToView(firstBtn)
//    .widthIs(48)
//    .heightEqualToWidth();
    
    UILabel * firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(firstImage.frame),SCW/4 , 22.5)];
    firstLabel.text = @"工作日志";
    firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    firstLabel.font = [UIFont systemFontOfSize:16];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    [firstBtn addSubview:firstLabel];
//    firstLabel.sd_layout
//    .leftSpaceToView(firstBtn, 0)
//    .topSpaceToView(firstImage,0)
//    .heightIs(22.5)
//    .rightSpaceToView(firstBtn, 0);
    
    
    UIButton * fourBtn =  [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(firstBtn.frame), CGRectGetMaxY(newMidView.frame), SCW/4, 122)];
    [fourBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [headerView addSubview:fourBtn];
    fourBtn.tag = 2;
    [fourBtn addTarget:self action:@selector(jumpWorkContentAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    fourBtn.sd_layout
//    .leftSpaceToView(firstBtn, 0)
//    .topEqualToView(firstBtn)
//    .widthIs(SCW/4)
//    .bottomEqualToView(firstBtn);
    
    UIImageView * fourImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCW/4)/2 - 24,122/2 - 24, 48, 48)];
    fourImage.image = [UIImage imageNamed:@"市场模块"];
    fourImage.contentMode = UIViewContentModeScaleAspectFill;
    [fourBtn addSubview:fourImage];
    
//    fourImage.sd_layout
//    .centerYEqualToView(fourBtn)
//    .centerXEqualToView(fourBtn)
//    .widthIs(48)
//    .heightEqualToWidth();
    
    UILabel * fourLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fourImage.frame), SCW/4, 22.5)];
    fourLabel.text = @"智能园区";
    fourLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    fourLabel.font = [UIFont systemFontOfSize:16];
    fourLabel.textAlignment = NSTextAlignmentCenter;
    [fourBtn addSubview:fourLabel];
    
//    fourLabel.sd_layout
//    .leftSpaceToView(fourBtn, 0)
//    .topSpaceToView(fourImage,0)
//    .heightIs(22.5)
//    .rightSpaceToView(fourBtn, 0);
    
    
    
    UIButton * secondBtn =  [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fourBtn.frame), CGRectGetMaxY(newMidView.frame), SCW/4, 122)];
    [secondBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [headerView addSubview:secondBtn];
    secondBtn.tag = 3;
    [secondBtn addTarget:self action:@selector(jumpWorkContentAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    secondBtn.sd_layout
//    .leftSpaceToView(fourBtn, 0)
//    .topEqualToView(fourBtn)
//    .widthIs(SCW/4)
//    .bottomEqualToView(fourBtn);
    
    UIImageView * secondImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCW/4)/2 - 24, 122/2 - 24, 48, 48)];
    secondImage.image = [UIImage imageNamed:@"体系文件"];
    secondImage.contentMode = UIViewContentModeScaleAspectFill;
    [secondBtn addSubview:secondImage];
    
//    secondImage.sd_layout
//    .centerYEqualToView(secondBtn)
//    .centerXEqualToView(secondBtn)
//    .widthIs(48)
//    .heightEqualToWidth();
    
    UILabel * secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondImage.frame), SCW/4, 22.5)];
    secondLabel.text = @"体系文件";
    secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    secondLabel.font = [UIFont systemFontOfSize:16];
    secondLabel.textAlignment = NSTextAlignmentCenter;
    [secondBtn addSubview:secondLabel];
    
//    secondLabel.sd_layout
//    .leftSpaceToView(secondBtn, 0)
//    .topSpaceToView(secondImage,0)
//    .heightIs(22.5)
//    .rightSpaceToView(secondBtn, 0);
    
    UIButton * thirdBtn =  [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(secondBtn.frame), CGRectGetMaxY(newMidView.frame), SCW/4, 122)];
    [thirdBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [headerView addSubview:thirdBtn];
    thirdBtn.tag = 4;
    [thirdBtn addTarget:self action:@selector(jumpWorkContentAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    thirdBtn.sd_layout
//    .leftSpaceToView(secondBtn, 0)
//    .topEqualToView(secondBtn)
//    .widthIs(SCW/4)
//    .bottomEqualToView(secondBtn);
    
    UIImageView * thirdImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCW/4)/2 - 24, 122/2 - 24, 48, 48)];
    thirdImage.image = [UIImage imageNamed:@"线上培训"];
    thirdImage.contentMode = UIViewContentModeScaleAspectFill;
    [thirdBtn addSubview:thirdImage];
    
//    thirdImage.sd_layout
//    .centerYEqualToView(thirdBtn)
//    .centerXEqualToView(thirdBtn)
//    .widthIs(48)
//    .heightEqualToWidth();
    
    UILabel * thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(thirdImage.frame), SCW/4, 22.5)];
    thirdLabel.text = @"线上培训";
    thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    thirdLabel.font = [UIFont systemFontOfSize:16];
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    [thirdBtn addSubview:thirdLabel];
    
//    thirdLabel.sd_layout
//    .leftSpaceToView(thirdBtn, 0)
//    .topSpaceToView(thirdImage,0)
//    .heightIs(22.5)
//    .rightSpaceToView(thirdBtn, 0);
    
//    [headerView setupAutoHeightWithBottomView:firstBtn bottomMargin:0];
//    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
}




- (void)showMoreNoticeAction:(UIButton *)noticeBtn{
    RSNoticeMoreViewController * notcieMoreVc = [[RSNoticeMoreViewController alloc]init];
    notcieMoreVc.title = @"最新公告";
    [self.navigationController pushViewController:notcieMoreVc animated:YES];
    notcieMoreVc.reReloadUnreadNumber = ^{
        [self reloadUnReadNotice];
    };
}
//通讯录
- (void)showPhoneContentMenu:(UIButton *)menuBtn{
    RSMailListViewController * mailVc = [[RSMailListViewController alloc]init];
    [self.navigationController pushViewController:mailVc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.informationArray.count;
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
    cell.informationmodel = self.informationArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSInformationModel * informationmodel = self.informationArray[indexPath.row];
    RSWKOAmanagerViewController * wkoamanagerVc = [[RSWKOAmanagerViewController alloc]init];
    wkoamanagerVc.type = @"3";
    wkoamanagerVc.title = informationmodel.title;
    wkoamanagerVc.URL = [NSString stringWithFormat:@"%@%@",URL_NEWPOST_IOS,informationmodel.url];
    [self.navigationController pushViewController:wkoamanagerVc animated:YES];
}

- (NSInteger)numberOfRowsForRollingNoticeView:(GYRollingNoticeView *)rollingView
{
    return self.contentArray.count;
}

- (__kindof GYNoticeViewCell *)rollingNoticeView:(GYRollingNoticeView *)rollingView cellAtIndex:(NSUInteger)index
{
    RSGyRollingCell * cell = [rollingView dequeueReusableCellWithIdentifier:@"RSGyRollingCell"];
    NSMutableDictionary * dic = self.contentArray[index];
    NSArray * array = [dic objectForKey:@"arr"];
    for (int i = 0; i < array.count; i++) {
        RSNoticeModel * noticemodel = array[i];
        if (i == 0) {
            if ([noticemodel.noticeType isEqualToString:@"通告"]) {
                cell.tagImageView.image = [UIImage imageNamed:@"通告复制"];
            }else if ([noticemodel.noticeType isEqualToString:@"奖惩"]){
                cell.tagImageView.image = [UIImage imageNamed:@"奖惩"];
            }else if ([noticemodel.noticeType isEqualToString:@"通知"]){
                cell.tagImageView.image = [UIImage imageNamed:@"通知"];
            }else{
                cell.tagImageView.image = [UIImage imageNamed:@"其他"];
            }
            cell.titelLabel.text = noticemodel.title;
        }else{
            if ([noticemodel.noticeType isEqualToString:@"通告"]) {
                cell.secondImageView.image = [UIImage imageNamed:@"通告复制"];
            }else if ([noticemodel.noticeType isEqualToString:@"奖惩"]){
                cell.secondImageView.image = [UIImage imageNamed:@"奖惩"];
            }else if ([noticemodel.noticeType isEqualToString:@"通知"]){
                cell.secondImageView.image = [UIImage imageNamed:@"通知"];
            }else{
                cell.secondImageView.image = [UIImage imageNamed:@"其他"];
            }
            cell.secondtitelLabel.text = noticemodel.title;
        }
    }
    return cell;
}

- (void)didClickRollingNoticeView:(GYRollingNoticeView *)rollingView forIndex:(NSUInteger)index andRow:(NSInteger)row
{
    RSNoticeMoreViewController * notcieMoreVc = [[RSNoticeMoreViewController alloc]init];
    notcieMoreVc.title = @"最新公告";
    [self.navigationController pushViewController:notcieMoreVc animated:YES];
    notcieMoreVc.reReloadUnreadNumber = ^{
        [self reloadUnReadNotice];
    };
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
        //NSLog(@"工作日志");
        RSAuditedViewController * auditedVc = [[RSAuditedViewController alloc]init];
        [self.navigationController pushViewController:auditedVc animated:YES];
    }else if (btn.tag == 2){
//        NSLog(@"市场模块");
        if (self.usermodel.OA_Market_Home == true) {
            RSMarketModuleViewController * marketModuleVc = [[RSMarketModuleViewController alloc]init];
            [self.navigationController pushViewController:marketModuleVc animated:YES];
        }else{
            jxt_showToastTitle(@"您没有这个权限进入",0.75);
        }
    }
    else if (btn.tag == 3){
        //NSLog(@"体系文件");
        RSSystemViewController * systemVc = [[RSSystemViewController alloc]init];
        [self.navigationController pushViewController:systemVc animated:YES];
    }
    else{
        //NSLog(@"线上培训");
        RSOnlineTrainingViewController * onlineTrainingVc = [[RSOnlineTrainingViewController alloc]init];
        [self.navigationController pushViewController:onlineTrainingVc animated:YES];
    }
}

@end
