//
//  RSHomeViewController.m
//  OAManage
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSHomeViewController.h"
#import "RSShenHeViewController.h"
#import "RSMenuViewController.h"

#import "RSHomeFirstCell.h"
#import "RSHomeSecondCell.h"
#import "RSHomeThirdCell.h"
#import "RSHomeFristHeaderView.h"
#import "RSAuditedViewController.h"




#import "RSWKOAmanagerViewController.h"
//修改密码
#import "RSPasswordModificationViewController.h"
//个人信息
#import "RSPersonalInformationViewController.h"
/**公告更多*/
#import "RSNoticeViewController.h"
#import "RSRedButton.h"
#import <SDImageCache.h>
//模型
#import "RSInformationModel.h"
#import "RSAuditedModel.h"



@interface RSHomeViewController ()<RSMenuViewControllerDelegate>

//资讯的数组
@property (nonatomic,strong)NSMutableArray * informationArray;



@property (nonatomic,strong)NSMutableArray * dataArray;


@property (nonatomic,strong)UILabel * numberLabel;
@end


@implementation RSHomeViewController
 static NSString * HOMEFRISTHEADERVIEW = @"HOMEFRISTHEADERVIEW";
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (NSMutableArray *)informationArray{
    if (!_informationArray) {
        _informationArray = [NSMutableArray array];
    }
    return _informationArray;
    
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        
        static CGFloat const kNameLabelWidth = 10;
        static CGFloat const kNameLabelHeight = 10;
        static CGFloat const kNameLabelX = 25; // 父视图宽44，UI说改到这个位置
        static CGFloat const kNameLabelY = 0;
        
        _numberLabel = [UILabel new];
      //  _numberLabel.hidden = YES;
        _numberLabel.frame = CGRectMake(kNameLabelX, kNameLabelY, kNameLabelWidth, kNameLabelHeight);
        
        _numberLabel.backgroundColor = [UIColor redColor];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.font = [UIFont systemFontOfSize:9];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.layer.cornerRadius = kNameLabelHeight * 0.5;
        _numberLabel.layer.masksToBounds = YES;
        _numberLabel.hidden = YES;
    }
    return _numberLabel;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reLoadCurrentViewData) name:@"reLoadCurrentViewData" object:nil];
    self.frostedViewController.panGestureEnabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    UIButton * menuBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [menuBtn setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    [menuBtn addSubview:self.numberLabel];
    [menuBtn addTarget:(RSMyNavigationViewController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
        //menuBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:menuBtn];
    self.navigationItem.leftBarButtonItem = item;
    RSMenuViewController * menuVc = (RSMenuViewController *)self.frostedViewController.menuViewController;
        menuVc.delegate = self;
       [self reloadInformationData];
       [self reloadAuditedData];
    
    RSWeakself
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        [weakSelf reloadInformationData];
        [weakSelf reloadAuditedData];
    }];
}

- (void)reLoadCurrentViewData{
    [self.tableview.mj_header beginRefreshing];
}

- (void)reloadInformationData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString * const kInitVector = @"16-Bytes--String";
    NetworkTool * network = [[NetworkTool alloc]init];
    NSNumber * number = [NSNumber numberWithInt:1];
    NSString * notice = URL_YIGODATA_DATA(number,@(3));
    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_NOTICE, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_NOTICE];
    network.successArrayReload = ^(NSMutableArray *array) {
        [self.informationArray removeAllObjects];
        [self.informationArray addObjectsFromArray:array];
        if (self.informationArray.count > 0 || self.dataArray.count > 0) {
            self.emptyView.hidden = YES;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            self.emptyView.hidden = NO;
        }
        [self.tableview.mj_header endRefreshing];
    };
    network.failure = ^(NSDictionary *dict) {
        if (self.informationArray.count > 0 || self.dataArray.count > 0) {
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
        }
        [self.tableview.mj_header endRefreshing];
    };
}


- (void)reloadAuditedData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString *const kInitVector = @"16-Bytes--String";
    NetworkTool * network = [[NetworkTool alloc]init];
    NSNumber * number = [NSNumber numberWithInt:1];
    NSString * notice = URL_YIGODATA_DATA(number,@(3));
    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_TOBEAUDIT, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_TOBEAUDIT];
    network.successArrayReload = ^(NSMutableArray *array) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
        if (self.informationArray.count > 0 || self.dataArray.count > 0) {
            self.emptyView.hidden = YES;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            self.emptyView.hidden = NO;
        }
         [self.tableview.mj_header endRefreshing];
    };
    
    network.failure = ^(NSDictionary *dict) {
        if (self.informationArray.count > 0 || self.dataArray.count > 0) {
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
        }
        [self.tableview.mj_header endRefreshing];
    };
}


- (void)didTableViewIndexpath:(NSIndexPath *)indexpath andViewController:(RSMenuViewController *)menVc{
     [self.frostedViewController hideMenuViewController];
    if (indexpath.row == 0) {
        RSPersonalInformationViewController * personalInformationVc = [[RSPersonalInformationViewController alloc]init];
        [self.navigationController pushViewController:personalInformationVc animated:YES];
        
    }else if (indexpath.row == 1) {
        RSPasswordModificationViewController * passwordModificationVc = [[RSPasswordModificationViewController alloc]init];
        
        [self.navigationController pushViewController:passwordModificationVc animated:YES];
    }else{
     //清除缓存
       // NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
        
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        
        float MBCache = [self sizeOfDirectory:path];
        //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
         MBCache = MBCache/1000/1000;
        NSString * text = [NSString stringWithFormat:@"已清理:%0.3lfM",MBCache];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:text message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //这边是清理缓存
            //异步清除图片缓存 （磁盘中的）
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                //[[SDImageCache sharedImageCache] clearMemory];
                [self deleteFileByPath:path];
            });
        }];
        [alert addAction:actionConfirm];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.informationArray.count > 3) {
            return 3;
        }else{
             return self.informationArray.count;
        }
    
    }else if (section == 1){
        return 1;
    }
    else{
        if (self.dataArray.count > 3) {
            return 3;
        }else{
            return self.dataArray.count;
        }
       
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * CELLHOMEFRISTID = @"CELLHOMEFRISTID";
        RSHomeFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLHOMEFRISTID];
        if (!cell) {
            cell = [[RSHomeFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLHOMEFRISTID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        RSInformationModel * informationmodel = self.informationArray[indexPath.row];
        cell.homeFirstContentLabel.text = informationmodel.title;
        CGFloat H = 0.0;
        if (IS_IPHONE) {
            H = (37 / SCW ) * SCW;
        }else{
            if (DEVICES_IS_PRO_12_9) {
                H = 52 * SCALE_TO_PRO;
            }else{
                H = (52 / SCW) * SCW;
            }
        }
        if (indexPath.row == 0) {
            CGRect rect = CGRectMake(0, 0, SCW - 30, H);
            UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(6, 6)]; CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc] init];
            cornerRadiusLayer.frame = rect;
            cornerRadiusLayer.path = cornerRadiusPath.CGPath;
            
        cell.homeFristView.layer.mask = cornerRadiusLayer;
        }else if (indexPath.row == 1){
            
        }else{
            CGRect rect = CGRectMake(0, 0, SCW - 30, H);
            UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(6, 6)]; CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc] init];
            cornerRadiusLayer.frame = rect;
            cornerRadiusLayer.path = cornerRadiusPath.CGPath;
             cell.homeFristView.layer.mask = cornerRadiusLayer;
            cell.homeFirstTransverseLineLabel.hidden = YES;
        }
        return cell;
    }else if (indexPath.section == 1){
        static NSString * CELLHOMESECONDID = @"CELLHOMESECONDID";
        RSHomeSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLHOMESECONDID];
        if (!cell) {
            
            cell = [[RSHomeSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLHOMESECONDID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString * CELLHOMETHIRDID = @"CELLHOMETHIRDID";
        RSHomeThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLHOMETHIRDID];
        if (!cell) {
            cell = [[RSHomeThirdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLHOMETHIRDID];
        }
            RSAuditedModel * auditemodel = self.dataArray[indexPath.row];
        cell.auditedmodel = auditemodel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (IS_IPHONE) {
        if (section == 0 || section == 2) {
            return 45;
        }
        return 15;
    }else{
        if (DEVICES_IS_PRO_12_9) {
            if (section == 0 || section == 2) {
                return 50 * SCALE_TO_PRO;
            }
            return 20 * SCALE_TO_PRO;
        }else{
            if (section == 0 || section == 2) {
                return 50;
            }
            return 20;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSHomeFristHeaderView * homeFristHeaderview = [[RSHomeFristHeaderView alloc]initWithReuseIdentifier:HOMEFRISTHEADERVIEW];
       // homeFristHeaderview.backgroundColor = [UIColor redColor];
    homeFristHeaderview.homeFristBtn.tag = section;
    [homeFristHeaderview.homeFristBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    if (section == 0) {
        homeFristHeaderview.homeFristHeaderLabel.text = @"公告通知";
        homeFristHeaderview.homeFristHeaderLabel.hidden = NO;
        homeFristHeaderview.homeFristImageView.hidden = NO;
        homeFristHeaderview.homeFristBtn.enabled = YES;
    }else if (section == 1){
        homeFristHeaderview.homeFristHeaderLabel.hidden = YES;
        homeFristHeaderview.homeFristImageView.hidden = YES;
        homeFristHeaderview.homeFristBtn.enabled = NO;
    }else{
        homeFristHeaderview.homeFristBtn.enabled = YES;
        homeFristHeaderview.homeFristHeaderLabel.hidden = NO;
        homeFristHeaderview.homeFristImageView.hidden = NO;
        homeFristHeaderview.homeFristHeaderLabel.text = @"待审核";
    }
    return homeFristHeaderview;
}

- (void)clickAction:(UIButton *)homeFristBtn{
    if (homeFristBtn.tag == 0) {
        //这边是跳转到H5的界面
        RSNoticeViewController * noticeVc = [[RSNoticeViewController alloc]init];
        [self.navigationController pushViewController:noticeVc animated:YES];

    }else if (homeFristBtn.tag == 1){
        RSShenHeViewController * shenHeVc = [[RSShenHeViewController alloc]init];
        [self.navigationController pushViewController:shenHeVc animated:YES];
    }else if(homeFristBtn.tag == 2){
        //待审核的界面
        RSAuditedViewController * auditedVc = [[RSAuditedViewController alloc]init];
        [self.navigationController pushViewController:auditedVc animated:YES];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_IPHONE) {
        if (indexPath.section == 0) {
            return (37 / SCW) * SCW;
        }else if(indexPath.section == 0){
            return (98 / SCW) * SCW;
        }else{
            return (93 / SCW ) * SCW;
        }
    }else{
        if (DEVICES_IS_PRO_12_9) {
            if (indexPath.section == 0) {
                return 52  * SCALE_TO_PRO;
            }else if(indexPath.section == 0){
                return 120 * SCALE_TO_PRO;
            }else{
                return 120 * SCALE_TO_PRO;
            }
        }else{
            if (indexPath.section == 0) {
                return (52 / SCW) * SCW;
            }else if(indexPath.section == 0){
                return (120 / SCW) * SCW;
            }else{
                return (120 / SCW ) * SCW;
            }
            
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
       //这边也是跳到H5的页面
        RSInformationModel * informationmodel = self.informationArray[indexPath.row];
        RSWKOAmanagerViewController * wkOaVc = [[RSWKOAmanagerViewController alloc]init];
        wkOaVc.URL = informationmodel.url;
        wkOaVc.type = @"0";
        wkOaVc.Currenttitle = informationmodel.title;
        [self.navigationController pushViewController:wkOaVc animated:YES];
        
    }else if (indexPath.section == 1){
        RSShenHeViewController * shenHeVc = [[RSShenHeViewController alloc]init];
        [self.navigationController pushViewController:shenHeVc animated:YES];
    }else{
        RSAuditedModel * auditedmodel = self.dataArray[indexPath.row];
        RSWKOAmanagerViewController * wkOaVc = [[RSWKOAmanagerViewController alloc]init];
        wkOaVc.billId = auditedmodel.billId;
        wkOaVc.workItemId = auditedmodel.workItemId;
        wkOaVc.billKey = auditedmodel.billKey;
        wkOaVc.usertime = auditedmodel.createtime;
        wkOaVc.creatorName = auditedmodel.creatorName;
        wkOaVc.deptName = auditedmodel.deptName;
        wkOaVc.type = @"1";
        wkOaVc.version = [[[UIDevice currentDevice] systemVersion] floatValue];
        [self.navigationController pushViewController:wkOaVc animated:YES];
    }
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
