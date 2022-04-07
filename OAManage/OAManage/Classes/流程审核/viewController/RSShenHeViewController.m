//
//  RSShenHeViewController.m
//  OAManage
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSShenHeViewController.h"
#import "RSShenHeFristCell.h"
#import "RSApprovalCell.h"


#import "RSShenHeModel.h"


#import "RSApprovalProcessViewController.h"
#import "RSWKOAmanagerViewController.h"
#import "ZZQEmptyView.h"

@interface SCMenuItem : NSObject <SCNavigationMenuItemProtocol,UIScrollViewDelegate>

@property (nonatomic, strong) NSString *title1;
@property (nonatomic, strong) NSString *title2;

@end

@implementation SCMenuItem

- (NSString *)navigationTitle
{
    return self.title1 ?: @"";
}

- (NSString *)menuTitle
{
    return self.title2 ?: @"";
}

@end

@interface RSShenHeViewController ()<SCNavigationMenuViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SCNavigationMenuView *menuView;
//左边的UItableview
@property (nonatomic,strong)UITableView * leftTableview;
//右边的UItableview
@property (nonatomic,strong)UITableView * rightTableview;
//右边UItableview的分页
@property (nonatomic,assign)NSInteger pageNum;
//左边的数组
@property (nonatomic,strong)NSMutableArray * leftArray;
//右边的数组
@property (nonatomic,strong)NSMutableArray * rightArray;
//选择menuView的方式
@property (nonatomic,strong)NSString * selectType;
//选择左边cell的位置
@property (nonatomic,strong)NSString * billKey;
//选择的位置
@property (nonatomic,assign)NSInteger selectIndex;

@property (nonatomic,strong) ZZQEmptyView * currentemptyView;
@end

@implementation RSShenHeViewController

- (NSMutableArray *)leftArray{
    if (!_leftArray) {
        _leftArray = [NSMutableArray array];
    }
    return _leftArray;
}

- (NSMutableArray *)rightArray{
    if (!_rightArray) {
        _rightArray = [NSMutableArray array];
    }
    return _rightArray;
}

- (ZZQEmptyView *)currentemptyView{
    if (!_currentemptyView) {
        _currentemptyView = [[ZZQEmptyView alloc] initWithView:self.view];
        _currentemptyView.emptyMode = ZZQEmptyViewModeNoData;
        _currentemptyView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        _currentemptyView.label.text = @"暂无任务";
        [_currentemptyView.button setTitle:@"点击重新加载" forState:UIControlStateNormal];
        _currentemptyView.button.hidden = YES;
        _currentemptyView.showtype = @"1";
        [_currentemptyView.button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    return _currentemptyView;
}

- (UITableView *)leftTableview{
    if (!_leftTableview) {
       CGFloat witdh = 0.0;
       if (SCH >= 780) {
            witdh = 100;
       }else{
            witdh = 88;
        }
        _leftTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, witdh, SCH - Height_NavBar - Height_TabBar) style:UITableViewStylePlain];
        _leftTableview.delegate = self;
        _leftTableview.dataSource = self;
        _leftTableview.showsVerticalScrollIndicator = NO;
        _leftTableview.showsHorizontalScrollIndicator = NO;
        _leftTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableview.backgroundColor =  [UIColor colorWithHexColorStr:@"#ffffff"];
    }
    return _leftTableview;
}

- (UITableView *)rightTableview{
    if (!_rightTableview) {
        _rightTableview = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTableview.frame), Height_NavBar,SCW - CGRectGetMaxX(self.leftTableview.frame) , SCH - Height_NavBar - Height_TabBar) style:UITableViewStylePlain];
        _rightTableview.delegate = self;
        _rightTableview.dataSource = self;
        _rightTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
    }
    return _rightTableview;
}

- (SCNavigationMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[SCNavigationMenuView alloc] initWithNavigationMenuItems:nil];
        _menuView.delegate = self;
        [_menuView displayMenuInView:self.view];
    }
    return _menuView;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     // [[NSNotificationCenter defaultCenter]postNotificationName:@"reLoadCurrentViewData" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(retrievingData) name:@"reLoadCurrentViewData" object:nil];
    
}


//- (void)retrievingData{
//    self.pageNum = 1;
////    self.selectType = @"1";
////    self.billKey = @"";
////    self.selectIndex = 0;
//    [self reloadShenHeNewData];
//    [self reloadRightShenHeData];
//
//}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    self.pageNum = 1;
    self.selectType = @"1";
    self.billKey = @"";
    self.selectIndex = 0;
    
    self.navigationItem.titleView = self.menuView;
    NSMutableArray *array = [NSMutableArray array];
    SCMenuItem *item1 = [SCMenuItem new];
    item1.title1 = @"我审批的";
    item1.title2 = @"我审批的";
    [array addObject:item1];
    
    SCMenuItem *item2 = [SCMenuItem new];
    item2.title1 = @"我提交的";
    item2.title2 = @"我提交的";
    
    [array addObject:item2];
    
    SCMenuItem *item3 = [SCMenuItem new];
    item3.title1 = @"已办审批";
    item3.title2 = @"已办审批";
    [array addObject:item3];
    
    SCMenuItem *item4 = [SCMenuItem new];
    item4.title1 = @"结束流程";
    item4.title2 = @"结束流程";
    [array addObject:item4];
    [self.menuView setNavigationMenuItems:array];
    self.tableview.hidden = YES;
    [self.view addSubview:self.leftTableview];
    [self.view addSubview:self.rightTableview];
    self.leftTableview.hidden = YES;
    self.rightTableview.hidden = YES;
    [self.rightTableview addSubview:self.currentemptyView];
    
    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    RSShenHeFristCell * cell = [self.leftTableview cellForRowAtIndexPath:indexpath];
    cell.shenHeLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self reloadShenHeNewData];
    self.emptyView.hidden = NO;
    self.rightTableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadShenHeRightNewData)];
    self.rightTableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadShenHeRightMoreData)];
}

- (void)reloadShenHeRightNewData{
     self.pageNum = 1;
    [self reloadRightShenHeData];
}

- (void)reloadShenHeRightMoreData{
    [self reloadRightShenHeData];
}

- (void)reloadShenHeNewData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString * const kInitVector = @"16-Bytes--String";
    NSString * kongStr = URL_YIGODATA_WORKFLOWTYPE(self.selectType);
    NSString * aes2 = [FSAES128 encryptAES:kongStr key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_FLOWLIST, canshu);
    NetworkTool * network = [[NetworkTool alloc]init];
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_FLOWLIST];
    network.successArrayReload = ^(NSMutableArray *array) {
        [self.leftArray removeAllObjects];
        self.leftArray = array;
        self.leftTableview.hidden = NO;
        self.rightTableview.hidden = NO;
        if (self.leftArray.count > 0) {
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
        }
        BOOL isFind = false;
        //默认选中位置
        for (int i = 0; i < self.leftArray.count; i++) {
             RSShenHeModel * shenhemodel = self.leftArray[i];
            if ([shenhemodel.billKey isEqualToString:self.billKey]) {
                self.selectIndex = i;
                self.billKey = shenhemodel.billKey;
                isFind = true;
                break;
            }
        }
        if (!isFind) {
            self.selectIndex = 0;
            self.billKey = @"";
        }
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:self.selectIndex inSection:0];
        [self.leftTableview selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.leftTableview reloadData];
        [self.rightTableview.mj_header beginRefreshing];
    };
}

- (void)reloadRightShenHeData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString *const kInitVector = @"16-Bytes--String";
    NetworkTool * network = [[NetworkTool alloc]init];
    NSNumber * number = [NSNumber numberWithInteger:self.pageNum];
    NSString * notice = URL_YIGODDATA_FLOWLIST(number, @(10), self.selectType, self.billKey);
    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * soapStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_MYAUDIT, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:soapStr andURLName:URL_MYAUDIT];
    network.successArrayReload = ^(NSMutableArray *array) {
        if (self.pageNum == 1) {
            self.rightTableview.hidden = NO;
            self.leftTableview.hidden = NO;
            [self.rightArray removeAllObjects];
             self.rightArray = array;
            if (self.rightArray.count > 0) {
                self.currentemptyView.hidden = YES;
            }else{
                self.currentemptyView.hidden = NO;
            }
            [self.rightTableview.mj_header endRefreshing];
            self.pageNum = 2;
        }else{
            self.currentemptyView.hidden = YES;
            NSArray * array1 = array;
            [self.rightArray addObjectsFromArray:array1];
            [self.rightTableview.mj_footer endRefreshing];
            self.pageNum++;
        }
        [self.rightTableview reloadData];
    };
    network.failure = ^(NSDictionary *dict) {
            if (self.rightArray.count > 0) {
                self.currentemptyView.hidden = YES;
            }else{
                self.currentemptyView.hidden = NO;
            }
            [self.rightTableview.mj_header endRefreshing];
            [self.rightTableview.mj_footer endRefreshing];
    };
}
#pragma mark - SCNavigationMenuViewDelegate
- (void)navigationMenuView:(SCNavigationMenuView *)navigationMenuView didSelectItemAtIndex:(NSUInteger)index{
    //SCMenuItem * item =(SCMenuItem *)[navigationMenuView.navigationMenuItems objectAtIndex:index];
    /**
     1   待我审批
     2   我发起的
     3   已办审批
     4   结束流程
     */
    switch (index) {
        case 0:
            self.selectType = @"1";
            break;
        case 1:
            self.selectType = @"2";
            break;
        case 2:
            self.selectType = @"3";
            break;
        case 3:
            self.selectType = @"4";
            break;
        default:
            self.selectType = @"1";
            break;
    }
    self.pageNum = 1;
    //[self.rightTableview.mj_header beginRefreshing];
    [self reloadShenHeNewData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableview) {
        return self.leftArray.count;
    }else{
        return self.rightArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableview) {
        return 60;
    }else{
        return (93 / SCW) * SCW;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableview) {
        static NSString * CELLID = @"SHEID";
        RSShenHeFristCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
        if (!cell) {
            cell = [[RSShenHeFristCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLID];
        }
        RSShenHeModel * shenhemodel = self.leftArray[indexPath.row];
        cell.shenHeLabel.text = [NSString stringWithFormat:@"%@",shenhemodel.billName];
        if (shenhemodel.flowCount >= 99) {
            cell.countLabel.text = [NSString stringWithFormat:@"99"];
        }else{
            cell.countLabel.text = [NSString stringWithFormat:@"%ld",(long)shenhemodel.flowCount];
        }
        if (shenhemodel.flowCount == 0) {
            cell.countLabel.hidden = YES;
        }else{
            cell.countLabel.hidden = NO;
        }
        if (indexPath.row == 0) {
            cell.shenHeImageView.hidden = NO;
            cell.shenHeLabel.textAlignment = NSTextAlignmentLeft;
//            cell.shenHeImageView.sd_layout
//            .leftSpaceToView(cell.contentView, 10)
//            .centerYEqualToView(cell.contentView)
//            .widthIs(13)
//            .heightEqualToWidth();
            cell.shenHeLabel.frame = CGRectMake(CGRectGetMaxX(cell.shenHeImageView.frame)+ 5, cell.shenHeImageView.yj_y - 4.5, 32, 13);
            
        }else{
            cell.shenHeLabel.textAlignment = NSTextAlignmentLeft;
            cell.shenHeImageView.hidden = YES;
        }
        if (indexPath.row == self.selectIndex) {
            cell.shenHeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
            cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        }else{
            cell.shenHeLabel.textColor = [UIColor colorWithHexColorStr:@"#7d7d7d"];
            cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f8f8f8"];
        }
        return cell;
    }else{
        static NSString * CELLID = @"SHE3ID";
        RSApprovalCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
        if (!cell) {
            cell = [[RSApprovalCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLID];
        }
       // cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        cell.auditemodel = self.rightArray[indexPath.row];
        
       // UIColor * color = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];//通过RGB来定义自己的颜色
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];//这句不可省略
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexColorStr:@"#f7f7f9"];
        
        cell.approvalBottomView.yj_height = 0;
//        cell.approvalBottomView.sd_layout
//        .heightIs(0);
//        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableview) {
        //[self.leftTableview deselectRowAtIndexPath:indexPath animated:YES];
        RSShenHeFristCell * cell = [tableView cellForRowAtIndexPath:indexPath];
       // NSIndexPath *indexpath = self.leftTableview.indexPathForSelectedRow;
        self.pageNum = 1;
        RSShenHeModel * shenhemodel = self.leftArray[indexPath.row];
        self.billKey = shenhemodel.billKey;
        self.selectIndex = indexPath.row;
        if (indexPath.row == self.selectIndex) {
            cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        }else{
            cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8F8"];
        }
        [self.leftTableview reloadData];
        [self.rightTableview.mj_header beginRefreshing];
    }else{
        [self.rightTableview deselectRowAtIndexPath:indexPath animated:YES];
        RSAuditedModel * auditedmodel = self.rightArray[indexPath.row];
        RSWKOAmanagerViewController * wkOaVc = [[RSWKOAmanagerViewController alloc]init];
        wkOaVc.billId = auditedmodel.billId;
        wkOaVc.workItemId = auditedmodel.workItemId;
        wkOaVc.billKey = auditedmodel.billKey;
        wkOaVc.usertime = auditedmodel.createtime;
        wkOaVc.creatorName = auditedmodel.creatorName;  
        wkOaVc.deptName = auditedmodel.deptName;
        if ([self.selectType isEqualToString:@"1"]) {
            wkOaVc.isApproval = @"1";
        }else{
            wkOaVc.isApproval = @"0";
        }
        wkOaVc.type = @"1";
        wkOaVc.title = auditedmodel.billName;
        wkOaVc.version = [[[UIDevice currentDevice] systemVersion] floatValue];
        [self.navigationController pushViewController:wkOaVc animated:YES];
        RSWeakself
        wkOaVc.UpdateView = ^{
            weakSelf.pageNum = 1;
            [weakSelf reloadShenHeNewData];
            [weakSelf reloadRightShenHeData];
        };
    }
}




//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
