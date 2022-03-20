//
//  RSPersonalInformationViewController.m
//  OAManage
//
//  Created by mac on 2018/11/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSPersonalInformationViewController.h"
#import "RSPersonFirstCell.h"
#import "RSPersonSecondCell.h"

@interface RSPersonalInformationViewController ()


@property (nonatomic,strong)NSArray * fristArray;

@property (nonatomic,strong)NSArray * secondArray;



@end

@implementation RSPersonalInformationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.frostedViewController.panGestureEnabled = NO;
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
    self.emptyView.hidden = YES;
    self.fristArray = @[@"昵称",@"性别"];
    self.secondArray = @[@"所在部门",@"所在职位"];
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * PERSIONID = @"personid";
    if (indexPath.section == 0) {
        RSPersonFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSIONID];
        if (!cell) {
            cell = [[RSPersonFirstCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PERSIONID];
        }
       // [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_HEADER_TEXT_IOS,self.userModel.userHead]] placeholderImage:[UIImage imageNamed:@"求真像"]];
        cell.headerview.image = [UIImage imageNamed:@"logo"];
//        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        cell.imageView.clipsToBounds = YES;
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        RSPersonSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:PERSIONID];
        if (!cell) {
            cell = [[RSPersonSecondCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PERSIONID];
        }
        if (indexPath.section == 1) {
            cell.nameLabel.text = self.fristArray[indexPath.row];
            if (indexPath.row == 0) {
                cell.phoneLabel.text = [NSString stringWithFormat:@"%@",self.usermodel.userName];
            }
            else{
                cell.phoneLabel.text = [NSString stringWithFormat:@"%@",self.usermodel.sex];
            }
        }else if (indexPath.section == 2){
            cell.nameLabel.text = self.secondArray[indexPath.row];
            if (indexPath.row == 0) {
                 cell.phoneLabel.text = [NSString stringWithFormat:@"%@",self.usermodel.deptName];
            }else{
                cell.phoneLabel.text = @"UI设计";
            }
        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section == 0) {
            return 101;
        }else{
            return 48;
        }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
        if (section == 0 || section == 2) {
            return 0;
        }else{
            return 10;
        }
}



@end
