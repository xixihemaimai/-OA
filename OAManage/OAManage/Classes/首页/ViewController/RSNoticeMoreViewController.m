//
//  RSNoticeMoreViewController.m
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSNoticeMoreViewController.h"
#import "RSXNoticeCell.h"
#import "RSNoticeModel.h"

@interface RSNoticeMoreViewController ()

@property (nonatomic,strong)NSMutableArray * noticeArray;


@property (nonatomic,assign)NSInteger pageNum;


@end

@implementation RSNoticeMoreViewController
- (NSMutableArray *)noticeArray{
    if (!_noticeArray) {
        _noticeArray = [NSMutableArray array];
    }
    return _noticeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最新公告";
    self.pageNum = 1;
    self.emptyView.hidden = NO;
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadNoticeData)];
    self.tableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadNoticMoreNewData)];
    [self.tableview.mj_header beginRefreshing];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem backItemWithimage:nil highImage:nil target:self action:@selector(allReadAction) title:@"全部已读"];
}


//全部已读
- (void)allReadAction{
    if ([self reloadAllNoticeModelReadStats]) {
        jxt_showAlertTwoButton(@"将标记所有信息为已读", nil, @"确定", ^(NSInteger buttonIndex) {
            RSWeakself
            NetworkTool * network = [[NetworkTool alloc]init];
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            NSString * mechanismS = [user objectForKey:@"mechanismName"];
            [dict setValue:mechanismS forKey:@"orgCode"];
            [dict setValue:weakSelf.usermodel.appLoginToken forKey:@"loginToken"];
            [network newReloadWebServiceNoDataURL:URL_ALLREAD_IOS andParameters:dict andURLName:URL_ALLREAD_IOS];
            network.successReload = ^(NSDictionary *dict) {
              //这边要设置数组里面所有的readstate的状态
                for (RSNoticeModel * noticemodel in weakSelf.noticeArray) {
                    if (noticemodel.readState == 0) {
                        noticemodel.readState = 1;
                    }
                }
                [weakSelf.tableview reloadData];
                //这边还需要返回只能的数据
                if (weakSelf.reReloadUnreadNumber) {
                    weakSelf.reReloadUnreadNumber();
                }
            };
        }, @"取消", ^(NSInteger buttonIndex) {
        });
    }else{
        jxt_showAlertTitle(@"所有的公告都是已读的状态");
    }
}

//点击某条公告为已读
- (void)clickNoticeSettingReadStatus:(NSInteger)noticeId andIndexpath:(NSIndexPath *)indexpath{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * mechanismS = [user objectForKey:@"mechanismName"];
    [dict setValue:mechanismS forKey:@"orgCode"];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    [dict setValue:[NSString stringWithFormat:@"{id:%ld}",noticeId] forKey:@"data"];
    [network newReloadWebServiceNoDataURL:URL_READ_IOS andParameters:dict andURLName:URL_READ_IOS];
    network.successReload = ^(NSDictionary *dict) {
      //这边要设置数组里面所有的readstate的状态
        RSNoticeModel * noticemodel = self.noticeArray[indexpath.row];
        noticemodel.readState = 1;
        [self.tableview reloadData];
        //这边还需要返回只能的数据
        if (self.reReloadUnreadNumber) {
            self.reReloadUnreadNumber();
        }
    };
}



- (void)reloadNoticeData{
    self.pageNum = 1;
    [self reloadNoticeNewData];
}

- (void)reloadNoticMoreNewData{
    [self reloadNoticeNewData];
}

- (void)reloadNoticeNewData{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
     NSString * mechanismS = [user objectForKey:@"mechanismName"];
    [dict setValue:URL_NEWNOTICE_IOS((long)self.pageNum, 40,mechanismS) forKey:@"data"];
    [network newReloadWebServiceNoDataURL:URL_NOTICE_IOS andParameters:dict andURLName:URL_NOTICE_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
        if (self.pageNum == 1) {
            [self.noticeArray removeAllObjects];
            self.noticeArray = array;
            self.pageNum = 2;
            [self.tableview.mj_header endRefreshing];
        }else{
            NSArray * array1 = array;
            [self.noticeArray addObjectsFromArray:array1];
            [self.tableview.mj_footer endRefreshing];
            self.pageNum++;
        }
        if (self.noticeArray.count > 0 ) {
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
        }
        [self.tableview reloadData];
    };
    network.failure = ^(NSDictionary *dict) {
        if (self.noticeArray.count > 0 ) {
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
        }
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    };
}

//MARK:判断所有的数据是否有未读的数据，有未读的数据就进行修改readState的状态
- (BOOL)reloadAllNoticeModelReadStats{
    BOOL readStats = false;
    for (RSNoticeModel * noticemodel in self.noticeArray) {
        if (noticemodel.readState == 0) {
            //未读
            readStats = true;
            break;
        }
    }
    return readStats;
}

//MARK:判断你点击的数据是否是未读的数据，要是为未读数据的话就进行网络请求，不是就随便跳转界面
- (BOOL)reloadArrayInNoticeModelReadStats:(NSIndexPath *)index{
    BOOL readStats = false;
    RSNoticeModel * noticemodel = self.noticeArray[index.row];
    if (noticemodel.readState == 1) {
        //已读
        return readStats = true;
    }else{
        //未读
        return readStats = false;
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noticeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ROLLCELLID = @"ROLLCELLID";
    RSXNoticeCell * cell = [tableView dequeueReusableCellWithIdentifier:ROLLCELLID];
    if (!cell) {
        cell = [[RSXNoticeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ROLLCELLID];
    }
    cell.noticemodel = self.noticeArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RSNoticeModel * noticemodel = self.noticeArray[indexPath.row];
    //cellForRowAtIndexPath
    //[tableView.cellForRowAtIndexPath:indexPath];
    RSXNoticeCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.redView.hidden = true;
    if (![self reloadArrayInNoticeModelReadStats:indexPath]) {
        //未读
        [self clickNoticeSettingReadStatus:noticemodel.noticeId andIndexpath:indexPath];
    }
    RSWKOAmanagerViewController * wkoamanagerVc = [[RSWKOAmanagerViewController alloc]init];
    wkoamanagerVc.type = @"3";
    wkoamanagerVc.title = noticemodel.title;
    wkoamanagerVc.URL = [NSString stringWithFormat:@"%@%@",URL_NEWPOST_IOS,noticemodel.url];
    [self.navigationController pushViewController:wkoamanagerVc animated:YES];
}

@end
