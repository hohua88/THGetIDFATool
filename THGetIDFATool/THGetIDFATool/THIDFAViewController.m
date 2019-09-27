//
//  THIDFAViewController.m
//  THGetIDFATool
//
//  Created by 动能无限 on 2019/9/25.
//  Copyright © 2019 eddy. All rights reserved.
//

#import "THIDFAViewController.h"
#import <AdSupport/AdSupport.h>
#import "TableViewCell.h"
#import "UIResponder+Router.h"
#import "UIViewController+HUD.h"
#import "THUtils.h"
#import "IDFASettingViewController.h"

@interface THIDFAViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation THIDFAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
   
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    footer.backgroundColor = [UIColor lightGrayColor];
    UIButton *questionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    questionButton.frame = CGRectMake(0, 0, 35, 35);
    questionButton.center = footer.center;;
    [questionButton setImage:[UIImage imageNamed:@"question_icon"] forState:0];

    [questionButton addTarget:self action:@selector(questionAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:questionButton];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"idfaCell"];
}

- (IBAction)questionAction:(UIButton *)button {
    IDFASettingViewController *controller = [[IDFASettingViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
    // 这样back回来的时候，tabBar会恢复正常显示
    self.hidesBottomBarWhenPushed = NO;
}

- (void)setupNavigationItem{
    
    UIButton * lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lightButton setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
    [lightButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    lightButton.frame = CGRectMake(0, 0, 35, 35);
    lightButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    UIBarButtonItem * lightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lightButton];
    self.navigationItem.rightBarButtonItems = @[lightButtonItem];
}

- (void)shareAction:(id)sender {
    NSString *textToShare = @"设备信息\n";
       
       NSString *shareInfo = [NSString stringWithFormat:@"IDFA=%@\nIDFV=%@\nSystemVersion=%@",[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString],[[[UIDevice currentDevice] identifierForVendor] UUIDString],[[UIDevice currentDevice] systemVersion]];
       textToShare = [textToShare stringByAppendingString:shareInfo];
       NSArray *activityItems = @[textToShare];
       
       UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];

       activityVC.excludedActivityTypes = @[
           UIActivityTypePostToFacebook,
           UIActivityTypePostToTwitter,
           UIActivityTypePrint,
           UIActivityTypePostToWeibo,
           UIActivityTypePrint,
           UIActivityTypeAssignToContact,
           UIActivityTypeSaveToCameraRoll,
           UIActivityTypeAddToReadingList,
           UIActivityTypePostToFlickr,
           UIActivityTypePostToVimeo
       ];
       UIPopoverPresentationController *popover = activityVC.popoverPresentationController;
       
       
       if (popover) {
           popover.sourceView = self.view;
           popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
       }
       [self presentViewController:activityVC animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idfaCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.row;
    if (indexPath.row == 0) {
        cell.title_Label.text = @"IDFA";
        cell.infoLabel.text = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    else if(indexPath.row == 1) {
        cell.title_Label.text = @"IDFV";
        cell.infoLabel.text = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    else if(indexPath.row == 2) {
        cell.title_Label.text = @"System Version";
        cell.infoLabel.text = [[UIDevice currentDevice] systemVersion];
    }
    else if(indexPath.row == 3) {
        cell.title_Label.text = @"HostName";
        cell.infoLabel.text = [THUtils hostname];
    }
    else if(indexPath.row == 4) {
        cell.title_Label.text = @"IP";
        cell.infoLabel.text = [THUtils getIPAddress];
    }
    else if(indexPath.row == 5) {
        cell.title_Label.text = @"磁盘大小";
        cell.infoLabel.text = [NSString stringWithFormat:@"%.2fG",[THUtils getTotalDiskspace]];
    }
    else if(indexPath.row == 6) {
        cell.title_Label.text = @"可用磁盘大小";
        cell.infoLabel.text =[NSString stringWithFormat:@"%.2fG",[THUtils getFreeDiskspace]];
    }
    return cell;
}

#pragma mark - routerEventWithName
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    NSLog(@"eventName: %@  userInfo: %@",eventName, userInfo);
    
    if ([userInfo[@"value"] integerValue] == 0) {
        [self showHint:@"IDFA复制成功"];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        pasteBoard.string = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    else if([userInfo[@"value"] integerValue] == 1) {
        [self showHint:@"IDFV复制成功"];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        pasteBoard.string = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    else if([userInfo[@"value"] integerValue] == 2) {
        [self showHint:@"System复制成功"];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        pasteBoard.string = [[UIDevice currentDevice] systemVersion];
    }
    else if([userInfo[@"value"] integerValue] == 3) {
        [self showHint:@"HostName复制成功"];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        pasteBoard.string = [[UIDevice currentDevice] systemVersion];
    }
    else if([userInfo[@"value"] integerValue] == 4) {
        [self showHint:@"IP复制成功"];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        pasteBoard.string = [[UIDevice currentDevice] systemVersion];
    }
    else if([userInfo[@"value"] integerValue] == 5) {
        [self showHint:@"磁盘大小复制成功"];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        pasteBoard.string = [[UIDevice currentDevice] systemVersion];
    }
    else{
        [self showHint:@"可用磁盘大小复制成功"];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        pasteBoard.string = [[UIDevice currentDevice] systemVersion];
    }
}

@end
