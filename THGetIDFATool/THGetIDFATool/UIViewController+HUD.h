//
//  UIViewController+HUD.h
//  NativeTest
//
//  Created by 动能无限 on 2019/8/15.
//  Copyright © 2019 DLWX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

@end

NS_ASSUME_NONNULL_END
