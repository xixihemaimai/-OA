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




@interface RSServiceViewController ()<GYRollingNoticeViewDelegate,GYRollingNoticeViewDataSource>

@property (nonatomic,strong)ZKImgRunLoopView * kimageRun;

@property (nonatomic,strong)NSMutableArray * contentArray;

@property (nonatomic,strong)GYRollingNoticeView * noticeView;

@property (nonatomic,strong)NSMutableArray * informationArray;


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

    [self reloadBannerNewData];
    
    [self reloadNoticeNewData];
    
    [self reloadInformationNewData];

    [self showCustomHeaderview];
}

- (void)reloadBannerNewData{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    [dict setValue:URL_NEWBANNER_IOS(1, 6) forKey:@"data"];
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
    [dict setValue:URL_NEWNOTICE_IOS((long)1, 6) forKey:@"data"];
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
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    [dict setValue:URL_NEWINFORMATION_IOS(1, 6) forKey:@"data"];
    [network newReloadWebServiceNoDataURL:URL_INFORMATION_IOS andParameters:dict andURLName:URL_INFORMATION_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
        [self.informationArray removeAllObjects];
        self.informationArray = array;
        [self.tableview reloadData];
    };
}

- (void)showCustomHeaderview{
    UIView * headerView = [[UIView alloc]init];
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
    UIButton * noticeImage = [[UIButton alloc]init];
    //noticeImage.image = [UIImage imageNamed:@"最新 公告"];
    [noticeImage setImage:[UIImage imageNamed:@"最新 公告"] forState:UIControlStateNormal];
    [noticeImage addTarget:self action:@selector(showMoreNoticeAction:) forControlEvents:UIControlEventTouchUpInside];
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
    .leftSpaceToView(midView, 0)
    .topEqualToView(midView)
    .bottomEqualToView(midView)
    .rightSpaceToView(headerView, 15);
    _noticeView = noticeView;

    //下分割线
    UIView * newMidView = [[UIView alloc]init];
    newMidView.backgroundColor = [UIColor colorWithHexColorStr:@"#f2f2f2"];
    [headerView addSubview:newMidView];
    newMidView.sd_layout
    .leftEqualToView(noticeImage)
    .rightSpaceToView(headerView, 15)
    .topSpaceToView(noticeImage, 9.5)
    .heightIs(0.5);
    
    //工作日志和体系文件
    UIButton * firstBtn = [[UIButton alloc]init];
    [firstBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [headerView addSubview:firstBtn];
    firstBtn.tag = 1;
    [firstBtn addTarget:self action:@selector(jumpWorkContentAction:) forControlEvents:UIControlEventTouchUpInside];
    firstBtn.sd_layout
    .leftSpaceToView(headerView, 0)
    .topSpaceToView(newMidView, 0)
    .widthIs(SCW/3)
    .heightIs(122);
    
    UIImageView * firstImage = [[UIImageView alloc]init];
    firstImage.image = [UIImage imageNamed:@"工作日志"];
    firstImage.contentMode = UIViewContentModeScaleAspectFill;
    [firstBtn addSubview:firstImage];
    firstImage.sd_layout
    .centerXEqualToView(firstBtn)
    .centerYEqualToView(firstBtn)
    .widthIs(67.5)
    .heightEqualToWidth();
    
    UILabel * firstLabel = [[UILabel alloc]init];
    firstLabel.text = @"工作日志";
    firstLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    firstLabel.font = [UIFont systemFontOfSize:16];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    [firstBtn addSubview:firstLabel];
    firstLabel.sd_layout
    .leftSpaceToView(firstBtn, 0)
    .topSpaceToView(firstImage,0)
    .heightIs(22.5)
    .rightSpaceToView(firstBtn, 0);
    
    UIButton * secondBtn =  [[UIButton alloc]init];
    [secondBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [headerView addSubview:secondBtn];
    secondBtn.tag = 2;
    [secondBtn addTarget:self action:@selector(jumpWorkContentAction:) forControlEvents:UIControlEventTouchUpInside];
    secondBtn.sd_layout
    .leftSpaceToView(firstBtn, 0)
    .topEqualToView(firstBtn)
    .widthIs(SCW/3)
    .bottomEqualToView(firstBtn);
    
    UIImageView * secondImage = [[UIImageView alloc]init];
    secondImage.image = [UIImage imageNamed:@"体系文件"];
    secondImage.contentMode = UIViewContentModeScaleAspectFill;
    [secondBtn addSubview:secondImage];
    secondImage.sd_layout
    .centerYEqualToView(secondBtn)
    .centerXEqualToView(secondBtn)
    .widthIs(67.5)
    .heightEqualToWidth();
    
    UILabel * secondLabel = [[UILabel alloc]init];
    secondLabel.text = @"体系文件";
    secondLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    secondLabel.font = [UIFont systemFontOfSize:16];
    secondLabel.textAlignment = NSTextAlignmentCenter;
    [secondBtn addSubview:secondLabel];
    secondLabel.sd_layout
    .leftSpaceToView(secondBtn, 0)
    .topSpaceToView(secondImage,0)
    .heightIs(22.5)
    .rightSpaceToView(secondBtn, 0);
    
    UIButton * thirdBtn =  [[UIButton alloc]init];
    [thirdBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#ffffff"]];
    [headerView addSubview:thirdBtn];
    thirdBtn.tag = 3;
    [thirdBtn addTarget:self action:@selector(jumpWorkContentAction:) forControlEvents:UIControlEventTouchUpInside];
    thirdBtn.sd_layout
    .leftSpaceToView(secondBtn, 0)
    .topEqualToView(secondBtn)
    .widthIs(SCW/3)
    .bottomEqualToView(secondBtn);
    
    UIImageView * thirdImage = [[UIImageView alloc]init];
    thirdImage.image = [UIImage imageNamed:@"线上培训"];
    thirdImage.contentMode = UIViewContentModeScaleAspectFill;
    [thirdBtn addSubview:thirdImage];
    thirdImage.sd_layout
    .centerYEqualToView(thirdBtn)
    .centerXEqualToView(thirdBtn)
    .widthIs(67.5)
    .heightEqualToWidth();
    
    UILabel * thirdLabel = [[UILabel alloc]init];
    thirdLabel.text = @"线上培训";
    thirdLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    thirdLabel.font = [UIFont systemFontOfSize:16];
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    [thirdBtn addSubview:thirdLabel];
    thirdLabel.sd_layout
    .leftSpaceToView(thirdBtn, 0)
    .topSpaceToView(thirdImage,0)
    .heightIs(22.5)
    .rightSpaceToView(thirdBtn, 0);
    
    [headerView setupAutoHeightWithBottomView:firstBtn bottomMargin:0];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
}

- (void)showMoreNoticeAction:(UIButton *)noticeBtn{
    RSNoticeMoreViewController * notcieMoreVc = [[RSNoticeMoreViewController alloc]init];
    notcieMoreVc.title = @"最新公告";
    [self.navigationController pushViewController:notcieMoreVc animated:YES];
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
            }
            else{
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
            }
            else{
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
    //    NSMutableDictionary * dic = self.contentArray[index];
    //    NSArray * array = [dic objectForKey:@"arr"];
    //    RSNoticeModel * noticemodel = array[row];
    //    RSWKOAmanagerViewController * wkoamanagerVc = [[RSWKOAmanagerViewController alloc]init];
    //    wkoamanagerVc.type = @"3";
    //    wkoamanagerVc.title = noticemodel.title;
    //    wkoamanagerVc.URL = [NSString stringWithFormat:@"%@%@",URL_NEWPOST_IOS,noticemodel.url];
    //    [self.navigationController pushViewController:wkoamanagerVc animated:YES];
    //    NSLog(@"点击的第几组: %lu 第几行:%lu", (unsigned long)index,(unsigned long)row);
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
        //        NSLog(@"工作日志");
        RSAuditedViewController * auditedVc = [[RSAuditedViewController alloc]init];
        

        [self.navigationController pushViewController:auditedVc animated:YES];
        
    }else if (btn.tag == 2){
        //        NSLog(@"体系文件");
        RSSystemViewController * systemVc = [[RSSystemViewController alloc]init];
        
        [self.navigationController pushViewController:systemVc animated:YES];
    }
    else{
        //        NSLog(@"线上培训");
        RSOnlineTrainingViewController * onlineTrainingVc = [[RSOnlineTrainingViewController alloc]init];
        
        [self.navigationController pushViewController:onlineTrainingVc animated:YES];
    }
}
@end
