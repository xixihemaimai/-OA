//
//  RSNoticeViewController.m
//  OAManage
//
//  Created by mac on 2018/12/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSNoticeViewController.h"
#import "RSInformationModel.h"
#import "RSWKOAmanagerViewController.h"
#import "RSNoticeCell.h"

@interface RSNoticeViewController ()

@property (nonatomic,strong)NSMutableArray * noticeArray;

@property (nonatomic,assign)NSInteger pageNum;

@end



@implementation RSNoticeViewController


- (NSMutableArray *)noticeArray{
    if (!_noticeArray) {
        _noticeArray = [NSMutableArray array];
    }
    return _noticeArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公告通知";
    self.pageNum = 1;
    
    self.emptyView.hidden = NO;
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadNoticeNewData)];
    self.tableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadNoticMoreNewData)];
    [self.tableview.mj_header beginRefreshing];
}


- (void)reloadNoticeNewData{
    self.pageNum = 1;
    [self reloadNoticeNew];
}


- (void)reloadNoticMoreNewData{
    [self reloadNoticeNew];
}



- (void)reloadNoticeNew{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString * const kInitVector = @"16-Bytes--String";
    NetworkTool * network = [[NetworkTool alloc]init];
    NSNumber * number = [NSNumber numberWithInteger:self.pageNum];
    NSString * notice = URL_YIGODATA_DATA(number,@(10));
    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_NOTICE, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_NOTICE];
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






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noticeArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_IPHONE) {
        return (46 / SCW) * SCW;
    }else{
        if (DEVICES_IS_PRO_12_9) {
            return  80 * SCALE_TO_PRO;
        }else{
            return (80 / SCW) * SCW;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * NOTICECELLID = @"NOTICECELLID";
    RSNoticeCell * cell = [tableView dequeueReusableCellWithIdentifier:NOTICECELLID];
    if (!cell) {
        cell = [[RSNoticeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NOTICECELLID];
        
    }
    cell.informationmodel = self.noticeArray[indexPath.row];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //这边也是跳到H5的页面
    RSInformationModel * informationmodel = self.noticeArray[indexPath.row];
    RSWKOAmanagerViewController * wkOaVc = [[RSWKOAmanagerViewController alloc]init];
    wkOaVc.URL = informationmodel.url;
    wkOaVc.type = @"0";
    wkOaVc.Currenttitle = informationmodel.title;
    [self.navigationController pushViewController:wkOaVc animated:YES];
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
