//
//  BCContentOB.h
//  xxxxxxxx
//
//  Created by WF on 2017/2/20.
//  Copyright © 2017年 WF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCContentOB : NSObject
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *attributeFirst;
@property(strong,nonatomic)NSString *attributeSecond;
@property(strong,nonatomic)NSString *attributeThird;
@property(strong,nonatomic)NSString *attributeFourth;



-(NSArray *)getAttributeNameArray;
-(NSArray *)getAttributeArray;
-(NSDictionary *)getDicOfOB;
@end
