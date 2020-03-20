//
//  RSOnlineVideoPlayViewController.m
//  OAManage
//
//  Created by mac on 2020/3/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSOnlineVideoPlayViewController.h"
#import "RSOnlineContentCell.h"
#import "AppDelegate.h"


#import "RSOnlineVideoHeaderView.h"

@interface RSOnlineVideoPlayViewController ()<UITableViewDelegate,UITableViewDataSource,SelVideoPlayerDelegate>

@property (nonatomic,strong)UITableView * tableview;

@property (nonatomic, strong)SelVideoPlayer *player;

@property (nonatomic,strong)UIView *playerSuperview;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * workArray;

@end

@implementation RSOnlineVideoPlayViewController

- (NSMutableArray *)workArray{
    if (!_workArray) {
        _workArray = [NSMutableArray array];
    }
    return _workArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCW, SCH) style:UITableViewStylePlain];

    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
    
    UIView *playerSuperview = [[UIView alloc]init];
    playerSuperview.frame = CGRectMake(0, 0, SCW, 215);
    self.tableview.tableHeaderView = playerSuperview;
    
    SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
    configuration.shouldAutoPlay = YES;
    configuration.supportedDoubleTap = YES;
    configuration.shouldAutorotate = YES;
    configuration.repeatPlay = NO;
    configuration.statusBarHideState = SelStatusBarHideStateFollowControls;
    configuration.sourceUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_NEWPOST_IOS,self.onlinemodel.url]];
    configuration.videoGravity = SelVideoGravityResizeAspect;
       
    self.player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(0, 0, SCW, 215) configuration:configuration];
    self.player.delegate = self;
    [playerSuperview addSubview:self.player];
    
    
    self.pageNum = 1;
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadVideoListNewData)];
    self.tableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadVideoListMoreNewData)];
    [self.tableview.mj_header beginRefreshing];
    
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
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    [dict setValue:URL_NEWRECOMMEND_IOS((long)self.pageNum,6, self.onlinemodel.onlineId, self.onlinemodel.videoTypeId, self.onlinemodel.videoTitle) forKey:@"data"];
//    NSLog(@"=========%@",dict);
    [network newReloadWebServiceNoDataURL:URL_VIDEORECOMMEND_IOS andParameters:dict andURLName:URL_VIDEORECOMMEND_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
      if (self.pageNum == 1) {
          [self.workArray removeAllObjects];
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
    };
    network.failure = ^(NSDictionary *dict) {
            [self.tableview.mj_header endRefreshing];
            [self.tableview.mj_footer endRefreshing];
    };
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return YES;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.workArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 97;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 117;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * ONLINEHEADERVIEW = @"ONLINEHEADERVIEW";
    RSOnlineVideoHeaderView * onlineHeaderView = [[RSOnlineVideoHeaderView alloc]initWithReuseIdentifier:ONLINEHEADERVIEW];
    onlineHeaderView.showLabel.text = self.onlinemodel.videoDescribe;
    return onlineHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * FIRSTCELLID = @"ONLINEVIDEOCELLID";
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
    [RSJumpVideoTool canYouSkipThePlaybackVideoInterfaceMoment:onlinemodel andViewController:self andUserModel:self.usermodel];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.player _pauseVideo];
}

- (void)dealloc{
    [self.player _deallocPlayer];
}

- (void)upViewController{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
