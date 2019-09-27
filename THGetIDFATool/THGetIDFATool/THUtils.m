//
//  THUtils.m
//  THGetIDFATool
//
//  Created by 动能无限 on 2019/9/27.
//  Copyright © 2019 eddy. All rights reserved.
//

#import "THUtils.h"
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>



@implementation THUtils
#pragma mark 获取ip地址
+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

#pragma mark 获取host的名称
+ (NSString *) hostname{
    char baseHostName[256]; // Thanks, Gunnar Larisch
    int success = gethostname(baseHostName, 255);
    if (success != 0) return nil;
    //    2015-07-30 19:32:36 update by 胡仕君
    //    baseHostName[255] = '/0';
    baseHostName[255] = '\0';
    NSLog(@"basehostname = %@",[NSString stringWithFormat:@"%s", baseHostName]);
#if TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat:@"%s", baseHostName];
#else
    return [NSString stringWithFormat:@"%s", baseHostName];
#endif
}

#pragma mark 总的磁盘空间

+ (float)getTotalDiskspace{
    float totalSpace;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
    } else {
        totalSpace = 0;
    }
    return totalSpace;
}

#pragma mark 可用磁盘空间
+ (float)getFreeDiskspace{
    float freeSpace;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        freeSpace = [freeFileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;

    } else {
        freeSpace = 0;
    }
    return freeSpace;
}

@end
