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
    [dict setValue:URL_NEWNOTICE_IOS((long)self.pageNum, 10) forKey:@"data"];
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
    RSWKOAmanagerViewController * wkoamanagerVc = [[RSWKOAmanagerViewController alloc]init];
    wkoamanagerVc.type = @"3";
    wkoamanagerVc.title = noticemodel.title;
    wkoamanagerVc.URL = [NSString stringWithFormat:@"%@%@",URL_NEWPOST_IOS,noticemodel.url];
    [self.navigationController pushViewController:wkoamanagerVc animated:YES];
}

@end
