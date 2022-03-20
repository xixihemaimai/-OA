//
//  AppDelegate.h
//  OAManage
//
//  Created by mac on 2018/10/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate,MiPushSDKDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,assign)BOOL allowRotation;//是否允许转向

@property (readonly, strong) NSPersistentContainer * persistentContainer;

- (void)saveContext;

- ( CGFloat )autoScaleW:( CGFloat)w;
- (CGFloat)autoScaleH:(CGFloat)h;

@end

