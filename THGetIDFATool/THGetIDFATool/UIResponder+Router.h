//
//  UIResponder+Router.h
//  cocoaPodsDemo
//
//  Created by eddy on 2017/8/14.
//  Copyright © 2017年 eddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
