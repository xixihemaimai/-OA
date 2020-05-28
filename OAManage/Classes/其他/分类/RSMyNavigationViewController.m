//
//  RSMyNavigationViewController.m
//  石来石往
//
//  Created by mac on 2017/11/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMyNavigationViewController.h"
#import "RSMenuViewController.h"
#import "RSShenHeViewController.h"
#import "RSApprovalProcessViewController.h"
#import "RSAuditedViewController.h"
#import <QuickLook/QuickLook.h>
#import "RSWKOAmanagerViewController.h"


@interface RSMyNavigationViewController ()<UINavigationControllerDelegate>


//@property (nonatomic,strong)UIImageView * lastVcView;

//@property (nonatomic,strong)UIView * cover;

@property (nonatomic,weak)id popDelegate;

@end

@implementation RSMyNavigationViewController


//- (UIImageView *)lastVcView{
//    if (!_lastVcView) {
//        UIWindow * window = [UIApplication sharedApplication].keyWindow;
//        UIImageView * lastVcView = [[UIImageView alloc]init];
//        lastVcView.frame = window.bounds;
//        self.lastVcView = lastVcView;
//    }
//    return _lastVcView;
//}


//- (UIView *)cover{
//    if (!_cover) {
//        UIWindow * window = [UIApplication sharedApplication].keyWindow;
//        UIView * cover = [[UIView alloc]init];
//        cover.backgroundColor = [UIColor blackColor];
//        cover.frame = window.bounds;
//        cover.alpha = 0.5;
//        self.cover = cover;
//    }
//    return _cover;
//}


//- (NSMutableArray *)images{
//    if (!_images) {
//        self.images = [[NSMutableArray alloc]init];
//    }
//    return _images;
//}

/**有截图return*/
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   // [self createScreenShot];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    //[self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    [self.navigationBar setShadowImage:[UIImage imageNamed:@"Line Copy 2"]];
    self.navigationBar.barTintColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UIColor *whiteColor = [UIColor colorWithHexColorStr:@"#333333"];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    [self.navigationBar setTitleTextAttributes:dic];
    

//    self.navigationBar.translucent = true;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = (id)viewController;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置返回按钮,只有非根控制器
        
//         if (@available(iOS 13.0, *)) {
//
//             if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
//
//                   viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"system-backnew"] highImage:[UIImage imageNamed:@"system-backnew"]  target:self action:@selector(back) title:nil];
//             }else{
//
//                   viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"system-backnew1"] highImage:[UIImage imageNamed:@"system-backnew1"]  target:self action:@selector(back) title:nil];
//             }
//         }else{
              viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"system-backnew"] highImage:[UIImage imageNamed:@"system-backnew"]  target:self action:@selector(back) title:nil];
//         }
        
       
            //  [self createScreenShot];
    }
    // 真正在跳转
    [super pushViewController:viewController animated:animated];
}

//FIXME:返回
- (void)back
{
//    self.cover.alpha = 0;
//    [self.lastVcView removeFromSuperview];
//    [self.cover removeFromSuperview];
//    [self.images removeLastObject];
    [self popViewControllerAnimated:YES];
}




//- (void)showMenu
//{
//    [self.frostedViewController presentMenuViewController];
//}



/**产生截图*/
//- (void)createScreenShot{
//    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0.0);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
//    [self.images addObject:image];
//}


#pragma mark -
#pragma mark Gesture recognizer

//- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
//{
//    //这边是首页往右滑的部分
//    if (self.interactivePopGestureRecognizer.delegate == self.popDelegate) {
//        //[self.frostedViewController panGestureRecognized:sender];
//    }
//    else{
//       //右滑返回上一个界面
//        if (self.viewControllers.count <= 1) {
//            return;
//        }
//        //在X方向上移动的距离
//        CGFloat tx = [sender translationInView:self.view].x;
//        if (tx < 0) {
//            return;
//        }
//        if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
//            CGFloat x = self.view.frame.origin.x;
//            if (x >= self.view.frame.size.width * 0.5) {
//                //决定pop还是还原
//                [UIView animateWithDuration:0.25 animations:^{
//                    self.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
////                    self.cover.alpha = 0;
//                } completion:^(BOOL finished) {
//                    [self popViewControllerAnimated:NO];
//                    self.view.transform = CGAffineTransformIdentity;
////                    self.cover.alpha = 0.5;
////                    [self.lastVcView removeFromSuperview];
////                    [self.cover removeFromSuperview];
////                    [self.images removeLastObject];
//                }];
//            }else{
//             //还原
//                [UIView animateWithDuration:0.25 animations:^{
//                    self.view.transform = CGAffineTransformIdentity;
////                    self.cover.alpha = 0.5;
//                }];
//            }
//        }else{
//            //正在移动中
////            self.view.transform = CGAffineTransformMakeTranslation(tx, 0);
////            UIWindow * window = [UIApplication sharedApplication].keyWindow;
////            self.lastVcView.image = self.images[self.images.count - 1];
////            self.cover.alpha = 0.5 - ((tx / self.view.frame.size.width)/2);
////            [window insertSubview:self.lastVcView atIndex:0];
////            [window insertSubview:self.cover aboveSubview:self.lastVcView];
//        }
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
