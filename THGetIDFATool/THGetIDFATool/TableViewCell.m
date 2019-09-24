//
//  TableViewCell.m
//  NativeTest
//
//  Created by 动能无限 on 2019/9/17.
//  Copyright © 2019 DLWX. All rights reserved.
//

#import "TableViewCell.h"
#import "UIResponder+Router.h"
NSString * const kTHCopyActionEvent = @"copyActionEvent";
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)copyAction:(id)sender {
    NSInteger tag = self.tag;
    [self routerEventWithName:kTHCopyActionEvent userInfo:@{@"key":@"clicked",@"value":[NSNumber numberWithInteger:tag]}];
}
@end
