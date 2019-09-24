//
//  TitleCollectionViewCell.m
//  THGetIDFATool
//
//  Created by 动能无限 on 2019/9/18.
//  Copyright © 2019 eddy. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@implementation TitleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (NSString *)cellIdentifier{
    return NSStringFromClass(self);
}

@end
