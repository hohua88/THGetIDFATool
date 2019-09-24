//
//  ImageCollectionViewCell.m
//  cocoaPodsDemo
//
//  Created by eddy on 2017/6/28.
//  Copyright © 2017年 eddy. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass(self);
}
@end
