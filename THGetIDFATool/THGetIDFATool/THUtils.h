//
//  THUtils.h
//  THGetIDFATool
//
//  Created by 动能无限 on 2019/9/27.
//  Copyright © 2019 eddy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THUtils : NSObject

+ (NSString *)hostname;

+ (NSString *)getIPAddress;

+ (float)getTotalDiskspace;

+ (float)getFreeDiskspace;

@end

NS_ASSUME_NONNULL_END
