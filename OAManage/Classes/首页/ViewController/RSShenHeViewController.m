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



- (UITableView *)leftTableview{
    if (!_leftTableview) {
        _leftTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 79, SCH - 64) style:UITableViewStylePlain];
        _leftTableview.delegate = self;
        _leftTableview.dataSource = self;
        _leftTableview.showsVerticalScrollIndicator = NO;
        _leftTableview.showsHorizontalScrollIndicator = NO;
        _leftTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
    }
    return _leftTableview;
}


- (UITableView *)rightTableview{
    if (!_rightTableview) {
        _rightTableview = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTableview.frame), 64,SCW -CGRectGetMaxX(self.leftTableview.frame) , SCH - 64) style:UITableViewStylePlain];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    RSShenHeFristCell * cell = [self.leftTableview cellForRowAtIndexPath:indexpath];
    cell.shenHeLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    [self reloadShenHeNewData];
    
    
    RSWeakself
    self.emptyView.reAction = ^{
        weakSelf.pageNum = 1;
        [weakSelf reloadRightShenHeNewData];
    };
    
    self.rightTableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        [weakSelf reloadRightShenHeNewData];
        [weakSelf.rightTableview.mj_header endRefreshing];
    }];
    
    self.rightTableview.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf reloadRightShenHeNewData];
        [weakSelf.rightTableview.mj_footer endRefreshing];
    }];
}


- (void)reloadShenHeNewData{
    NSString * kongStr = @"";
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, kongStr);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_FLOWLIST, canshu);
    NetworkTool * network = [[NetworkTool alloc]init];
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_FLOWLIST];
    network.successArrayReload = ^(NSMutableArray *array) {
        self.leftArray = array;
        self.leftTableview.hidden = NO;
        self.rightTableview.hidden = NO;
        if (self.leftArray.count > 0) {
            self.emptyView.hidden = YES;
        }else{
            self.emptyView.hidden = NO;
        }
        //默认选中第一个位置
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        self.selectIndex = indexpath.row;
        [self.leftTableview selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.leftTableview reloadData];
        [self.rightTableview.mj_header beginRefreshing];
    };
}

- (void)reloadRightShenHeNewData{
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
             self.pageNum = 2;
        }else{
            NSArray * array1 = array;
            [self.rightArray addObjectsFromArray:array1];
            self.pageNum++;
        }
        [self.rightTableview reloadData];
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
    [self.rightTableview.mj_header beginRefreshing];
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
        return 48;
    }else{
        if (IS_IPHONE) {
            return (93 / SCW) * SCW;
        }else{
            if (DEVICES_IS_PRO_12_9) {
                return  120 * SCALE_TO_PRO;
            }else{
                return (120 / SCW) * SCW;
            }
        }
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
        if (indexPath.row > 0) {
            cell.shenHeImageView.hidden = YES;
            
        }else{
            cell.shenHeImageView.hidden = NO;
    
        }
        
            if (indexPath.row == self.selectIndex) {
                    cell.shenHeLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
                }else{
                    cell.shenHeLabel.backgroundColor = [UIColor clearColor];
            }
        return cell;
    }else{
        static NSString * CELLID = @"SHE3ID";
        RSApprovalCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
        if (!cell) {
            cell = [[RSApprovalCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLID];
        }
        cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        cell.auditemodel = self.rightArray[indexPath.row];
       // cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            cell.shenHeLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        }else{
            cell.shenHeLabel.backgroundColor = [UIColor clearColor];
        }
        [self.leftTableview reloadData];
       
        [self.rightTableview.mj_header beginRefreshing];
        
        
    }else{
     
        RSAuditedModel * auditemodel = self.rightArray[indexPath.row];
        RSApprovalProcessViewController * approvalProgressVc = [[RSApprovalProcessViewController alloc]init];
        approvalProgressVc.billId = auditemodel.billId;
        [self.navigationController pushViewController:approvalProgressVc animated:YES];

    }
}




- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
