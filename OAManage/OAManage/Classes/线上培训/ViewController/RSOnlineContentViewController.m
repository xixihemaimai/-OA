//
//  RSOnlineContentViewController.m
//  OAManage
//
//  Created by mac on 2020/3/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSOnlineContentViewController.h"
#import "RSOnlineContentCell.h"
//播放视频
#import "RSOnlineVideoPlayViewController.h"
#import "RSOnlineModel.h"

@interface RSOnlineContentViewController ()

@property (nonatomic,assign)NSInteger pageNum;


@property (nonatomic,strong)NSMutableArray * workArray;


@end

@implementation RSOnlineContentViewController

-(NSMutableArray *)workArray{
    if (!_workArray) {
        _workArray = [NSMutableArray array];
    }
    return _workArray;
}


//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
////    self.navigationController.navigationBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.emptyView.hidden = true;
    
    self.pageNum = 1;
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadVideoListNewData)];
    self.tableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadVideoListMoreNewData)];
    [self.tableview.mj_header beginRefreshing];
    
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
}

//下拉
- (void)reloadVideoListNewData{
    self.pageNum = 1;
    [self reloadAuditedData];
}

//上拉
- (void)reloadVideoListMoreNewData{
    [self reloadAuditedData];
}


- (void)reloadAuditedData{
//    NSLog(@"+++++++++++++++%@",self.title);
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * mechanismS = [user objectForKey:@"mechanismName"];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    [dict setValue:URL_NEWVIDEO_IOS((long)self.pageNum,6,mechanismS,(long)self.view.tag,self.searchStr) forKey:@"data"];
//    NSLog(@"=========%@",dict);
    [network newReloadWebServiceNoDataURL:URL_VIDEO_IOS andParameters:dict andURLName:URL_VIDEO_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
      if (self.pageNum == 1) {
          [self.workArray removeAllObjects];
//          self.auditedArray = array;
          [self.workArray addObjectsFromArray:array];
          self.pageNum = 2;
          [self.tableview reloadData];
          [self.tableview.mj_header endRefreshing];
      }else{
          NSArray * array1 = array;
          [self.workArray addObjectsFromArray:array1];
          self.pageNum++;
          [self.tableview reloadData];
          [self.tableview.mj_footer endRefreshing];
      }
      if (self.workArray.count > 0 ) {
          self.emptyView.hidden = YES;
      }else{
          self.emptyView.hidden = NO;
      }
    };
    
    network.failure = ^(NSDictionary *dict) {
        if (self.workArray.count > 0 ) {
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
        }
            [self.tableview.mj_header endRefreshing];
            [self.tableview.mj_footer endRefreshing];
    };
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.workArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 97;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * FIRSTCELLID = @"ONLINECONTENTCELLID";
    
    RSOnlineContentCell * cell = [tableView dequeueReusableCellWithIdentifier:FIRSTCELLID];
    if (!cell) {
        cell = [[RSOnlineContentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:FIRSTCELLID];
    }
    cell.onlinemodel = self.workArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    RSOnlineModel * onlinemodel = self.workArray[indexPath.row];
    NSError * errer = nil;
    [KTVHTTPCache proxyStart:&errer];
    if (errer) {
        NSLog(@"播放失败");
    }else{
        NSLog(@"播放成功");
    }
    
    [RSJumpVideoTool canYouSkipThePlaybackVideoInterfaceMoment:onlinemodel andViewController:self];
}

- (void)dealloc{
    [KTVHTTPCache proxyStop];
}

@end
