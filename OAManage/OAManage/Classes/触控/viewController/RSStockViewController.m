//
//  RSStockViewController.m
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSStockViewController.h"
#import "RSBLStockCell.h"
#import "RSSLStockHeaderView.h"
#import "RSSLStockFootView.h"
#import "RSSLStockCell.h"
#import "RSTouchAlertView.h"
//荒料的模型
#import "RSBMStockModel.h"
//大板的模型
#import "RSSlStockModel.h"
#import "RSSLPieceModel.h"


@interface RSStockViewController ()<RSTouchAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>

//列表的显示
@property (nonatomic,strong)NSMutableArray * choosingArray;
//记录打开的分组
@property (nonatomic,strong)NSMutableArray * expendArray;
//取消的数组
@property (nonatomic,strong)NSMutableArray * cancelArray;

@property (nonatomic,strong)RSTouchAlertView * touchAlertview;

@property (nonatomic,assign)NSInteger pageNum;
//荒料号
@property (nonatomic,strong)NSString * blockNo;
//物料名称
@property (nonatomic,strong)NSString * mtlName;

@property (nonatomic,strong)UITableView * contentTableview;

@end

@implementation RSStockViewController

- (RSTouchAlertView *)touchAlertview{
    if (!_touchAlertview) {
        _touchAlertview = [[RSTouchAlertView alloc]initWithFrame:CGRectMake(33, SCH/2 - 180, SCW - 66, 290)];
        _touchAlertview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        _touchAlertview.layer.cornerRadius = 15;
        _touchAlertview.delegate = self;
    }
    return _touchAlertview;
}

//- (UITableView *)contentTableview{
//    if (!_contentTableview) {
//        CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
//        //CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight))
//        CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
//        _contentTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight)) style:UITableViewStyleGrouped];
//        _contentTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _contentTableview.delegate = self;
//        _contentTableview.dataSource = self;
//    }
//    return _contentTableview;
//}

- (NSMutableArray *)choosingArray{
    if (!_choosingArray) {
        _choosingArray = [NSMutableArray array];
    }
    return _choosingArray;
}

- (NSMutableArray *)expendArray{
    if (!_expendArray) {
        _expendArray = [NSMutableArray array];
    }
    return _expendArray;
}

- (NSMutableArray *)cancelArray{
    if (!_cancelArray) {
        _cancelArray = [NSMutableArray array];
    }
    return _cancelArray;
}

- (NSMutableArray *)selectdeContentArray{
    if (!_selectdeContentArray) {
        _selectdeContentArray = [NSMutableArray array];
    }
    return _selectdeContentArray;
}

- (NSMutableArray *)selectionArray{
    if (!_selectionArray) {
        _selectionArray = [NSMutableArray array];
    }
    return _selectionArray;
}

static NSString * SLSTOCKHEADERVIEWID = @"SLSTOCKHEADERVIEWID";
static NSString * SLSTOCKFOOTVIEWID = @"SLSTOCKFOOTVIEWID";
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"荒料库存";
    self.emptyView.hidden = YES;
//    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
    self.contentTableview.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
   // self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    self.contentTableview.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [self.tableview removeFromSuperview];
//     if (@available(iOS 11.0, *)) {
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    UITableView * contentTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, SCW, SCH - Height_NavBar) style:UITableViewStyleGrouped];
    contentTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableview.delegate = self;
    contentTableview.dataSource = self;
    contentTableview.estimatedRowHeight = 0;
    contentTableview.estimatedSectionHeaderHeight = 0;
    contentTableview.estimatedSectionFooterHeight = 0;
    _contentTableview = contentTableview;
    [self.view addSubview:self.contentTableview];
    self.blockNo = @"";
    self.mtlName = @"";
    UIButton * screenBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [screenBtn addTarget:self action:@selector(screenAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * testitem = [[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    self.navigationItem.rightBarButtonItem = testitem;
    self.pageNum = 1;
    self.contentTableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadAuditedNewData)];
    self.contentTableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadAuditedMoreNewData)];
    [self.contentTableview.mj_header beginRefreshing];
    [self setUIBottomView];
}

- (void)reloadAuditedNewData{
    self.pageNum = 1;
    [self reloadStockData];
}

- (void)reloadAuditedMoreNewData{
    [self reloadStockData];
}

- (void)reloadStockData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString *const kInitVector = @"16-Bytes--String";
    NetworkTool * network = [[NetworkTool alloc]init];
    NSNumber * number = [NSNumber numberWithInteger:self.pageNum];
    NSString * type = [NSString string];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        type = @"BM";
    }else{
        type = @"SL";
    }
    //113956
    NSNumber * deaid = [NSNumber numberWithInteger:self.shippermodel.shipperId];
    NSString * notice = [NSString string];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        notice = URL_YIGODATA_STOCK(number, @(10), self.mtlName,self.blockNo,deaid,type);
    }else{
        NSNumber * whsId = [NSNumber numberWithInteger:self.warehousemodel.warehouseId];
        NSNumber * storeAreaId = [NSNumber numberWithInteger:self.storeAreamodel.storeAreaId];
        notice = URL_YIGODATA_SLSTOCK(number, @(10), self.mtlName, self.blockNo, deaid, type, whsId, storeAreaId);
    }
    NSString * aes2 = [FSAES128 encryptAES:notice key:aes andKInItVector:kInitVector];
    NSString * canshu = URL_YIGODATA_NOTICE(self.usermodel.appLoginToken, aes2);
    NSString * sopaStr = URL_YIGODATA_IOS(URL_WORKFLOWWEBSERVICE, URL_STOCK, canshu);
    [network reloadWebServiceNoDataURL:URL_YIGO_IOS andParameters:sopaStr andURLName:URL_STOCK];
    if ([self.selectType isEqualToString:@"huangliao"]) {
        network.successReload = ^(NSDictionary *dict) {
             NSArray * array = [RSBMStockModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
           if (self.pageNum == 1) {
                 [self.choosingArray removeAllObjects];
                 [self.choosingArray addObjectsFromArray:array];
                 self.pageNum = 2;
                 [self.contentTableview.mj_header endRefreshing];
            }else{
                 NSArray * array1 = array;
                 [self.choosingArray addObjectsFromArray:array1];
                 self.pageNum++;
                 [self.contentTableview.mj_footer endRefreshing];
            }
            [self.contentTableview reloadData];
//            if (self.choosingArray.count > 0 ) {
//                self.emptyView.hidden = YES;
//            }else{
//                self.emptyView.hidden = NO;
//            }
        };
        network.failure = ^(NSDictionary *dict) {
//            if (self.choosingArray.count > 0 ) {
//                self.emptyView.hidden = YES;
//            }else{
//                self.emptyView.hidden = NO;
//            }
                [self.contentTableview.mj_header endRefreshing];
                [self.contentTableview.mj_footer endRefreshing];
        };
    }else{
        network.successReload = ^(NSDictionary *dict) {
            NSMutableArray * array = [NSMutableArray array];
            array = dict[@"list"];
            if (self.pageNum == 1) {
                [self.choosingArray removeAllObjects];
                NSMutableArray * tempArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    RSSlStockModel * slstockmodel = [[RSSlStockModel alloc]init];
                    slstockmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    slstockmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slstockmodel.msid = [[array objectAtIndex:i]objectForKey:@"msid"];
                    slstockmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    slstockmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    tempArray = [[array objectAtIndex:i]objectForKey:@"piece"];
                    for (int j = 0; j < tempArray.count; j++) {
                        RSSLPieceModel * slpiecemodel = [[RSSLPieceModel alloc]init];
                        slpiecemodel.area = [[tempArray objectAtIndex:j]objectForKey:@"area"];
                        slpiecemodel.did = [[[tempArray objectAtIndex:j]objectForKey:@"did"] integerValue];
                        slpiecemodel.slNo = [[[tempArray objectAtIndex:j]objectForKey:@"slNo"] integerValue];
                        slpiecemodel.msid = [[tempArray objectAtIndex:j]objectForKey:@"msid"];
                        slpiecemodel.mtlName = [[tempArray objectAtIndex:j]objectForKey:@"mtlName"];
                        slpiecemodel.blockNo = [[tempArray objectAtIndex:j]objectForKey:@"blockNo"];
                        slpiecemodel.turnsNo = [[tempArray objectAtIndex:j]objectForKey:@"turnsNo"];
                        slpiecemodel.isbool = false;
                        slpiecemodel.isSelect = false;
                        [slstockmodel.piece addObject:slpiecemodel];
                    }
                    [self.choosingArray addObject:slstockmodel];
                }
                self.pageNum = 2;
                [self.contentTableview.mj_header endRefreshing];
            }else{
                NSMutableArray * tempArray = [NSMutableArray array];
                NSMutableArray * contentArray = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    RSSlStockModel * slstockmodel = [[RSSlStockModel alloc]init];
                    slstockmodel.area = [[array objectAtIndex:i]objectForKey:@"area"];
                    slstockmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    slstockmodel.msid = [[array objectAtIndex:i]objectForKey:@"msid"];
                    slstockmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                     slstockmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    tempArray = [[array objectAtIndex:i]objectForKey:@"piece"];
                    for (int j = 0; j < tempArray.count; j++) {
                        RSSLPieceModel * slpiecemodel = [[RSSLPieceModel alloc]init];
                        slpiecemodel.area = [[tempArray objectAtIndex:j]objectForKey:@"area"];
                        slpiecemodel.did = [[[tempArray objectAtIndex:j]objectForKey:@"did"] integerValue];
                        slpiecemodel.slNo = [[[tempArray objectAtIndex:j]objectForKey:@"slNo"] integerValue];
                        slpiecemodel.msid = [[tempArray objectAtIndex:j]objectForKey:@"msid"];
                        slpiecemodel.mtlName = [[tempArray objectAtIndex:j]objectForKey:@"mtlName"];
                        slpiecemodel.blockNo = [[tempArray objectAtIndex:j]objectForKey:@"blockNo"];
                        slpiecemodel.turnsNo = [[tempArray objectAtIndex:j]objectForKey:@"turnsNo"];
                        slpiecemodel.isbool = false;
                        slpiecemodel.isSelect = false;
                        [slstockmodel.piece addObject:slpiecemodel];
                    }
                    [contentArray addObject:slstockmodel];
                }
                [self.choosingArray addObjectsFromArray:contentArray];
                self.pageNum++;
                //[self.contentTableview reloadData];
                [self.contentTableview.mj_footer endRefreshing];
            }
             [self.contentTableview reloadData];
//            if (self.choosingArray.count > 0 ) {
//                self.emptyView.hidden = YES;
//            }else{
//                self.emptyView.hidden = NO;
//            }
        };
        network.failure = ^(NSDictionary *dict) {
//            if (self.choosingArray.count > 0 ) {
//                self.emptyView.hidden = YES;
//            }else{
//                self.emptyView.hidden = NO;
//            }
                [self.contentTableview.mj_header endRefreshing];
                [self.contentTableview.mj_footer endRefreshing];
        };
    }
}

- (void)screenAction:(UIButton *)screenBtn{
     [self.touchAlertview showView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.contentTableview) {
        if ([self.selectType isEqualToString:@"huangliao"]) {
            return 1;
        }else{
            return self.choosingArray.count;
        }
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.contentTableview) {
        if ([self.selectType isEqualToString:@"huangliao"]) {
              return self.choosingArray.count;
          }else{
              if ([self.expendArray containsObject:@(section)]) {
                  RSSlStockModel * slstockmodel = self.choosingArray[section];
                  return slstockmodel.piece.count;
              }else{
                  return 0;
              }
          }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.contentTableview) {
        if ([self.selectType isEqualToString:@"daban"]) {
              return 148;
             
         }else{
              return 0.001;
         }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.contentTableview) {
        if ([self.selectType isEqualToString:@"daban"]) {
            return 10;
        }else{
            return 0.001;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.contentTableview) {
        if ([self.selectType isEqualToString:@"huangliao"]) {
               return 126;
           }else{
               return 70.5;
           }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.contentTableview) {
        if ([self.selectType isEqualToString:@"daban"]) {
            RSSLStockHeaderView * slstockHeaderview = [[RSSLStockHeaderView alloc]initWithReuseIdentifier:SLSTOCKHEADERVIEWID];
            slstockHeaderview.selectBtn.tag = section;
            slstockHeaderview.tag = section;
            slstockHeaderview.tap.view.tag = section;
            RSSlStockModel * slstockmodel = self.choosingArray[section];
            slstockHeaderview.slstockmodel = slstockmodel;
            if (self.selectdeContentArray.count > 0) {
                for (int j = 0; j < self.selectdeContentArray.count; j++) {
                    RSSLPieceModel * slpiecemodel = self.selectdeContentArray[j];
                    for (int i = 0; i < slstockmodel.piece.count; i++) {
                         RSSLPieceModel * slpiecemodel1 = slstockmodel.piece[i];
                        if (slpiecemodel.did == slpiecemodel1.did) {
                            if (!slpiecemodel.isSelect) {
                                slpiecemodel1.isSelect = false;
                            }else{
                                slpiecemodel1.isSelect = true;
                            }
                        }
                    }
                }
                BOOL selectAll = YES;
                for (int i = 0; i < slstockmodel.piece.count; i++) {
                    RSSLPieceModel * slpiecemodel = slstockmodel.piece[i];
                    if (!slpiecemodel.isSelect) {
                        selectAll = NO;
                        break;
                    }
                }
                slstockHeaderview.selectBtn.selected = selectAll;
            }else{
                BOOL selectAll = YES;
                for (int i = 0; i < slstockmodel.piece.count; i++) {
                    RSSLPieceModel * slpiecemodel = slstockmodel.piece[i];
                    if (!slpiecemodel.isSelect) {
                        selectAll = NO;
                        break;
                    }
                }
                 slstockHeaderview.selectBtn.selected = selectAll;
            }
            if ([self.expendArray containsObject:@(section)]) {
                slstockHeaderview.choosingDirectionImageView.transform = CGAffineTransformMakeRotation(M_PI);
            }else {
                slstockHeaderview.choosingDirectionImageView.transform = CGAffineTransformIdentity;
            }
            [slstockHeaderview.selectBtn addTarget:self action:@selector(dabanHeaderButtonOnClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [slstockHeaderview.tap addTarget:self action:@selector(dabanHeaderTapAction:)];
            return slstockHeaderview;
        }else{
            return nil;
        }
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == self.contentTableview) {
        if ([self.selectType isEqualToString:@"daban"]) {
             RSSLStockFootView * slstockFootview = [[RSSLStockFootView alloc]initWithReuseIdentifier:SLSTOCKFOOTVIEWID];
               return slstockFootview;
        }else{
            return nil;
        }
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.contentTableview) {
        if ([self.selectType isEqualToString:@"huangliao"]) {
            static NSString * STOCKCELLID = @"STOCKCELLID";
            RSBLStockCell * cell = [tableView dequeueReusableCellWithIdentifier:STOCKCELLID];
            if (!cell) {
                cell = [[RSBLStockCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:STOCKCELLID];
            }
            RSBMStockModel * bmstockmodel = self.choosingArray[indexPath.row];
            cell.bmstockmodel = bmstockmodel;
            cell.selectBtn.tag = indexPath.row;
            if (self.selectionArray.count > 0) {
                 for (int i = 0; i < self.selectionArray.count; i++) {
                 RSBMStockModel * bmstockmodel1 = self.selectionArray[i];
                    if (bmstockmodel1.did == bmstockmodel.did) {
                        cell.selectBtn.selected = YES;
                        break;
                    }else{
                        cell.selectBtn.selected = false;
                    }
                }
            }
            else{
                cell.selectBtn.selected = false;
            }
            [cell.selectBtn addTarget:self action:@selector(huangliaoSelectAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString * STOCKCELLID = @"STOCKCELLID";
            RSSLStockCell * cell = [tableView dequeueReusableCellWithIdentifier:STOCKCELLID];
            if (!cell) {
                cell = [[RSSLStockCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:STOCKCELLID];
            }
            cell.tag = indexPath.section;
            cell.selectBtn.tag = indexPath.row;
            [cell.selectBtn addTarget:self action:@selector(dabanShowAndHideSelectContentAction:) forControlEvents:UIControlEventTouchUpInside];
            RSSlStockModel * slstockmodel = self.choosingArray[indexPath.section];
            RSSLPieceModel * slpiecemodel = slstockmodel.piece[indexPath.row];
            cell.filmNumberLabel.text = [NSString stringWithFormat:@"片号%ld",(long)(indexPath.row + 1)];
            cell.longDetailLabel.text = [NSString stringWithFormat:@"%0.3lf",[slpiecemodel.area doubleValue]];
            if (self.selectdeContentArray.count > 0) {
                   for (int i = 0; i < self.selectdeContentArray.count; i++) {
                       RSSLPieceModel * slpiecemodel1 = self.selectdeContentArray[i];
                       if (slpiecemodel1.did == slpiecemodel.did) {
                           cell.selectBtn.selected = true;
                           slpiecemodel.isSelect = true;
                           break;
                       }else{
                           cell.selectBtn.selected = false;
                           slpiecemodel.isSelect = false;
                       }
                   }
                   if (slpiecemodel.isSelect) {
                       cell.selectBtn.selected = true;
                   }else{
                       cell.selectBtn.selected = false;
                   }
               }else{
                   if (slpiecemodel.isSelect) {
                       cell.selectBtn.selected = true;
                   }else{
                       cell.selectBtn.selected = false;
                   }
               }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return nil;
}

- (void)setUIBottomView{
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27c79a"]];
    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}
//确定的方法
- (void)sureAction:(UIButton *)sureBtn{
    if ([self.selectType isEqualToString:@"huangliao"]) {
        if (self.selectionArray.count < 1) {
               jxt_showToastMessage(@"请选择需要的内容", 0.75);
               return;
           }
           if ([self.selectType isEqualToString:@"huangliao"]) {
               if ([self.delegate respondsToSelector:@selector(huangliaoSelectContentArray:andCancelArray:)]) {
                   [self.delegate huangliaoSelectContentArray:self.selectionArray andCancelArray:self.cancelArray];
               }
           }
    }else{
        if (self.selectdeContentArray.count < 1) {
               jxt_showToastMessage(@"请选择需要的内容", 0.75);
               return;
           }
           if ([self.delegate respondsToSelector:@selector(dabanChoosingContentArray:andCancelArray:)]) {
              [self.delegate dabanChoosingContentArray:self.selectdeContentArray andCancelArray:self.cancelArray];
           }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//荒料cell的选择
- (void)huangliaoSelectAction:(UIButton *)selectBtn{
    selectBtn.selected = !selectBtn.selected;
    if (selectBtn.selected) {
        RSBMStockModel * bmstockmodel = self.choosingArray[selectBtn.tag];
        [self.selectionArray addObject:bmstockmodel];
    }else{
        RSBMStockModel * bmstockmodel = self.choosingArray[selectBtn.tag];
        for (int i = 0; i < self.selectionArray.count; i++) {
            RSBMStockModel * bmstockmodel1 = self.selectionArray[i];
            if (bmstockmodel1.did == bmstockmodel.did) {
                [self.selectionArray removeObjectAtIndex:i];
                [self.cancelArray addObject:@(bmstockmodel.did)];
            }
         }
      }
}
//大板Cell的选择
- (void)dabanShowAndHideSelectContentAction:(UIButton *)selectBtn{
    UIView *v = [selectBtn superview];//获取父类view
    UIView *v1 = [v superview];
    UIView * v2 = [v1 superview];
    RSSLStockCell * cell = (RSSLStockCell *)[v2 superview];
       RSSlStockModel * slstockmodel = self.choosingArray[cell.tag];
       RSSLPieceModel * slpiecemodel = slstockmodel.piece[selectBtn.tag];
       selectBtn.selected = !selectBtn.selected;
       if (selectBtn.selected) {
           slpiecemodel.isSelect = true;
           [self.selectdeContentArray addObject:slpiecemodel];
       }else{
           [self.cancelArray addObject:@(slpiecemodel.did)];
           slpiecemodel.isSelect = false;
           for (int i = 0; i < self.selectdeContentArray.count; i++) {
               RSSLPieceModel * slpiecemodel1 = self.selectdeContentArray[i];
               if (slpiecemodel1.did == slpiecemodel.did) {
                   [self.selectdeContentArray removeObjectAtIndex:i];
                   break;
               }
           }
       }
       //[self.tableview reloadSections:[NSIndexSet indexSetWithIndex:cell.tag] withRowAnimation:UITableViewRowAnimationNone];
     [self.contentTableview reloadSections:[NSIndexSet indexSetWithIndex:cell.tag] withRowAnimation:UITableViewRowAnimationNone];
}
//大板的头部视图selectBtn的方法
- (void)dabanHeaderButtonOnClickAction:(UIButton *)selectBtn{
    RSSlStockModel * slstockmodel = self.choosingArray[selectBtn.tag];
        selectBtn.selected = !selectBtn.selected;
       if (selectBtn.selected) {
           for (int i = 0; i < slstockmodel.piece.count; i++) {
               RSSLPieceModel * slpiecemodel = slstockmodel.piece[i];
               if (slpiecemodel.isSelect) {
                   slpiecemodel.isSelect = true;
               }else{
                   [self.selectdeContentArray addObject:slpiecemodel];
                   slpiecemodel.isSelect = true;
               }
           }
       }else {
           for (int i = 0; i < slstockmodel.piece.count; i++) {
               RSSLPieceModel * slpiecemodel = slstockmodel.piece[i];
               slpiecemodel.isSelect = false;
               [self.cancelArray addObject:@(slpiecemodel.did)];
           }
           
           for (int i = 0; i < self.selectdeContentArray.count; i++) {
               RSSLPieceModel * slpiecemodel1 = self.selectdeContentArray[i];
               for (int j = 0; j < slstockmodel.piece.count; j++) {
                   RSSLPieceModel * slpiecemodel = slstockmodel.piece[j];
                   if (slpiecemodel.did == slpiecemodel1.did) {
                       [self.selectdeContentArray removeObjectAtIndex:i];
                       i--;
                       break;
                   }
               }
           }
       }
    //[self.tableview reloadData];
    [self.contentTableview reloadData];
}
//大板头部视图的的选择
- (void)dabanHeaderTapAction:(UITapGestureRecognizer *)tap{
    RSSLStockHeaderView * slstockHeaderview = (RSSLStockHeaderView *)tap.view;
    if ([self.expendArray containsObject:@(slstockHeaderview.tag)]) {
        [self.expendArray removeObject:@(slstockHeaderview.tag)];
        [UIView animateWithDuration:0.1 animations:^{
            slstockHeaderview.choosingDirectionImageView.transform = CGAffineTransformIdentity;
        }];
    }else{
        [self.expendArray addObject:@(slstockHeaderview.tag)];
        [UIView animateWithDuration:0.1 animations:^{
            slstockHeaderview.choosingDirectionImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
    [self.contentTableview reloadData];
}

//rstouchAlertViewDelegate
- (void)inputName:(NSString *)string andBlockName:(NSString *)blockName{
    self.mtlName = string;
    self.blockNo = blockName;
    self.pageNum = 1;
    [self reloadStockData];
}

@end
