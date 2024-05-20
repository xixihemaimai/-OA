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

@interface RSOnlineVideoPlayViewController ()
<SJEdgeControlLayerDelegate>


@property (nonatomic,strong)UIView *playerSuperview;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,strong)NSMutableArray * workArray;

@property (nonatomic,strong)SJVideoPlayer * player;

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
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    applegate.allowRotation = 1;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.player.rotationManager.disabledAutorotation = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emptyView.hidden = YES;
    
    UIView *playerSuperview = [[UIView alloc]init];
    playerSuperview.frame = CGRectMake(0, 0, SCW, 215);
    self.tableview.tableHeaderView = playerSuperview;
    self.player = [SJVideoPlayer player];
    [playerSuperview addSubview:self.player.view];
    NSURL * proxyURL = [NSURL URLWithString:[KTVHTTPCache proxyURLStringWithOriginalURLString:[NSString stringWithFormat:@"%@%@",URL_NEWPOST_IOS,self.onlinemodel.url]]];
        self.player.URLAsset = [[SJVideoPlayerURLAsset alloc]initWithURL:proxyURL];
    self.player.defaultEdgeControlLayer.hiddenTitleItemWhenOrientationIsPortrait = false;
//    // 设置资源
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.player.presentView.placeholderImageView.image = [UIImage imageNamed:@"默认图"];
    //是否开启剪辑工具栏
    self.player.defaultEdgeControlLayer.enabledClips = true;
    self.player.defaultEdgeControlLayer.delegate = self;
    
    
    
    self.pageNum = 1;
    self.tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadVideoListNewData)];
    self.tableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadVideoListMoreNewData)];
    [self reloadAuditedData];
    
}


//SJEdgeControlLayerDelegate按键返回的代理（//点击返回按钮的回调）
- (void)backItemWasTappedForControlLayer:(id<SJControlLayer>)controlLayer{
    if (!self.player.isFullscreen) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
     NSString * mechanismS = [user objectForKey:@"mechanismName"];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    [dict setValue:URL_NEWRECOMMEND_IOS((long)self.pageNum,6,mechanismS,(long)self.onlinemodel.onlineId,(long)self.onlinemodel.videoTypeId, self.onlinemodel.videoTitle) forKey:@"data"];
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


//这是准备播放下一条视频
//- (void)videoPlayer:(__kindof SJBaseVideoPlayer *)videoPlayer prepareToPlay:(SJVideoPlayerURLAsset *)asset{
//    NSLog(@"------------------------------");
//}

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
     CGSize size = [self.onlinemodel.videoDescribe boundingRectWithSize:CGSizeMake(SCW - 31, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return size.height + 50;
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
    [RSJumpVideoTool canYouSkipThePlaybackVideoInterfaceMoment:onlinemodel andViewController:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.player pause];
}


- (void)dealloc{
    [self.player stop];
}


@end
