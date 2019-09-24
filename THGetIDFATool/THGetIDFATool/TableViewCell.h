//
//  TableViewCell.h
//  NativeTest
//
//  Created by 动能无限 on 2019/9/17.
//  Copyright © 2019 DLWX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const kTHCopyActionEvent;

@interface TableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *title_Label;

@property (nonatomic, weak) IBOutlet UILabel *infoLabel;

@property (nonatomic, weak) IBOutlet UIButton *cpButton;

@end

NS_ASSUME_NONNULL_END
