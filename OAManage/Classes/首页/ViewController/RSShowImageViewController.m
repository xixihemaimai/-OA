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
    showImage.image = [UIImage imageNamed:@"欢迎页"];
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
