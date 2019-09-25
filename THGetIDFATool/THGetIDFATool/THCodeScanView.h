//
//  THCodeScanView.h
//  THGetIDFATool
//
//  Created by 动能无限 on 2019/9/25.
//  Copyright © 2019 eddy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^THCodeScanCallback)(NSString * _Nullable scanString, BOOL succed);

NS_ASSUME_NONNULL_BEGIN

@interface THCodeScanView : UIView

@property (nonatomic, strong) THCodeScanCallback callback;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
