//
//  RSInputWorkViewController.m
//  OAManage
//
//  Created by mac on 2019/12/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSInputWorkViewController.h"
#import "RSApprovalProcessModel.h"

//添加的界面
#import "RSSalertView.h"
//新的组头视图
#import "RSApprovalHeaderView.h"
//新的cell
#import "RSApprovalProcessCell.h"
//工作模型
#import "RSWorkContentModel.h"
#import "RSWorkTypeModel.h"

@interface RSInputWorkViewController ()<RSSalertViewDelegate>

@property (nonatomic,strong)NSMutableArray * approvalArray;


@property (nonatomic,strong)UITextView * footTextview;


@property (nonatomic,strong)RSSalertView * salertview;


@property (nonatomic,assign)NSInteger select;

//时间
@property (nonatomic,strong)NSString * timeStr;

@property (nonatomic,strong)RSWorkContentModel * workContentmodel;


@end

@implementation RSInputWorkViewController

- (RSWorkContentModel *)workContentmodel{
    if (!_workContentmodel) {
        _workContentmodel = [[RSWorkContentModel alloc]init];
    }
    return _workContentmodel;
}


- (NSMutableArray *)approvalArray{
    if (!_approvalArray) {
        _approvalArray = [NSMutableArray array];
    }
    return _approvalArray;
}

- (RSSalertView *)salertview{
    if (!_salertview) {
        _salertview = [[RSSalertView alloc]initWithFrame:CGRectMake(33, (SCH/2) - 214, SCW - 66, 428)];
        _salertview.backgroundColor = [UIColor whiteColor];
        _salertview.layer.cornerRadius = 15;
        _salertview.delegate = self;
    }
    return _salertview;
}

static NSString * APPROVALHEADERVIEW = @"APPROVALHEADERVIEW";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeStr = [self dataChangString];
    self.title = @"填写日志";
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    self.emptyView.hidden = YES;
    
    
    [self setCustomTableViewFootView];
          
    [self setSaveBtnCustomView];
    
    
    
    UIButton * addBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addBtn setTitle:@"时间" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addBtn addTarget:self action:@selector(addTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = item;
    [self reloadOnlyAndAddWorkNewData];
}

- (void)setSaveBtnCustomView{
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, SCH - 50, SCW, 50);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:saveBtn];
    [saveBtn bringSubviewToFront:self.view];
    saveBtn.layer.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"].CGColor;
    saveBtn.layer.shadowColor = [UIColor colorWithHexColorStr:@"#E5E5E5"].CGColor;
    saveBtn.layer.shadowOffset = CGSizeMake(0,-1.5);
    saveBtn.layer.shadowOpacity = 1;
    saveBtn.layer.shadowRadius = 5;
    [saveBtn addTarget:self action:@selector(saveAndUpdateAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reloadOnlyAndAddWorkNewData{
    if ([self.showType isEqualToString:@"update"]) {
        //URL_DIARY_GET_DTL_IOS 获取
       NetworkTool * network = [[NetworkTool alloc]init];
       NSMutableDictionary * dict = [NSMutableDictionary dictionary];
       [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
       [dict setValue:URL_DIARY_NEWGET_DTL_IOS((long)self.auditedId) forKey:@"data"];
       [network newReloadWebServiceNoDataURL:URL_DIARY_GET_DTL_IOS andParameters:dict andURLName:URL_DIARY_GET_DTL_IOS];
        network.workSuccess = ^(RSWorkContentModel *workContentmodel) {
            self.workContentmodel = workContentmodel;
            self.footTextview.text = self.workContentmodel.summary;
            [self.tableview reloadData];
        };
    }
}

- (void)setCustomTableViewFootView{
    
    UIView * footView = [[UIView alloc]init];
    footView.frame = CGRectMake(0, 0, SCW, 84);
    footView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UITextView * footTextview = [[UITextView alloc]initWithFrame:CGRectMake(15, 8, SCW - 30, 68)];
    footTextview.backgroundColor = [UIColor colorWithHexColorStr:@"#F5F7FA"];
    footTextview.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    footTextview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
    footTextview.returnKeyType = UIReturnKeySend;
    //contentTextview.delegate = self;
    [footView addSubview:footTextview];
    
    footTextview.layer.cornerRadius = 4;
    footTextview.layer.masksToBounds = YES;
    _footTextview = footTextview;

//    [footView setupAutoHeightWithBottomView:footTextview bottomMargin:8];
//    [footView layoutIfNeeded];
    self.tableview.tableFooterView = footView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RSApprovalHeaderView * approvalHeaderview = [[RSApprovalHeaderView alloc]initWithReuseIdentifier:APPROVALHEADERVIEW];
    if (section == 0) {
        approvalHeaderview.titleLabel.text = @"今日计划";
    }else if (section == 1){
        approvalHeaderview.titleLabel.text = @"明日计划";
    }else if (section == 2){
        approvalHeaderview.titleLabel.text = @"今日未完成工作";
    }
    else{
        approvalHeaderview.titleLabel.text = @"今日总结";
        approvalHeaderview.addBtn.hidden = YES;
    }
    approvalHeaderview.addBtn.tag = section;
    [approvalHeaderview.addBtn addTarget:self action:@selector(addWorkContentAction:) forControlEvents:UIControlEventTouchUpInside];
    return approvalHeaderview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.workContentmodel.todayPlanArray.count;
    }else if (section == 1){
        return self.workContentmodel.tomorrowPlanArray.count;
    }else if (section == 2){
        return self.workContentmodel.inCompleteArray.count;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELLPROGRESSSTATUSID = @"CELLPROGRESSSTATUSID";
    RSApprovalProcessCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLPROGRESSSTATUSID];
    if (!cell) {
        cell = [[RSApprovalProcessCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLPROGRESSSTATUSID];
    }
    cell.contentView.tag = indexPath.section;
    if (indexPath.section == 0) {
      cell.workTypemodel = self.workContentmodel.todayPlanArray[indexPath.row];
    }else if (indexPath.section == 1){
        cell.workTypemodel = self.workContentmodel.tomorrowPlanArray[indexPath.row];
    }else if (indexPath.section == 2){
        cell.workTypemodel = self.workContentmodel.inCompleteArray[indexPath.row];
    }
    cell.openBtn.tag = indexPath.row;
    [cell.openBtn addTarget:self action:@selector(oepnAndCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        RSWorkTypeModel * workTypemodel = self.workContentmodel.todayPlanArray[indexPath.row];
        return workTypemodel.cellH;
    }else if (indexPath.section == 1){
        RSWorkTypeModel * workTypemodel = self.workContentmodel.tomorrowPlanArray[indexPath.row];
        return workTypemodel.cellH;
    }else{
        RSWorkTypeModel * workTypemodel = self.workContentmodel.inCompleteArray[indexPath.row];
        return workTypemodel.cellH;
    }
}


- (void)oepnAndCloseAction:(UIButton *)openBtn{
    UIView *v = [openBtn superview];//获取父类view
    UIView * v1 = [v superview];
    
    if (v1.tag == 0) {
        RSWorkTypeModel * workTypemodel = self.workContentmodel.todayPlanArray[openBtn.tag];
        openBtn.selected = !openBtn.selected;
        workTypemodel.open = openBtn.selected;
    }else if (v1.tag == 1){
        RSWorkTypeModel * workTypemodel = self.workContentmodel.tomorrowPlanArray[openBtn.tag];
        openBtn.selected = !openBtn.selected;
        workTypemodel.open = openBtn.selected;
    }else{
        RSWorkTypeModel * workTypemodel = self.workContentmodel.inCompleteArray[openBtn.tag];
        openBtn.selected = !openBtn.selected;
        workTypemodel.open = openBtn.selected;
    }
    [self.tableview reloadData];
//    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:openBtn.tag inSection:0];
//
//    [UIView performWithoutAnimation:^{
//
//    [self.tableview reloadRowsAtIndexPaths:@[indexpath]withRowAnimation:UITableViewRowAnimationNone];
//
//    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //要进去带进去的，是那个类型，具体内容，重要程度，重要程度的位置，输出结果，那个组，哪一个行，
    [self.salertview showView];
    if (indexPath.section == 0) {
        RSWorkTypeModel * workTypemodel = self.workContentmodel.todayPlanArray[indexPath.row];
        NSString * level = [workTypemodel.level substringFromIndex:6];
        [self.salertview.choiceBtn setTitle:level forState:UIControlStateNormal];
        self.salertview.addType = @"update";
        if ([workTypemodel.level isEqualToString:@"重要层度: 低"]) {
            self.salertview.select = 0;
        }else if ([workTypemodel.level isEqualToString:@"重要层度: 中"]){
            self.salertview.select = 1;
        }else{
            self.salertview.select = 2;
        }
        self.salertview.titleLabel.text = @"今日计划";
        NSString * content = [workTypemodel.content substringFromIndex:3];
        NSString * result = [workTypemodel.result substringFromIndex:6];
        
        self.salertview.contentTextview.text = content;
        self.salertview.resultTextview.text = result;
        self.salertview.indexpath = indexPath;
        
    }else if (indexPath.section  == 1){
        RSWorkTypeModel * workTypemodel = self.workContentmodel.tomorrowPlanArray[indexPath.row];
        NSString * level = [workTypemodel.level substringFromIndex:6];
        [self.salertview.choiceBtn setTitle:level forState:UIControlStateNormal];
        self.salertview.addType = @"update";
        if ([workTypemodel.level isEqualToString:@"重要层度: 低"]) {
            self.salertview.select = 0;
        }else if ([workTypemodel.level isEqualToString:@"重要层度: 中"]){
            self.salertview.select = 1;
        }else{
            self.salertview.select = 2;
        }
         self.salertview.titleLabel.text = @"明日计划";
        NSString * content = [workTypemodel.content substringFromIndex:3];
        NSString * result = [workTypemodel.result substringFromIndex:6];
        self.salertview.contentTextview.text = content;
        self.salertview.resultTextview.text = result;
        self.salertview.indexpath = indexPath;
    }else{
        RSWorkTypeModel * workTypemodel = self.workContentmodel.inCompleteArray[indexPath.row];
        NSString * level = [workTypemodel.level substringFromIndex:6];
        [self.salertview.choiceBtn setTitle:level forState:UIControlStateNormal];
        self.salertview.addType = @"update";
        if ([workTypemodel.level isEqualToString:@"重要层度: 低"]) {
            self.salertview.select = 0;
        }else if ([workTypemodel.level isEqualToString:@"重要层度: 中"]){
            self.salertview.select = 1;
        }else{
            self.salertview.select = 2;
        }
        self.salertview.titleLabel.text = @"今天未完成工作";
        NSString * content = [workTypemodel.content substringFromIndex:3];
        NSString * result = [workTypemodel.result substringFromIndex:6];
        self.salertview.contentTextview.text = content;
        self.salertview.resultTextview.text = result;
        self.salertview.indexpath = indexPath;
    }
}


- (void)addWorkContentAction:(UIButton *)addBtn{
    //这个是添加的section
    [self.salertview showView];
    switch (addBtn.tag) {
        case 0:
            self.salertview.titleLabel.text = @"今日计划";
            break;
        case 1:
            self.salertview.titleLabel.text = @"明日计划";
            break;
        case 2:
            self.salertview.titleLabel.text = @"今日未完成工作";
            break;
        default:
            self.salertview.titleLabel.text = @"今日计划";
            break;
    }
    [self.salertview.choiceBtn setTitle:@"低" forState:UIControlStateNormal];
    if (addBtn.tag == 0) {
       self.salertview.indexpath = [NSIndexPath indexPathForRow:self.workContentmodel.todayPlanArray.count inSection:addBtn.tag];
    }else if (addBtn.tag  == 1){
       self.salertview.indexpath = [NSIndexPath indexPathForRow:self.workContentmodel.tomorrowPlanArray.count inSection:addBtn.tag];
    }else{
       self.salertview.indexpath = [NSIndexPath indexPathForRow:self.workContentmodel.inCompleteArray.count inSection:addBtn.tag];
    }
    self.salertview.addType = @"add";
    self.salertview.select = 0;
    
}

- (void)addTimeAction:(UIButton *)timeBtn{
    //时间
    WSDatePickerView * datepicker = [[WSDatePickerView alloc]initWithDateStyle:DateStyleShowYearMonthDay scrollToDate:[NSDate date] CompleteBlock:^(NSDate *selectDate) {
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        self.timeStr = date;
        
           
    }];
    datepicker.doneButtonColor = [UIColor colorWithHexColorStr:@"#27c79a"];
    [datepicker show];
}



-(void)backSalertViewDataWithTitle:(NSString *)title andChoiceTitle:(NSString *)choiceTitle andSelect:(NSInteger)select andContentTextview:(NSString *)contentTextStr andResultTextview:(NSString *)resultTextStr andIndexpath:(NSIndexPath *)indexpath andAddType:(NSString *)addType{
    //这边总结，具体内容,输出结果
    
    if ([addType isEqualToString:@"add"]) {
        if (indexpath.section == 0) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setValue:contentTextStr forKey:@"content"];
            [dict setValue:resultTextStr forKey:@"result"];
            [dict setValue:choiceTitle forKey:@"level"];
            RSWorkTypeModel * workTypemodel = [RSWorkTypeModel statusWithDict:dict andIndex:indexpath.row];
            [self.workContentmodel.todayPlanArray addObject:workTypemodel];
        }else if (indexpath.section == 1){
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setValue:contentTextStr forKey:@"content"];
            [dict setValue:resultTextStr forKey:@"result"];
            [dict setValue:choiceTitle forKey:@"level"];
            RSWorkTypeModel * workTypemodel = [RSWorkTypeModel statusWithDict:dict andIndex:indexpath.row];
            [self.workContentmodel.tomorrowPlanArray addObject:workTypemodel];
        }else{
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setValue:contentTextStr forKey:@"content"];
            [dict setValue:resultTextStr forKey:@"result"];
            [dict setValue:choiceTitle forKey:@"level"];
            RSWorkTypeModel * workTypemodel = [RSWorkTypeModel statusWithDict:dict andIndex:indexpath.row];
            [self.workContentmodel.inCompleteArray addObject:workTypemodel];
        }
        [self.tableview reloadData];
        
    }else{
        //修改
        if (indexpath.section == 0) {
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setValue:contentTextStr forKey:@"content"];
            [dict setValue:resultTextStr forKey:@"result"];
            [dict setValue:choiceTitle forKey:@"level"];
            RSWorkTypeModel * workTypemodel = [RSWorkTypeModel statusWithDict:dict andIndex:indexpath.row];
            [self.workContentmodel.todayPlanArray replaceObjectAtIndex:indexpath.row withObject:workTypemodel];
        }else if (indexpath.section == 1){
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setValue:contentTextStr forKey:@"content"];
            [dict setValue:resultTextStr forKey:@"result"];
            [dict setValue:choiceTitle forKey:@"level"];
            RSWorkTypeModel * workTypemodel = [RSWorkTypeModel statusWithDict:dict andIndex:indexpath.row];
            [self.workContentmodel.tomorrowPlanArray replaceObjectAtIndex:indexpath.row withObject:workTypemodel];
        }else{
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            [dict setValue:contentTextStr forKey:@"content"];
            [dict setValue:resultTextStr forKey:@"result"];
            [dict setValue:choiceTitle forKey:@"level"];
            RSWorkTypeModel * workTypemodel = [RSWorkTypeModel statusWithDict:dict andIndex:indexpath.row];
            [self.workContentmodel.inCompleteArray replaceObjectAtIndex:indexpath.row withObject:workTypemodel];
        }
        [self.tableview reloadData];
    }
}



//保存
- (void)saveAndUpdateAction:(UIButton *)saveBtn{
    
    if ([self.footTextview.text length] < 1) {
        jxt_showToastMessage(@"没有添加工作总结", 0.75);
        return;
    }
    
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    
    NSMutableDictionary * paraDict = [NSMutableDictionary dictionary];
    [paraDict setValue:self.timeStr forKey:@"diaryDate"];
    [paraDict setValue:self.footTextview.text forKey:@"summary"];
    if ([self.showType isEqualToString:@"update"]) {
        [paraDict setValue:[NSNumber numberWithInteger:self.auditedId] forKey:@"id"];
    }
    NSMutableArray * todayArray = [NSMutableArray array];
    for (int i = 0; i < self.workContentmodel.todayPlanArray.count; i++) {
        RSWorkTypeModel * worktypemodel = self.workContentmodel.todayPlanArray[i];
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        [dict setValue:@"today_plan" forKey:@"diaryType"];
        NSString * level = [worktypemodel.level substringFromIndex:6];
        [dict setValue:level forKey:@"level"];
        NSString * content = [worktypemodel.content substringFromIndex:3];
        [dict setValue:content forKey:@"content"];
        NSString * result = [worktypemodel.result substringFromIndex:6];
        [dict setValue:result forKey:@"result"];
        [todayArray addObject:dict];
        [paraDict setValue:todayArray forKey:@"todayPlan"];
    }
    NSMutableArray * tomorrowArray = [NSMutableArray array];
    for (int i = 0; i < self.workContentmodel.tomorrowPlanArray.count; i++) {
        RSWorkTypeModel * worktypemodel = self.workContentmodel.tomorrowPlanArray[i];
               NSMutableDictionary * dict = [NSMutableDictionary dictionary];
               [dict setValue:@"tomorrow_plan" forKey:@"diaryType"];
        NSString * level = [worktypemodel.level substringFromIndex:6];
               [dict setValue:level forKey:@"level"];
        NSString * content = [worktypemodel.content substringFromIndex:3];
               [dict setValue:content forKey:@"content"];
        NSString * result = [worktypemodel.result substringFromIndex:6];
               [dict setValue:result forKey:@"result"];
               [tomorrowArray addObject:dict];
          [paraDict setValue:tomorrowArray forKey:@"tomorrowPlan"];
    }
    NSMutableArray * completeArray = [NSMutableArray array];
    for (int i = 0; i < self.workContentmodel.inCompleteArray.count; i++) {
        RSWorkTypeModel * worktypemodel = self.workContentmodel.inCompleteArray[i];
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        [dict setValue:@"incomplete" forKey:@"diaryType"];
        NSString * level = [worktypemodel.level substringFromIndex:6];
        [dict setValue:level forKey:@"level"];
         NSString * content = [worktypemodel.content substringFromIndex:3];
        [dict setValue:content forKey:@"content"];
        NSString * result = [worktypemodel.result substringFromIndex:6];
        [dict setValue:result forKey:@"result"];
        [completeArray addObject:dict];
        [paraDict setValue:completeArray forKey:@"incomplete"];
    }
    NSData *data=[NSJSONSerialization dataWithJSONObject:paraDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [dict setValue:jsonStr forKey:@"data"];
    //这边是所有的
    if ([self.showType isEqualToString:@"add"]) {
        //添加
        //URL_DIARY_ADD_IOS
        [network newReloadWebServiceNoDataURL:URL_DIARY_ADD_IOS andParameters:dict andURLName:URL_DIARY_ADD_IOS];
        network.workSuccess = ^(RSWorkContentModel *workContentmodel) {
            self.workContentmodel = workContentmodel;
            self.footTextview.text = self.workContentmodel.summary;
            [self.tableview reloadData];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadWork" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        };
    }else{
       //修改
        //URL_DIARY_UPDATE_IOS
        [network newReloadWebServiceNoDataURL:URL_DIARY_UPDATE_IOS andParameters:dict andURLName:URL_DIARY_UPDATE_IOS];
        network.workSuccess = ^(RSWorkContentModel *workContentmodel) {
            self.workContentmodel = workContentmodel;
            self.footTextview.text = self.workContentmodel.summary;
            [self.tableview reloadData];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadWork" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
}



- (void)deleteSalertViewContentIndexpath:(NSIndexPath *)indexpath andType:(nonnull NSString *)addType{
    if ([addType isEqualToString:@"update"]) {
        //删除
        if (indexpath.section == 0) {
            [self.workContentmodel.todayPlanArray removeObjectAtIndex:indexpath.row];
        }else if (indexpath.section == 1){
            [self.workContentmodel.tomorrowPlanArray removeObjectAtIndex:indexpath.row];
        }else{
            [self.workContentmodel.inCompleteArray removeObjectAtIndex:indexpath.row];
        }
        [self.tableview reloadData];
    }
}


@end
