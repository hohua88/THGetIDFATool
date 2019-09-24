//
//  IDFASettingViewController.m
//  THGetIDFATool
//
//  Created by 动能无限 on 2019/9/18.
//  Copyright © 2019 eddy. All rights reserved.
//

#import "IDFASettingViewController.h"
#import <WebKit/WebKit.h>
#import "ImageCollectionViewCell.h"
#import "TitleCollectionViewCell.h"

@interface IDFASettingViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation IDFASettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:[ImageCollectionViewCell cellIdentifier] bundle:nil] forCellWithReuseIdentifier:[ImageCollectionViewCell cellIdentifier]];
     [self.collectionView registerNib:[UINib nibWithNibName:[TitleCollectionViewCell cellIdentifier] bundle:nil] forCellWithReuseIdentifier:[TitleCollectionViewCell cellIdentifier]];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ImageCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    TitleCollectionViewCell *titlecCell = [collectionView dequeueReusableCellWithReuseIdentifier:[TitleCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    if (indexPath.section == 0) {
        return titlecCell;
    }
    else {
        NSInteger imageIndex = indexPath.section;
        
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"setting-%zd.png", imageIndex]];
        return cell;
    }
   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(self.view.frame.size.width, 50);
    }
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(11, 14, 10, 14);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;//Item之间的最小间隔
}

@end
