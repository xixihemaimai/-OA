//
//  UIControl+QiEventInterval.m
//  OAManage
//
//  Created by mac on 2020/11/5.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UIControl+QiEventInterval.h"
#import <objc/runtime.h>

static char * const qi_eventIntervalKey = "qi_eventIntervalKey";
static char * const eventUnavailableKey = "eventUnavailableKey";

@interface UIControl()

@property (nonatomic,assign)BOOL eventUnavailable;


@end


@implementation UIControl (QiEventInterval)


+ (void)load
{
    Method method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method qi_method = class_getInstanceMethod(self, @selector(qi_sendAcion:to:forEvent:));
    method_exchangeImplementations(method, qi_method);
}

- (void)qi_sendAcion:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if ([self isMemberOfClass:[UIButton class]]) {
        if (self.eventUnavailable == NO) {
            self.eventUnavailable = YES;
            [self qi_sendAcion:action to:target forEvent:event];
            [self performSelector:@selector(setEventUnavailable:) withObject:0 afterDelay:self.qi_eventInterval];
        }else{
            [SVProgressHUD showErrorWithStatus:@"等待时间结束，防止你重复点击"];
        }
    }else{
        [self qi_sendAcion:action to:target forEvent:event];
    }
}


#pragma mark - Setter & Getter functions

- (NSTimeInterval)qi_eventInterval {
    return [objc_getAssociatedObject(self, qi_eventIntervalKey) doubleValue];
}

- (void)setQi_eventInterval:(NSTimeInterval)qi_eventInterval {
    objc_setAssociatedObject(self, qi_eventIntervalKey, @(qi_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)eventUnavailable {
    return [objc_getAssociatedObject(self, eventUnavailableKey) boolValue];
}

- (void)setEventUnavailable:(BOOL)eventUnavailable {
    objc_setAssociatedObject(self, eventUnavailableKey, @(eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
