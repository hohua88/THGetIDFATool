//
//  UIResponder+Router.m
//  cocoaPodsDemo
//
//  Created by eddy on 2017/8/14.
//  Copyright © 2017年 eddy. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)


- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
