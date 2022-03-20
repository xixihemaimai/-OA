//
//  RSAboutOurViewController.m
//  OAManage
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSAboutOurViewController.h"

@interface RSAboutOurViewController ()

@end

@implementation RSAboutOurViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.emptyView.hidden = YES;
     self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    [self customHeaderView];
    
}


- (void)customHeaderView{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    UIImageView * headerImage = [[UIImageView alloc]init];
    headerImage.image = [UIImage imageNamed:@"关于我们"];
    [headerView addSubview:headerImage];
    
    headerView.frame = CGRectMake(0, 0, SCW, 500);
    headerImage.frame = CGRectMake(0, 0, SCW, 250);
//    headerImage.sd_layout.leftSpaceToView(headerView, 0).rightSpaceToView(headerView, 0).topSpaceToView(headerView, 0).heightIs(250);
    
    //介绍
    UILabel * headerLabel = [[UILabel alloc]init];
    headerLabel.text = @"       瑞石OA是由厦门瑞石信息科技有限公司开发致力于解决企业移动办公的问题，将企业办公进入随时随地分享，随时随地操作，随时随地能看到反馈的工作氛围，提升企业员工工作时效性，从根本上实现了企业的移动办公，构建科学的管理模式。";
    headerLabel.numberOfLines = 0;
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    headerLabel.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:headerLabel];
    
//    headerLabel.sd_layout
//    .leftSpaceToView(headerView, 37.5)
//    .rightSpaceToView(headerView, 37.5)
//    .topSpaceToView(headerImage, 31)
//    .heightIs(202);
    
    headerLabel.frame = CGRectMake(37.5, CGRectGetMaxY(headerImage.frame) + 31, SCW - 37.5 -37.5, 202);
    
    UILabel * andLabel = [[UILabel alloc]init];
    andLabel.text = @"和";
    andLabel.numberOfLines = 0;
    andLabel.textAlignment = NSTextAlignmentCenter;
    andLabel.textColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    andLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:andLabel];
    
//    andLabel.sd_layout.centerXEqualToView(headerView).topSpaceToView(headerLabel, 69.5).heightIs(20).widthIs(15);
    andLabel.frame = CGRectMake(SCW/2 - 7.5, SCH - 100, 15, 20);
    

    UIButton * privacyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [privacyBtn setTitle:@"用户隐私" forState:UIControlStateNormal];
    [privacyBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
    privacyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:privacyBtn];
    [privacyBtn addTarget:self action:@selector(privacyAction:) forControlEvents:UIControlEventTouchUpInside];
//    privacyBtn.sd_layout.topEqualToView(andLabel).bottomEqualToView(andLabel).widthIs(58).rightSpaceToView(andLabel, 0);
    
    privacyBtn.frame = CGRectMake(SCW/2 - 58/2 - 35, SCH - 100, 58, 20);
    
    UIButton * serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [serviceBtn setTitle:@"用户协议" forState:UIControlStateNormal];
    [serviceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
    serviceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:serviceBtn];
    [serviceBtn addTarget:self action:@selector(serviceAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    serviceBtn.sd_layout.leftSpaceToView(andLabel, 0).topEqualToView(andLabel).bottomEqualToView(andLabel).widthIs(58);
    
    serviceBtn.frame = CGRectMake(CGRectGetMaxX(andLabel.frame), SCH - 100, 58, 20);
//    [headerView setupAutoHeightWithBottomView:privacyBtn bottomMargin:30];
//    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
    
}

//用户隐私
- (void)privacyAction:(UIButton *)privacyBtn{
    RSWKOAmanagerViewController * wkOAstr = [[RSWKOAmanagerViewController alloc]init];
    wkOAstr.type = @"5";
    [self.navigationController pushViewController:wkOAstr animated:YES];
}


//用户协议
- (void)serviceAction:(UIButton *)serviceBtn{
    RSWKOAmanagerViewController * wkOAstr = [[RSWKOAmanagerViewController alloc]init];
    wkOAstr.type = @"6";
    [self.navigationController pushViewController:wkOAstr animated:YES];
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ABOUNTCELLID = @"ABOUNTCELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ABOUNTCELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ABOUNTCELLID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}





@end
