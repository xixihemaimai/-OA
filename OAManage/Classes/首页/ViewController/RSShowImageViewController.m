//
//  RSShowImageViewController.m
//  OAManage
//
//  Created by mac on 2019/12/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSShowImageViewController.h"

@interface RSShowImageViewController ()

@end

@implementation RSShowImageViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    UIImageView * showImage = [[UIImageView alloc]init];
    showImage.frame = CGRectMake(0, 0, SCW, SCH);
    if (iphonex) {
        showImage.image = [UIImage imageNamed:@"Group1125_2436XS和X"];
    }else if (iPhoneXR){
        showImage.image = [UIImage imageNamed:@"Group-6XR"];
    }else if (iPhoneXS){
        showImage.image = [UIImage imageNamed:@"Group1125_2436XS和X"];
    }else if (iPhoneXSMax){
        showImage.image = [UIImage imageNamed:@"Group-7XSmax"];
    }else if (iPhone6p){
        showImage.image = [UIImage imageNamed:@"Group1242_22805.5"];
    }else{
        showImage.image = [UIImage imageNamed:@"欢迎页"];
    }
    [self.view addSubview:showImage];
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
