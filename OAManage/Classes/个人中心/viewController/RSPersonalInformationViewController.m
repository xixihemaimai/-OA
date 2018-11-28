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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.frostedViewController.panGestureEnabled = NO;
    self.title = @"个人信息";
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
    
    if (IS_IPHONE) {
        
        
        if (indexPath.section == 0) {
            return 101;
        }else{
            return 48;
        }
        
    }else{
        if (indexPath.section == 0) {
            
            if (DEVICES_IS_PRO_12_9) {
                
                return 140 * SCALE_TO_PRO;
            }else{
                return (140 / SCW ) * SCW;
            }
            
            
        }else{
            
            
            if (DEVICES_IS_PRO_12_9) {
                
                return 60 * SCALE_TO_PRO;
            }else{
                
                return (60 / SCW ) * SCW;
            }
            
           
        }
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (IS_IPHONE) {
        if (section == 0 || section == 2) {
            return 0;
        }else{
            return 10;
        }
    }else{
        if (section == 0 || section == 2) {
            
            if (DEVICES_IS_PRO_12_9) {
                
                return 0 * SCALE_TO_PRO;
            }else{
                
                return (0 / SCW ) * SCW;
            }
 
        }else{
            if (DEVICES_IS_PRO_12_9) {
                
                return 10 * SCALE_TO_PRO;
            }else{
                
                return (10 / SCW ) * SCW;
            }
        }
    }
}



//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section == 1) {
//        if (indexPath.row == 1) {
//            self.usermodel.sex = @"男";
//            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//            NSData * data = [user objectForKey:@"OAUSERMODEL"];
//            RSUserModel * usermodel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            usermodel.sex = @"男";
//            NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:usermodel];
//            [user setObject:data1 forKey:@"OAUSERMODEL"];
//
//        }
//
//    }
//
//
//
//
//}



@end
