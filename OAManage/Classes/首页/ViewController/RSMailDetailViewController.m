//
//  RSMailDetailViewController.m
//  OAManage
//
//  Created by mac on 2019/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSMailDetailViewController.h"
#import "RSMailDetailCell.h"

@interface RSMailDetailViewController ()

@property (nonatomic,strong)NSMutableArray * phoneArray;

@end

@implementation RSMailDetailViewController

- (NSMutableArray *)phoneArray{
    if (!_phoneArray) {
        _phoneArray = [NSMutableArray array];
    }
    return _phoneArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.hidden = YES;
    //设置导航栏背景图片为一个空的image，这样就透明了
       [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
       
       //去掉透明后导航栏下边的黑边
       [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emptyView.hidden = YES;
    
    [self setCustomHeaderViewContent];
    
    
    
    
    
    if (![self.mailmodel.phone1 isEqualToString:@""]) {
        [self.phoneArray addObject:self.mailmodel.phone1];
    }
    if (![self.mailmodel.phone2 isEqualToString:@""]) {
        [self.phoneArray addObject:self.mailmodel.phone2];
    }
    if (![self.mailmodel.phone3 isEqualToString:@""]) {
        [self.phoneArray addObject:self.mailmodel.phone3];
    }
    
    
    
}


- (void)setCustomHeaderViewContent{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UIButton * backgroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[backgroundBtn setba:[UIImage imageNamed:@"背景"] forState:UIControlStateNormal];
    [backgroundBtn setBackgroundImage:[UIImage imageNamed:@"背景"] forState:UIControlStateNormal];
    [headerView addSubview:backgroundBtn];
    backgroundBtn.sd_layout
    .leftSpaceToView(headerView, 0)
    .topSpaceToView(headerView, 0)
    .rightSpaceToView(headerView, 0)
    .heightIs(237.5);
    
    
    UIButton * touBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [touBtn setImage:[UIImage imageNamed:@"Group 2 Copy"] forState:UIControlStateNormal];
    [headerView addSubview:touBtn];
    touBtn.sd_layout
    .leftSpaceToView(headerView, 15)
    .topSpaceToView(headerView, 215)
    .widthIs(44)
    .heightEqualToWidth();
    
    //名字
    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.text = self.mailmodel.name;
    nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    nameLabel.font = [UIFont systemFontOfSize:17];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:nameLabel];
    
    nameLabel.sd_layout
    .leftEqualToView(touBtn)
    .topSpaceToView(touBtn, 8)
    .rightSpaceToView(headerView, 15)
    .heightIs(24);
    
    UILabel * departmentLabel = [[UILabel alloc]init];
    departmentLabel.text = self.mailmodel.department;
    departmentLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    departmentLabel.font = [UIFont systemFontOfSize:14];
    departmentLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:departmentLabel];
    
     CGRect rect = [departmentLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    
    departmentLabel.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(nameLabel, 2)
    .heightIs(20)
    .widthIs(rect.size.width);
    
    UILabel * positionLabel = [[UILabel alloc]init];
    positionLabel.text = self.mailmodel.position;
    positionLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    positionLabel.font = [UIFont systemFontOfSize:12];
    positionLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:positionLabel];
    
    positionLabel.sd_layout
    .leftSpaceToView(departmentLabel, 7)
    .topEqualToView(departmentLabel)
    .bottomEqualToView(departmentLabel)
    .rightSpaceToView(headerView, 15);
    
    
    UIView * bottom = [[UIView alloc]init];
    bottom.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [headerView addSubview:bottom];
    
    
    bottom.sd_layout
    .leftSpaceToView(headerView, 15)
    .rightSpaceToView(headerView, 15)
    .topSpaceToView(departmentLabel, 15)
    .heightIs(0.5);
    
    
    [headerView setupAutoHeightWithBottomView:bottom bottomMargin:20];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.phoneArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * MAILLISTDETAILCELLID = @"MAILLISTDETAILCELLID";
    RSMailDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:MAILLISTDETAILCELLID];
    if (!cell) {
        cell = [[RSMailDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MAILLISTDETAILCELLID];
    }
    //cell.textLabel.text = @"名字";
    cell.phoneNameLabel.text = [NSString stringWithFormat:@"电话%ld",indexPath.row + 1];
    cell.phoneLabel.text = [NSString stringWithFormat:@"%@",self.phoneArray[indexPath.row]];
    
    cell.playPhoneBtn.tag = indexPath.row;
    [cell.playPhoneBtn addTarget:self action:@selector(playPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//打电话
- (void)playPhoneAction:(UIButton *)playBtn{
    NSString * phoneStr = self.phoneArray[playBtn.tag];
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneStr];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


@end
