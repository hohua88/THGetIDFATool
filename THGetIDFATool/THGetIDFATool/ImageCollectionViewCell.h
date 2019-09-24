//
//  ImageCollectionViewCell.h
//  cocoaPodsDemo
//
//  Created by eddy on 2017/6/28.
//  Copyright © 2017年 eddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

+ (NSString *)cellIdentifier;
@end
